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
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optics.tryUpdating(whole, f)
	}
	
	public func trySetting(_ whole: Whole, to newValue: NewPart) -> NewWhole {
		optics.trySetting(whole, to: newValue)
	}
}

extension OptionalOptic {
	public func each<Element, NewElement>() -> EachOptional<Self, Element, NewElement>
	where Part == [Element], NewPart == [NewElement] {
		EachOptional {
			self
		}
	}
}
