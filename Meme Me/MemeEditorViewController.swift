//
//  MemeEditorViewController.swift
//  Meme Me
//
//  Created by Luis Yoshida on 6/2/15.
//  Copyright (c) 2015 Msen. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeEditorNavigationBar: UINavigationBar!
    @IBOutlet weak var memeEditorUIToolbar: UIToolbar!
    @IBOutlet weak var shareMemeBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        // Set text properties
        
        let memeTextAttributes = [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSStrokeWidthAttributeName: -3.0
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP", attributes: memeTextAttributes)
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes: memeTextAttributes)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.imagePickerView.image != nil {
            self.shareMemeBarButton.enabled = true
        } else {
            self.shareMemeBarButton.enabled = false
        }
        
        
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unsubscribeFromKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pickingAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Dismiss keyboard when hitting return or touching outside the TextView
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    // Move the keyboard up when editing the bottom textfield
    
    func getKeyboardHeight(notification: NSNotification) -> Float {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return Float(keyboardSize.CGRectValue().height)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if topTextField.isFirstResponder() != true {
            self.view.frame.origin.y -= CGFloat(self.getKeyboardHeight(notification))
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if topTextField.isFirstResponder() != true {
            self.view.frame.origin.y += CGFloat(self.getKeyboardHeight(notification))
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func saveMeme() -> Meme {
        // TODO: Implement
        
        var meme = Meme(topMessage: self.topTextField.text, bottomMessage: self.bottomTextField.text, originalImage: self.imagePickerView.image!, memedImage: generateMemedImage())

        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        
        return meme
    }
    
    func generateMemedImage() -> UIImage {
        
        self.memeEditorNavigationBar.hidden = true
        self.memeEditorUIToolbar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.memeEditorNavigationBar.hidden = false
        self.memeEditorUIToolbar.hidden = false
        
        return memedImage
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        
    }
    
    
    @IBAction func shareMeme(sender: AnyObject) {
        var meme: Meme = saveMeme()
        
        let activityViewController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
//        let memeEditorViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
//        
//        self.presentViewController(memeEditorViewController, animated: true, completion: nil)
    }
    
}

