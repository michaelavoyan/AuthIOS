//
//  AuthProvider.swift
//  Auth
//
//  Created by Michael Avoyan on 23/02/2023.
//

import Foundation
import LocalAuthentication

public class AuthProvider {
    public static func instance() -> Auth {
        return AuthImpl(localAuthenticationContext: LAContext(), executor: ExecutorImpl())
    }
}
