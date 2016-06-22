//
//  AppDelegate.swift
//  ConfigFilesDemo
//
//  Created by Carlos M. Vicente Herrero on 18/6/16.
//  Copyright © 2016 Carlos M. Vicente Herrero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let storyBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:NSBundle.mainBundle())
        let plistParser: PListParser = PListParser()
        let appConfiguration: AppConfiguration = plistParser.readAppConfigurationFromPlist()
        
        let viewController:ViewController = (storyBoard.instantiateViewControllerWithIdentifier("ViewController") as? ViewController)!
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = viewController
        self.window?.addSubview(viewController.view)
        
        viewController.loadAppConfiguration(appConfiguration)
        
        return true
    }
}

