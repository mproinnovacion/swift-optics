import Foundation

public struct MapArray<O: ArrayOptic, MappedPart, MappedNewPart>: ArrayOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = MappedPart
	public typealias NewPart = MappedNewPart
	
	public let optic: O
	@usableFromInline let from: (O.Part) -> MappedPart
	@usableFromInline let to: (O.Part, MappedNewPart) -> O.NewPart
	
	@inlinable
	public init(
		@ArrayOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (O.Part, MappedNewPart) -> O.NewPart
	) {
		self.optic = build()
		self.from = from
		self.to = to
	}
	
	@inlinable
	public init(
		@ArrayOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (MappedNewPart) -> O.NewPart
	) {
		self.optic = build()
		self.from = from
		self.to = { _, newPart in
			to(newPart)
		}
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic.getAll(whole).map(from)
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updatingAll(whole) { oPart in
			to(oPart, f(from(oPart)))
		}
	}
}

extension ArrayOptic {
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (Part, MappedNewPart) -> NewPart
	) -> MapArray<Self, MappedPart, MappedNewPart> {
		MapArray({ self }, from: from, to: to)
	}
	
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (MappedNewPart) -> NewPart
	) -> MapArray<Self, MappedPart, MappedNewPart> {
		MapArray({ self }, from: from, to: to)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapArray<Self, MappedPart, MappedPart> where NewPart == Part {
		MapArray({ self }, from: conversion.to, to: conversion.from)
	}
}
