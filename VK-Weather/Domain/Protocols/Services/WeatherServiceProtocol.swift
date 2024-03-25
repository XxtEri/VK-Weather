protocol WeatherServiceProtocol {
	func getWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse
	func getNextWeathers(latitude: Double, longitude: Double) async throws -> WeathersResponse
}
