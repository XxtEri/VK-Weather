struct WeathersResponse: Decodable {
	let cod: String
	let message: Int
	let cnt: Int
	let list: [NextWeatherResponse]
	let city: CityResponse
}

struct NextWeatherResponse: Decodable {
	let dt: Int
	let main: WeatherNextInformationResponse
	let weather: [WeatherMainInformationResponse]
	let clouds: CloudResponse
	let wind: WindResponse
	let visibility: Int
	let pop: Float
	let snow: RainResponse?
	let sys: WeatherNextSys
	let dt_txt: String
}

struct WeatherNextInformationResponse: Decodable {
	let temp: Float
	let feels_like: Float
	let temp_min: Float
	let temp_max: Float
	let pressure: Int
	let sea_level: Int
	let grnd_level: Int
	let humidity: Int
	let temp_kf: Float
}

struct RainResponse: Decodable {
	enum CodingKeys: String, CodingKey {
		case value = "3h"
	}
	
	let value: Float
}

struct WeatherNextSys: Decodable {
	let pod: String
}

struct CityResponse: Decodable {
	let id: Int
	let name: String
	let coord: CoordinatesResponse
	let country: String
	let population: Int
	let timezone: Int
	let sunrise: Int32
	let sunset: Int32
}
