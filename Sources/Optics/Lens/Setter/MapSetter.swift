import Foundation

public struct MapSetter<O: SetterOptic, MappedPart, MappedNewPart>: SetterOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = MappedPart
	public typealias NewPart = MappedNewPart
	
	public let optic: O
	@usableFromInline let from: (O.Part) -> MappedPart
	@usableFromInline let to: (O.Part, MappedNewPart) -> O.NewPart

	public init(
		optic: O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (O.Part, MappedNewPart) -> O.NewPart

	) {
		self.optic = optic
		self.from = from
		self.to = to
	}
	
	public func updating(_ whole: Whole, _ f: @escaping (Part) -> NewPart) -> NewWhole {
		self.optic.updating(whole) { part in
			to(part, f(from(part)))
		}
	}
}

extension SetterOptic {
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (Part, MappedNewPart) -> NewPart
	) -> MapSetter<Self, MappedPart, MappedNewPart> {
		MapSetter(
			optic: self,
			from: from,
			to: to
		)
	}
	
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (MappedNewPart) -> NewPart
	) -> MapSetter<Self, MappedPart, MappedNewPart> {
		MapSetter(
			optic: self,
			from: from,
			to: { _, newPart in
				to(newPart)
			}
		)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapSetter<Self, MappedPart, MappedPart> where NewPart == Part {
		MapSetter(
			optic: self,
			from: conversion.to,
			to: { _, newPart in
				conversion.from(newPart)
			}
		)
	}
}
