//
//  FCFileCacheHelper.m
//  gitDemo
//
//  Created by John on 15/12/9.
//  Copyright © 2015年 FeverCat. All rights reserved.
//

#import "FCFileCacheHelper.h"

@implementation FCFileCacheHelper

+ (NSString *)cacheFilePath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return cachePath;
}

+ (CGFloat)cacheFileSize {
    return [self filesSizeAtPath:[self cacheFilePath]];
}

+ (void)clearCache {
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachePath = [self cacheFilePath];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachePath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
    });
}

+ (long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (CGFloat)filesSizeAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    long long folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *abosolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self filesSizeAtPath:abosolutePath];
        }
        return folderSize/1024.0/1024.0;
    }
    return 0;
}

+ (void)clearCacheSuccess {
    //    NSLog(@"清理成功");
    //    NSLog(@"%f",[self cacheFileSize]);
}
@end
