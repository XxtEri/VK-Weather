protocol HasGetWeatherUseCase {
	var getWeatherUseCase: GetWeatherUseCase { get }
}

protocol HasConvertTempKelvinToCelsiusUseCase {
	var convertTempKelvinToCelsiusUseCase: ConvertTempKelvinToCelsiusUseCase { get }
}

protocol HasGetNextWeathersUseCase {
	var getNextWeathersUseCase: GetNextWeathersUseCase { get }
}
