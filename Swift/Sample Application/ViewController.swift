//
//  ViewController.swift
//  Sample Application
//
//  Created by joe on 2015/12/11.
//  Copyright (c) 2015年 joe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var usernameField = JKTextField();
    var passwordField = JKTextField();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.frame = CGRectMake((self.view.frame.size.width-200)/2, 100, 200, 50);
        usernameField.placeholder = "Username";
        usernameField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        usernameField.keyboardType = UIKeyboardType.EmailAddress;
        usernameField.autoacorrectionType = UITextAutocorrectionType.No;
        self.view.addSubview(usernameField);
        
        passwordField.frame = CGRectMake((self.view.frame.size.width-200)/2, 170, 200, 50);
        passwordField.placeholder = "Password";
        passwordField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        passwordField.keyboardType = UIKeyboardType.Default;
        passwordField.autoacorrectionType = UITextAutocorrectionType.No;
        passwordField.secureTextEntry = true;
        self.view.addSubview(passwordField);
        
        let tap = UITapGestureRecognizer(target: self, action: "hiddenKeyboard");
        self.view.addGestureRecognizer(tap);
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        usernameField.show();
        passwordField.show();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func hiddenKeyboard() {
        if (usernameField.isFirstResponder()){
            usernameField.resignFirstResponder();
        }else if (passwordField.isFirstResponder()){
            passwordField.resignFirstResponder();
        }
    }

}

