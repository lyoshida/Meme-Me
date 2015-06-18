//
//  SentMemeViewController.swift
//  Meme Me
//
//  Created by Luis Yoshida on 6/10/15.
//  Copyright (c) 2015 Msen. All rights reserved.
//

import Foundation
import UIKit

class SentMemeViewController : UIViewController {
    
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
}
