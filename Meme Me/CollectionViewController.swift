//
//  CollectionViewController.swift
//  Meme Me
//
//  Created by Luis Yoshida on 6/18/15.
//  Copyright (c) 2015 Msen. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeGridCell", forIndexPath: indexPath) as! CollectionViewCell
        let meme = memes[indexPath.item]
        
        cell.topTextField.text = meme.topMessage
        cell.bottomTextField.text = meme.bottomMessage
        let imageView = UIImageView(image: meme.originalImage)
        cell.memeImageView = imageView
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        detailViewController.meme = self.memes[indexPath.item]
        
        self.navigationController!.pushViewController(detailViewController, animated: true)
        

    }
    
}
