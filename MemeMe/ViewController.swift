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
    var savedMemes = []

    @IBOutlet weak var photoPreview: UIImageView!
    @IBOutlet weak var pickFromAlbum: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!

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
        
        // disable the share button until image selected
        shareButton.enabled = false

        //set default text in text boxes
        self.topText.text = "TOP"
        println(self.topText.text.dynamicType)
        self.bottomText.text = "BOTTOM"
        
        
        //helper function to apply style to both fields
        func applyTextStyle(text: UITextField!){
            
            text.backgroundColor = UIColor.clearColor()
            text.borderStyle = .None
            text.tintColor = UIColor.whiteColor()
            text.textAlignment = .Center
            text.font = UIFont(name: "Impact", size: 30)
            text.textColor = UIColor.whiteColor()
        }

        applyTextStyle(self.topText)
        applyTextStyle(self.bottomText)

    }
    
    // return key dismisses keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // replace only the default text with user entered text
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
    }
    
    // subscribe to keyboard notifications
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillHideNotification, object: nil)
    }
    
    // control sliding up and down of view with the keyboard
    // slide only when bottomText is the active field
    func keyboardWillShow(notification: NSNotification) {
        if self.bottomText.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.bottomText.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // camera button code
    @IBAction func cameraActivate(sender: UIBarButtonItem) {
        // check if a camera is available on the device, disable button if not
            imagePicker.sourceType = .Camera
            presentViewController(imagePicker, animated: true, completion: nil)
            shareButton.enabled = true
    }
    
    // select an image from album
    @IBAction func albumActivate(sender: UIBarButtonItem) {
        // opens album on phone
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage! {
            // remove auto fit for selected image in the view to keep aspect ratio and remove image from the dictionary
            self.photoPreview.contentMode = .ScaleAspectFit
            self.photoPreview.image = selectedImage
            shareButton.enabled = true
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // dismiss the image picker if the user presses cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //revert to default text and remove image if user presses cancel
    @IBAction func cancelByUser(sender: UIBarButtonItem) {
        self.topText.text = "TOP"
        self.bottomText.text = "BOTTOM"
        self.photoPreview.image = nil
        shareButton.enabled = false
    }
    
    // share the meme
    // calls createMemeImage to generate the graphic with text
    @IBAction func shareIt(sender: UIBarButtonItem) {
        let shareMeme = createMemeImage()
        let activityController = UIActivityViewController(activityItems: [shareMeme], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
    }
    
    // create a new image with the user input
    // called when user shares the meme
    func createMemeImage() -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        return memedImage
    }
    
    // save the meme as an object when the user shares it
    func saveMeme(image: UIImage, path: String -> Bool) {
        var meme = (
            topText: topText.text!,
            bottomText: bottomText.text!,
            image: photoPreview.image!,
            memedImage: createMemeImage()
        )
    }
}


