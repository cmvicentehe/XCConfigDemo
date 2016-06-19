//
//  AppConfiguration.swift
//  ConfigFilesDemo
//
//  Created by Carlos M. Vicente Herrero on 18/6/16.
//  Copyright © 2016 Carlos M. Vicente Herrero. All rights reserved.
//

import Foundation

struct AppConfiguration {
    
    var appName: String
    var bundleId: String
    var supportedEnvironments: [Environment]
    var selectedEnvironment: Environment
    var facebookId: String
    var pushNotificationsId: String
    var signingIdentity: String
    var provisioningProfile: String
    
    init (appName: String,
          bundleId: String,
          supportedEnvironments: [Environment],
          selectedEnvironment: Environment,
          facebookId: String,
          pushNotificationsId: String,
          signingIdentity: String,
          provisioningProfile: String) {
    
        self.appName                = appName
        self.bundleId               = bundleId
        self.supportedEnvironments  = supportedEnvironments
        self.selectedEnvironment    = selectedEnvironment
        self.facebookId             = facebookId
        self.pushNotificationsId    = pushNotificationsId
        self.signingIdentity        = signingIdentity
        self.provisioningProfile    = provisioningProfile
    }
    
}