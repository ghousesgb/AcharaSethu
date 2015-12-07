//
//  SplashScreen.swift
//  AcharaSethu
//
//  Created by Shaik Ghouse Basha on 27/11/15.
//  Copyright © 2015 Innozol. All rights reserved.
//

import UIKit
import Spring

class SplashScreen: UIViewController {

    @IBOutlet var backgroundBlurView: UIView!
    @IBOutlet var pictureGallelryScollView: UIScrollView!
    var pictureArray: NSArray!
    var animationText: NSArray!
    var animateIndex:Int=0
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var animatingLabel: SpringLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureArray = ["pic01","pic02","pic03","pic04","pic05","pic06"]
        animationText = ["Events","Albums","To-Do","Chat","Voice Calls","Video Chat"]
         NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "moveToNextPage", userInfo: nil, repeats: true)
        self.blurView()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var index = 0
        var yAxis:CGFloat = 0.0
        let contentWidth:CGFloat = (self.pictureGallelryScollView.contentSize.width)
        let pageWidth:CGFloat = CGRectGetWidth(self.pictureGallelryScollView.frame)
        if(pageWidth<contentWidth) {
         return;
        }
        while(index<pictureArray.count) {
            
            var newFrame  = self.pictureGallelryScollView.bounds
            newFrame.origin.x += yAxis
            
            let imageView = UIImageView.init(frame: newFrame)
            imageView.image = UIImage(named: pictureArray[index] as! String)
            index++
            yAxis = self.pictureGallelryScollView.frame.size.width * CGFloat(index)
            self.pictureGallelryScollView.addSubview(imageView)
        }
        let maxWidth:CGFloat = self.pictureGallelryScollView.frame.width * CGFloat(pictureArray.count)
        self.pictureGallelryScollView.contentSize = CGSize(width: maxWidth, height: self.pictureGallelryScollView.frame.height)
        
        

    }
    func moveToNextPage (){
        
        let pageWidth:CGFloat = CGRectGetWidth(self.pictureGallelryScollView.bounds)
        let maxWidth:CGFloat = pageWidth * CGFloat(pictureArray.count)
        let contentOffset:CGFloat = self.pictureGallelryScollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        let pageNumber = round(contentOffset / pictureGallelryScollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber) + 1
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
            pageControl.currentPage = 0
        }
        self.applyBackgroundBlurView(pictureArray[pageControl.currentPage] as! String)
        self.pictureGallelryScollView.scrollRectToVisible(CGRectMake(slideToX, -20, pageWidth, CGRectGetHeight(self.pictureGallelryScollView.bounds)), animated: true)
        
        if(animateIndex>animationText.count-1) {
            animateIndex=0
        }
        self.animatingLabel.text = animationText[animateIndex] as? String
        animateIndex++;
        self.animatingLabel.animation = "fadeInUp"
        self.animatingLabel.animate()
        
    }
    
    @IBAction func enterButtonAction(sender: UIButton) {
        self.performSegueWithIdentifier("registrationSegue", sender: nil)
    }
    
    @IBAction func signupusingFacebookButtonAction(sender: SpringButton) {
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("MainRevealViewController") 
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    func applyBackgroundBlurView(imageName : String) {

        let chosenImage = UIImage(named: imageName)
        self.backgroundBlurView.backgroundColor = UIColor(patternImage: chosenImage!)
        
    }
    func blurView() {
        self.backgroundBlurView.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.backgroundBlurView.addSubview(blurEffectView)
    }
}
