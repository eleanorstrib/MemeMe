//
//  SentMemesCollVC.swift
//  MemeMe
//
//  Created by Eleanor Stribling on 10/14/15.
//  Copyright (c) 2015 eleanorstrib. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollVC: UICollectionViewController {
    
    @IBOutlet weak var newMemeButton: UIBarButtonItem!

    var sentMemes = savedMemes
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO remove print statements
        println(self.sentMemes)
        println(self.sentMemes.count)
        return self.sentMemes.count
    }
    
    override func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollCell", forIndexPath: indexPath) as! MemeCollCell
        let meme = savedMemes[indexPath.item]
        let imageView = UIImageView(image: meme.memedImage)
//        cell.memeImageView?.image = UIImage(named: meme.memedImage)
        
        return cell
    }

    
    // show navbar and toolbar with this view, hide when user creates meme
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.hidden = true
    }
    
    @IBAction func makeNewMeme(sender: AnyObject) {
        self.performSegueWithIdentifier("makeMeme", sender: self)
    }
    
}













