//
//  AuthImpl.swift
//  Auth
//
//  Created by Michael Avoyan on 23/02/2023.
//

import UIKit
import LocalAuthentication

class AuthImpl: Auth {
    
    let localAuthenticationContext: LAContext
    let executor: Executor
    
    init(localAuthenticationContext: LAContext, executor: Executor) {
        self.localAuthenticationContext = localAuthenticationContext
        self.executor = executor
    }
    
    func isAuthenticationAvailable(
        successHandler: @escaping (Bool) -> Void,
        errorHandler: @escaping (AuthError) -> Void
    ) {
        self.executor.runOnMainThread { [weak self] in
            do {
                var error: NSError?
                try successHandler(self?.localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) == true)
            } catch let error {
                errorHandler(AuthError(error: error))
            }
        }
    }
    
    func authenticate(
        authConfig: AuthConfig,
        successHandler: @escaping (Bool) -> Void,
        errorHandler: @escaping (AuthError) -> Void) {
            
            self.executor.runOnMainThread { [weak self] in
                do {
                    try self?.localAuthenticationContext.evaluatePolicy(
                        .deviceOwnerAuthentication,
    //                    .deviceOwnerAuthenticationWithBiometrics,
                        localizedReason: authConfig.title
                    ) { success, error in
                        
                        if success {
                            successHandler(true)
                        } else {
                            if let error = error {
                                errorHandler(AuthError(error: error))
                            } else {
                                successHandler(false)
                            }
                        }
                    }
                } catch let error {
                    errorHandler(AuthError(error: error))
                }
            }
        }
    
    func openSecuritySettings(
        successHandler: @escaping (Bool) -> Void,
        errorHandler: @escaping (AuthError) -> Void) {
            
            self.executor.runOnMainThread {
                if let url = URL.init(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    successHandler(true)
                }
                else {
                    errorHandler(AuthError(description: "Failed to oppen settings"))
                }
            }
        }
}
