//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by Scotty on 19/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit



class AppCoordinator: Coordinator
{
    private let AUTHENTICATION_KEY: String  = "Authentication"
    private let LIST_KEY: String  = "List"

    private var window: UIWindow
    private(set) var coordinators = [String:Coordinator]()
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        if isLoggedIn {
            showList()
        } else {
            showAuthentication()
        }
    }
}



extension AppCoordinator: AuthenticationCoordinatorDelegate
{
    private var isLoggedIn: Bool {
        return false;
    }
    
    private func showAuthentication()
    {
        let authenticationCoordinator = AuthenticationCoordinator(window: window)
        coordinators[AUTHENTICATION_KEY] = authenticationCoordinator
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
    }
    
    func authenticationCoordinatorDidFinish(authenticationCoordinator authenticationCoordinator: AuthenticationCoordinator)
    {
        coordinators[AUTHENTICATION_KEY] = nil
        showList()
    }
}


extension AppCoordinator: ListCoordinatorDelegate
{
    private func showList()
    {
        let listCoordinator = ListCoordinator(window: window)
        coordinators[LIST_KEY] = listCoordinator
        listCoordinator.delegate = self
        listCoordinator.start()
    }
    
    func listCoordinatorDidFinish(listCoordinator listCoordinator: ListCoordinator)
    {
        coordinators[LIST_KEY] = nil
    }
}

