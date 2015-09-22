//
//  ViewController.swift
//  MemeMe
//
//  Created by Eleanor Stribling on 9/8/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var photoPreview: UIImageView!
    @IBOutlet weak var pickFromAlbum: UIToolbar!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        
        // assign delegates
        self.topText.delegate = self;
        self.bottomText.delegate = self;
        imagePicker.delegate = self;
        
        // check if there is a camera present on the device
        // if not, disable the camera button
        if  UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
            self.cameraButton.enabled = false
        }

        //set default text in text boxes
        self.topText.text = "TOP"
        self.bottomText.text = "BOTTOM"
        
//        let textFieldStyling = [
//            NSBackgroundColorAttributeName: UIColor.clearColor(),
//            NSFontAttributeName: UIFont(name: "Impact", size: 25)!,
////            NSForegroundColorAttributeName: UIColor.whiteColor(),
//            NSStrokeColorAttributeName: UIColor.blackColor()
//        ]
        
        // link the attributes dictionary to the text fields
//        topText.defaultTextAttributes = textFieldStyling
//        bottomText.defaultTextAttributes = textFieldStyling
        
        
        // custom settings for text boxes
//        self.topText.backgroundColor = UIColor.clearColor()
//        self.topText.borderStyle = .None
//        self.topText.textColor = UIColor.whiteColor()
//        self.topText.tintColor = UIColor.whiteColor()
//        self.topText.textAlignment = .Center
//        self.topText.font = UIFont(name: "Impact", size: 25)
        
        func applyTextStyle(text: UITextField!){
            text.backgroundColor = UIColor.clearColor()
            text.borderStyle = .None
            text.textColor = UIColor.whiteColor()
            text.tintColor = UIColor.whiteColor()
            text.textAlignment = .Center
            text.font = UIFont(name: "Impact", size: 25)
        }

        applyTextStyle(topText)
        applyTextStyle(bottomText)
        
        
        
    }
    
    // return key dismisses keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // Figure out what the new text will be, if we return true
        var newText: NSString = textField.text
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
        
        // returning true gives the text field permission to change its text
        return true;
    }
    
    // camera button code
    @IBAction func cameraActivate(sender: UIButton) {
        // check if a camera is available on the device, disable button if not
            imagePicker.sourceType = .Camera
            presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // select an image code
    @IBAction func albumActivate(sender: UIButton) {
        // opens album on phone
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage! {
            // remove auto fit for selected image in the view to keep aspect ratio and remove image from the dictionary
            self.photoPreview.contentMode = .ScaleAspectFit
            self.photoPreview.image = selectedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // dismiss the image picker if the user presses cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}


