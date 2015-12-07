//
//  RegistrationScreen.swift
//  AcharaSethu
//
//  Created by Shaik Ghouse Basha on 27/11/15.
//  Copyright © 2015 Innozol. All rights reserved.
//

import UIKit

class RegistrationScreen: BaseViewController{

    @IBOutlet var emailView: UIView!
    @IBOutlet var mobileView: UIView!
    var keyboardShowing: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardShowing = false


    }
    
    override func viewDidAppear(animated: Bool) {

        super.viewDidAppear(animated)
//        animateLabel(self.emailView,  isHidden: true)
        animateLabel(self.mobileView, isHidden: true)
    }

        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    @IBAction func registerButtonAction(sender: UIButton) {
        self.view.endEditing(true)
        switch sender.tag {
            
        case 0:
            animateLabel(self.emailView,  isHidden: true)
            animateLabel(self.mobileView, isHidden: true)
                break
        case 1:
            animateLabel(self.emailView, isHidden: false)
            animateLabel(self.mobileView, isHidden: true)
                break
        case 2:
            animateLabel(self.emailView,  isHidden: true)
            animateLabel(self.mobileView, isHidden: false)
                break
        default:
            animateLabel(self.emailView,  isHidden: true)
            animateLabel(self.mobileView, isHidden: true)
            break
            
        }

    }
    func animateLabel(view :UIView, isHidden hiddenStatus:Bool) {
        UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 10, initialSpringVelocity: 20.0, options: UIViewAnimationOptions(), animations: {
            view.hidden = hiddenStatus
            }, completion: nil)
    }
    
    @IBAction func backButtonAction(sender: UIButton) {
         self.navigationController?.popViewControllerAnimated(true)
    }

}
