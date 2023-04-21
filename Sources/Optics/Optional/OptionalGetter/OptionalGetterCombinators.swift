import Foundation

public struct OptionalGetter<O: OptionalGetterOptic>: OptionalGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	@inlinable
	public init(
		@OptionalGetterOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func tryGet(_ whole: O.Whole) -> O.Part? {
		self.optic.tryGet(whole)
	}
}
