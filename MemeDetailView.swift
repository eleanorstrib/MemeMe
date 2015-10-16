//
//  MemeDetailView.swift
//  MemeMe
//
//  Created by Eleanor Stribling on 10/15/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailView: UIViewController {
    
    @IBOutlet weak var memeDetail: UIImageView!
    
    var sentMemes: Meme!
    
    override func viewWillAppear(animated: Bool) {
        self.memeDetail.image = sentMemes.memedImage
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.hidden = false
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
}
