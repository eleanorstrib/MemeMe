//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Eleanor Stribling on 9/21/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        textField.backgroundColor = UIColor.clearColor()
        textField.borderStyle = .None
        textField.textColor = UIColor.whiteColor()
        textField.tintColor = UIColor.whiteColor()
        textField.textAlignment = .Center
        textField.font = UIFont(name: "Impact", size: 25)
        return true
    }
}