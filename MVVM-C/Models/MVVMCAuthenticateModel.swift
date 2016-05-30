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
    private(set) var loggedIn = false
    
    func login(email email: String, password: String, completionHandler: (error: NSError?) ->())
    {
        var error: NSError? = nil
        if email != "scotty@example.com" || password != "password" {
            error = NSError(domain: "MVVM-C",
                            code: 1,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid Email or Password"])
        }
        loggedIn = true
        completionHandler(error: error)
    }
}
