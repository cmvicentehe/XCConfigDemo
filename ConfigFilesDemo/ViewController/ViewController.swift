//
//  ViewController.swift
//  ConfigFilesDemo
//
//  Created by Carlos M. Vicente Herrero on 18/6/16.
//  Copyright © 2016 Carlos M. Vicente Herrero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var appConfiguration: AppConfiguration?
    
    @IBOutlet weak var appNameLeftLabel: UILabel!
    @IBOutlet weak var appNameRightLabel: UILabel!
    @IBOutlet weak var bundleIdentifierLeftLabel: UILabel!
    @IBOutlet weak var bundleIdentifierRightLabel: UILabel!
    @IBOutlet weak var environmentLeftLabel: UILabel!
    @IBOutlet weak var environmentRightLabel: UILabel!
    @IBOutlet weak var facebookIdentifierLeftLabel: UILabel!
    @IBOutlet weak var facebookIdentifierRightLabel: UILabel!
    @IBOutlet weak var pushNotificationsIdentifierLeftLabel: UILabel!
    @IBOutlet weak var pushNotificationsIdentifierRightLabel: UILabel!
    @IBOutlet weak var codeSignIdentityLeftLabel: UILabel!
    @IBOutlet weak var codeSignIdentityRightLabel: UILabel!
    @IBOutlet weak var provisioningProfileLeftLabel: UILabel!
    @IBOutlet weak var provisioningProfileRightLabel: UILabel!
    @IBOutlet weak var openWebButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func loadAppConfiguration(appConfiguration:AppConfiguration) -> Void {
        self.appConfiguration = appConfiguration
        self.updateUI()
    }
    
    func updateUI() -> Void {
        appNameRightLabel.text = appConfiguration?.appName
        bundleIdentifierRightLabel.text = appConfiguration?.bundleId
        environmentRightLabel.text = appConfiguration?.selectedEnvironment.environmentKey
        facebookIdentifierRightLabel.text = appConfiguration?.facebookId
        pushNotificationsIdentifierRightLabel.text = appConfiguration?.pushNotificationsId
        codeSignIdentityRightLabel.text = appConfiguration?.signingIdentity
        provisioningProfileRightLabel.text = appConfiguration?.provisioningProfile
    }
    
    @IBAction func openEnvironmentURL() -> Void {
        let url:String = (appConfiguration?.selectedEnvironment.environmentValue)!
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
}

