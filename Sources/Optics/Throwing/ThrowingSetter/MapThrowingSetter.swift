import Foundation

public struct MapThrowingSetter<O: ThrowingSetterOptic, MappedPart, MappedNewPart>: ThrowingSetterOptic {
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
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.optic.updating(in: whole) { part in
			to(part, try f(from(part)))
		}
	}
}

extension ThrowingSetterOptic {
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (Part, MappedNewPart) -> NewPart
	) -> MapThrowingSetter<Self, MappedPart, MappedNewPart> {
		MapThrowingSetter(
			optic: self,
			from: from,
			to: to
		)
	}
	
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (MappedNewPart) -> NewPart
	) -> MapThrowingSetter<Self, MappedPart, MappedNewPart> {
		MapThrowingSetter(
			optic: self,
			from: from,
			to: { _, newPart in
				to(newPart)
			}
		)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapThrowingSetter<Self, MappedPart, MappedPart> where NewPart == Part {
		MapThrowingSetter(
			optic: self,
			from: conversion.to,
			to: { _, newPart in
				conversion.from(newPart)
			}
		)
	}
}
