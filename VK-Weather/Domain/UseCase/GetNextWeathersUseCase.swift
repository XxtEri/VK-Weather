final class GetNextWeathersUseCase {
	typealias Dependencies = HasWeatherRepository
	
	// MARK: - Init
	
	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}
	
	// MARK: - Public
	
	func invoke(latitude: Double, longitude: Double) async throws -> [WeatherModel] {
		try await dependencies.weatherRepository.getNextWeathers(latitude: latitude, longitude: longitude)
	}
	
	// MARK: - Private
	
	private let dependencies: Dependencies
}
