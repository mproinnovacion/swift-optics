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
		in whole: O.Whole,
		update f: @escaping (O.Part) -> O.NewPart
	) -> O.NewWhole {
		setter.updating(in: whole, update: f)
	}
}
