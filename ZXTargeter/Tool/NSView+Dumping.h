//
//  NSView+Dumping.h
//  ONEXcodePlugin
//
//  Created by user on 15/11/28.
//  Copyright © 2015年 陈奕龙. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (Dumping)

-(void)dumpWithIndent:(NSString *)indent;

- (NSView *)findViewByClass:(Class)clazz title:(NSString *)title;
@end
