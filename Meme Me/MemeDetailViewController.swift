//
//  MemeDetailViewController.swift
//  Meme Me
//
//  Created by Luis Yoshida on 6/18/15.
//  Copyright (c) 2015 Msen. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme?
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if let image = self.meme?.memedImage {
            self.memeImageView.image = image
        }
        
        
    }
    
    
    
}
