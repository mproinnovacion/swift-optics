import Foundation

public struct FlatMapAsyncOptional<O: AsyncOptionalOptic, MappedPart>: AsyncOptionalOptic
where O.NewPart == O.Part {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = MappedPart
	public typealias NewPart = MappedPart
	
	public let optic: O
	@usableFromInline let from: (O.Part) -> MappedPart?
	@usableFromInline let to: (O.Part, MappedPart) -> O.Part?
	
	@inlinable
	public init(
		@AsyncOptionalOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart?,
		to: @escaping (O.Part, MappedPart) -> O.Part?
	) {
		self.optic = build()
		self.from = from
		self.to = to
	}
	
	@inlinable
	public init(
		@AsyncOptionalOpticBuilder _ build: () -> O,
		from: @escaping (O.Part) -> MappedPart?,
		to: @escaping (MappedPart) -> O.Part?
	) {
		self.optic = build()
		self.from = from
		self.to = { _, newPart in
			to(newPart)
		}
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await optic.tryGet(whole).flatMap { (original: O.Part) -> MappedPart? in
			self.from(original)
		}
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await optic.tryUpdating(whole) { oPart in
			guard let original = from(oPart) else {
				return oPart
			}
			
			return await to(oPart, try f(original)) ?? oPart
		}
	}
	
	public func trySetting(
		_ whole: Whole,
		to newValue: Part
	) async -> NewWhole {
		await optic.tryUpdating(whole, { oPart in
			to(oPart, newValue) ?? oPart
		})
	}
}

extension AsyncOptionalOptic where NewPart == Part {
	public func flatMap<MappedPart>(
		from: @escaping (Part) -> MappedPart?,
		to: @escaping (Part, MappedPart) -> Part?
	) -> FlatMapOptional<Self, MappedPart> {
		FlatMapOptional({ self }, from: from, to: to)
	}
	
	public func flatMap<MappedPart>(
		from: @escaping (Part) -> MappedPart?,
		to: @escaping (MappedPart) -> Part?
	) -> FlatMapOptional<Self, MappedPart> {
		FlatMapOptional({ self }, from: from, to: to)
	}
}
