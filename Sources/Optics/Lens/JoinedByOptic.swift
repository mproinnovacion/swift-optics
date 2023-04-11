import Foundation

public struct JoinedByOptic: LensOptic {
	public typealias Whole = [String]
	public typealias Part = String
	public typealias NewWhole = [String]
	public typealias NewPart = String
	
	public let separator: String
	
	public init(
		separator: String
	) {
		self.separator = separator
	}
	
	public func get(
		_ whole: Whole
	) -> Part {
		whole.joined(separator: separator)
	}
	
	public func update(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		let string = whole.joined(separator: separator)
		return f(string).components(separatedBy: separator)
	}
}

extension LensOptic where Part == [String], NewPart == [String] {
	public func joinedBy(
		separator: String
	) -> some LensOptic<Whole, String, NewWhole, String> {
		Lens {
			self
			JoinedByOptic(separator: separator)
		}
	}
}
