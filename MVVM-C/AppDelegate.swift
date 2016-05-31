//
//  AppDelegate.swift
//  MVVM-C
//
//  Created by Scotty on 19/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var navigationController: UINavigationController?
    var appCoordinator: AppCoordinator!
    
    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        
        window = UIWindow()
        navigationController = UINavigationController()
        window?.rootViewController = navigationController
        appCoordinator = AppCoordinator(navigationController: navigationController!)
        
        // show auth when restarting the app
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false , forKey: "loggedIn")
        
        // use detail endpoint
        appCoordinator.start()
//        let detailEndpoint = DetailEndpoint(itemIndex: 0)
//        appCoordinator.startWithEndpoint(detailEndpoint)
        
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

