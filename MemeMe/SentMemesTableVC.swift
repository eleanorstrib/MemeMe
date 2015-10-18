//
//  SentMemesTableVC.swift
//  MemeMe
//
//  Created by Eleanor Stribling on 10/13/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableVC: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newMeme: UIBarButtonItem!
    
    var sentMemes: [Meme] {
        return savedMemes
    }
    
    override func tableView(tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentMemes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //create the reusable cell and define data source
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemeCell") as! UITableViewCell
        let meme = sentMemes[indexPath.row]
        
        //set the text and image for the table
        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    // swipe to delete functionality in the table view
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let meme = sentMemes[indexPath.row]
        if editingStyle == .Delete {
            savedMemes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    //reload data in table so that memes created via collection VC show up
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // show navbar toolbar with this view, hide when user creates meme; hide back button
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.tabBar.hidden = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.hidden = true
    }
    
    // go to meme editing VC (plus sign)
    @IBAction func makeNewMeme(sender: UIBarButtonItem) {
        performSegueWithIdentifier("makeMemeTable", sender: self)
    }
    
    // go to meme detail view
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailView") as! MemeDetailView
        
        detailVC.sentMemes = sentMemes[indexPath.row]
        navigationController!.pushViewController(detailVC, animated: true)
    }
    
}

