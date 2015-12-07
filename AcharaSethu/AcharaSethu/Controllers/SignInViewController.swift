//
//  SignInViewController.swift
//  AcharaSethu
//
//  Created by Shaik Ghouse Basha on 30/11/15.
//  Copyright © 2015 Innozol. All rights reserved.
//

import UIKit
import TextFieldEffects

class SignInViewController: BaseViewController, iCarouselDataSource, iCarouselDelegate  {
    
    @IBOutlet var carousel: iCarousel!
    @IBOutlet var userNameTextField: JiroTextField!
    @IBOutlet var passwordTextField: JiroTextField!
    var pictureArray: NSArray!
    
    var keyboardShowing: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardShowing = false
        
        pictureArray = ["pic01","pic02","pic03","pic04","pic05","pic06","pic01","pic02","pic03","pic04","pic05","pic06"]
        carousel.dataSource = self
        carousel.scrollSpeed = 0.5
        carousel.type = .Rotary
        carousel.autoscroll=0.4;



    }
    
    @IBAction func backButtonAction(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return pictureArray.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        let imageView: UIImageView
        
        if view != nil {
            imageView = view as! UIImageView
        } else {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
        }
        let picName = pictureArray[index] as! String
        imageView.image = UIImage(named: picName)
        
        return imageView
    }
    /*func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .Spacing)
        {
            return value * 1.1
        }
        return value
    }*/
    
    func keyboardWillShow(sender: NSNotification) {
        if(!keyboardShowing) {
            keyboardShowing = true
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y -= 150
            })
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        keyboardShowing = false;
        self.view.frame.origin.y += 150
    }
    
    @IBAction func signInButtonAction(sender: UIButton) {
        let username = userNameTextField.text! as String
        let password = passwordTextField.text! as String
        
        if(username.length < 3 || password.length < 3) {
            SweetAlert().showAlert("Error !", subTitle: "InProper Username or Password, Please try again", style: AlertStyle.Warning)
        }
    }
}
