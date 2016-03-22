//
//  NSObject_Extension.m
//  ZXTargeter
//
//  Created by user on 16/3/22.
//  Copyright © 2016年 陈奕龙. All rights reserved.
//


#import "NSObject_Extension.h"
#import "ZXTargeter.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[ZXTargeter alloc] initWithBundle:plugin];
        });
    }
}
@end
