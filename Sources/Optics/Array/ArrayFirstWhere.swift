import Foundation

public struct ArrayFirstWhere<O: ArrayOptic>: OptionalOptic
where O.NewPart == O.Part, O.NewWhole == O.Whole {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let optic: O
	public let filter: (Part) -> Bool
	
	@inlinable
	public init(
		@ArrayOpticBuilder with build: () -> O,
		where filter: @escaping (Part) -> Bool

	) {
		self.optic = build()
		self.filter = filter
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		optic.getAll(whole).first(where: self.filter)
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var updated = false
		return optic.updatingAll(
			in: whole
		) { part in
			guard self.filter(part), updated == false else {
				return part
			}
			
			updated = true
			return f(part)
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

extension ArrayOptic {
	public func first(
		where filter: @escaping (Part) -> Bool
	) -> ArrayFirstWhere<Self>
	where NewPart == Part, NewWhole == Whole {
		ArrayFirstWhere {
			self
		} where: { part in
			filter(part)
		}
	}
}
