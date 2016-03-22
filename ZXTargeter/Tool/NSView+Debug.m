//
//  NSView+Debug.m
//  ONEXcodePlugin
//
//  Created by user on 16/3/16.
//  Copyright © 2016年 陈奕龙. All rights reserved.
//

#import "NSView+Debug.h"

@implementation NSView (Debug)

- (void)debug_setBackGroundColor:(NSColor *)color {
    CALayer *viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:color.CGColor]; //RGB plus Alpha Channel
    [self setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [self setLayer:viewLayer];
}
@end
