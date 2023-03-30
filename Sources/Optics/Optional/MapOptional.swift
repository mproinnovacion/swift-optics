import Foundation

public struct MapOptional<O: OptionalOptic, MappedPart>: OptionalOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = MappedPart
	public typealias NewPart = MappedPart
	
	public let optic: O
	@usableFromInline let from: (O.Part) -> MappedPart
	@usableFromInline let to: (O.Part, MappedPart) -> O.NewPart
	
	@inlinable
	public init(
		@OptionalOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (O.Part, MappedPart) -> O.NewPart
	) {
		self.optic = build()
		self.from = from
		self.to = to
	}
	
	@inlinable
	public init(
		@OptionalOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (MappedPart) -> O.NewPart
	) {
		self.optic = build()
		self.from = from
		self.to = { _, newPart in
			to(newPart)
		}
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		optic.tryGet(whole).map(from)
	}
	
	public func tryUpdate(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdate(whole) { oPart in
			to(oPart, f(from(oPart)))
		}
	}
	
	public func trySet(_ whole: O.Whole, to newValue: MappedPart) -> O.NewWhole {
		optic.tryUpdate(whole, { oPart in
			to(oPart, newValue)
		})
	}
}

extension OptionalOptic {
	public func map<MappedPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (Part, MappedPart) -> NewPart
	) -> MapOptional<Self, MappedPart> {
		MapOptional({ self }, from: from, to: to)
	}
	
	public func map<MappedPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (MappedPart) -> NewPart
	) -> MapOptional<Self, MappedPart> {
		MapOptional({ self }, from: from, to: to)
	}
}
