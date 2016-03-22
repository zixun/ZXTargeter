//
//  ONETargetTableCellView.m
//  ONEXcodePlugin
//
//  Created by user on 16/3/16.
//  Copyright © 2016年 陈奕龙. All rights reserved.
//

#import "ONETargetTableCellView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ONETargetTableCellView ()

@end

@implementation ONETargetTableCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
    self.checkButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSButton *btn = (NSButton *)input;
        if (btn.state == NSOnState) {
            NSLog(@"ON");
            if (self.checkClickBlock) {
                self.checkClickBlock(true,self.textField.stringValue);
            }
            
        }else if (btn.state == NSOffState) {
            NSLog(@"OFF");
            if (self.checkClickBlock) {
                self.checkClickBlock(false,self.textField.stringValue);
            }
        }else {
            NSLog(@"UNKNOW");
        }
        
        return [RACSignal empty];
    }];
}

@end
