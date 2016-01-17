//
//  ViewController.m
//  YFTextField
//
//  Created by zyh on 15/12/16.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "ViewController.h"
#import "YFTextField.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet YFTextField *textField;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet YFTextField *textField1;
@property (strong, nonatomic) IBOutlet YFTextField *textField2;
@property (strong, nonatomic) IBOutlet YFTextField *textField3;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    //leftView只有文字  下面不带细线
//    [self.textField1 setYFTextFieldBorderStyle:YFTextFieldBorderStyleUnderLine];
//    [self.textField1 setYFTextFieldWithBorderLineColor:[UIColor redColor] andWidth:1];
//    [self.textField1 setYFTextFieldWithLeftViewText:@"百度：" spacing:10 textFont:[UIFont systemFontOfSize:16] andTextColor:[UIColor redColor]];
//    [self.textField1 setYFTextFieldWithPlaceholderText:@"百度一下" textFont:[UIFont systemFontOfSize:12] andTextColor:[UIColor lightGrayColor]];
    
    
    [self.textField1 setYFTextFieldBorderStyle:YFTextFieldBorderStyleCustomRoundedRect];
    [self.textField1 setYFTextFieldWithBorderCornerRadius:10];
    [self.textField1 setYFTextFieldWithBorderLineColor:[UIColor redColor] andWidth:5];
    [self.textField1 setYFTextFieldWithLeftViewImage:[UIImage imageNamed:@"pic_user"] spacing:10 imageWH:CGSizeMake(21, 21)];
    
    
    
    
    
    //没有 leftView
    
    [self.textField3 setYFTextFieldBorderStyle:YFTextFieldBorderStyleUnderLine];
    [self.textField3 setYFTextFieldWithBorderLineColor:[UIColor lightGrayColor] andWidth:1];
    [self.textField3 setYFTextFieldWithPlaceholderText:@"百度一下" textFont:[UIFont systemFontOfSize:13] andTextColor:[UIColor lightGrayColor]];
    
    //自己初始化的textfield
    YFTextField *yfTextField = [[YFTextField alloc]initWithFrame:CGRectMake(20, 90, 200, 30)];
    [yfTextField setYFTextFieldBorderStyle:YFTextFieldBorderStyleUnderLine];
    [yfTextField setYFTextFieldWithLeftViewText:@"百度：" spacing:10 textFont:[UIFont systemFontOfSize:14] andTextColor:[UIColor lightGrayColor]];
    [yfTextField setYFTextFieldWithBorderLineColor:[UIColor lightGrayColor] andWidth:1];
    [self.view addSubview:yfTextField];
    
}


@end
