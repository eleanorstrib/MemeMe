//
//  SentMemesVC.swift
//  MemeMe
//
//  Created by Eleanor Stribling on 10/13/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import Foundation
import UIKit

class SentMemesVC: UIViewController {
    let sentMemes = savedMemes
    
    func tableView(tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(self.sentMemes.count)
        return self.sentMemes.count
    }
    
}

