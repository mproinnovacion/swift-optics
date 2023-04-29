import Foundation

extension AsyncLensOptic where Part == String, NewPart == String {
	public func splitBy(
		separator: String
	) -> some AsyncLensOptic<Whole, [String], NewWhole, [String]> {
		AsyncLens {
			self
			LiftLensToAsync(optic: SplitByOptic(separator: separator))
		}
	}
}
