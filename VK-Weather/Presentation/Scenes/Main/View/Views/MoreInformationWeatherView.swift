import UIKit

final class MoreInformationWeatherView: UIView {
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public
	
	func configure(model: WeatherModel) {
		feelsLikeWeatherView.configure(title: "Ощущается как", value: "\(Int(model.weatherInformation.feelsLike.rounded(.up)))°")
		pressureView.configure(title: "Давление", value: "\(model.weatherInformation.pressure)\nмм рт.ст.")
		humidityView.configure(title: "Влажность", value: "\(model.weatherInformation.humidity)%")
		visibilityView.configure(title: "Видимость", value: "\(model.visibility / 1000)км")
		cloudsView.configure(title: "Облачность", value: "\(model.cloudy)%")
		windView.configure(title: "Ветер", value: "скорость: \(model.wind.speed) м/с\nугол наклона ветра: \(model.wind.deg)°")
	}
	
	// MARK: - Private
	
	private let feelsLikeWeatherView = TitleWithValueCardView()
	private let pressureView = TitleWithValueCardView()
	private let humidityView = TitleWithValueCardView()
	private let visibilityView = TitleWithValueCardView()
	private let cloudsView = TitleWithValueCardView()
	private let windView = TitleWithValueCardView()
	
	private func setup() {
		setupPressureView()
		setupFeelsLikeWeatherView()
		setupHumidityView()
		setupVisibilityView()
		setupCloudsView()
		setupWindView()
		
		feelsLikeWeatherView.translatesAutoresizingMaskIntoConstraints = false
		pressureView.translatesAutoresizingMaskIntoConstraints = false
		humidityView.translatesAutoresizingMaskIntoConstraints = false
		visibilityView.translatesAutoresizingMaskIntoConstraints = false
		cloudsView.translatesAutoresizingMaskIntoConstraints = false
		windView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupPressureView() {
		addSubview(pressureView)
		NSLayoutConstraint.activate([
			pressureView.topAnchor.constraint(equalTo: topAnchor),
			pressureView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
		])
	}
	
	private func setupFeelsLikeWeatherView() {
		addSubview(feelsLikeWeatherView)
		NSLayoutConstraint.activate([
			feelsLikeWeatherView.topAnchor.constraint(equalTo: topAnchor),
			feelsLikeWeatherView.trailingAnchor.constraint(equalTo: pressureView.leadingAnchor, constant: -12),
			feelsLikeWeatherView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			feelsLikeWeatherView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -24 * 1.5),
			feelsLikeWeatherView.heightAnchor.constraint(equalTo: pressureView.heightAnchor)
		])
	}
	
	private func setupHumidityView() {
		addSubview(humidityView)
		NSLayoutConstraint.activate([
			humidityView.topAnchor.constraint(equalTo: pressureView.bottomAnchor, constant: 12),
			humidityView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
		])
	}
	
	private func setupVisibilityView() {
		addSubview(visibilityView)
		NSLayoutConstraint.activate([
			visibilityView.topAnchor.constraint(equalTo: pressureView.bottomAnchor, constant: 12),
			visibilityView.trailingAnchor.constraint(equalTo: humidityView.leadingAnchor, constant: -12),
			visibilityView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			visibilityView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -24 * 1.5)
		])
	}
	
	private func setupCloudsView() {
		addSubview(cloudsView)
		NSLayoutConstraint.activate([
			cloudsView.topAnchor.constraint(equalTo: visibilityView.bottomAnchor, constant: 12),
			cloudsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			cloudsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
		])
	}
	
	private func setupWindView() {
		addSubview(windView)
		NSLayoutConstraint.activate([
			windView.topAnchor.constraint(equalTo: cloudsView.bottomAnchor, constant: 12),
			windView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			windView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			windView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
