//
//  ZXProjectHelper.h
//  ONEXcodePlugin
//
//  Created by user on 16/3/11.
//  Copyright © 2016年 陈奕龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXProject : NSObject

@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString *path;


@end

@interface ZXProjectHelper : NSObject

+ (ZXProject *)currentProject;

+ (NSArray *)allSourceFile;

@end
