//
//  DetailCoordinator.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit


protocol DetailCoordinatorDelegate: class
{
    func detailCoordinatorDidFinish(detailCoordinator detailCoordinator: DetailCoordinator)
}

class DetailCoordinator: Coordinator
{
    weak var delegate: DetailCoordinatorDelegate?
    private let dataItem: DataItem
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, dataItem: DataItem)
    {
        self.navigationController = navigationController
        self.dataItem = dataItem
    }
    
    func start()
    {
        startWithEndpoint(nil)
    }
    
    func startWithEndpoint(endpoint: Endpoint?) {
        switch endpoint {
        default:
            setupDetail()
        }
    }
    
    private func setupDetail() {
        let storyboard = UIStoryboard(name: "MVVM-C", bundle: nil)
        if let vc = storyboard.instantiateViewControllerWithIdentifier("Detail") as? MVVMCDetailViewController {
            let viewModel =  MVVMCDetailViewModel()
            viewModel.model = MVVMCDetailModel(detailItem: dataItem)
            viewModel.coordinatorDelegate = self
            vc.viewModel = viewModel
            navigationController.pushViewController(vc, animated: true)
        }
    }
}

extension DetailCoordinator: DetailViewModelCoordinatorDelegate
{
    
    func detailViewModelDidEnd(viewModel: DetailViewModel)
    {
        delegate?.detailCoordinatorDidFinish(detailCoordinator: self)
    }
    
}
