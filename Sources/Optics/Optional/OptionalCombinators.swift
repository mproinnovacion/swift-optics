import Foundation

public struct Optionally<Optics: OptionalOptic>: OptionalOptic {
	public typealias Whole = Optics.Whole
	public typealias NewWhole = Optics.NewWhole
	public typealias Part = Optics.Part
	public typealias NewPart = Optics.NewPart
	
	public let optics: Optics
	
	@inlinable
	public init(
		@OptionalOpticBuilder with build: () -> Optics
	) {
		self.optics = build()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		optics.tryGet(whole)
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optics.tryUpdating(in: whole, update: f)
	}
	
	public func trySetting(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		optics.trySetting(in: whole, to: newValue)
	}
}

