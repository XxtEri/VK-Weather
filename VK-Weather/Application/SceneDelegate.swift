//
//  SceneDelegate.swift
//  VK-Weather
//
//  Created by Елена on 19.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	// MARK: - Public
	
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = scene as? UIWindowScene else { return }
		
		appCoordinator = createAppCoordinator(scene: scene)
		appCoordinator?.start(animated: false)
	}

	// MARK: - Private
	
	private var appCoordinator: AppCoordinator?
	
	private func createAppCoordinator(scene: UIWindowScene) -> AppCoordinator {
		let window = UIWindow(windowScene: scene)
		let navigationController = NavigationController()
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
		
		self.window = window
		
		return AppCoordinator(navigationController: navigationController)
	}
}

