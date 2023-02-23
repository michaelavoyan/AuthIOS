//
//  GlobalConfig.swift
//  Auth
//
//  Created by Michael Avoyan on 23/02/2023.
//

import Foundation

struct GlobalConfig {
    static let Package = "avoyan.auth"
        
    #if DEBUG
        static let IsDebug = true
    #else
        static let IsDebug = false
    #endif    
}
