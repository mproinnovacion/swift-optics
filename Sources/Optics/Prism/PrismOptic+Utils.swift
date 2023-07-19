import Foundation

extension PrismOptic {
	public func matches(
		_ whole: Whole
	) -> Bool {
		self.extract(from: whole) != nil
	}
}
