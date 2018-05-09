//
//  ViewController.swift
//  KeychainTest
//
//  Created by Daniel Wallace on 9/05/18.
//  Copyright © 2018 danwallacenz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func setTapped(_ sender: Any) {
        
        let keychain = Keychain(service: "com.example.github-token")
        DispatchQueue.global().async {
            do {
                // Should be the secret invalidated when passcode is removed? If not then use `.WhenUnlocked`
                try keychain
                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
                    .set("01234567-89ab-cdef-0123-456789abcdef", key: "kishikawakatsumi")
            } catch let error {
                // Error handling if needed...
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func getTapped(_ sender: Any) {
        let keychain = Keychain(service: "com.example.github-token")
        
        DispatchQueue.global().async {
            do {
                let password = try keychain
                    .authenticationPrompt("Authenticate to login to server")
                    .get("kishikawakatsumi")
                
                print("password: \(String(describing: password))")
            } catch let error {
                // Error handling if needed...
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

