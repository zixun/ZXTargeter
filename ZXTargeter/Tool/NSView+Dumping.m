//
//  NSView+Dumping.m
//  ONEXcodePlugin
//
//  Created by user on 15/11/28.
//  Copyright © 2015年 陈奕龙. All rights reserved.
//

#import "NSView+Dumping.h"

@implementation NSView (Dumping)

-(void)dumpWithIndent:(NSString *)indent {
    NSString *class = NSStringFromClass([self class]);
    NSString *info = @"";
    if ([self respondsToSelector:@selector(title)]) {
        NSString *title = [self performSelector:@selector(title)];
        if (title != nil && [title length] > 0) {
            info = [info stringByAppendingFormat:@" title=%@", title];
        }
    }
    if ([self respondsToSelector:@selector(stringValue)]) {
        NSString *string = [self performSelector:@selector(stringValue)];
        if (string != nil && [string length] > 0) {
            info = [info stringByAppendingFormat:@" stringValue=%@", string];
        }
    }
    NSString *tooltip = [self toolTip];
    if (tooltip != nil && [tooltip length] > 0) {
        info = [info stringByAppendingFormat:@" tooltip=%@", tooltip];
    }
    
    NSLog(@"%@%@%@", indent, class, info);
    
    if ([[self subviews] count] > 0) {
        NSString *subIndent = [NSString stringWithFormat:@"%@%@", indent, ([indent length]/2)%2==0 ? @"| " : @": "];
        for (NSView *subview in [self subviews]) {
            [subview dumpWithIndent:subIndent];
        }
    }
}

- (NSView *)findViewByClass:(Class)clazz title:(NSString *)title {
    
    if ([self isKindOfClass:clazz] && [self respondsToSelector:@selector(title)] && [[self performSelector:@selector(title)] isEqualToString:title ] ) {
        return self;
    }else {
        
        if ([[self subviews] count] > 0) {
            
            
            
            NSView *result = nil;
            for (NSInteger i = 0; i < [[self subviews] count]; i++ ) {
                NSView *subview = [self subviews][i];
                NSView *v = [subview findViewByClass:clazz title:title];

                if (v != nil) {
                     result = v;
                }
            }
            
            return result;
        }else {
            return nil;
        }
    }
}

@end
