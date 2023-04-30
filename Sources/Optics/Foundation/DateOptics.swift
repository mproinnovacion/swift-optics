import Foundation

public enum Weekday: Int {
	case monday = 2
	case tuesday = 3
	case wednesday = 4
	case thursday = 5
	case friday = 6
	case saturday = 7
	case sunday = 1
}

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
		} tryUpdating: { date, update in
			let components = calendar.dateComponents(
				allComponents,
				from: date
			)
			
			let updated = update(components)
			
			return calendar.date(from: updated) ?? date
		} trySetting: { date, newComponents in
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
	
	private static func componentOptic(
		_ path: WritableKeyPath<DateComponents, Int?>,
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		Optionally {
			componentsOptic(calendar: calendar, timeZone: timeZone)
			path
			Int?.optic()
		}
	}
	
	public static func componentOptic(
		_ path: WritableKeyPath<DateComponents, Int?>,
		component: Calendar.Component,
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		OptionalRawOptic { date in
			componentOptic(path, calendar: calendar, timeZone: timeZone)
				.tryGet(date)
		} tryUpdating: { date, update in
			guard
				let value = componentOptic(path, calendar: calendar, timeZone: timeZone)
					.tryGet(date)
			else {
				return date
			}
			
			let updated = update(value)
			return calendar.date(bySetting: component, value: updated, of: date) ?? date
		} trySetting: { date, value in
			calendar.date(bySetting: component, value: value, of: date) ?? date
		}
	}
	
	public static func dayOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		componentOptic(
			\DateComponents.day,
			 component: .day,
			 calendar: calendar,
			 timeZone: timeZone
		)
	}
	
	public static func weekdayValueOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		componentOptic(
			\DateComponents.weekday,
			 component: .weekday,
			 calendar: calendar,
			 timeZone: timeZone
		)
	}
	
	public static func weekdayOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Weekday> {
		weekdayValueOptic(
			calendar: calendar,
			timeZone: timeZone
		).flatMap { value in
			Weekday(rawValue: value)
		} to: { day in
			day.rawValue
		}
	}
	
	public static func monthOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		componentOptic(
			\DateComponents.month,
			 component: .month,
			 calendar: calendar,
			 timeZone: timeZone
		)
	}
	
	public static func yearOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		componentOptic(
			\DateComponents.year,
			 component: .year,
			 calendar: calendar,
			 timeZone: timeZone
		)
	}
	
	public static func hourOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		componentOptic(
			\DateComponents.hour,
			 component: .hour,
			 calendar: calendar,
			 timeZone: timeZone
		)
	}
	
	@inlinable
	public static func minuteOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		componentOptic(
			\DateComponents.minute,
			 component: .minute,
			 calendar: calendar,
			 timeZone: timeZone
		)
	}
	
	public static func secondOptic(
		calendar: Calendar = .autoupdatingCurrent,
		timeZone: TimeZone = .autoupdatingCurrent
	) -> some SimpleOptionalOptic<Date, Int> {
		componentOptic(
			\DateComponents.second,
			 component: .second,
			 calendar: calendar,
			 timeZone: timeZone
		)
	}
}
