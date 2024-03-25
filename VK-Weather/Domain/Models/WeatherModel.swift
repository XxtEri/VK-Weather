struct WeatherModel {
	var weatherInformation: WeatherInformationModel
	let visibility: Int
	let wind: WindModel
	let cloudy: Int
	var date: String?
}

struct WeatherInformationModel {
	var temperature: Float
	var minTemperature: Float
	var maxTemperature: Float
	var feelsLike: Float
	let pressure: Int
	let humidity: Int
}

struct WindModel {
	let speed: Float
	let deg: Int
}
