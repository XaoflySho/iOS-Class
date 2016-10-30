//
//  ViewController.m
//  QRCreateDemo
//
//  Created by Xaofly Sho on 2016/10/30.
//  Copyright © 2016年 Xaofly Sho. All rights reserved.
//

#import "ViewController.h"
#import "QRCreate.h"

@interface ViewController ()

@property (nonatomic) IBOutlet UITextView *inputTextView;

@property (nonatomic) IBOutlet UIImageView *outputImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (IBAction)createButtonClick:(id)sender {
    
    [self.view endEditing:YES];
    
    NSString *text = self.inputTextView.text;
    
    self.outputImageView.image = [QRCreate createQRWithText:text QRSize:CGSizeMake(CGRectGetWidth(self.outputImageView.bounds), CGRectGetHeight(self.outputImageView.bounds))];
    
}

- (IBAction)saveQRCodeToPhotosAlbum:(id)sender {
    
    UIImage* image = self.outputImageView.image;
    
    if (!image) {
        
        [self createButtonClick:nil];
        
    }
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:), NULL);
    
}

//图片保存完后调用的方法
- (void)onCompleteCapture:(UIImage *)screenImage didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    
    NSLog(@"%@", error);
    
    if (error){
        
        //保存失败
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"失败" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        
    }else {
        
        //保存成功
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"保存成功" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
