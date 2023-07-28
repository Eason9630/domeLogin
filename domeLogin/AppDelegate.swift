//
//  AppDelegate.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/5/23.
//

import UIKit
import FacebookCore
import Firebase
import GoogleSignIn
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        FirebaseApp.configure()
        GMSPlacesClient.provideAPIKey("AIzaSyDUsvvw1-4Liict7_IA_cDFPEYrl77QajU")


        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
                
        ApplicationDelegate.shared.application(app, open: url, options: options)
    
        return GIDSignIn.sharedInstance.handle(url)
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


}

