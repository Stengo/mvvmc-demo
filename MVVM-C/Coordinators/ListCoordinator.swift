//
//  ListCoordinator.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

protocol ListCoordinatorDelegate: class
{
    func listCoordinatorDidFinish(listCoordinator listCoordinator: ListCoordinator)
}

class ListCoordinator: Coordinator
{
    private var selectedData: DataItem?
    
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    
    weak var delegate: ListCoordinatorDelegate?
    private(set) var detailCoordinator: DetailCoordinator?
    private(set) var authenticationCoordinator: AuthenticationCoordinator?
    private var navigationController: UINavigationController
    private var listViewController: MVVMCListViewController?
    
    func start()
    {
        startWithEndpoint(nil)
    }
    
    func startWithEndpoint(endpoint: Endpoint?) {
        setupList()
        
        switch endpoint {
        case let detailEndpoint as DetailEndpoint:
            // ugly, requires more thought
            listViewModelDidSelectData(self.listViewController!.viewModel!, data: self.listViewController!.viewModel!.itemAtIndex(detailEndpoint.itemIndex!)!)
        default:
            return
        }
    }
    
    private func setupList() {
        let storyboard = UIStoryboard(name: "MVVM-C", bundle: nil)
        listViewController = storyboard.instantiateViewControllerWithIdentifier("List") as? MVVMCListViewController
        
        guard let listViewController = listViewController else { return }
        
        let viewModel =  MVVMCListViewModel()
        viewModel.model = MVVMCListModel()
        viewModel.coordinatorDelegate = self
        listViewController.viewModel = viewModel
        navigationController.pushViewController(listViewController, animated: false)
    }
}

extension ListCoordinator: ListViewModelCoordinatorDelegate
{
    func listViewModelDidSelectData(viewModel: ListViewModel, data: DataItem)
    {
        selectedData = data
        showAuthentication()
    }
}

extension ListCoordinator: DetailCoordinatorDelegate
{
    func detailCoordinatorDidFinish(detailCoordinator detailCoordinator: DetailCoordinator)
    {
        self.detailCoordinator = nil
    }
}


extension ListCoordinator: AuthenticationCoordinatorDelegate
{
    private var isLoggedIn: Bool {
        return false;
    }
    
    private func showAuthentication()
    {
        let authenticationCoordinator = AuthenticationCoordinator(navigationController: navigationController)
        self.authenticationCoordinator = authenticationCoordinator
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
    }
    
    func authenticationCoordinatorDidFinish(authenticationCoordinator authenticationCoordinator: AuthenticationCoordinator)
    {
        self.authenticationCoordinator = nil
        navigationController.popViewControllerAnimated(true)
        guard let data = selectedData else {
            return
        }
        detailCoordinator = DetailCoordinator(navigationController: navigationController, dataItem: data)
        detailCoordinator?.delegate = self
        detailCoordinator?.start()
    }
}
