//
//  TableViewController.swift
//  Meme Me
//
//  Created by Luis Yoshida on 6/18/15.
//  Copyright (c) 2015 Msen. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
        let meme = self.memes[indexPath.row]
        
        cell.textLabel?.text = meme.topMessage + " " + meme.bottomMessage
        cell.imageView?.image = meme.originalImage
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
