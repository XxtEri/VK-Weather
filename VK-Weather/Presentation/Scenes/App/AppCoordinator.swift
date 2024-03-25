import UIKit

final class AppCoordinator: Coordinator {
	// MARK: - Init
	
	init(navigationController: NavigationController, appDependency: AppDependency = AppDependency()) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}
	
	// MARK: - Public
	
	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?
	
	let navigationController: NavigationController
	let appDependency: AppDependency
	
	func start(animated: Bool) {
		showMainScreen(animated: animated)
	}
	
	// MARK: - Private
	
	private func showMainScreen(animated: Bool) {
		let coordinator = show(MainScreenCoordinator.self, animated: animated)
	}
}
