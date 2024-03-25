import UIKit

final class MainScreenViewController: BaseViewController, NavigationBarHiding {
	// MARK: - Init
	
	init(viewModel: MainScreenViewModel, locationService: LocationServiceProtocol) {
		self.viewModel = viewModel
		self.locationService = locationService
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life cycles
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		setupBindings()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupActivityIndicator()
		locationService.determineLocation()
	}
	
	// MARK: - Private
	
	private let viewModel: MainScreenViewModel
	private var locationService: LocationServiceProtocol
	
	// MARK: Views
	
	private let scrollView = UIScrollView()
	private let contentView = UIView()
	private let informationCurrentWeatherView = InformationCurrentWeatherView()
	private let moreInformationWeatherView = MoreInformationWeatherView()
	private let weatherNextDaysTitleLabel = UILabel()
	private let weatherNextDaysTableView = UITableView(frame: .zero)
	
	// MARK: Setup
	
	private func setupBindings() {
		locationService.onDidLoadCoordinateLocation = { [ weak self ] coordinates in
			guard let self = self else { return }
			self.viewModel.loadData(locationCoordinates: coordinates)
		}
		
		locationService.onDidLoadLocality = { [ weak self ] locality in
			self?.informationCurrentWeatherView.configureTownTitle(locality)
		}
		
		locationService.onDidReceiveError = { [ weak self ] error in
			self?.viewModel.onDidRecieveLocationError(error: error)
		}
		
		viewModel.onDidLoadData = { [ weak self ] in
			guard let self = self, let weatherToday = self.viewModel.weatherToday else { return }
			self.stopActivityIndicator()
			self.moreInformationWeatherView.configure(model: weatherToday)
			self.informationCurrentWeatherView.configureTemperature(
				current: Int(weatherToday.weatherInformation.temperature),
				max: Int(weatherToday.weatherInformation.maxTemperature),
				min: Int(weatherToday.weatherInformation.minTemperature)
			)
			self.weatherNextDaysTableView.reloadData()
		}
		
		viewModel.onDidReceiveError = { [ weak self ] errorDescription in
			guard let self = self else { return }
			self.showErrorBanner(with: errorDescription)
			DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
				self.hideErrorBanner()
			}
		}
		
		viewModel.showAlertPermissionLocation = { [ weak self ] in
			self?.showGoToSettingsAlert(title: "Отсутствует доступ к локации", description: "Для получения информации о погоде необходимо установить ваше местоположение. Разрешите определение вашего точного местоположения для этого приложения в настройках", cancelButtonTitle: "Отмена")
		}
	}
	
	private func setup() {
		setupScrollView()
		setupContentView()
		setupInformationCurrentWeatherView()
		setupMoreInformationWeatherView()
		setupWeatherNextDaysTitleLabel()
		setupWeatherNextDaysTableView()
		
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		contentView.translatesAutoresizingMaskIntoConstraints = false
		informationCurrentWeatherView.translatesAutoresizingMaskIntoConstraints = false
		weatherNextDaysTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		weatherNextDaysTableView.translatesAutoresizingMaskIntoConstraints = false
		moreInformationWeatherView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupScrollView() {
		view.addSubview(scrollView)
		scrollView.backgroundColor = .clear
		scrollView.showsVerticalScrollIndicator = false
		scrollView.contentInsetAdjustmentBehavior = .never
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	private func setupContentView() {
		scrollView.addSubview(contentView)
		print(UIScreen.main.bounds.size.height)
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.35)
		])
	}
	
	private func setupInformationCurrentWeatherView() {
		contentView.addSubview(informationCurrentWeatherView)
		NSLayoutConstraint.activate([
			informationCurrentWeatherView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
			informationCurrentWeatherView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
		])
	}
	
	private func setupMoreInformationWeatherView() {
		contentView.addSubview(moreInformationWeatherView)
		NSLayoutConstraint.activate([
			moreInformationWeatherView.topAnchor.constraint(equalTo: informationCurrentWeatherView.bottomAnchor, constant: 24),
			moreInformationWeatherView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			moreInformationWeatherView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
		])
	}
	
	private func setupWeatherNextDaysTitleLabel() {
		contentView.addSubview(weatherNextDaysTitleLabel)
		weatherNextDaysTitleLabel.text = "Прогноз погоды на 7 дней"
		weatherNextDaysTitleLabel.textColor = .black
		weatherNextDaysTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		NSLayoutConstraint.activate([
			weatherNextDaysTitleLabel.topAnchor.constraint(equalTo: moreInformationWeatherView.bottomAnchor, constant: 24),
			weatherNextDaysTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
			weatherNextDaysTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
		])
	}
	
	private func setupWeatherNextDaysTableView() {
		contentView.addSubview(weatherNextDaysTableView)
		weatherNextDaysTableView.backgroundColor = .none
		weatherNextDaysTableView.showsVerticalScrollIndicator = false
		weatherNextDaysTableView.showsHorizontalScrollIndicator = false
		weatherNextDaysTableView.separatorStyle = .none
		weatherNextDaysTableView.dataSource = self
		weatherNextDaysTableView.rowHeight = UITableView.automaticDimension
		weatherNextDaysTableView.isScrollEnabled = false
		weatherNextDaysTableView.register(WeatherNextDaysTableViewCell.self, forCellReuseIdentifier: WeatherNextDaysTableViewCell.reuseIdentifier)
		NSLayoutConstraint.activate([
			weatherNextDaysTableView.topAnchor.constraint(equalTo: weatherNextDaysTitleLabel.bottomAnchor, constant: 12),
			weatherNextDaysTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
			weatherNextDaysTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
			weatherNextDaysTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 24),
		])
	}
	
}

// MARK: - UITableViewDataSource

extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.nextWeathers.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: WeatherNextDaysTableViewCell.reuseIdentifier, for: indexPath
		) as? WeatherNextDaysTableViewCell else {
			return UITableViewCell()
		}
		
		let weather = viewModel.nextWeathers[indexPath.row]
		cell.configure(
			date: weather.date,
			maxTemperature: weather.maxTemperature,
			minTemperature: weather.minTemperature
		)
		
		return cell
	}
}

// MARK: - GoToSettingsAlertShowing

extension MainScreenViewController: GoToSettingsAlertShowing {}
