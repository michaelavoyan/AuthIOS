//
//  ExecutorImpl.swift
//  Auth
//
//  Created by Michael Avoyan on 23/02/2023.
//

import Foundation

class ExecutorImpl: Executor {
    private var mainThread: DispatchQueue
    
    init() {
        self.mainThread = DispatchQueue.main
    }
    
//    func runOn(_ callinghQueue: DispatchQueue, _ block: @escaping () -> Void) {
//        callinghQueue.async {
//            block()
//        }
//    }
    
    func runOnMainThread(_ block: @escaping () -> Void) {
        self.mainThread.async {
            block()
        }
    }
    
    func runOnBackgroundThread(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async {
            block()
        }
    }
}
