//
//  NSString+XSString.m
//  Kuke
//
//  Created by Xaofly Sho on 16/2/23.
//  Copyright © 2016年 Xaofly Sho. All rights reserved.
//

#import "NSString+XSString.h"

@implementation NSString (XSString)

- (NSString *)stringByRemovingHTMLMark {
    
    NSString *string = self;
    
    NSScanner * scanner = [NSScanner scannerWithString:string];
    NSString * HTMLmark = nil;
    
    while(![scanner isAtEnd]) {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&HTMLmark];
        //替换字符
        string = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",HTMLmark] withString:@""];
    }
    
    return string;
}

+ (NSString *)generatesRandomStringWithLength:(int)length {
    
    char data[length];
    
    for (int x=0; x < length; data[x ++] = (char)('A' + (arc4random_uniform(26))));
    
    NSString *randomString =[[NSString alloc]initWithBytes:data length:length encoding:NSUTF8StringEncoding];
    
    return randomString;
    
}

+ (NSString *)stringByJSONObject:(id)JSONObject {
    
    NSString *JSONString = nil;
    
    if ([NSJSONSerialization isValidJSONObject:JSONObject]) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:JSONObject options:NSJSONWritingPrettyPrinted error:nil];
        JSONString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
    }else {
        
        NSLog(@"Error! Not is valid JSONObject.");
        
    }
    
    return JSONString;
    
}

@end
