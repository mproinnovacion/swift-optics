import Foundation

public struct FirstOptional<L: OptionalOptic, Element>: OptionalOptic
where L.Part == [Element], L.NewPart == L.Part, L.NewWhole == L.Whole {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = Element
	public typealias NewPart = Element
	
	public let optic: L
	
	@inlinable
	public init(
		@OptionalOpticBuilder with build: () -> L
	) {
		self.optic = build()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.optic.tryGet(whole)?.first
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(in: whole) { elements in
			guard elements.count > 0 else {
				return elements
			}
			
			var result = elements
			result[0] = f(result[0])
			return result
		}
	}

	public func trySetting(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		tryUpdating(in: whole) { _ in
			newValue
		}
	}
}

extension OptionalOptic {
	public func first<Element>() -> FirstOptional<Self, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		FirstOptional {
			self
		}
	}
}
