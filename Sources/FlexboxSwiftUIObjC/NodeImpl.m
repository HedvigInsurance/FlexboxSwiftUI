//
//  NodeImpl.m
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-19.
//

#import <Foundation/Foundation.h>
#import "NodeImpl.h"

static YGSize measureNode(YGNodeRef node, float width, YGMeasureMode widthMode, float height, YGMeasureMode heightMode)
{
    NodeImpl *self = (__bridge NodeImpl *)YGNodeGetContext(node);
    self.isDirty = false;
    CGSize size = self.measure(CGSizeMake(width, height), widthMode, heightMode);
    return (YGSize){ size.width, size.height };
}

static void YGRemoveAllChildren(const YGNodeRef node)
{
    if (node == NULL) {
        return;
    }

    while (YGNodeGetChildCount(node) > 0) {
        YGNodeRemoveChild(node, YGNodeGetChild(node, YGNodeGetChildCount(node) - 1));
    }
}

@implementation NodeImpl

- (void)dealloc
{
    YGNodeFree(_node);
}

- (id)init
{
    self = [super init];
    if (self == nil) return nil;
    
    _node = YGNodeNew();
    YGNodeSetContext(_node, (__bridge void *)self);
    
    YGConfigSetLogger(YGConfigGetDefault(), LogCallback);

    return self;
}

- (void)setChildren:(NSArray<NodeImpl*> *)children
{
    _children = [children copy];

    YGRemoveAllChildren(_node);

    for (int i = 0; i < children.count; i++) {
        YGNodeInsertChild(_node, [children[i] node], i);
    }
}

- (void)layout
{
    [self layoutWithMaxSize:CGSizeMake(NAN, NAN)];
}

- (Boolean)isDirty {
    return YGNodeIsDirty(_node);
}

- (void)setIsDirty:(Boolean)isDirty
{
    if (isDirty) {
        [self willChangeValueForKey:@"isDirty"];
        if (YGNodeHasMeasureFunc(_node)) {
            YGNodeMarkDirty(_node);
        }
        [self didChangeValueForKey:@"isDirty"];
    }
}

- (void)removeMeasureFunc
{
    YGNodeSetMeasureFunc(_node, NULL);
}

static int LogCallback(YGConfigRef config, YGNodeRef node, YGLogLevel level, const char* format, va_list args) {
    printf("[YOGA]: ");
    vprintf(format, args);
    return 0;
}

-(void)unmarkChildrenDirty {
    for (NodeImpl* child in _children) {
        [child setIsDirty: false];
        [child unmarkChildrenDirty];
    }
}

- (void)layoutWithMaxSize:(CGSize)maxSize
{
    YGNodeCalculateLayout(_node, maxSize.width, maxSize.height, YGNodeStyleGetDirection(_node));
    [self unmarkChildrenDirty];
}

- (CGRect)frame
{
    CGRect frame = (CGRect) {
        .origin = {
            .x = YGNodeLayoutGetLeft(_node),
            .y = YGNodeLayoutGetTop(_node),
        },
        .size = {
            .width = YGNodeLayoutGetWidth(_node),
            .height = YGNodeLayoutGetHeight(_node),
        },
    };
    return frame;
}

- (UIEdgeInsets)padding
{
    UIEdgeInsets padding = (UIEdgeInsets) {
        .left = YGNodeLayoutGetPadding(_node, YGEdgeLeft),
        .right = YGNodeLayoutGetPadding(_node, YGEdgeRight),
        .top = YGNodeLayoutGetPadding(_node, YGEdgeTop),
        .bottom = YGNodeLayoutGetPadding(_node, YGEdgeBottom),
    };
    return padding;
}

- (void)setMeasure:(CGSize (^)(CGSize, YGMeasureMode, YGMeasureMode))measure
{
    if (self.children.count == 0) {
        _measure = [measure copy];
        
        YGNodeSetMeasureFunc(_node, (_measure != nil ? measureNode : NULL));
    }
}

@end
