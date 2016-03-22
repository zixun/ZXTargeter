//
//  ONESettingManager.m
//  ONEXcodePlugin
//
//  Created by user on 15/11/30.
//  Copyright © 2015年 陈奕龙. All rights reserved.
//

#import "ONESettingManager.h"
#import "Xcode3TargetWrapper.h"

NSString *const kONESettingSelectedTargetsDictionary = @"com.chenyilongyellow.ONEXcodePlugin.selectedTargets";

@implementation ONESettingManager

+ (ONESettingManager *)defaultManager
{
    static dispatch_once_t once;
    static ONESettingManager *defaultManager;
    dispatch_once(&once, ^ {
        defaultManager = [[ONESettingManager alloc] init];
        
        NSDictionary *defaults = @{kONESettingSelectedTargetsDictionary: @{}};
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    });
    return defaultManager;
}

//read
- (NSArray *)getSelectedTargetsForProjectName:(NSString *)name {
    
    if (name == nil) {
        NSLog(@"===========Get===============>工程名是空的<=============Get=============");
        
        return [[NSArray alloc] init];
    }
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kONESettingSelectedTargetsDictionary];
    NSArray *result = [dic objectForKey:name];
    
    if (result == nil) {
        result = [[NSArray alloc] init];
    }
    
    return result;
}

//write
- (void)setSelectedTargets:(NSArray *)targets forProjectName:(NSString *)name {
    
    if (name == nil) {
        NSLog(@"===========Set===============>工程名是空的<===========Set===============");
        return;
    }
    
    NSMutableDictionary *dic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:kONESettingSelectedTargetsDictionary] mutableCopy];
    
    dic[name] = targets;
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kONESettingSelectedTargetsDictionary];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
