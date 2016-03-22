//
//  Xcode3TargetMembershipDataSource+Hook.m
//  ONEXcodePlugin
//
//  Created by user on 15/11/27.
//  Copyright © 2015年 陈奕龙. All rights reserved.
//

#import "Xcode3TargetMembershipDataSource+Hook.h"
#import "Xcode3TargetWrapper.h"
#import "ONESettingManager.h"
#import "NSView+Dumping.h"
#import <Masonry/Masonry.h>
#import "ONETargetSettingWindowController.h"
#import "NSView+Debug.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <JRSwizzle/JRSwizzle.h>
#import <ReactiveCocoa/RACEXTScope.h>

@implementation Xcode3TargetMembershipDataSource (Hook)

+ (void)hook
{
    [self jr_swizzleMethod:@selector(updateTargets) withMethod:@selector(updateTargetsHook) error:nil];
}

- (void)updateTargetsHook
{
    [self updateTargetsHook];
    
    //添加设置按钮
    [self _addSettingButton];
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kONEXcodePluginCanReflash object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        NSNotification *noti = (NSNotification *)x;
        NSString *proName = noti.object;
        NSArray *selectedTargets = [[ONESettingManager defaultManager] getSelectedTargetsForProjectName:proName];
        
        [self updateTargetsBySettingSelectedTargets:selectedTargets];
    }];
    
    NSString *proName = [ZXProjectHelper currentProject].name;
    NSArray *selectedTargets = [[ONESettingManager defaultManager] getSelectedTargetsForProjectName:proName];
    
    if (selectedTargets == nil || selectedTargets.count == 0) {
        return;
    }
    
    [self updateTargetsBySettingSelectedTargets:selectedTargets];
}

- (void)updateTargetsBySettingSelectedTargets:(NSArray *)selectedTargets {
    NSMutableArray *wrappedTargets = [self valueForKey:@"wrappedTargets"];
    
    for (Xcode3TargetWrapper *wrappedTarget in wrappedTargets) {
        NSString *name = wrappedTarget.name;
        
        if ([selectedTargets containsObject:name]) {
            wrappedTarget.selected = YES;
        }else {
            wrappedTarget.selected = NO;
        }
    }
}

- (void)_addSettingButton {
    NSView *superView = [[[[self valueForKey:@"tableView"] superview] superview] superview];
    
    if (superView == nil) {
        return;
    }
    
    NSButton* settingButton = [[NSButton alloc] init];
    settingButton.bezelStyle = NSRoundedBezelStyle;
    [settingButton setTitle:@"Setting"];
    
    settingButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        ONETargetSettingWindowController *controller = [[ONETargetSettingWindowController alloc] initWithWindowNibName:@"ONETargetSettingWindowController"];
        
        NSMutableArray *wrappedTargets = [self valueForKey:@"wrappedTargets"];
        controller.wrappedTargets = wrappedTargets;
        controller.project = [ZXProjectHelper currentProject];
        [controller showWindow:controller];
        
        return [RACSignal empty];
    }];
    [superView addSubview:settingButton];
    
    [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.bottom.equalTo(superView);
        make.height.equalTo(@25);
        make.width.equalTo(@70);
    }];
}

@end
