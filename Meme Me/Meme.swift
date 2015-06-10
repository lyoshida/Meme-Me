//
//  Meme.swift
//  Meme Me
//
//  Created by Luis Yoshida on 6/10/15.
//  Copyright (c) 2015 Msen. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    init(topMessage: String, bottomMessage: String, originalImage: UIImage, memedImage: UIImage) {
        self.topMessage = topMessage
        self.bottomMessage = bottomMessage
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
    var topMessage: String
    var bottomMessage: String
    var originalImage: UIImage
    var memedImage: UIImage
}