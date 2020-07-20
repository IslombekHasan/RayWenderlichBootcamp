//
//  AppDelegate.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var persistentStore: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Sandwiches")
    container.loadPersistentStores { (storeDesc, error) in
      if let error = error {
        fatalError("Couldn't load Core Data")
      }
    }
    return container
  }()

  func saveContext() {
    let context = persistentStore.viewContext
    guard context.hasChanges else { return }
    do { try context.save() }
    catch let error { print("Couldn't save due to \(error)") }
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
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


}

