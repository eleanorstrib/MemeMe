//
//  SentMemesVC.swift
//  MemeMe
//
//  Created by Eleanor Stribling on 10/13/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import Foundation
import UIKit

class SentMemesVC: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    func viewdidLoad() {
        super.viewDidLoad()
        //TODO: fix, not working
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    let sentMemes = savedMemes
    
    override func tableView(tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(self.sentMemes.count)
        return self.sentMemes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //create the reusable cell and define data source
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemeCell") as! UITableViewCell
        let meme = self.sentMemes[indexPath.row]
        
        //set the text and image for the table
        cell.textLabel?.text = meme.topText + meme.bottomText
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    
    
}

