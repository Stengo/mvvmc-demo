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
    
    func listCoordinatorDidFinish(listCoordinator listCoordinator: ListCoordinator)
    {
        coordinators[CoordinatorType.List] = nil
    }
}

