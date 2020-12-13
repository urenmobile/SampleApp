//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/1/20.
//

import UIKit
import URENData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Dependency 
        let networkReachability = NetworkReachabilityManager.shared
        let appViewModel = AppViewModel()
        appCoordinator = AppCoordinator(networkReachability: networkReachability, appViewModel: appViewModel)
        appCoordinator.start()
        
        return true
    }
}

