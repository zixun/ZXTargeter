//
//  ZXTargeter.h
//  ZXTargeter
//
//  Created by user on 16/3/22.
//  Copyright © 2016年 陈奕龙. All rights reserved.
//

#import <AppKit/AppKit.h>

@class ZXTargeter;

static ZXTargeter *sharedPlugin;

@interface ZXTargeter : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end