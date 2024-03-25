final class WeatherRepository: WeatherRepositoryProtocol {
	typealias Dependencies = HasWeatherService & HasWeatherMapper
	
	// MARK: - Init
	
	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}
	
	// MARK: - Public
	
	func getWeather(latitude: Double, longitude: Double) async throws -> WeatherModel {
		let weatherResponse = try await dependencies.weatherService.getWeather(latitude: latitude, longitude: longitude)
		
		return dependencies.weatherMapper.fromWeatherResponse(weatherResponse)
	}
	
	func getNextWeathers(latitude: Double, longitude: Double) async throws -> [WeatherModel] {
		let nextWeatherResponse = try await dependencies.weatherService.getNextWeathers(latitude: latitude, longitude: longitude)
		var nextWeatherModels: [WeatherModel] = []
		nextWeatherResponse.list.forEach {
			nextWeatherModels.append(dependencies.weatherMapper.fromNextWeatherResponse($0))
		}
		
		return nextWeatherModels
	}
	
	// MARK: - Private
	
	private let dependencies: Dependencies
}
