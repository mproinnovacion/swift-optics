import Foundation

/// Filter an Array Optic
public struct Filter<O: ArrayOptic>: ArrayOptic
where O.NewPart == O.Part, O.NewWhole == O.Whole {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart

	public let filter: (Part) -> Bool
	public let optic: O

	@inlinable
	public init(
		filter: @escaping (Part) -> Bool,
		@ArrayOpticBuilder with build: () -> O
	) {
		self.filter = filter
		self.optic = build()
	}

	public func getAll(_ whole: Whole) -> [Part] {
		optic.getAll(whole).filter(self.filter)
	}

	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updatingAll(in: whole) { part in
			guard self.filter(part) else {
				return part
			}

			return f(part)
		}
	}
}

extension LensOptic {
	public func filter<Element>(
		_ filter: @escaping (Element) -> Bool
	) -> Filter<Each<Self, Element, Element>> where Part == [Element], NewPart == Part, NewWhole == Whole {
		Filter(
			filter: filter,
			with: { self.each() }
		)
	}
	
	public func filterIndexed<Element>(
		_ filter: @escaping (Int, Element) -> Bool
	) -> MapArray<Filter<Each<Enumerated<Self, Element, Element>, (Int, Element), (Int, Element)>>, Element, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		Enumerated { self }
			.each()
			.filter(filter)			
			.map { pair in
				pair.1
			} to: { current, updated in
				(current.0, updated)
			}
	}
	
	
	public func onlyEven<Element>() -> MapArray<Filter<Each<Enumerated<Self, Element, Element>, (Int, Element), (Int, Element)>>, Element, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		self.filterIndexed { index, _ in
			index % 2 == 0
		}
	}
	
	public func onlyOdd<Element>() -> MapArray<Filter<Each<Enumerated<Self, Element, Element>, (Int, Element), (Int, Element)>>, Element, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		self.filterIndexed { index, _ in
			index % 2 != 0
		}
	}
}

extension OptionalOptic {
	public func filter<Element>(
		_ filter: @escaping (Element) -> Bool
	) -> Filter<EachOptional<Self, Element, Element>> where Part == [Element], NewPart == Part, NewWhole == Whole {
		Filter(
			filter: filter,
			with: { self.each() }
		)
	}
	
	public func filterIndexed<Element>(
		_ filter: @escaping (Int, Element) -> Bool
	) -> MapArray<Filter<EachOptional<EnumeratedOptionally<Self, Element, Element>, (Int, Element), (Int, Element)>>, Element, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		EnumeratedOptionally { self }
			.each()
			.filter(filter)
			.map { pair in
				pair.1
			} to: { current, updated in
				(current.0, updated)
			}
	}
	
	public func onlyEven<Element>() -> MapArray<Filter<EachOptional<EnumeratedOptionally<Self, Element, Element>, (Int, Element), (Int, Element)>>, Element, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		self.filterIndexed { index, _ in
			index % 2 == 0
		}
	}
	
	public func onlyOdd<Element>() -> MapArray<Filter<EachOptional<EnumeratedOptionally<Self, Element, Element>, (Int, Element), (Int, Element)>>, Element, Element>
	where Part == [Element], NewPart == Part, NewWhole == Whole {
		self.filterIndexed { index, _ in
			index % 2 != 0
		}
	}
}

extension ArrayOptic {
	public func filter(
		_ filter: @escaping (Part) -> Bool
	) -> Filter<Self> where NewPart == Part {
		Filter(filter: filter, with: { self })
	}
	
	public func filterIndexed(
		_ filter: @escaping (Int, Part) -> Bool
	) -> MapArray<Filter<ArrayEnumerated<Self>>, Part, Part>
	where NewPart == Part, NewWhole == Whole {
		ArrayEnumerated { self }
			.filter(filter)
			.map { pair in
				pair.1
			} to: { current, updated in
				(current.0, updated)
			}
	}
	
	public func onlyEven() -> MapArray<Filter<ArrayEnumerated<Self>>, Part, Part>
	where NewPart == Part, NewWhole == Whole {
		self.filterIndexed { index, _ in
			index % 2 == 0
		}
	}
	
	public func onlyOdd() -> MapArray<Filter<ArrayEnumerated<Self>>, Part, Part>
	where NewPart == Part, NewWhole == Whole {
		self.filterIndexed { index, _ in
			index % 2 != 0
		}
	}
}
