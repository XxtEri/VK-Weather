import Foundation

final class MainScreenViewModel {
	typealias Dependencies = HasGetWeatherUseCase & HasConvertTempKelvinToCelsiusUseCase & HasCalendarHelper & HasGetNextWeathersUseCase
	
	// MARK: - Init
	
	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}
	
	// MARK: - Public
	
	private(set) var weatherToday: WeatherModel?
	private(set) var nextWeathers: [NextWeatherModel] = []
	
	var onDidLoadData: (() -> Void)?
	var onDidReceiveError: ((String) -> Void)?
	var showAlertPermissionLocation: (() -> Void)?
	
	func loadData(locationCoordinates: LocationCoordinates) {
		Task {
			do {
				try await loadCurrentWeather(locationCoordinates: locationCoordinates)
				try await loadNextWeathers(locationCoordinates: locationCoordinates)
				
				DispatchQueue.main.async {
					guard let weatherToday = self.weatherToday else { return }
					self.weatherToday = self.convertTemperatureInModel(weather: weatherToday)
					self.onDidLoadData?()
				}
			} catch {
				guard let error = error as? AppError else { return }
				DispatchQueue.main.async {
					self.handleError(error: error)
				}
			}
		}
	}
	
	func onDidRecieveLocationError(error: Error) {
		guard let error = error as? LocationServiceError else { return }
		if error == .unauthorized {
			showAlertPermissionLocation?()
		} else {
			handleError(error: error)
		}
	}
	
	// MARK: - Private
	
	private let dependencies: Dependencies
	
	private func loadCurrentWeather(locationCoordinates: LocationCoordinates) async throws {
		weatherToday = try await dependencies.getWeatherUseCase.invoke(
			latitude: locationCoordinates.latitude,
			longitude: locationCoordinates.longitude
		)
	}
	
	private func loadNextWeathers(locationCoordinates: LocationCoordinates) async throws {
		let nextWeekDates = dependencies.calendarHelper.getWeekFromDate(date: Date()).map {
			DateFormatter.yearMonthDayISO.string(from: $0)
		}
		let nextWeathers = try await dependencies.getNextWeathersUseCase.invoke(latitude: locationCoordinates.latitude, longitude: locationCoordinates.longitude)
		
		nextWeekDates.forEach { date in
			var maxTemperatures: [Float] = []
			var minTemperatures: [Float] = []
			 
			nextWeathers.forEach { weather in
				if let weatherDate = weather.date {
					let tempDate = DateFormatter.ISODate.date(from: weatherDate) ?? Date()
					let convertDate = DateFormatter.yearMonthDayISO.string(from: tempDate)
					
					if date == convertDate {
						maxTemperatures.append(weather.weatherInformation.maxTemperature)
						minTemperatures.append(weather.weatherInformation.minTemperature)
					}
				}
			}
			
			let tempDate = DateFormatter.yearMonthDayISO.date(from: date) ?? Date()
			let convertDateNextWeather = DateFormatter.dateWithMonthToRus.string(from: tempDate)

			if let maxTemperature = maxTemperatures.max(), let minTemperature = minTemperatures.min() {
				self.nextWeathers.append(NextWeatherModel(
					date: convertDateNextWeather,
					maxTemperature: convertTemperature(maxTemperature),
					minTemperature: convertTemperature(minTemperature)
				))
			} else {
				self.nextWeathers.append(NextWeatherModel(
					date: convertDateNextWeather,
					maxTemperature: nil,
					minTemperature: nil
				))
			}
		}
	}
	
	private func convertTemperatureInModel(weather: WeatherModel) -> WeatherModel {
		var weather = weather
		weather.weatherInformation.temperature = dependencies.convertTempKelvinToCelsiusUseCase.invoke(weather.weatherInformation.temperature)
		weather.weatherInformation.maxTemperature = dependencies.convertTempKelvinToCelsiusUseCase.invoke(weather.weatherInformation.maxTemperature)
		weather.weatherInformation.minTemperature = dependencies.convertTempKelvinToCelsiusUseCase.invoke(weather.weatherInformation.minTemperature)
		weather.weatherInformation.feelsLike = dependencies.convertTempKelvinToCelsiusUseCase.invoke(weather.weatherInformation.feelsLike)
		
		return weather
	}
	
	private func convertTemperature(_ temperature: Float) -> Int {
		Int(dependencies.convertTempKelvinToCelsiusUseCase.invoke(temperature).rounded(.up))
	}
	
	private func handleError(error: AppError) {
		onDidReceiveError?(error.errorDescription)
	}
}
