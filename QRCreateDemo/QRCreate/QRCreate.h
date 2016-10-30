//
//  QRCreate.h
//  QRCreateDemo
//
//  Created by Xaofly Sho on 2016/10/30.
//  Copyright © 2016年 Xaofly Sho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QRCreate : NSObject

+ (UIImage *)createQRWithText:(NSString *)text QRSize:(CGSize)size;

@end
