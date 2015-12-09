//
//  FCFileCacheHelper.h
//  gitDemo
//
//  Created by John on 15/12/9.
//  Copyright © 2015年 FeverCat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface FCFileCacheHelper : NSObject
+ (void)clearCache;
+ (CGFloat)cacheFileSize;
@end
