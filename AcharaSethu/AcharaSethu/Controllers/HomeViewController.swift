//
//  HomeViewController.swift
//  AcharaSethu
//
//  Created by Shaik Ghouse Basha on 02/12/15.
//  Copyright © 2015 Innozol. All rights reserved.
//

import UIKit
import Spring
import DZNEmptyDataSet

class HomeViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate { 

    @IBOutlet var tableView: UITableView!
    @IBOutlet var animatingView: UIView!
    @IBOutlet var homeButton: SpringButton!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var animatingViewLeadingConstant: NSLayoutConstraint!
    @IBOutlet var animatingViewWidthConstant: NSLayoutConstraint!
    @IBOutlet var animatingViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        if self.revealViewController() != nil {
            menuButton.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        tableView.tableFooterView = UIView()
        
        self.addressBook.loadContacts(
            { (contacts: [APContact]?, error: NSError?) in
                if let uwrappedContacts = contacts {
                    // do something with contacts
                }
                else if let unwrappedError = error {
                    // show error
                }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.animatingViewWidthConstant.constant    =   self.homeButton.frame.size.width
        self.animatingViewHeightConstant.constant   =   self.homeButton.frame.size.height //+ self.animatingView.frame.size.height * 2
    }
    
    @IBAction func menuButtonAction(sender: SpringButton) {
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.animatingViewLeadingConstant.constant = sender.frame.origin.x
  
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Welcome"
        let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Tap the button below to add your first grokkleglob."
        let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "welcome")
    }
    
    func buttonTitleForEmptyDataSet(scrollView: UIScrollView!, forState state: UIControlState) -> NSAttributedString! {
        let str = "Add Grokkleglob"
        let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleCallout)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func emptyDataSetDidTapButton(scrollView: UIScrollView!) {
        let ac = UIAlertController(title: "Button tapped!", message: nil, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Hurray", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    
}
