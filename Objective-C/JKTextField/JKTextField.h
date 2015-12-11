//
//  JKTextField.h
//  
//
//  Created by joe on 2015/12/10.
//
//

#import <UIKit/UIKit.h>

@interface JKTextField : UIView

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;

@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;

@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, assign) BOOL secureTextEntry;


- (void)show;

@end
