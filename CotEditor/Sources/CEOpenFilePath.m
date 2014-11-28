//
//  CEOpenFilePath.m
//  CotEditor
//
//  Created by WANG WEI on 2014/11/28.
//  Copyright (c) 2014年 CotEditor Project. All rights reserved.
//

#import "CEOpenFilePath.h"

@implementation CEOpenFilePath

+ (instancetype)openFilePathWithUrl:(NSURL *)url {
    return [[[self class] alloc] initWithUrl:url];
}

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        NSError *lineColumnError;
        NSError *lineError;
        
        // Regular expression for some file name as file://YourPath/fileName.m:4 or file://YourPath/fileName.m:4:10
        // 4:10 means line 4, column 10
        NSRegularExpression *lineColumnReg = [NSRegularExpression regularExpressionWithPattern:@"^(.+):([0-9]+:[0-9]+)$" options:NSRegularExpressionSearch error:&lineColumnError];
        NSRegularExpression *lineReg = [NSRegularExpression regularExpressionWithPattern:@"^(.+):([0-9]+)$" options:NSRegularExpressionSearch error:&lineError];
        
        if (lineColumnError || lineError) {
            //NSAssert(false, @"The error should be always nil.");
            return self;
        }
        
        NSString *filePath = url.absoluteString;
        NSRange filePathRange = NSMakeRange(0, filePath.length);
        
        //Check if file path match one of these regex.
        NSTextCheckingResult *result = [lineColumnReg firstMatchInString:filePath options:kNilOptions range:filePathRange] ?:
                                       [lineReg firstMatchInString:filePath options:kNilOptions range:filePathRange];
        if (result) { //No match. It seems a plain file path
            NSRange fileNameRange = [result rangeAtIndex:1]; //Range for file name. (.+) in the reg expression. index 0 is the whole string
            NSRange positionRange = [result rangeAtIndex:2]; //Range for line/columm
            
            _fileURL = [NSURL URLWithString:[filePath substringWithRange:fileNameRange]];
            _positionString = [filePath substringWithRange:positionRange];
        }
    }
    return self;
}

-(BOOL)containsPosition {
    return [self.positionString length] != 0;
}

@end
