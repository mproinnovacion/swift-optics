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
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(in: whole) { oPart in
			to(oPart, f(from(oPart)))
		}
	}
	
	public func trySetting(in whole: O.Whole, to newValue: MappedPart) -> O.NewWhole {
		optic.tryUpdating(in: whole) { oPart in
			to(oPart, newValue)
		}
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
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapOptional<Self, MappedPart> where NewPart == Part {
		MapOptional({ self }, from: conversion.to, to: conversion.from)
	}
}

