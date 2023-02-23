//
//  Executor.swift
//  Auth
//
//  Created by Michael Avoyan on 23/02/2023.
//

import Foundation

protocol Executor {
//    func runOn(_ callinghQueue: DispatchQueue, _ block: @escaping () -> Void)
    func runOnMainThread(_ block: @escaping () -> Void)
    func runOnBackgroundThread(_ block: @escaping () -> Void)
}
