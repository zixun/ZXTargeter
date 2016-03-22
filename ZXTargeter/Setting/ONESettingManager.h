//
//  ONESettingManager.h
//  ONEXcodePlugin
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 陈奕龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ONETargetSettingWindowController.h"

@interface ONESettingManager : NSObject

+ (ONESettingManager *)defaultManager;

//read
- (NSArray *)getSelectedTargetsForProjectName:(NSString *)name;

//write
- (void)setSelectedTargets:(NSArray *)targets forProjectName:(NSString *)name;

@end
