struct WeatherResponse: Decodable {
	let coord: CoordinatesResponse
	let weather: [WeatherMainInformationResponse]
	let base: String
	let main: WeatherInformationResponse
	let visibility: Int
	let wind: WindResponse
	let clouds: CloudResponse
	let dt: Int
	let sys: SysResponse
	let timezone: Int
	let id: Int
	let name: String
	let cod: Int
}

struct CoordinatesResponse: Decodable {
	let lat: Float
	let lon: Float
}

struct WeatherMainInformationResponse: Decodable {
	let id: Int
	let main: String
	let description: String
	let icon: String
}

struct WeatherInformationResponse: Decodable {
	let temp: Float
	let feels_like: Float
	let temp_min: Float
	let temp_max: Float
	let pressure: Int
	let humidity: Int
}

struct WindResponse: Decodable {
	let speed: Float
	let deg: Int
	let gust: Float?
}

struct CloudResponse: Decodable {
	let all: Int
}

struct SysResponse: Decodable {
	let country: String
	let sunrise: Int
	let sunset: Int
}
