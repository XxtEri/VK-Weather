import UIKit

extension DateFormatter {
	// MARK: - Public

	static let yearMonthDayISO = dateFormatter(format: FormatType.yearMonthDayISO.rawValue)
	static let dateWithMonthToRus = dateFormatter(format: FormatType.dateWithMonth.rawValue, locale: Locale(identifier: "ru_RU"))
	static let ISODate = dateFormatter(format: FormatType.ISODate.rawValue)
	
	// MARK: - Private
	
	enum FormatType: String {
		case yearMonthDayISO = "yyyy-MM-dd"
		case dateWithMonth = "dd MMMM | EEEE"
		case ISODate = "yyyy-MM-dd HH:mm:ss"
	}

	private static func dateFormatter(format: String, locale: Locale = .current, timeZone: TimeZone? = .current) -> DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		dateFormatter.locale = locale
		dateFormatter.timeZone = timeZone
		return dateFormatter
	}
}
