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
        let appConfiguration: AppConfiguration = self.readAppConfigurationFromPlist()
        
        let viewController:ViewController = (storyBoard.instantiateViewControllerWithIdentifier("ViewController") as? ViewController)!
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = viewController
        self.window?.addSubview(viewController.view)
        
        viewController.loadAppConfiguration(appConfiguration)
        
        return true
    }
    
    // MARK: APP_CONFIGURATION
    func readAppConfigurationFromPlist () -> AppConfiguration {
        
        let appConfiguration:AppConfiguration
        var appName:String = ""
        var bundleIdentifier:String = ""
        var facebookIdentifier:String = ""
        var notificationsIdentifier:String = ""
        let supportedEnvironments: [Environment] = self.readSupportedEnvironmentsFromPlist()
        let selectedEnvironment: Environment = self.readSelectedEnvironmentFromPlist(supportedEnvironments)
        var signingIdentity: String = ""
        var provisioningProfile: String = ""
        
        guard let infoPlistPath:String = NSBundle.mainBundle().pathForResource("Info", ofType: "plist") else {
            return AppConfiguration (appName: "",
                                   bundleId: "",
                                   supportedEnvironments: [],
                                   selectedEnvironment: Environment(environmentKey: "", environmentValue: ""),
                                   facebookId: "",
                                   pushNotificationsId: "",
                                   signingIdentity: "",
                                   provisioningProfile: "")
        }
        
        if let dict:NSDictionary = NSDictionary(contentsOfFile: infoPlistPath) {
            
            if let name:String = dict["Facebook_ID"] as? String
            {
                appName = name
            }
            
            if let bundleID:String = dict["CFBundleIdentifier"] as? String
            {
                bundleIdentifier = bundleID
            }
            
            if let facebookID:String = dict["Facebook_ID"] as? String
            {
                facebookIdentifier = facebookID
            }
            
            if let notificationsID:String = dict["NotificationPush_ID"] as? String
            {
                notificationsIdentifier = notificationsID
            }
            
            if let siginingIdentityInformation:String = dict["SigningIdentity"] as? String
            {
                signingIdentity = siginingIdentityInformation
            }
            
            if let provisioningProfileInformation:String = dict["ProvisioningProfile"] as? String
            {
                provisioningProfile = provisioningProfileInformation
            }

        }
        
        appConfiguration = AppConfiguration(appName: appName,
                                            bundleId: bundleIdentifier,
                                            supportedEnvironments: supportedEnvironments,
                                            selectedEnvironment: selectedEnvironment,
                                            facebookId: facebookIdentifier,
                                            pushNotificationsId: notificationsIdentifier,
                                            signingIdentity: signingIdentity,
                                            provisioningProfile: provisioningProfile)
        
        return appConfiguration
    }
    
    // MARK: APP_CONFIGURATION (Environment)
    
    func readSupportedEnvironmentsFromPlist() -> [Environment] {
        
        var supportedEnvironments:[Environment] = []
        
        guard let infoPlistPath:String = NSBundle.mainBundle().pathForResource("Info", ofType: "plist") else { return [] }
        
        if let dict:NSDictionary = NSDictionary(contentsOfFile: infoPlistPath) {
            
            if let supportedEnvironmentsDict:Dictionary<String, String> = dict["SupportedEnvironments"] as? Dictionary<String, String> {
                
                for key:String in supportedEnvironmentsDict.keys {
                    
                    let value: String = supportedEnvironmentsDict[key]!
                    let environment:Environment = Environment(environmentKey: key, environmentValue: value)
                    
                    supportedEnvironments.append(environment)
                }
            }
            
        }
        return supportedEnvironments
    }
    
    func readSelectedEnvironmentFromPlist(supportedEnvironments: [Environment]) -> Environment {
        
        var result:Environment? = nil
        
        guard let infoPlistPath:String = NSBundle.mainBundle().pathForResource("Info", ofType: "plist") else { return self.environmentForKey("Production", supportedEnvironments: supportedEnvironments) }
        
        if let dict:NSDictionary = NSDictionary(contentsOfFile: infoPlistPath) {
            
            if let selectedEnvironment:String = dict["SelectedEnvironment"] as? String
            {
                result = self.environmentForKey(selectedEnvironment, supportedEnvironments: supportedEnvironments)
            }
        }
        
        if result == nil {
            
            result = self.environmentForKey("Production", supportedEnvironments: supportedEnvironments)
        }
        
        return result!
    }
    
    func environmentForKey(key: String, supportedEnvironments: [Environment]) -> Environment {
        
        var result:Environment? = nil
        
        for environment:Environment in supportedEnvironments {
            
            if environment.environmentKey == key {
                
                result = environment
                break
            }
        }
        
        if result == nil {
            
            result = self.environmentForKey("Production", supportedEnvironments: supportedEnvironments)
        }
        
        return result!
    }
}

