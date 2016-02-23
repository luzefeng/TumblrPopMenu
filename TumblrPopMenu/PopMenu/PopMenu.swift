//
//  PopMenu.swift
//  TumblrPopMenu
//
//  Created by lu on 16/2/22.
//  Copyright © 2016年 lu. All rights reserved.
//

import Foundation
import UIKit

class PopMenu: UIView{
    var textButton: UIButton!
    var photoButton: UIButton!
    var quoteButton: UIButton!
    var linkButton: UIButton!
    var chatButton: UIButton!
    var videoButton: UIButton!
    var backgroundView: UIView!
    var nevermindButton: UIButton!
    var centerHigh: [CGPoint]!
    var centerLow: [CGPoint]!
    var centerMenu: [CGPoint]!
    var delegate: PopMenuDelegate?
    var isHidding: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initImageView()
        initCenterArray(frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initCenterArray(frame: CGRect){
        let widthUnit = frame.width/4
        let heightHigh = frame.origin.y - textButton.frame.height/2
        let heightLow = frame.height + textButton.frame.height/2
        let gap = textButton.frame.height/2 + 5
        centerHigh = [CGPoint]()
        centerHigh.append(CGPoint(x: widthUnit, y: heightHigh))
        centerHigh.append(CGPoint(x: widthUnit*2, y: heightHigh))
        centerHigh.append(CGPoint(x: widthUnit*3, y: heightHigh))
        
        centerLow = [CGPoint]()
        centerLow.append(CGPoint(x: widthUnit, y: heightLow))
        centerLow.append(CGPoint(x: widthUnit*2, y: heightLow))
        centerLow.append(CGPoint(x: widthUnit*3, y: heightLow))
        centerLow.append(CGPoint(x: widthUnit*2, y: frame.height + nevermindButton.frame.height/2))
        
        centerMenu = [CGPoint]()
        centerMenu.append(CGPoint(x: widthUnit, y: frame.height/2 - gap))
        centerMenu.append(CGPoint(x: widthUnit*2, y: frame.height/2 - gap))
        centerMenu.append(CGPoint(x: widthUnit*3, y: frame.height/2 - gap))
        centerMenu.append(CGPoint(x: widthUnit, y: frame.height/2 + gap))
        centerMenu.append(CGPoint(x: widthUnit*2, y: frame.height/2 + gap))
        centerMenu.append(CGPoint(x: widthUnit*3, y: frame.height/2 + gap))
        centerMenu.append(CGPoint(x: widthUnit*2, y: frame.height - nevermindButton.frame.height/2))
    }
    
    private func initImageView(){
        let image = UIImage(named: "button-chat")
        let frame = CGRectMake(0, 0, image!.size.width, image!.size.height)
        textButton = UIButton(frame: frame)
        textButton.setBackgroundImage(UIImage(named: "button-text")!, forState: .Normal)

        photoButton = UIButton(frame: frame)
        photoButton.setBackgroundImage(UIImage(named: "button-photo")!, forState: .Normal)

        quoteButton = UIButton(frame: frame)
        quoteButton.setBackgroundImage(UIImage(named: "button-quote")!, forState: .Normal)
        
        linkButton = UIButton(frame: frame)
        linkButton.setBackgroundImage(UIImage(named: "button-link")!, forState: .Normal)
        
        chatButton = UIButton(frame: frame)
        chatButton.setBackgroundImage(UIImage(named: "button-chat")!, forState: .Normal)
        
        videoButton = UIButton(frame: frame)
        videoButton.setBackgroundImage(UIImage(named: "button-video")!, forState: .Normal)

        nevermindButton = UIButton(type: .System)
        nevermindButton.frame = CGRectMake(0, 0, self.frame.width, textButton.frame.height/2)
        nevermindButton.setTitle("Nevermind", forState: .Normal)
        nevermindButton.backgroundColor = UIColor.redColor()
        backgroundView = UIView(frame: self.frame)
        
        textButton.tag = 0
        photoButton.tag = 1
        quoteButton.tag = 2
        linkButton.tag = 3
        chatButton.tag = 4
        videoButton.tag = 5
    }
    
    private func setupView(){
        self.hidden = true
        backgroundView.backgroundColor = UIColor(red: 61/255, green: 77/255, blue: 100/255, alpha: 0.95)
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
        backgroundView.userInteractionEnabled = true
        
        nevermindButton.hidden = true
        nevermindButton.userInteractionEnabled = true
        nevermindButton.backgroundColor = UIColor(red: 61/255, green: 77/255, blue: 97/255, alpha: 1.0)
        nevermindButton.tintColor = UIColor(red: 133/255, green: 141/255, blue: 152/255, alpha: 1.0)
        nevermindButton.addTarget(self, action: "handleTap:", forControlEvents: .TouchUpInside)
        
        textButton.addTarget(self, action: "clickMenu:", forControlEvents: .TouchUpInside)
        photoButton.addTarget(self, action: "clickMenu:", forControlEvents: .TouchUpInside)
        quoteButton.addTarget(self, action: "clickMenu:", forControlEvents: .TouchUpInside)
        linkButton.addTarget(self, action: "clickMenu:", forControlEvents: .TouchUpInside)
        chatButton.addTarget(self, action: "clickMenu:", forControlEvents: .TouchUpInside)
        videoButton.addTarget(self, action: "clickMenu:", forControlEvents: .TouchUpInside)

        self.addSubview(backgroundView)
        self.addSubview(textButton)
        self.addSubview(photoButton)
        self.addSubview(quoteButton)
        self.addSubview(chatButton)
        self.addSubview(linkButton)
        self.addSubview(videoButton)
        self.addSubview(nevermindButton)
    }

    func clickMenu(sender: AnyObject){
        print("clickMenu")
        let index = (sender as! UIButton).tag
        hideMenuView()
        delegate?.didClickMenu(index)
    }
    
    func handleTap(sender: AnyObject){
        print("handleTap")
        hideMenuView()
    }
    
    private func hideMenuView(){
        print("hideMenuView")
        if isHidding{
            return
        }
        
        isHidding = true
        //Nevermind button
        nevermindButton.center = centerMenu[6]
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.nevermindButton.center = self.centerLow[3]
            }) { (finished) -> Void in
                self.nevermindButton.hidden = true
                self.isHidding = false
        }
        
