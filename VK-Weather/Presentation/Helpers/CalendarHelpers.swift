import UIKit

protocol CalendarHelperProtocol {
	func getWeekFromDate(date: Date) -> [Date]
}

final class CalendarHelper: CalendarHelperProtocol {
	// MARK: - Public

	func getWeekFromDate(date: Date) -> [Date] {
		let weekDays = (1...7).map {
			calendar.date(byAdding: .day, value: $0, to: date) ?? Date()
		}
		return weekDays
	}

	// MARK: - Private

	private let calendar = Calendar.current
	
	private func addDays(date: Date, days: Int) -> Date {
		calendar.date(byAdding: .day, value: days, to: date) ?? Date()
	}
}
