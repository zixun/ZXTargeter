//
//  ONETargetSettingWindowController.h
//  ONEXcodePlugin
//
//  Created by user on 16/3/15.
//  Copyright © 2016年 陈奕龙. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZXProjectHelper.h"

#define kONEXcodePluginCanReflash @"kONEXcodePluginCanReflash"

@interface ONETargetSettingWindowController : NSWindowController

@property (nonatomic, strong) NSMutableArray *wrappedTargets;

@property (nonatomic, strong) ZXProject *project;

@end
