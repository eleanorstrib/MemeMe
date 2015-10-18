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
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var newMemeButton: UIBarButtonItem!


    var sentMemes: [Meme] {
        return savedMemes
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        // set spacing, etc for display of memes
        let space: CGFloat = 9.0
        let memeWidth = (self.view.frame.size.width / 5.0)
        let memeHeight = (self.view.frame.size.height / 5.0)
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(memeWidth, memeHeight)
        flowLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO remove print statements
        println("hello!")
        println(self.sentMemes.count)
        return self.sentMemes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollCell", forIndexPath: indexPath) as! MemeCollCell
        let meme = self.sentMemes[indexPath.row]
        
        cell.memeImageView?.image = meme.memedImage
        println("returning cell collview")
        return cell
    }
    
    //reload data in table so that memes created via table VC show up
    override func viewWillAppear(animated:Bool) {
        collectionView!.reloadData()
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
        self.performSegueWithIdentifier("makeMemeCollection", sender: self)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailView") as! MemeDetailView
        
        detailVC.sentMemes = self.sentMemes[indexPath.row]
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
}













