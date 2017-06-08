//
//  AppDelegate.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 8/19/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import SVProgressHUD


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        application.isStatusBarHidden = true
        
        //Facebook enablers
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //IQKeyboard Manager Enabler
        IQKeyboardManager.sharedManager().enable = true
    //    STPPaymentConfiguration.shared().publishableKey = "pk_test_Ifvl01MgR4PwBfmnH5WWfgvn"
        /*
        STPTheme.default().accentColor = UIColor.red
        STPTheme.default().primaryBackgroundColor = UIColor.darkGray
        STPTheme.default().secondaryForegroundColor = UIColor.green
        STPTheme.default().primaryForegroundColor = UIColor.black
        STPTheme.default().accentColor = UIColor.gray
        STPTheme.default().
        STPTheme.default().secondaryBackgroundColor = UIColor.white
        //STPTheme.default().emphasisFont = UIColor.black
        
        */
        
        return true
    }
    
    //Facebook login AppDelegate information
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation:options[UIApplicationOpenURLOptionsKey.sourceApplication])
        
        // Add any custom logic here.
        return handled;
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       // FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    /*
    func registerForPushNotifications(application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(
            forTypes: [.badge, .sound, .alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
    }

*/
}

