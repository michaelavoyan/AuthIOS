//
//  Result.swift
//  Auth
//
//  Created by Michael Avoyan on 23/02/2023.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(AuthError)
}

extension Result {
    func get() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

public struct AuthError: Error {
    public let code: Int?
    public let description: String

    public init(error: Error, code: Int? = nil) {
        self.description = "\(error)"
        self.code = code
    }
    public init(description: String, code: Int? = nil) {
        self.description = description
        self.code = code
    }
}
