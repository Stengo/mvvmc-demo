//
//  MVVMCAuthenticateModel.swift
//  MVVM-C
//
//  Created by Scotty on 20/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

class MVVMCAuthenticateModel: AuthenticateModel
{
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    func login(email email: String, password: String, completionHandler: (error: NSError?) ->())
    {
        var error: NSError? = nil
        if email != "scotty@example.com" || password != "password" {
            error = NSError(domain: "MVVM-C",
                            code: 1,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid Email or Password"])
        }
        let successful = error == nil ? true : false
        defaults.setBool(successful , forKey: "loggedIn")
        completionHandler(error: error)
    }
    
    func loggedIn(completionHandler: (loggedIn: Bool) -> Void) {
        let loggedIn = defaults.boolForKey("loggedIn")
        completionHandler(loggedIn: loggedIn)
    }
}
