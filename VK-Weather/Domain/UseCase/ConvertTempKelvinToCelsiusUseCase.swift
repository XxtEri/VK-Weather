final class ConvertTempKelvinToCelsiusUseCase {
	private let absoluteZeroInKelvin: Float = 273.15
	
	func invoke(_ temperature: Float) -> Float {
		return temperature - absoluteZeroInKelvin
	}
}
