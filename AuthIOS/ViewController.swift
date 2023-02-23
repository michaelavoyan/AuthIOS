//
//  ViewController.swift
//  AuthIOS
//
//  Created by Michael Avoyan on 19/02/2023.
//

import UIKit
import Auth

class ViewController: UIViewController {
    
    @IBOutlet weak var btnAuthenticate: UIButton!
    @IBOutlet weak var btnOpenSecuritySettings: UIButton!
    
    private var auth: Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = AuthProvider.instance()
        
        btnAuthenticate.addTarget(self, action: #selector(authenticate), for: .touchUpInside)
        btnOpenSecuritySettings.addTarget(self, action: #selector(openSecuritySettings), for: .touchUpInside)
    }
    
    @objc private func authenticate() {
        auth.isAuthenticationAvailable(
            successHandler: { [weak self] isAuthenticationAvailable in
                NSLog("isAuthenticationAvailable: \(isAuthenticationAvailable)")
                if isAuthenticationAvailable {
                    self?.auth.authenticate(
                        authConfig: AuthConfig(
                            title: "The passcode you use to unlock this Phone, can also be used to access your Velocity account."
                        ),
                        successHandler: { isRecognized in
                            NSLog("User recognized: \(isRecognized)")
                            
                        },
                        errorHandler: { [weak self] error in
                            NSLog("Auth error: \(error)")
                            self?.showAlert(title: "Auth error", message: error.description)
                        })
                } else {
                    self?.showAlert(title: "Authentication is NOT Available", message: "")
                }
            },
            errorHandler: { [weak self] error in
                NSLog("isAuthenticationAvailable error: \(error)")
                self?.showAlert(title: "isAuthenticationAvailable error", message: error.description)
            })
    }
    
    @objc private func openSecuritySettings() {
        auth.openSecuritySettings (
            successHandler: { isOpen in
                NSLog("Security settings open: \(isOpen)")
            },
            errorHandler: { error in
                NSLog("Security settings open error: \(error)")
            })
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

