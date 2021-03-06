//
//  AppDelegate.swift
//  todo-list-firebase
//
//  Created by Eldar Goloviznin on 20/09/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
    
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = UIViewController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        let router = Router(viewController: rootVC)
        router.showRootScene()
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let categoryIdentifier = response.notification.request.content.categoryIdentifier
        switch categoryIdentifier {
        case "task-deadline":
            switch response.actionIdentifier {
            case "mark-as-done":
                let taskInteractor = TaskInteractor()
                let task = Task(id: response.notification.request.identifier,
                                title: "",
                                description: "",
                                date: nil,
                                done: true)
                taskInteractor.edit(task: task)
                
            case "remind-later":
                let localNotificationsInteractor = LocalNotificationsInteractorDefault()
                // TODO
            default:
                break
            }
        default:
            break
        }
        
        completionHandler()
    }
    
}

