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
        startWithEndpoint(nil)
    }
    
    func startWithEndpoint(endpoint: Endpoint?) {
        switch endpoint {
        default:
            showListWithEndpoint(endpoint)
        }
    }
}


extension AppCoordinator: ListCoordinatorDelegate
{
    private func showList()
    {
        showListWithEndpoint(nil)
    }
    
    private func showListWithEndpoint(endpoint: Endpoint?)
    {
        let listCoordinator = ListCoordinator(window: window)
        coordinators[CoordinatorType.List] = listCoordinator
        listCoordinator.delegate = self
        listCoordinator.startWithEndpoint(endpoint)
    }
    
    func listCoordinatorDidFinish(listCoordinator listCoordinator: ListCoordinator)
    {
        coordinators[CoordinatorType.List] = nil
    }
}

