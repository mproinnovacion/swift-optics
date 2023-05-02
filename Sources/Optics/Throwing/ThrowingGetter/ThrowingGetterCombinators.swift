import Foundation

public struct ThrowingGetter<O: ThrowingGetterOptic>: ThrowingGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	@inlinable
	public init(
		@ThrowingGetterOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func get(_ whole: O.Whole) throws -> O.Part {
		try self.optic.get(whole)
	}
}
