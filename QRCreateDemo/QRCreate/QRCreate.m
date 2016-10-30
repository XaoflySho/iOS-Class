//
//  QRCreate.m
//  QRCreateDemo
//
//  Created by Xaofly Sho on 2016/10/30.
//  Copyright © 2016年 Xaofly Sho. All rights reserved.
//

#import "QRCreate.h"

@implementation QRCreate

+ (UIImage *)createQRWithText:(NSString *)text QRSize:(CGSize)size{
    
    //    数据源，要转换的文字
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    //    获取过滤器（转换器）
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //    重置为默认值
    [filter setDefaults];
    //    数据源加入过滤器
    [filter setValue:data forKeyPath:@"inputMessage"];
    /*
     设置纠错级别（容错率）
     L: 7%的字码可被修正
     M: 15%的字码可被修正，默认
     Q: 25%的字码可被修正
     H: 30%的字码可被修正
     */
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    //    获取转换结果，单位像素为1像素的二维码图片
    CIImage *outputImage = [filter outputImage];
    
    //    计算需要放大倍数
    CGFloat scale = size.width / CGRectGetWidth(outputImage.extent);
    //    设置放大算法
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    //    对图片进行放大
    CIImage *transformImage = [outputImage imageByApplyingTransform:transform];
    
    //    将CIImage数据格式转换为CGImage数据格式保存
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:transformImage fromRect:transformImage.extent];
    
    //    转换为UIImage对象
    UIImage *QRCodeImage = [UIImage imageWithCGImage:imageRef];
    
    return QRCodeImage;
}

@end
