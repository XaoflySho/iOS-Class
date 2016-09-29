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

    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,152,155,156,170,171,176,185,186
     * 电信号段: 133,134,153,170,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,152,155,156,170,171,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[256]|7[016]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,134,153,170,177,180,181,189
     */
    NSString *CT = @"^1(3[34]|53|7[07]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
