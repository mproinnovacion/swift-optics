import Foundation

public struct MapAsyncOptional<O: AsyncOptionalOptic, MappedPart>: AsyncOptionalOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = MappedPart
	public typealias NewPart = MappedPart
	
	public let optic: O
	@usableFromInline let from: (O.Part) -> MappedPart
	@usableFromInline let to: (O.Part, MappedPart) -> O.NewPart
	
	@inlinable
	public init(
		@AsyncOptionalOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (O.Part, MappedPart) -> O.NewPart
	) {
		self.optic = build()
		self.from = from
		self.to = to
	}
	
	@inlinable
	public init(
		@AsyncOptionalOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart,
		to: @escaping (MappedPart) -> O.NewPart
	) {
		self.optic = build()
		self.from = from
		self.to = { _, newPart in
			to(newPart)
		}
	}
	
	public func tryGet(_ whole: Whole) async-> Part? {
		await optic.tryGet(whole).map(from)
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await optic.tryUpdating(whole) { oPart in
			to(oPart, try await f(from(oPart)))
		}
	}
	
	public func trySetting(
		_ whole: O.Whole,
		to newValue: MappedPart
	) async -> O.NewWhole {
		await optic.tryUpdating(whole, { oPart in
			to(oPart, newValue)
		})
	}
}

extension AsyncOptionalOptic {
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

