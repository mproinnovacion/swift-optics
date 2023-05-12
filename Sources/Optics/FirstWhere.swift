import Foundation

public struct FirstWhere<L: LensOptic, Element>: OptionalOptic
where L.Part == [Element], L.NewPart == L.Part, L.NewWhole == L.Whole {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = Element
	public typealias NewPart = Element
	
	public let lens: L
	public let filter: (Part) -> Bool
	
	@inlinable
	public init(
		@LensOpticBuilder with build: () -> L,
		where filter: @escaping (Part) -> Bool

	) {
		self.lens = build()
		self.filter = filter
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		lens.get(whole).first(where: self.filter)
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(in: whole) { elements in
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

extension LensOptic {
	public func first<Element>(
		where filter: @escaping (Element) -> Bool
	) -> FirstWhere<Self, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		FirstWhere {
			self
		} where: { element in
			filter(element)
		}
	}
}
