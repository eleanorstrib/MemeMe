//
//  ViewController.swift
//  MemeMe
//
//  Created by Eleanor Stribling on 9/8/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    @IBOutlet var photoPreview: UIView!
    @IBOutlet weak var pickFromAlbum: UIToolbar!
    @IBOutlet weak var cameraButton: UITableViewCell!
    @IBOutlet weak var albumButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraActivate(sender: UIButton) {
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func albumActivate(sender: UIButton) {
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }

}

