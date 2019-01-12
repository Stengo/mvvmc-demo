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
    private var window: UIWindow
    private(set) var coordinators = [CoordinatorType:Coordinator]()
    
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
        coordinators[CoordinatorType.Authentication] = authenticationCoordinator
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
    }
    
    func authenticationCoordinatorDidFinish(authenticationCoordinator: AuthenticationCoordinator)
    {
        coordinators[CoordinatorType.Authentication] = nil
        showList()
    }
}


extension AppCoordinator: ListCoordinatorDelegate
{
    private func showList()
    {
        let listCoordinator = ListCoordinator(window: window)
        coordinators[CoordinatorType.List] = listCoordinator
        listCoordinator.delegate = self
        listCoordinator.start()
    }
    
    func listCoordinatorDidFinish(listCoordinator: ListCoordinator)
    {
        coordinators[CoordinatorType.List] = nil
    }
}

