import Foundation

public struct SplitByOptic: LensOptic {
	public typealias Whole = String
	public typealias Part = [String]
	public typealias NewWhole = String
	public typealias NewPart = [String]
	
	public let separator: String
	
	public init(
		separator: String
	) {
		self.separator = separator
	}
	
	public func get(
		_ whole: Whole
	) -> Part {
		whole.components(separatedBy: separator)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		let components = whole.components(separatedBy: separator)
		return String(
			try f(components).joined(separator: separator)
		)
	}
}

extension LensOptic where Part == String, NewPart == String {
	public func splitBy(
		separator: String
	) -> some LensOptic<Whole, [String], NewWhole, [String]> {
		Lens {
			self
			SplitByOptic(separator: separator)
		}
	}
}
