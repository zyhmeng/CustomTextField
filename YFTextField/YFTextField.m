//
//  YFTextField.m
//  YFTextField
//
//  Created by zyh on 15/12/16.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "YFTextField.h"

@interface YFTextField()
@property (nonatomic, assign) CGRect textFieldWH;
@property (nonatomic) BOOL fineLine;
@end

@implementation YFTextField


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self fontAndFineLineColorInit];
        [self configAttributeInit];
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textFieldWH = self.frame;
    }
    return self;
}
- (void)configAttributeInit
{
    _leftTextFont = 14;
    _textFieldHight = 30;
    _textFieldLeftViewImageWH = 21;
}
- (void)fontAndFineLineColorInit
{
    _fineLineColor = [UIColor lightGrayColor];
    _inputTextFontColor = [UIColor lightGrayColor];
    _fineLineColor = [UIColor lightGrayColor];
}
//只有图片的leftView
- (void)setupTextFieldWithLeftViewImage:(UIImage *)leftImage textViewLeftViewSpacing:(CGFloat)spacing andFineLine:(BOOL)fineLine
{
    //设置inputTextFontColor
    [self setTextColor:self.inputTextFontColor];
    //计算leftView的尺寸
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.textFieldLeftViewImageWH + spacing, self.textFieldLeftViewImageWH)];
    
    //设置leftView
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.textFieldLeftViewImageWH, self.textFieldLeftViewImageWH)];
    //设置图片
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    [leftView addSubview:leftButton];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.borderStyle = UITextBorderStyleNone;
    [self setNeedsLayout];
    [self setNeedsDisplay];
    [self layoutIfNeeded];
    _fineLine = fineLine;
//    if (fineLine) {
//        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.textFieldWH.size.height-1, self.textFieldWH.size.width, 1)];
//        image.backgroundColor = self.fineLineColor;
//        [self addSubview:image];
//    }
}

//只有文字的leftView
- (void)setupTextFieldWithLeftViewText:(NSString *)leftViewText textViewLeftViewSpacing:(CGFloat)spacing andFineLine:(BOOL)fineLine
{
    //设置inputTextFontColor
    [self setTextColor:self.inputTextFontColor];
    // 根据字数设置view尺寸
    CGFloat leftViewTextWidth = [self setLeftViewTextWidth:leftViewText];
    
    //计算leftView的尺寸
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftViewTextWidth + spacing, self.textFieldHight)];
    
    //设置leftView
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, leftViewTextWidth, self.textFieldHight)];
    
    [leftButton setTitle:leftViewText forState:UIControlStateNormal];
    [leftButton setTitleColor:self.leftTextFontColor forState:UIControlStateNormal];
    //设置leftText font
    leftButton.titleLabel.font = [UIFont systemFontOfSize:self.leftTextFont];
    
    [leftView addSubview:leftButton];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    self.borderStyle = UITextBorderStyleNone;
    self.fineLine = fineLine;
//    if (fineLine) {
//        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, ScreenWidth, 1)];
//        image.backgroundColor = self.fineLineColor;
//        [self addSubview:image];
//    }
}
//textfield  没有leftView
- (void)setupTextFieldWithFineLine:(BOOL)fineLine
{
    //设置inputTextFontColor
    [self setTextColor:self.inputTextFontColor];
    self.fineLine = fineLine;
//    if (fineLine) {
//        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, ScreenWidth, 1)];
//        image.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:image];
//    }
}


//根据字数设置leftViewText的尺寸
- (CGFloat)setLeftViewTextWidth:(NSString *)leftViewText
{
    //根据字数设置leftViewText的尺寸
    CGFloat maxWidth = 200;
    CGSize maxSize = CGSizeMake(maxWidth,CGFLOAT_MAX);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    UIFont *font = [UIFont systemFontOfSize:self.leftTextFont];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [leftViewText boundingRectWithSize:maxSize
                                             options:opts
                                          attributes:attributes
                                             context:nil];
    return rect.size.width;
}

- (void)drawRect:(CGRect)rect {
    if (self.fineLine) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, self.fineLineColor.CGColor);
        CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1));
    }
    
}

- (void)setLeftTextFont:(int)leftTextFont
{
    _leftTextFont = leftTextFont;
}

- (void)setTextFieldLeftViewImageWH:(CGFloat)textFieldLeftViewImageWH
{
    _textFieldLeftViewImageWH = textFieldLeftViewImageWH;
}

- (void)setTextFieldHight:(int)textFieldHight
{
    _textFieldHight = textFieldHight;
}
- (void)setFineLineColor:(UIColor *)fineLineColor
{
    _fineLineColor = fineLineColor;
    
}

- (void)setInputTextFontColor:(UIColor *)inputTextFontColor
{
    _inputTextFontColor = inputTextFontColor;
}

- (void)setLeftTextFontColor:(UIColor *)leftTextFontColor
{
    _leftTextFontColor = leftTextFontColor;
}

- (void)setTextFieldWH:(CGRect)textFieldWH
{
    _textFieldWH = textFieldWH;
}


/*

//图片文字都有的leftView
- (void)setupTextFieldWithLeftViewImage:(UIImage *)leftImage  leftViewText:(NSString *)leftViewText textViewLeftViewSpacing:(CGFloat)spacing andFineLine:(BOOL)fineLine
{
    
    //根据字数设置view尺寸
    CGFloat leftViewTextWidth = [self setLeftViewTextWidth:leftViewText];
    //计算leftView的尺寸
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftViewTextWidth + self.textFieldLeftViewImageWH + spacing, DefaultTextFieldHight)];
    
    //设置leftView
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, leftViewTextWidth + self.textFieldLeftViewImageWH + spacing, DefaultTextFieldHight)];
    //设置图片
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    //设置文字
    [leftButton setTitle:leftViewText forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    leftButton.titleLabel.font = [UIFont systemFontOfSize:DefaultLeftTextFont];
    leftButton.titleLabel.textColor = [UIColor lightGrayColor];
    
    [leftView addSubview:leftButton];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.borderStyle = UITextBorderStyleNone;
    if (fineLine) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, DefaultTextFieldHight-1, ScreenWidth, 1)];
        image.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:image];
    }
    
}

*/


@end

