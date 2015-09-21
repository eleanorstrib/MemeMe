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
    
    //text field delegate
    let textFieldDel = TextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        
        self.topText.delegate = textFieldDel
        
        // check if there is a camera present on the device
        // if not, disable the camera button
        if  UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
            self.cameraButton.enabled = false
        }
        

//        self.bottomText.delegate = textFieldDel
        // custom settings for text boxes
//        self.topText.backgroundColor = UIColor.clearColor()
//        self.topText.borderStyle = .None
//        self.topText.textColor = UIColor.whiteColor()
//        self.topText.tintColor = UIColor.whiteColor()
//        self.topText.textAlignment = .Center
//        self.topText.font = UIFont(name: "Impact", size: 25)
        
        imagePicker.delegate = self
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


