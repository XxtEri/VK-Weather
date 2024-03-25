//
//  AppDelegate.swift
//  VK-Weather
//
//  Created by Елена on 19.03.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var orientationLock = UIInterfaceOrientationMask.portrait

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication,
					 supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
		orientationLock
	}
}

