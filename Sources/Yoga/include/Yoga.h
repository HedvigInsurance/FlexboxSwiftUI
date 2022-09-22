#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#if SWIFT_PACKAGE
#include "../YGEnums.h"
#else
#import <Yoga/YGEnums.h>
#endif

#if SWIFT_PACKAGE
#include "../YGMacros.h"
#else
#import <Yoga/YGMacros.h>
#endif


#if SWIFT_PACKAGE
#include "../YGValue.h"
#else
#import <Yoga/YGValue.h>
#endif

#if SWIFT_PACKAGE
#include "../Yoga.h"
#else
#import <Yoga/Yoga.h>
#endif

FOUNDATION_EXPORT double yogaVersionNumber;
FOUNDATION_EXPORT const unsigned char yogaVersionString[];

