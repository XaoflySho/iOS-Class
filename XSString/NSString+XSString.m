//
//  NSString+XSString.m
//  Kuke
//
//  Created by Xaofly Sho on 16/2/23.
//  Copyright © 2016年 Xaofly Sho. All rights reserved.
//

#import "NSString+XSString.h"
#import <CommonCrypto/CommonDigest.h>

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

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param JSONString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryByJSONString:(NSString *)JSONString {
    
    JSONString =[JSONString stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    
    if (JSONString == nil) {
        
        return nil;
        
    }
    
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    
    if(error) {
        
        NSLog(@"JSON解析失败：%@",error);
        
        return nil;
        
    }
    
    return dictionary;
    
}

- (NSString *) sha1 {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *) md5 {
    
    //    const char *cStr = [self UTF8String];
    //    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
