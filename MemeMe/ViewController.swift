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
    // sets up Swift array to save meme objects to
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
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
        view.backgroundColor = UIColor.grayColor()
        
        // assign delegates
        topText.delegate = self;
        bottomText.delegate = self;
        imagePicker.delegate = self;
        
        // check if there is a camera present on the device
        // if not, disable the camera button
        if  UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
            cameraButton.enabled = false
        }
        
        // disable the share button until image selected
        shareButton.enabled = false

        //set default text in text boxes
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        
        
        //helper function to apply style to both fields
        func applyTextStyle(text: UITextField!){
            // style the field
            text.backgroundColor = UIColor.clearColor()
            text.borderStyle = .None
            text.tintColor = UIColor.whiteColor()
            // style the characters
            let charAttributes = [
                NSStrokeWidthAttributeName: -3.0,
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSStrokeColorAttributeName: UIColor.blackColor(),
                NSFontAttributeName: UIFont(name: "Impact", size: 30)!,
            ]
            topText.defaultTextAttributes = charAttributes
            topText.textAlignment = .Center
            bottomText.defaultTextAttributes = charAttributes
            bottomText.textAlignment = .Center
        }
        applyTextStyle(topText)        
        applyTextStyle(bottomText)
    }
    
    /////////KEYBOARD MOVEMENT/////////
    // return key dismisses keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
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
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
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
        if bottomText.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    // check if the bottomText field is active, only slide if true
    func keyboardWillHide(notification: NSNotification) {
        if bottomText.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    /////////IMAGE SELECTION/////////
    
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
            photoPreview.contentMode = .ScaleAspectFill
            photoPreview.image = selectedImage
            shareButton.enabled = true
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // dismiss the image picker if the user presses cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /////////CANCEL BUTTON/////////
    
    //revert to default text and remove image if user presses cancel (changed from v1 where it reset text and image
    @IBAction func cancelByUser(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("backToDetail", sender: self)
    }
    
    /////////SHARE & SAVE/////////
    
    // share the meme
    // calls createMemeImage to generate the graphic with text
    @IBAction func shareIt(sender: UIBarButtonItem) {
        let shareMeme = createMemeImage()
        let activityController = UIActivityViewController(activityItems: [shareMeme], applicationActivities: nil)
        activityController.completionWithItemsHandler = {
            (activity, success, items, error) in
            self.saveMeme()
        }
        presentViewController(activityController, animated: true, completion: nil)
        
    }
    
    // create a new image with the user input
    // called when user shares the meme
    func createMemeImage() -> UIImage {
        // hide everything but meme itself before saving
        navBar.hidden = true
        toolBar.hidden = true
        // get image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        // show the navigation/toolbars when you go back to the app
        navBar.hidden = false
        toolBar.hidden = false
        
        return memedImage
    }
    
    // save the meme an instanciacion of the Meme object when the user shares it
    // append the struct to savedMemes array and save to device
    func saveMeme() {
        var meme = Meme(
            topText: topText.text,
            bottomText: bottomText.text,
            image: photoPreview.image!,
            memedImage: createMemeImage()
        )
        // TODO: remove print statements
        println(meme)
        savedMemes.append(meme)
        println(savedMemes)
    }


}


