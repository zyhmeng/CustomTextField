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
    
    //leftView只有文字  下面带细线
    
    [self.textField setLeftTextFont:18];
    [self.textField setInputTextFontColor:[UIColor redColor]];
    [self.textField setLeftTextFontColor:[UIColor redColor]];
    [self.textField setFineLineColor:[UIColor redColor]];
    [self.textField setupTextFieldWithLeftViewText:@"百度一下："  textViewLeftViewSpacing:10 andFineLine:YES];
    [self.textField setFineLineColor:[UIColor redColor]];
    [self.textField setPlaceholder:@"百度一下，你就知道"];
    
    //leftView只有文字  下面不带细线
    [self.textField1 setupTextFieldWithLeftViewText:@"百度：" textViewLeftViewSpacing:10 andFineLine:NO];
    
    //leftView带有图片
    [self.textField2 setupTextFieldWithLeftViewImage:[UIImage imageNamed:@"pic_user"] textViewLeftViewSpacing:10 andFineLine:YES];
    
    //leftView带有图片文字
    [self.textField3 setupTextFieldWithFineLine:YES];
    
}


@end
