import UIKit

enum MessageBannerStyle {
	case error
	case `default`
	
	var backgroundColor: UIColor {
		switch self {
			case .error:
				return .red.withAlphaComponent(0.9)
			case .default:
				return .gray.withAlphaComponent(0.9)
		}
	}
}
