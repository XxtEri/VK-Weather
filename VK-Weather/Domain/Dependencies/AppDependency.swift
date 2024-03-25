protocol HasCalendarHelper {
	var calendarHelper: CalendarHelperProtocol { get }
}

final class AppDependency {
	// MARK: - Init
	
	init() {
		internalConvertTempKelvinToCelsiusUseCase = ConvertTempKelvinToCelsiusUseCase()
		internalWeatherMapper = WeatherMapper()
		internalWeaterService = WeatherService()
		internalLocationService = LocationService()
		internalCalendarHelper = CalendarHelper()
	}

	// MARK: - Private
	
	private let internalConvertTempKelvinToCelsiusUseCase: ConvertTempKelvinToCelsiusUseCase
	private lazy var internalGetNextWeathersUseCase: GetNextWeathersUseCase = {
		GetNextWeathersUseCase(dependencies: self)
	}()
	private lazy var internalGetWeatherUseCase: GetWeatherUseCase = {
		GetWeatherUseCase(dependencies: self)
	}()

	private lazy var internalWeatherRepository: WeatherRepositoryProtocol = {
		WeatherRepository(dependencies: self)
	}()
	
	private let internalWeatherMapper: WeatherMapperProtocol
	
	private let internalWeaterService: WeatherServiceProtocol
	private let internalLocationService: LocationServiceProtocol
	
	private let internalCalendarHelper: CalendarHelperProtocol
}

// MARK: - HasGetWeatherUseCase {

extension AppDependency: HasGetWeatherUseCase {
	var getWeatherUseCase: GetWeatherUseCase {
		internalGetWeatherUseCase
	}
}

// MARK: - HasConvertTempKelvinToCelsiusUseCase

extension AppDependency: HasConvertTempKelvinToCelsiusUseCase {
	var convertTempKelvinToCelsiusUseCase: ConvertTempKelvinToCelsiusUseCase {
		internalConvertTempKelvinToCelsiusUseCase
	}
}

// MARK: HasGetNextWeathersUseCase

extension AppDependency: HasGetNextWeathersUseCase {
	var getNextWeathersUseCase: GetNextWeathersUseCase {
		internalGetNextWeathersUseCase
	}
}

// MARK: - HasWeatherRepository

extension AppDependency: HasWeatherRepository {
	var weatherRepository: WeatherRepositoryProtocol {
		internalWeatherRepository
	}
}

// MARK: - HasWeatherMapper

extension AppDependency: HasWeatherMapper {
	var weatherMapper: WeatherMapperProtocol {
		internalWeatherMapper
	}
}

// MARK: - HasWeatherService

extension AppDependency: HasWeatherService {
	var weatherService: WeatherServiceProtocol {
		internalWeaterService
	}
}

extension AppDependency: HasLocationService {
	var locationService: LocationServiceProtocol {
		internalLocationService
	}
}

// MARK: - HasCalendarHelper

extension AppDependency: HasCalendarHelper {
	var calendarHelper: CalendarHelperProtocol {
		internalCalendarHelper
	}
}
