import Foundation

enum WeatherServiceError: LocalizedError, AppError {
	case unowned
	
	var errorDescription: String {
		switch self {
			case .unowned:
				return "Произошла неизвестная ошибка при загрузке данных о погоде. Проверьте интернет соединение и перезапустите приложение"
		}
	}
}
