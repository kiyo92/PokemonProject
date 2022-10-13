//
//  AppDelegate.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navController = UINavigationController()
        
        self.coordinator = MainCoordinator(navigationController: navController)

        self.coordinator?.start()

        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = navController

        self.window?.makeKeyAndVisible()
         
        return true
    }
}

