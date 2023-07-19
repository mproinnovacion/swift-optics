import Foundation

extension OptionalOptic {
	public func matches(
		_ whole: Whole
	) -> Bool {
		self.tryGet(whole) != nil
	}
}
