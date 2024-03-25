import Foundation

enum LocationServiceError: LocalizedError, AppError {
	case unauthorized
	case unknowned
	
	var errorDescription: String {
		switch self {
			case .unauthorized:
				return "Отстутсвует разрешение на определение локации"
			case .unknowned:
				return "Произошла ошибка при определении местоположения. Проверьте доступ к локации и перезапустите приложение"
		}
	}
}