        // Photo Image
        UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.photoButton.center = self.centerHigh[1]
            }) { (finished) -> Void in
                self.hidden = true
        }
        
        // Text | Chat | Quote Image
        UIView.animateWithDuration(0.6, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.textButton.center = self.centerHigh[0]
            self.quoteButton.center = self.centerHigh[2]
            self.chatButton.center = self.centerHigh[1]
            }) { (finished) -> Void in
        }
        
        // Link | Video Image
        UIView.animateWithDuration(0.6, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.linkButton.center = self.centerHigh[0]
            self.videoButton.center = self.centerHigh[2]
            }) { (finished) -> Void in
        }
    }
    
    func showMenuView(){
        print("showMenuView")
        
        self.hidden = false
        
        nevermindButton.center = centerLow[3]
        nevermindButton.hidden = false
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.nevermindButton.center = self.centerMenu[6]
            }) { (finished) -> Void in
        }
        
        // Photo Image
        photoButton.center = centerLow[1]
        UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.photoButton.center = self.centerMenu[1]
            }) { (finished) -> Void in
        }
        
        // Text | Chat | Quote Image
        textButton.center = centerLow[0]
        quoteButton.center = centerLow[2]
        chatButton.center = centerLow[1]
        UIView.animateWithDuration(0.6, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.textButton.center = self.centerMenu[0]
            self.quoteButton.center = self.centerMenu[2]
            self.chatButton.center = self.centerMenu[4]
            }) { (finished) -> Void in
        }
        
        // Link | Video Image
        linkButton.center = centerLow[0]
        videoButton.center = centerLow[2]
        UIView.animateWithDuration(0.6, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.linkButton.center = self.centerMenu[3]
            self.videoButton.center = self.centerMenu[5]
            }) { (finished) -> Void in
        }
    }
}



