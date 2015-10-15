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

    let sentMemes = savedMemes
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println(self.sentMemes.count)
        return self.sentMemes.count
    }
    
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollCell", forIndexPath: indexPath) as! CollCell
//  
//        
//        let meme = self.sentMemes[indexPath.row]
//        
//        cell.imageView?.image = meme.memedImage
//        
//        return cell
//    }
}













