//
//  ProfileViewController.swift
//  AcharaSethu
//
//  Created by Shaik Ghouse Basha on 02/12/15.
//  Copyright © 2015 Innozol. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileBackgroundView: UIView!
    
    override func viewDidLoad() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.profileBackgroundView.addSubview(blurEffectView)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.profileImageView.layer.borderWidth     =   4.0
        self.profileImageView.layer.borderColor     =   UIColor.whiteColor().CGColor
        self.profileImageView.layer.cornerRadius    =   (self.profileImageView.bounds.size.width / 2.0)
        self.profileImageView.layer.masksToBounds   =   true
        self.profileImageView.backgroundColor = UIColor.clearColor()
        
       
        
        if let chosenImage =  NSUserDefaults.standardUserDefaults().objectForKey("PROFILE_PIC") {
            
            let imageData = chosenImage as? NSData
            let image = UIImage.init(data: imageData!, scale: 0.0)
            self.profileImageView.image = image
            self.backgroundBlurView(image!)
        }
    }
    
    func backgroundBlurView(chosenImage : UIImage) {
        
        UIGraphicsBeginImageContext(self.profileBackgroundView.frame.size)
        chosenImage.drawInRect(self.profileBackgroundView.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        NSUserDefaults.standardUserDefaults().setObject(UIImagePNGRepresentation(chosenImage), forKey: "PROFILE_PIC")
        self.profileBackgroundView.backgroundColor = UIColor(patternImage: image)
        
        self.view.superview?.bringSubviewToFront(self.profileImageView)
        
    }

    
}
