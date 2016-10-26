//
//  NSString+XSString.h
//  Kuke
//
//  Created by Xaofly Sho on 16/2/23.
//  Copyright © 2016年 Xaofly Sho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (XSString)

/*!
 移除字符串中的HTML标签
 
 @return NSString 移除HTML标签后的字符串
 */
- (NSString *)stringByRemovingHTMLMark;

/*!
 生成一个由大写英文字母组成的随机字符串
 
 @param lenght 字符串长度
 
 @return NSString 生成的相应长度的字符串
 */
+ (NSString *)generatesRandomStringWithLength:(int)lenght;

/*!
 将JSON对象（NSArray、NSDictionary）转换为字符串
 
 @param JSONObject JSON对象（NSArray、NSDictionary）
 
 @return NSString 转换后的字符串
 */
+ (NSString *)stringByJSONObject:(id)JSONObject;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param JSONString JSON格式的字符串
 * @return NSDictionary 返回字典
 */
+ (NSDictionary *)dictionaryByJSONString:(NSString *)JSONString;

/*!
 对字符串进行SHA1计算
 
 @return NSString 计算结果
 */
- (NSString *) sha1;

/*!
 对字符串进行MD5计算
 
 @return NSString 计算结果
 */
- (NSString *) md5;


/**
 手机号码判断

 @param mobileNum 手机号

 @return 是否为手机号
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


/**
 计算字符串大小

 @param string 需要计算的字符串
 @param width 最大宽度
 @param fontSize 最大高度
 @return 计算结果
 */
+ (CGSize)textSizeWithString:(NSString *)string maxWidth:(CGFloat)width maxHigh:(CGFloat)high fontSize:(CGFloat)fontSize;

@end
