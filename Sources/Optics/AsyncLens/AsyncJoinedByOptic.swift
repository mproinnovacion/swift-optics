import Foundation

public struct AsyncJoinedByOptic: AsyncLensOptic {
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
	) async -> Part {
		whole.joined(separator: separator)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		let string = whole.joined(separator: separator)
		return try await f(string).components(separatedBy: separator)
	}
}

extension AsyncLensOptic where Part == [String], NewPart == [String] {
	public func joinedBy(
		separator: String
	) -> some AsyncLensOptic<Whole, String, NewWhole, String> {
		AsyncLens {
			self
			AsyncJoinedByOptic(separator: separator)
		}
	}
}
