//
//  YFTextField.h
//  YFTextField
//
//  Created by zyh on 15/12/16.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YFTextField : UITextField

//DefaulColor lightGrayColor
@property (nonatomic, strong) UIColor *leftTextFontColor;
@property (nonatomic, strong) UIColor *inputTextFontColor;
@property (nonatomic, strong) UIColor *fineLineColor;

//DefaulttextFieldLeftViewImageWH 21
@property (nonatomic, assign) CGFloat textFieldLeftViewImageWH;

//DefaultLeftTextFont   14
@property (nonatomic)  int  leftTextFont;

//DefaultTextFieldHight 30
@property (nonatomic)  int  textFieldHight;

//textField  leftViewWithImage
- (void)setupTextFieldWithLeftViewImage:(UIImage *)leftImage textViewLeftViewSpacing:(CGFloat)spacing andFineLine:(BOOL)fineLine;

//textfield  leftViewWithText
- (void)setupTextFieldWithLeftViewText:(NSString *)leftViewText textViewLeftViewSpacing:(CGFloat)spacing andFineLine:(BOOL)fineLine;

//textfield  no leftView
- (void)setupTextFieldWithFineLine:(BOOL)fineLine;

@end
