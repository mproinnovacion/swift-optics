import Foundation

public struct MapLens<O: LensOptic, MappedPart, MappedNewPart>: LensOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = MappedPart
	public typealias NewPart = MappedNewPart
	
	public let optic: O
	@usableFromInline let from: (O.Part) -> MappedPart
	@usableFromInline let to: (O.Part, MappedNewPart) -> O.NewPart
	
	@inlinable
	public init(
		@LensOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (O.Part, MappedNewPart) -> O.NewPart
	) {
		self.optic = build()
		self.from = from
		self.to = to
	}
	
	@inlinable
	public init(
		@LensOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (MappedNewPart) -> O.NewPart
	) {
		self.optic = build()
		self.from = from
		self.to = { _, newPart in
			to(newPart)
		}
	}
	
	public func get(_ whole: Whole) -> Part {
		from(optic.get(whole))
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try optic.updating(whole) { oPart in
			to(oPart, try f(from(oPart)))
		}
	}
}

extension LensOptic {
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (Part, MappedNewPart) -> NewPart
	) -> MapLens<Self, MappedPart, MappedNewPart> {
		MapLens({ self }, from: from, to: to)
	}
	
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (MappedNewPart) -> NewPart
	) -> MapLens<Self, MappedPart, MappedNewPart> {
		MapLens({ self }, from: from, to: to)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapLens<Self, MappedPart, MappedPart> where NewPart == Part {
		MapLens({ self }, from: conversion.to, to: conversion.from)
	}
}
