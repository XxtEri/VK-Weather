protocol WeatherRepositoryProtocol {
	func getWeather(latitude: Double, longitude: Double) async throws -> WeatherModel
	func getNextWeathers(latitude: Double, longitude: Double) async throws -> [WeatherModel]
}
