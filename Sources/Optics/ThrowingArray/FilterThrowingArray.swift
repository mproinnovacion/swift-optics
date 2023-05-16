import Foundation

/// Filter an Array Optic
public struct ThrowingArrayFilter<O: ThrowingArrayOptic>: ThrowingArrayOptic
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
		@ThrowingArrayOpticBuilder with build: () -> O
	) {
		self.filter = filter
		self.optic = build()
	}

	public func getAll(_ whole: Whole) throws -> [Part] {
		try optic.getAll(whole).filter(self.filter)
	}

	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try optic.updatingAll(in: whole) { part in
			guard self.filter(part) else {
				return part
			}

			return try f(part)
		}
	}
}

extension ThrowingArrayOptic {
	public func filter(
		_ filter: @escaping (Part) -> Bool
	) -> ThrowingArrayFilter<Self> where NewPart == Part {
		ThrowingArrayFilter(filter: filter, with: { self })
	}
}

extension ThrowingOptic {
	public func filter(
		_ filter: @escaping (Part) -> Bool
	) -> ThrowingArrayFilter<LiftThrowingToThrowingArray<Self>> where NewPart == Part {
		ThrowingArrayFilter(filter: filter, with: { self })
	}
	
	public func filterIndexed(
		_ filter: @escaping (Int, Part) -> Bool
	) -> MapThrowingArraySetter<ThrowingArrayFilter<ThrowingArrayEnumerated<LiftThrowingToThrowingArray<Self>>>, LiftThrowingToThrowingArray<Self>.Part, LiftThrowingToThrowingArray<Self>.NewPart>
	where NewPart == Part, NewWhole == Whole {
		let result = ThrowingArrayEnumerated { self }
			.filter(filter)
			.map { pair in
				pair.1
			} to: { current, updated in
				(current.0, updated)
			}
		
		return result
	}
	
	
	public func selectEven() -> MapThrowingArraySetter<ThrowingArrayFilter<ThrowingArrayEnumerated<LiftThrowingToThrowingArray<Self>>>, Self.NewPart, Self.NewPart>
	where NewPart == Part, NewWhole == Whole {
		self.filterIndexed { index, _ in
			index % 2 == 0
		}
	}
	
	public func selectOdd() -> MapThrowingArraySetter<ThrowingArrayFilter<ThrowingArrayEnumerated<LiftThrowingToThrowingArray<Self>>>, Self.NewPart, Self.NewPart>
	where NewPart == Part, NewWhole == Whole {
		self.filterIndexed { index, _ in
			index % 2 != 0
		}
	}
}
