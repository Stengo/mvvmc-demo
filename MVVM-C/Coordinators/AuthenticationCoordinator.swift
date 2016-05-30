//
//  AuthenticationCoordinator.swift
//  MVVM-C
//
//  Created by Scotty on 19/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

protocol AuthenticationCoordinatorDelegate: class
{
    func authenticationCoordinatorDidFinish(authenticationCoordinator authenticationCoordinator: AuthenticationCoordinator)
}

class AuthenticationCoordinator: Coordinator
{
    weak var delegate: AuthenticationCoordinatorDelegate?
    private let window: UIWindow
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        let storyboard = UIStoryboard(name: "MVVM-C", bundle: nil)
        if let vc = storyboard.instantiateViewControllerWithIdentifier("Authentication") as? MVVMCAuthenticationViewController {
            let viewModel =  MVVMCAuthenticateViewModel()
            let model = MVVMCAuthenticateModel()
            model.loggedIn({ (loggedIn) in
                if loggedIn {
                    self.delegate?.authenticationCoordinatorDidFinish(authenticationCoordinator: self)
                } else {
                    viewModel.model = MVVMCAuthenticateModel()
                    viewModel.coordinatorDelegate = self
                    vc.viewModel = viewModel
                    self.window.rootViewController = vc
                }
            })
        }
    }
}

extension AuthenticationCoordinator: AuthenticateViewModelCoordinatorDelegate
{
    func authenticateViewModelDidLogin(viewModel viewModel: AuthenticateViewModel)
    {
        delegate?.authenticationCoordinatorDidFinish(authenticationCoordinator: self)
    }
}
