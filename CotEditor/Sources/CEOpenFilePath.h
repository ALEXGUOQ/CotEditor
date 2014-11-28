//
//  CEOpenFilePath.h
//  CotEditor
//
//  Created by WANG WEI on 2014/11/28.
//  Copyright (c) 2014年 CotEditor Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CEOpenFilePath : NSObject

@property (nonatomic, copy) NSURL *fileURL;
@property (nonatomic, copy) NSString *positionString;
@property (nonatomic, readonly) BOOL containsPosition;

+ (instancetype) openFilePathWithUrl:(NSURL *)url;

@end
