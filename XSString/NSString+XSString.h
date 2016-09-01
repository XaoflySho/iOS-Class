//
//  NSString+XSString.h
//  Kuke
//
//  Created by Xaofly Sho on 16/2/23.
//  Copyright © 2016年 Xaofly Sho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XSString)

/*
 移除字符串中的HTML标签
 */
- (NSString *)stringByRemovingHTMLMark;

/*
 生成一个由大写英文字母组成的随机字符串
 */
+ (NSString *)generatesRandomStringWithLength:(int)lenght;

/*
 将JSON对象（NSArray、NSDictionary）转换为字符串
 */
+ (NSString *)stringByJSONObject:(id)JSONObject;

@end
