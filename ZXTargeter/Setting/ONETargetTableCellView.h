//
//  ONETargetTableCellView.h
//  ONEXcodePlugin
//
//  Created by user on 16/3/16.
//  Copyright © 2016年 陈奕龙. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ONETargetTableCellView : NSTableCellView

@property (nonatomic, assign) NSInteger row;

@property (weak) IBOutlet NSButton *checkButton;

@property(nonatomic, copy) void (^checkClickBlock)(BOOL checked,NSString *targetName);
@end
