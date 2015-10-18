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
        super.viewWillAppear(animated)
        memeDetail.image = sentMemes.memedImage
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.hidden = false
        navigationItem.setHidesBackButton(false, animated: false)
    }
    
}
