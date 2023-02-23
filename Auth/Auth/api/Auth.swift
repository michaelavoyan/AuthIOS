//
//  Auth.swift
//  Auth
//
//  Created by Michael Avoyan on 23/02/2023.
//

import UIKit
import LocalAuthentication

public protocol Auth {
    ///Checks if authentication is available on the device
    func isAuthenticationAvailable(
        successHandler: @escaping (Bool) -> Void,
        errorHandler: @escaping (AuthError) -> Void
    )
    
    ///Displays a authentication identification dialog with provided configurations
    func authenticate(
        authConfig: AuthConfig,
        successHandler: @escaping (Bool) -> Void,
        errorHandler: @escaping (AuthError) -> Void
    )

    /// Navigates to device's security settings screen for authentication setup
    func openSecuritySettings(
        successHandler: @escaping (Bool) -> Void,
        errorHandler: @escaping (AuthError) -> Void
    )
}
