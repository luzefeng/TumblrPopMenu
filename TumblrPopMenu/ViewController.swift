//
//  ViewController.swift
//  TumblrPopMenu
//
//  Created by lu on 16/2/22.
//  Copyright © 2016年 lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PopMenuDelegate {
    var menuView: PopMenu!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        menuView = PopMenu(frame: self.view.frame)
        menuView.delegate = self
        self.view.addSubview(menuView)
    }

    @IBAction func handleTap(sender: AnyObject) {
        menuView.showMenuView()
    }
    
    func didClickMenu(index: Int) {
        print("click at \(index)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

