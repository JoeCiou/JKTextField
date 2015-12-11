//
//  JKTextField.m
//  
//
//  Created by joe on 2015/12/10.
//
//

#import "JKTextField.h"

typedef NS_ENUM(NSUInteger, JKPlaceholderStatus) {
    JKPlaceholderStatusMajor,
    JKPlaceholderStatusTitle
};

@interface JKTextField ()<UITextFieldDelegate>{
    JKPlaceholderStatus placeholderStatus;
    UITextField *_textField;
    UILabel *_placeholderLabel;
    UIImageView *_baseline;
}

@end

@implementation JKTextField

- (instancetype)init{
    self = [super init];
    if (self){
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
        [self setFrame:frame];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    self.layer.masksToBounds = YES;
    _textColor = [UIColor colorWithWhite:1 alpha:0.9];
    _placeholderColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    _font = [UIFont systemFontOfSize:16];
    _secureTextEntry = NO;
    _autocorrectionType = UITextAutocorrectionTypeDefault;
    _clearButtonMode = UITextFieldViewModeNever;
    _keyboardType = UIKeyboardTypeDefault;
    placeholderStatus = JKPlaceholderStatusMajor;
    
    _textField = [[UITextField alloc]init];
    _textField.textColor = _textColor;
    _textField.tintColor = _textColor;
    _textField.font = _font;
    _textField.delegate = self;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.enabled = NO;
    [self addSubview:_textField];
    
    _placeholderLabel = [[UILabel alloc]init];
    _placeholderLabel.textColor = _placeholderColor;
    _placeholderLabel.font = _font;
    _placeholderLabel.transform = CGAffineTransformScale(_placeholderLabel.transform, 1, 1);
    [self addSubview:_placeholderLabel];
    
    _baseline = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    _baseline.backgroundColor = _textColor;
    [self addSubview:_baseline];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showKeyboard)];
    [self addGestureRecognizer:tap];
    
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _textField.frame = CGRectMake(5, frame.size.height*0.4, frame.size.width-5, frame.size.height*0.5);
    _placeholderLabel.frame = CGRectMake(5, _textField.frame.origin.y, _textField.frame.size.width, _textField.frame.size.height);
    _baseline.frame = CGRectMake(0, frame.size.height-1, frame.size.width, 1);
}

- (void)setText:(NSString *)text{
    _text = text;
    _textField.text = text;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _textField.textColor = textColor;
    _textField.tintColor = textColor;
    _baseline.backgroundColor = textColor;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _placeholderLabel.text = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    _placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font{
    _font = font;
    _textField.font = font;
    _placeholderLabel.font = font;
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode{
    _clearButtonMode = clearButtonMode;
    _textField.clearButtonMode = clearButtonMode;
}

- (void)setAutocorrectionType:(UITextAutocorrectionType)autocorrectionType{
    _autocorrectionType = autocorrectionType;
    _textField.autocorrectionType = autocorrectionType;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType{
    _keyboardType = keyboardType;
    _textField.keyboardType = keyboardType;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry{
    _secureTextEntry = secureTextEntry;
    _textField.secureTextEntry = secureTextEntry;
}

- (void)show{
    if (placeholderStatus == JKPlaceholderStatusMajor){
        CGRect baselineRect = _baseline.frame;
        CGRect placeholderRect = _placeholderLabel.frame;
        _baseline.frame = CGRectMake(0, baselineRect.origin.y, 0, baselineRect.size.height);
        _placeholderLabel.frame = CGRectMake(placeholderRect.origin.x, self.frame.size.height, placeholderRect.size.width, placeholderRect.size.height);
        [UIView animateWithDuration:0.8 animations:^{
            _baseline.frame = baselineRect;
            _placeholderLabel.frame = placeholderRect;
        }];
    }
}

- (void)showKeyboard{
    if (placeholderStatus == JKPlaceholderStatusMajor){
        placeholderStatus = JKPlaceholderStatusTitle;
        [UIView animateWithDuration:0.3 animations:^{
            _placeholderLabel.transform = CGAffineTransformScale(_placeholderLabel.transform, 0.7f, 0.7f);
            _placeholderLabel.frame = CGRectMake(5, 0, _placeholderLabel.frame.size.width, _placeholderLabel.frame.size.height);
        }];
    }
    _textField.enabled = YES;
    [_textField becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder{
    return [_textField canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder{
    return [_textField becomeFirstResponder];
}

- (BOOL)canResignFirstResponder{
    return [_textField canResignFirstResponder];
}

- (BOOL)resignFirstResponder{
    return [_textField resignFirstResponder];
}

- (BOOL)isFirstResponder{
    return [_textField isFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _textField.enabled = NO;
    if (placeholderStatus == JKPlaceholderStatusTitle && [_textField.text isEqualToString:@""]){
        placeholderStatus = JKPlaceholderStatusMajor;
        [UIView animateWithDuration:0.3 animations:^{
            _placeholderLabel.transform = CGAffineTransformScale(_placeholderLabel.transform, 1/0.7f, 1/0.7f);
            _placeholderLabel.frame = CGRectMake(5, _textField.frame.origin.y, _textField.frame.size.width, _textField.frame.size.height);
        }];
    }
}





@end
