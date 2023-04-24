import Foundation

public struct ThrowingArrayGetter<O: ThrowingArrayGetterOptic>: ThrowingArrayGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	@inlinable
	public init(
		@ThrowingGetterOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func getAll(_ whole: O.Whole) throws -> [O.Part] {
		try self.optic.getAll(whole)
	}
}
