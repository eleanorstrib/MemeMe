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
    
    var sentMemes: [Meme] {
        return savedMemes
    }
    
    override func tableView(tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: remove print statement
        println(self.sentMemes.count)
        return self.sentMemes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //create the reusable cell and define data source
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemeCell") as! UITableViewCell
        let meme = self.sentMemes[indexPath.row]
        
        //set the text and image for the table
        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        cell.imageView?.image = meme.memedImage
        
        return cell
    }

    //reload data in table so that memes created via collection VC show up
    override func viewWillAppear(animated:Bool) {
        tableView.reloadData()
    }
    
    // show navbar and toolbar with this view, hide when user creates meme
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.tabBar.hidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.hidden = true
    }
    
    
    @IBAction func makeNewMeme(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("makeMemeTable", sender: self)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailView") as! MemeDetailView
        
        detailVC.sentMemes = self.sentMemes[indexPath.row]
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    
    
}

