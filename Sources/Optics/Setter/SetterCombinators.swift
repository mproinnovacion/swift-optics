import Foundation

public struct Setter<O: SetterOptic>: SetterOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let setter: O
	
	@inlinable
	public init(
		@SetterOpticBuilder with build: () -> O
	) {
		self.setter = build()
	}
	
	public func updating(
		_ whole: O.Whole,
		_ f: @escaping (O.Part) throws -> O.NewPart
	) rethrows -> O.NewWhole {
		try setter.updating(whole, f)
	}
}
