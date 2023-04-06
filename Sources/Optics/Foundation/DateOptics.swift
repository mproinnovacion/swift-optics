import Foundation

extension Date {
	private static var allComponents: Set<Calendar.Component> {
		[.era, .weekday, .day, .month, .year, .hour, .minute, .second, .nanosecond]
	}
	
	public static func componentsOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, DateComponents> {
		OptionalRawOptic { date in
			calendar.dateComponents(
				allComponents,
				from: date
			)
		} tryUpdate: { date, update in
			var components = calendar.dateComponents(
				allComponents,
				from: date
			)
			
			components = update(components)
			
			return calendar.date(from: components) ?? date
		} trySet: { date, newComponents in
			var components = calendar.dateComponents(
				allComponents,
				from: date
			)

			components.era = newComponents.era ?? components.era
			components.day = newComponents.day ?? components.day
			components.month = newComponents.month ?? components.month
			components.year = newComponents.year ?? components.year
			components.hour = newComponents.hour ?? components.hour
			components.minute = newComponents.minute ?? components.minute
			components.second = newComponents.second ?? components.second
			
			return calendar.date(from: components) ?? date
		}
	}
	
	public static func dayOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		Optionally {
			componentsOptic(calendar: calendar, timeZone: timeZone)
			\DateComponents.day
			Int?.optic()
		}
	}
	
	private static func componentsWeekdayOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		Optionally {
			componentsOptic(calendar: calendar, timeZone: timeZone)
			\DateComponents.weekday
			Int?.optic()
		}
	}
	
	public static func weekdayOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		OptionalRawOptic { date in
			componentsWeekdayOptic(calendar: calendar, timeZone: timeZone).tryGet(date)
		} tryUpdate: { date, update in
			guard let weekday = componentsWeekdayOptic(calendar: calendar, timeZone: timeZone).tryGet(date) else {
				return date
			}
			
			let updated = update(weekday)
			
			return calendar.date(bySetting: .weekday, value: updated, of: date) ?? date
		} trySet: { date, weekday in
			calendar.date(bySetting: .weekday, value: weekday, of: date) ?? date
		}
	}
	
	public static func monthOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		Optionally {
			componentsOptic(calendar: calendar, timeZone: timeZone)
			\DateComponents.month
			Int?.optic()
		}
	}
	
	public static func yearOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		Optionally {
			componentsOptic(calendar: calendar, timeZone: timeZone)
			\DateComponents.year
			Int?.optic()
		}
	}
	
	public static func hourOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		Optionally {
			componentsOptic(calendar: calendar, timeZone: timeZone)
			\DateComponents.hour
			Int?.optic()
		}
	}
	
	@inlinable
	public static func minuteOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		Optionally {
			componentsOptic(calendar: calendar, timeZone: timeZone)
			\DateComponents.minute
			Int?.optic()
		}
	}
	
	public static func secondOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		Optionally {
			componentsOptic(calendar: calendar, timeZone: timeZone)
			\DateComponents.second
			Int?.optic()
		}
	}
}
