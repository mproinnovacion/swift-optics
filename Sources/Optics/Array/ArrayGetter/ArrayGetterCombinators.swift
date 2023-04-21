import Foundation

public struct ArrayGetter<O: ArrayGetterOptic>: ArrayGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	@inlinable
	public init(
		@ArrayGetterOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func getAll(_ whole: O.Whole) -> [O.Part] {
		self.optic.getAll(whole)
	}
}
