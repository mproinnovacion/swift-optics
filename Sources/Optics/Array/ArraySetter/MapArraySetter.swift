import Foundation

public struct MapArraySetter<O: ArraySetterOptic, MappedPart, MappedNewPart>: ArraySetterOptic {
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
	
	public func updatingAll(
		_ whole: O.Whole,
		_ f: @escaping (MappedPart) -> MappedNewPart
	) -> O.NewWhole {
		self.optic.updatingAll(whole) { part in
			to(part, f(from(part)))
		}
	}	
}

extension ArraySetterOptic {
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (Part, MappedNewPart) -> NewPart
	) -> MapArraySetter<Self, MappedPart, MappedNewPart> {
		MapArraySetter(
			optic: self,
			from: from,
			to: to
		)
	}
	
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (MappedNewPart) -> NewPart
	) -> MapArraySetter<Self, MappedPart, MappedNewPart> {
		MapArraySetter(
			optic: self,
			from: from,
			to: { _, newPart in
				to(newPart)
			}
		)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapArraySetter<Self, MappedPart, MappedPart> where NewPart == Part {
		MapArraySetter(
			optic: self,
			from: conversion.to,
			to: { _, newPart in
				conversion.from(newPart)
			}
		)
	}
}
