import Foundation

public struct FirstArray<O: ArrayOptic>: OptionalOptic
where O.NewPart == O.Part, O.NewWhole == O.Whole {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let optic: ArrayTakeFirst<O>
	
	@inlinable
	public init(
		@ArrayOpticBuilder with build: () -> O
	) {
		self.optic = build().takeFirst(1)
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.optic.getAll(whole).first
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updatingAll(in: whole, update: f)
	}

	public func trySetting(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		optic.settingAll(in: whole, to: newValue)
	}
}

extension ArrayOptic {
	public func first() -> FirstArray<Self>
	where NewPart == Part, NewWhole == Whole {
		FirstArray {
			self
		}
	}
}
