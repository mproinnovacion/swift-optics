import Foundation

public struct FirstOptionalWhere<L: OptionalOptic, Element>: OptionalOptic
where L.Part == [Element], L.NewPart == L.Part, L.NewWhole == L.Whole {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = Element
	public typealias NewPart = Element
	
	public let optic: L
	public let filter: (Part) -> Bool
	
	@inlinable
	public init(
		@OptionalOpticBuilder with build: () -> L,
		where filter: @escaping (Part) -> Bool

	) {
		self.optic = build()
		self.filter = filter
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		optic.tryGet(whole)?.first(where: self.filter)
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(in: whole) { elements in
			guard
				elements.count > 0,
				let index = elements.firstIndex(where: self.filter)
			else {
				return elements
			}
						
			var result = elements
			result[index] = f(result[index])
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
	public func first<Element>(
		where filter: @escaping (Element) -> Bool
	) -> FirstOptionalWhere<Self, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		FirstOptionalWhere {
			self
		} where: { element in
			filter(element)
		}
	}
}
