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
    
    @IBOutlet weak var newMeme: UIBarButtonItem!
    
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
    
    override func viewDidAppear(animated:Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBAction func makeNewMeme(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("makeMeme", sender: self)
    }
    
    
    
}

