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


@property (nonatomic, strong) UIColor *borderLineColor;
@property (nonatomic) CGFloat borderLineWidth;
@property (nonatomic) CGFloat borderCornerRadius;
@property (nonatomic) CGFloat yfTextFieldHight;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) NSString *placeholderText;
@end

@implementation YFTextField

#pragma mark - 枚举设置textField的类型
- (void)setYFTextFieldBorderStyle:(YFTextFieldBorderStyle)style
{
    switch (style) {
        case YFTextFieldBorderStyleNone:
        {
            self.borderStyle = UITextBorderStyleNone;
        }
            break;
        case YFTextFieldBorderStyleUnderLine:
        {
            self.borderStyle = UITextBorderStyleNone;
            _fineLine = YES;
        }
            break;
        case YFTextFieldBorderStyleCustomRoundedRect:
        {
            [self.layer setBorderColor:self.borderLineColor.CGColor];
            [self.layer setBorderWidth:self.borderLineWidth];
            [self.layer setCornerRadius:self.borderCornerRadius];
        }
            break;
        case YFTextFieldBorderStyleSystemRoundedRect:
        {
            self.borderStyle = UITextBorderStyleRoundedRect;
        }
            break;
        default:
            break;
    }
}

#pragma mark - 只有图片的leftView
- (void)setYFTextFieldWithLeftViewImage:(UIImage *)leftImage spacing:(CGFloat)spacing imageWH:(CGSize)imageWH
{
    //计算leftView的尺寸
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, imageWH.width + spacing, imageWH.height)];
    
    //设置leftView
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, imageWH.width, imageWH.height)];
    //设置图片
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    [leftView addSubview:leftButton];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;

}

#pragma mark - 只有文字的leftView
- (void)setYFTextFieldWithLeftViewText:(NSString *)leftViewText spacing:(CGFloat)spacing textFont:(UIFont *)textFont andTextColor:(UIColor *)textColor
{
    // 根据字数得到view尺寸
    CGRect textRect = [self computeTextRectWith:leftViewText andTextFont:textFont];
    
    //计算leftView的尺寸
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, textRect.size.width + spacing, self.textFieldHight)];
    
    //设置leftView
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, textRect.size.width, self.textFieldHight)];
    
    [leftButton setTitle:leftViewText forState:UIControlStateNormal];
    [leftButton setTitleColor:textColor forState:UIControlStateNormal];
    //设置leftText font
    leftButton.titleLabel.font = textFont;
    
    [leftView addSubview:leftButton];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - setup border line
- (void)setYFTextFieldWithBorderLineColor:(UIColor *)color andWidth:(CGFloat)width
{
    _borderLineColor = color;
    _borderLineWidth = width;
}

#pragma mark - setup border corner radius
- (void)setYFTextFieldWithBorderCornerRadius:(CGFloat)radius
{
    _borderCornerRadius = radius;
}

#pragma mark - setup placeholder
- (void)setYFTextFieldWithPlaceholderText:(NSString *)placeholderText textFont:(UIFont *)font andTextColor:(UIColor *)color
{
    _placeholderColor = color;
    _placeholderFont = font;
    _placeholderText = placeholderText;
    [self setPlaceholder:placeholderText];
}

#pragma mark - 调用一些系统的方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.yfTextFieldHight = self.frame.size.height;
        [self fontAndFineLineColorInit];
        [self configAttributeInit];
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.yfTextFieldHight = self.frame.size.height;
        [self fontAndFineLineColorInit];
        [self configAttributeInit];
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
    _leftTextFontColor = [UIColor lightGrayColor];
}


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
//    _fineLine = fineLine;
}

#pragma mark - 只有文字的leftView
- (void)setupTextFieldWithLeftViewText:(NSString *)leftViewText spacing:(CGFloat)spacing textFont:(UIFont *)textFont andTextColor:(UIColor *)textColor
{
    // 根据字数设置view尺寸
    CGFloat leftViewTextWidth = [self setLeftViewTextWidth:leftViewText];
    
    //计算leftView的尺寸
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftViewTextWidth + spacing, self.textFieldHight)];
    
    //设置leftView
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, leftViewTextWidth, self.textFieldHight)];
    
    [leftButton setTitle:leftViewText forState:UIControlStateNormal];
    [leftButton setTitleColor:textColor forState:UIControlStateNormal];
    //设置leftText font
    leftButton.titleLabel.font = textFont;
    
    [leftView addSubview:leftButton];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;

}
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
//    self.fineLine = fineLine;
}

#pragma mark - 没有leftView
- (void)setupTextFieldWithFineLine:(BOOL)fineLine
{
    //设置inputTextFontColor
    [self setTextColor:self.inputTextFontColor];
//    self.fineLine = fineLine;
}



#pragma mark - 根据字数设置leftViewText的尺寸
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
#pragma mark - 根据字体大小多少计算尺寸
- (CGRect)computeTextRectWith:(NSString *)text andTextFont:(UIFont *)textFont
{
    //根据字数设置leftViewText的尺寸
    CGFloat maxWidth = 200;
    CGSize maxSize = CGSizeMake(maxWidth,CGFLOAT_MAX);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : textFont, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [text boundingRectWithSize:maxSize
                                     options:opts
                                  attributes:attributes
                                     context:nil];
    return rect;
    
}

- (void)drawRect:(CGRect)rect {
    if (self.fineLine) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, self.borderLineColor.CGColor);
        CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), self.borderLineWidth));
    }
    
}

#pragma mark - 写一些属性的set方法
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

#pragma mark - 居中placeholder的文字
- (void)drawPlaceholderInRect:(CGRect)rect {
    //draw place holder.
    if (self.placeholderText != nil && self.placeholderFont != nil) {
        CGRect placeholderTextRect = [self computeTextRectWith:self.placeholderText andTextFont:self.placeholderFont];
        CGRect placeholderRect = CGRectMake(0, (self.frame.size.height-placeholderTextRect.size.height)*0.5, rect.size.width, rect.size.height);
        
        [[self placeholder] drawInRect:placeholderRect withAttributes:@{NSForegroundColorAttributeName:self.placeholderColor,NSFontAttributeName:self.placeholderFont}];
        
    }
}



@end

