//
//  NodeImpl.h
//  FlexboxSwiftUI
//
//  Created by Sam Pettersson on 2022-08-19.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@import Yoga;

NS_ASSUME_NONNULL_BEGIN

/// The private wrapper around `YGNodeRef`.
/// @warning This should not be used directly.
@interface NodeImpl : NSObject

@property (nonatomic, readonly, assign) YGNodeRef node;

@property (nonatomic, copy) NSArray<NodeImpl*> *children;

@property (nonatomic, readonly, assign) CGRect frame;

@property (nonatomic, readonly, assign) UIEdgeInsets padding;

@property (assign, nonatomic) Boolean isDirty;

@property (nonatomic, copy) CGSize (^measure)(CGSize size, YGMeasureMode widthMode, YGMeasureMode heightMode);

- (void)removeMeasureFunc;

- (void)layout;

- (void)layoutWithMaxSize:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END
