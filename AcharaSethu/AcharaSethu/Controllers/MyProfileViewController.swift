//
//  MyProfileViewController.swift
//  AcharaSethu
//
//  Created by Shaik Ghouse Basha on 02/12/15.
//  Copyright © 2015 Innozol. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var profilePictureBackgroundView: UIView!
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        picker.delegate = self
        
        if self.revealViewController() != nil {
            menuButton.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.profilePictureBackgroundView.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.profilePictureBackgroundView.addSubview(blurEffectView)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.profileImageView.layer.borderWidth     =   4.0
        self.profileImageView.layer.borderColor     =   UIColor.whiteColor().CGColor
        self.profileImageView.layer.cornerRadius    =   (self.profileImageView.bounds.size.width / 2.0)
        self.profileImageView.layer.masksToBounds   =   true
        
        if let chosenImage =  NSUserDefaults.standardUserDefaults().objectForKey("PROFILE_PIC") {
            
            let imageData = chosenImage as? NSData
            let image:UIImage = UIImage.init(data: imageData!, scale: 0.0)!
            self.profileImageView.image = image
            self.backgroundBlurView(image)
        }
        
    }

    @IBAction func editButtonAction(sender: UIButton) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Please select", message: "", preferredStyle: .ActionSheet)
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Photo", style: .Default)
            { action -> Void in
                self.shootPhoto()
        }
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose Photo", style: .Default)
            { action -> Void in
               self.photofromLibrary()
        }
        actionSheetController.addAction(choosePictureAction)
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as UIView
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func shootPhoto() {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            presentViewController(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
     func photofromLibrary() {
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)//4
 
    }
        
    //MARK: Delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
//        self.profileImageView.contentMode = .ScaleAspectFit //3
        self.profileImageView.image = chosenImage //4
        self.backgroundBlurView(chosenImage)
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func noCamera(){
        SweetAlert().showAlert("No Camera", subTitle: "Sorry, This device has no camera", style: AlertStyle.Warning)
        /*SweetAlert().showAlert("Good job!", subTitle: "You clicked the button!", style: AlertStyle.Success)*/
    }
    
    func backgroundBlurView(chosenImage : UIImage) {

        
        UIGraphicsBeginImageContext(self.profilePictureBackgroundView.frame.size)
        chosenImage.drawInRect(self.profilePictureBackgroundView.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        NSUserDefaults.standardUserDefaults().setObject(UIImagePNGRepresentation(chosenImage), forKey: "PROFILE_PIC")
        self.profilePictureBackgroundView.backgroundColor = UIColor(patternImage: image)
        
        self.view.superview?.bringSubviewToFront(self.profileImageView)

    }
    

}
