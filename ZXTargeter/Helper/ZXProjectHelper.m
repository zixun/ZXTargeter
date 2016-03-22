//
//  ZXProjectHelper.m
//  ONEXcodePlugin
//
//  Created by user on 16/3/11.
//  Copyright © 2016年 陈奕龙. All rights reserved.
//

#import "ZXProjectHelper.h"
#import "Xcode3TargetMembershipDataSource.h"

@implementation ZXProject


@end

@implementation ZXProjectHelper

+ (ZXProject *)currentProject {
    
    ZXProject *project = [[ZXProject alloc] init];
    
    
    NSArray *workspaceWindowControllers = [NSClassFromString(@"IDEWorkspaceWindowController") valueForKey:@"workspaceWindowControllers"];
    
    id workSpace;
    
    
    for (id controller in workspaceWindowControllers) {
        if ([[controller valueForKey:@"window"] isEqual:[NSApp mainWindow]]) {
            workSpace = [controller valueForKey:@"_workspace"];
        }
    }
    
    project.name = [workSpace valueForKey:@"name"];
    
    NSString *pathString  = [[workSpace valueForKey:@"representingFilePath"] valueForKey:@"pathString"];
    
    if ([pathString hasSuffix:@".xcodeproj"]) {
        NSURL *pathURL = [NSURL URLWithString:pathString];
        
        pathURL = pathURL.URLByDeletingLastPathComponent;
        project.path = [pathURL absoluteString];
        
        
    }
    
    
    return project;
}

+ (NSArray *)allSourceFile {
    ZXProject *project = [ZXProjectHelper currentProject];
    NSArray *arr = [ZXProjectHelper srcFilesAtPath:project.path];
    return arr;
}

+ (NSArray *)srcFilesAtPath:(NSString *)path {
    
    NSMutableArray *result =[[NSMutableArray alloc] init];
    
    NSError *error = nil;
    NSArray *contentOfFolder = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    for (NSString *aPath in contentOfFolder) {
        NSString * fullPath = [path stringByAppendingPathComponent:aPath];
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDir])
        {
            if (isDir == YES) {
                
                if (![aPath isEqualToString:@".git"]) {
                    [result addObjectsFromArray:[[ZXProjectHelper srcFilesAtPath:fullPath] copy]];
                }
            }else {
                NSURL *url = [NSURL URLWithString:fullPath];
                NSString *pathExtension = url.pathExtension;
                
                if ([pathExtension isEqualToString:@"m"]) {
                    [result addObject:fullPath];
                }
            }
        }
    }
    
    return result;

}

@end
