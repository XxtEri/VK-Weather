enum URLFactory {
	private static let baseURL = "https://api.openweathermap.org/data/2.5/"
	private static let apiToken = "7fc760cd88636f846818b1dc5b1879e2"
	
	enum Weather {
		static func getWeather(latitude: Double, longitude: Double) -> String {
			"\(baseURL)weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiToken)"
		}
		static func getWeathers(latitude: Double, longitude: Double) -> String {
			"\(baseURL)forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiToken)"
		}
	}
}
