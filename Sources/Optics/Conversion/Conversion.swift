import Foundation

public struct Conversion<From, To> {
	public var from: (To) -> From
	public var to: (From) -> To
	
	public init(
		from: @escaping (To) -> From,
		to: @escaping (From) -> To
	) {
		self.from = from
		self.to = to
	}
}

