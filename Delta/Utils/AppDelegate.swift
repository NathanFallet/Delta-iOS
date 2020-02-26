//
//  AppDelegate.swift
//  Delta
//
//  Created by Nathan FALLET on 9/17/18.
//  Copyright © 2018 Nathan FALLET. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Get build numbers
        let data = UserDefaults.standard
        let current_version = Int(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0") ?? 0
        var build_number = current_version
        if let value = data.value(forKey: "build_number") as? Int {
            build_number = value
        }
        
        // Check to update
        //if build_number < X {}
        
        // Update database
        Database.current.updateDatabase(build_number: build_number)
        
        // Get current version and save it
        data.set(current_version, forKey: "build_number")
        
        // Create view
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplitViewController()
        window?.makeKeyAndVisible()
        
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

#if targetEnvironment(macCatalyst)
extension AppDelegate {
    
    override func buildMenu(with builder: UIMenuBuilder) {
        // Check if it's main menu
        if builder.system == .main {
            // Help feature
            builder.replaceChildren(ofMenu: .help, from: helpMenu(elements:))
        }
    }
    
    func helpMenu(elements: [UIMenuElement]) -> [UIMenuElement] {
        // Create a menu item
        let help = UIKeyCommand(title: "help".localized(), image: nil, action: #selector(openHelp(_:)), input: "?", modifierFlags: .command, propertyList: nil, alternates: [], discoverabilityTitle: nil, attributes: .destructive, state: .off)
        
        // Return list
        return [help]
    }
    
    @objc func openHelp(_ sender: Any) {
        // Help and documentation
        if let url = URL(string: "https://www.delta-math-helper.com") {
            UIApplication.shared.open(url)
        }
    }

}
#endif
