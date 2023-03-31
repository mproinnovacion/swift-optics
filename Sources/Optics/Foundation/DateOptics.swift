import Foundation

extension Date {
	private static var allComponents: Set<Calendar.Component> {
		[.era, .day, .month, .year, .hour, .minute, .second, .nanosecond]
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
