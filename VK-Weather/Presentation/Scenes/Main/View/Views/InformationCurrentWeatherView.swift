import UIKit

final class InformationCurrentWeatherView: UIView {
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public
	
	func configureTemperature(current: Int, max: Int, min: Int) {
		temperatureLabel.text = "\(current)°"
		minMaxTemperatureTodayLabel.text = "Макс.: \(max)°, мин.: \(min)°"
	}
	
	func configureTownTitle(_ town: String) {
		townLabel.text = town
	}
	
	// MARK: - Private
	
	private let currentPlaceTitleLabel = UILabel()
	private let townLabel = UILabel()
	private let temperatureLabel = UILabel()
	private let minMaxTemperatureTodayLabel = UILabel()
	
	private func setup() {
		setupCurrentPlaceTitleLabel()
		setupTownLabel()
		setupTemperatureLabel()
		setupMinMaxTemperatureTodayLabel()
		
		currentPlaceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		townLabel.translatesAutoresizingMaskIntoConstraints = false
		temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
		minMaxTemperatureTodayLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupCurrentPlaceTitleLabel() {
		addSubview(currentPlaceTitleLabel)
		currentPlaceTitleLabel.text = "Текущее место"
		currentPlaceTitleLabel.textColor = .black
		currentPlaceTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .regular)
		NSLayoutConstraint.activate([
			currentPlaceTitleLabel.topAnchor.constraint(equalTo: topAnchor),
			currentPlaceTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
	
	private func setupTownLabel() {
		addSubview(townLabel)
		townLabel.textColor = .black
		townLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		NSLayoutConstraint.activate([
			townLabel.topAnchor.constraint(equalTo: currentPlaceTitleLabel.bottomAnchor, constant: 4),
			townLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
	
	private func setupTemperatureLabel() {
		addSubview(temperatureLabel)
		temperatureLabel.textColor = .black
		temperatureLabel.font = UIFont.systemFont(ofSize: 76, weight: .thin)
		NSLayoutConstraint.activate([
			temperatureLabel.topAnchor.constraint(equalTo: townLabel.bottomAnchor, constant: 6),
			temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
	
	private func setupMinMaxTemperatureTodayLabel() {
		addSubview(minMaxTemperatureTodayLabel)
		minMaxTemperatureTodayLabel.textColor = .black
		minMaxTemperatureTodayLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		NSLayoutConstraint.activate([
			minMaxTemperatureTodayLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor),
			minMaxTemperatureTodayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			minMaxTemperatureTodayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
}
