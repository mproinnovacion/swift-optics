import Foundation

/// Transforms a Lens of an Array to an ArrayOptic
public struct EachOptional<O: OptionalOptic, Element, NewElement>: ArrayOptic
where O.Part == [Element], O.NewPart == [NewElement] {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = Element
	public typealias NewPart = NewElement
	
	public let optic: O
	
	@inlinable
	public init(
		@OptionalOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic.tryGet(whole) ?? []
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(in: whole) { parts in
			parts.map(f)
		}
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
