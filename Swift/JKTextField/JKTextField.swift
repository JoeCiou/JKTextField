//
//  JKTextField.swift
//  
//
//  Created by joe on 2015/12/11.
//
//

import UIKit

enum JKPlaceholderStatus{
    case Major
    case Title
}

class JKTextField: UIView,UITextFieldDelegate {

    var text: String = ""{
        didSet{
            textField.text = text;
        }
    }
    var textColor: UIColor = UIColor(white: 1, alpha: 0.9){
        didSet{
            textField.textColor = textColor;
            textField.tintColor = textColor;
            baseline.backgroundColor = textColor;
        }
    }
    var placeholder: String = ""{
        didSet{
            placeholderLabel.text = placeholder;
        }
    }
    var placeholderColor: UIColor = UIColor(white: 0.9, alpha: 0.7){
        didSet{
            placeholderLabel.textColor = placeholderColor;
        }
    }
    var font: UIFont = UIFont.systemFontOfSize(16){
        didSet{
            textField.font = font;
            placeholderLabel.font = font;
        }
    }
    var clearButtonMode: UITextFieldViewMode = UITextFieldViewMode.Never{
        didSet{
            textField.clearButtonMode = clearButtonMode;
        }
    }
    var autoacorrectionType: UITextAutocorrectionType = UITextAutocorrectionType.Default{
        didSet{
            textField.autocorrectionType = autoacorrectionType;
        }
    }
    var keyboardType: UIKeyboardType = UIKeyboardType.Default{
        didSet{
            textField.keyboardType = keyboardType;
        }
    }
    var secureTextEntry: Bool = false{
        didSet{
            textField.secureTextEntry = secureTextEntry;
        }
    }
    
    private var placeholderStatus: JKPlaceholderStatus = JKPlaceholderStatus.Major;
    private var textField: UITextField = UITextField();
    private var placeholderLabel: UILabel = UILabel();
    private var baseline: UIImageView = UIImageView();

    init(){
        super.init(frame: CGRectZero);
        initView();
    }
    
    override init(frame: CGRect){
        super.init(frame: frame);
        initView();
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView();
    }
    
    private func initView(){
        self.layer.masksToBounds = true;
        
        textField.textColor = textColor;
        textField.tintColor = textColor;
        textField.font = font;
        textField.delegate = self;
        textField.borderStyle = UITextBorderStyle.None;
        textField.enabled = false;
        self.addSubview(textField);
        
        placeholderLabel.textColor = placeholderColor;
        placeholderLabel.font = font;
        placeholderLabel.transform = CGAffineTransformScale(placeholderLabel.transform, 1, 1);
        self.addSubview(placeholderLabel);
        
        baseline.frame = CGRect(x: 0, y: frame.size.height-1, width: frame.size.width, height: 1);
        baseline.backgroundColor = textColor;
        self.addSubview(baseline);
        
        let tap = UITapGestureRecognizer(target: self, action: "showKeyboard");
        self.addGestureRecognizer(tap);
    }
    
    override var frame: CGRect{
        didSet{
            textField.frame = CGRect(x: 5, y: frame.size.height*0.4, width: frame.size.width-5, height: frame.size.height*0.5);
            placeholderLabel.frame = CGRectMake(5, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height);
            baseline.frame = CGRectMake(0, frame.size.height-1, frame.size.width, 1);
        }
    }
    
    func show(){
        if (placeholderStatus == JKPlaceholderStatus.Major){
            let baselineRect = baseline.frame;
            let placeholderRect = placeholderLabel.frame;
            baseline.frame = CGRectMake(0, baselineRect.origin.y, 0, baselineRect.size.height);
            placeholderLabel.frame = CGRectMake(placeholderRect.origin.x, self.frame.size.height, placeholderRect.size.width, placeholderRect.size.height);
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                self.baseline.frame = baselineRect;
                self.placeholderLabel.frame = placeholderRect;
            });
        }
    }
    
    func showKeyboard(){
        if (placeholderStatus == JKPlaceholderStatus.Major){
            placeholderStatus = JKPlaceholderStatus.Title;
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.placeholderLabel.transform = CGAffineTransformScale(self.placeholderLabel.transform, 0.7, 0.7);
                self.placeholderLabel.frame = CGRectMake(5, 0, self.placeholderLabel.frame.size.width, self.placeholderLabel.frame.size.height);
            });
        }
        textField.enabled = true;
        textField.becomeFirstResponder();
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return textField.canBecomeFirstResponder();
    }
    
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder();
    }
    
    override func canResignFirstResponder() -> Bool {
        return textField.canResignFirstResponder();
    }
    
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder();
    }
    
    override func isFirstResponder() -> Bool {
        return textField.isFirstResponder();
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.enabled = false;
        if (placeholderStatus == JKPlaceholderStatus.Title && textField.text.isEmpty){
            placeholderStatus = JKPlaceholderStatus.Major;
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.placeholderLabel.transform = CGAffineTransformScale(self.placeholderLabel.transform, 1/0.7, 1/0.7);
                self.placeholderLabel.frame = CGRectMake(5, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height);
            })
        }
    }
    
    
}
