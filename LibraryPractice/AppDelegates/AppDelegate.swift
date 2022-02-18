//
//  AppDelegate.swift
//  LibraryPractice
//
//  Created by Hemant Shrestha on 16/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
//    var coordinator: MainCoordinator?
//    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let navController = UINavigationController()
//        coordinator = MainCoordinator(navigationController: navController)
//        coordinator?.start()
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
//        sandboxPlayground()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func sandboxPlayground() {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls.last?.appendingPathComponent("file.txt")
        
        //Write
        do {
            try "Hi There!".write(to: url!, atomically: true, encoding: .utf8)
        } catch {
            print("error while writting")
        }
        
        do {
            let content = try String(contentsOf: url!, encoding: .utf8)
            print(content)
        } catch {
            debugPrint("Error in Reading.")
        }
    }


}

