protocol WeatherMapperProtocol {
	func fromWeatherResponse(_ response: WeatherResponse) -> WeatherModel
	func fromNextWeatherResponse(_ response: NextWeatherResponse) -> WeatherModel
}
