import Foundation

public struct MapAsyncLens<O: AsyncLensOptic, MappedPart, MappedNewPart>: AsyncLensOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = MappedPart
	public typealias NewPart = MappedNewPart
	
	public let optic: O
	@usableFromInline let from: (O.Part) -> MappedPart
	@usableFromInline let to: (O.Part, MappedNewPart) -> O.NewPart
	
	@inlinable
	public init(
		@AsyncLensOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (O.Part, MappedNewPart) -> O.NewPart
	) {
		self.optic = build()
		self.from = from
		self.to = to
	}
	
	@inlinable
	public init(
		@AsyncLensOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (MappedNewPart) -> O.NewPart
	) {
		self.optic = build()
		self.from = from
		self.to = { _, newPart in
			to(newPart)
		}
	}
	
	public func get(_ whole: Whole) async -> Part {
		await from(optic.get(whole))
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await optic.updating(whole) { oPart in
			to(oPart, try await f(from(oPart)))
		}
	}
}

extension AsyncLensOptic {
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (Part, MappedNewPart) -> NewPart
	) -> MapAsyncLens<Self, MappedPart, MappedNewPart> {
		MapAsyncLens({ self }, from: from, to: to)
	}
	
	public func map<MappedPart, MappedNewPart>(
		from: @escaping (Part) -> MappedPart,
		to: @escaping (MappedNewPart) -> NewPart
	) -> MapAsyncLens<Self, MappedPart, MappedNewPart> {
		MapAsyncLens({ self }, from: from, to: to)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapAsyncLens<Self, MappedPart, MappedPart> where NewPart == Part {
		MapAsyncLens({ self }, from: conversion.to, to: conversion.from)
	}
}
