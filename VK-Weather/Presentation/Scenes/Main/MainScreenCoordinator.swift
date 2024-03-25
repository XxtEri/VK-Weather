final class MainScreenCoordinator: Coordinator {
	// MARK: - Init
	
	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}
	
	// MARK: - Public
	
	let navigationController: NavigationController
	let appDependency: AppDependency
	
	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?
	
	func start(animated: Bool) {
		showMainScreen(animated: animated)
	}
	
	// MARK: - Private
	
	private func showMainScreen(animated: Bool) {
		let viewModel = MainScreenViewModel(dependencies: appDependency)
		let viewController = MainScreenViewController(viewModel: viewModel, locationService: appDependency.locationService)
		
		addPopObserver(for: viewController)
		navigationController.pushViewController(viewController, animated: animated)
	}
}
