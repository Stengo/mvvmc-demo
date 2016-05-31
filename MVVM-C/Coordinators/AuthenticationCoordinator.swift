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
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    
    func start()
    {
        startWithEndpoint(nil)
    }
    
    func startWithEndpoint(endpoint: Endpoint?) {
        switch endpoint {
        default:
            setupAuthentication()
        }
    }
    
    private func setupAuthentication() {
        let storyboard = UIStoryboard(name: "MVVM-C", bundle: nil)
        if let vc = storyboard.instantiateViewControllerWithIdentifier("Authentication") as? MVVMCAuthenticationViewController {
            let viewModel =  MVVMCAuthenticateViewModel()
            let model = MVVMCAuthenticateModel()
            model.loggedIn { (loggedIn) in
                if loggedIn {
                    self.delegate?.authenticationCoordinatorDidFinish(authenticationCoordinator: self)
                } else {
                    viewModel.model = MVVMCAuthenticateModel()
                    viewModel.coordinatorDelegate = self
                    vc.viewModel = viewModel
                    self.navigationController.pushViewController(vc, animated: true)
                }
            }
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
