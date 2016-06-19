//
//  Environment.swift
//  ConfigFilesDemo
//
//  Created by Carlos M. Vicente Herrero on 18/6/16.
//  Copyright © 2016 Carlos M. Vicente Herrero. All rights reserved.
//

import Foundation

struct Environment {
    
    var environmentKey: String
    var environmentValue: String
    
    init (environmentKey: String,
          environmentValue: String) {
    
        self.environmentKey = environmentKey
        self.environmentValue = environmentValue
    }
    
}