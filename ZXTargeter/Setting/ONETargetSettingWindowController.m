//
//  ONETargetSettingWindowController.m
//  ONEXcodePlugin
//
//  Created by user on 16/3/15.
//  Copyright © 2016年 陈奕龙. All rights reserved.
//

#import "ONETargetSettingWindowController.h"
#import "Xcode3TargetWrapper.h"
#import <Masonry/Masonry.h>
#import "ONETargetTableCellView.h"
#import "ONESettingManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface ONETargetSettingWindowController () <NSTableViewDelegate, NSTableViewDataSource>
@property (weak) IBOutlet NSTableView *tableview;

@property (weak) IBOutlet NSTextField *projectInfoLabel;

@property (weak) IBOutlet NSButton *saveButton;


@property (nonatomic, strong) NSMutableArray *selectedTarget;

@end

@implementation ONETargetSettingWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    //事件绑定
    
    @weakify(self);
    self.saveButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        [[ONESettingManager defaultManager] setSelectedTargets:self.selectedTarget forProjectName:self.project.name];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kONEXcodePluginCanReflash object:self.project.name];
        
        
        [self close];
        return [RACSignal empty];
    }];
    
    //数据初始化
    
    
    
    
    //UI更新 数据初始化
    if (self.project.name == nil) {
        self.projectInfoLabel.stringValue = @"未识别的工程";
        self.selectedTarget = [[NSMutableArray alloc] init];
    }else {
        self.projectInfoLabel.stringValue = self.project.name;
        
        self.selectedTarget = [[[ONESettingManager defaultManager] getSelectedTargetsForProjectName:self.project.name] mutableCopy];
    }
    
    [self.tableview reloadData];
}



- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.wrappedTargets count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSString *cellIdentity = @"";
    
    if (tableColumn == tableView.tableColumns[0]) {
        cellIdentity = @"TargetCell";
        
        
        ONETargetTableCellView *cell = (ONETargetTableCellView *)[tableView makeViewWithIdentifier:cellIdentity owner:nil];
        
        if (cell != nil) {
            
            cell.row = row;
            
            Xcode3TargetWrapper *targetWapper = self.wrappedTargets[row];
            cell.textField.stringValue = targetWapper.name;
            
            
            if ([self.selectedTarget containsObject:targetWapper.name]) {
                [cell.checkButton setState:NSOnState];
            }else {
                [cell.checkButton setState:NSOffState];
            }
            
            
            cell.checkClickBlock = ^(BOOL checked,NSString *targetName) {
                
                if (checked == YES) {
                    [self.selectedTarget addObject:targetName];
                }else {
                    [self.selectedTarget removeObject:targetName];
                }
            };
            
            
            
            
        }
        return cell;
        
    }else {
        return nil;
    }
    
}



- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)rowIndex {
    NSLog(@"%ld tapped!", (long)rowIndex);
    return NO;
}

@end
