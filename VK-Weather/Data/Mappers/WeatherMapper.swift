struct WeatherMapper: WeatherMapperProtocol {
	func fromWeatherResponse(_ response: WeatherResponse) -> WeatherModel {
		.init(
			weatherInformation: WeatherInformationModel(
				temperature: response.main.temp,
				minTemperature: response.main.temp_min,
				maxTemperature: response.main.temp_max,
				feelsLike: response.main.feels_like,
				pressure: response.main.pressure,
				humidity: response.main.humidity
			),
			visibility: response.visibility,
			wind: WindModel(speed: response.wind.speed, deg: response.wind.deg),
			cloudy: response.clouds.all
		)
	}
	
	func fromNextWeatherResponse(_ response: NextWeatherResponse) -> WeatherModel {
		.init(
			weatherInformation: WeatherInformationModel(
				temperature: response.main.temp,
				minTemperature: response.main.temp_min,
				maxTemperature: response.main.temp_max,
				feelsLike: response.main.feels_like,
				pressure: response.main.pressure,
				humidity: response.main.humidity
			),
			visibility: response.visibility,
			wind: WindModel(speed: response.wind.speed, deg: response.wind.deg),
			cloudy: response.clouds.all,
			date: response.dt_txt
		)
	}
}
