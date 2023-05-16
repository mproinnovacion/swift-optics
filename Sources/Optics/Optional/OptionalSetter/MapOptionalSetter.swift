import Foundation

public struct MapOptionalSetter<O: OptionalSetterOptic, MappedPart, MappedNewPart>: OptionalSetterOptic {
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
	
	public func tryUpdating(
		in whole: O.Whole,
		update f: @escaping (MappedPart) -> MappedNewPart
	) -> O.NewWhole {
		self.optic.tryUpdating(in: whole) { part in
			to(part, f(from(part)))
		}
	}
}

extension OptionalSetterOptic {
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (Part, MappedNewPart) -> NewPart
	) -> MapOptionalSetter<Self, MappedPart, MappedNewPart> {
		MapOptionalSetter(
			optic: self,
			from: from,
			to: to
		)
	}
	
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (MappedNewPart) -> NewPart
	) -> MapOptionalSetter<Self, MappedPart, MappedNewPart> {
		MapOptionalSetter(
			optic: self,
			from: from,
			to: { _, newPart in
				to(newPart)
			}
		)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapOptionalSetter<Self, MappedPart, MappedPart> where NewPart == Part {
		MapOptionalSetter(
			optic: self,
			from: conversion.to,
			to: { _, newPart in
				conversion.from(newPart)
			}
		)
	}
}
