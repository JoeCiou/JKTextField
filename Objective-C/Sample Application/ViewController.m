//
//  ViewController.m
//  Sample Application
//
//  Created by joe on 2015/12/10.
//  Copyright (c) 2015年 joe. All rights reserved.
//

#import "ViewController.h"
#import "JKTextField.h"

@interface ViewController (){
    JKTextField *usernameField;
    JKTextField *passwordField;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    usernameField = [[JKTextField alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 100, 200, 50)];
    usernameField.font = [UIFont systemFontOfSize:16];
    usernameField.placeholder = @"Username";
    usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameField.keyboardType = UIKeyboardTypeEmailAddress;
    usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:usernameField];
    
    passwordField = [[JKTextField alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 170, 200, 50)];
    passwordField.font = [UIFont systemFontOfSize:16];
    passwordField.placeholder = @"Password";
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [usernameField show];
    [passwordField show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)hiddenKeyboard{
    if ([usernameField isFirstResponder]){
        [usernameField resignFirstResponder];
    }else if ([passwordField isFirstResponder]){
        [passwordField resignFirstResponder];
    }
}

@end
