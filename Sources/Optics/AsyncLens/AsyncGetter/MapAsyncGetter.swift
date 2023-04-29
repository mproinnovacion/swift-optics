import Foundation

public struct MapAsyncGetter<O: AsyncGetterOptic, MappedPart>: AsyncGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = MappedPart
	
	public let optic: O
	@usableFromInline let update: (O.Part) async -> MappedPart
	
	@inlinable
	public init(
		@AsyncGetterOpticBuilder _ build: () -> O,
		_ update: @escaping (O.Part) -> MappedPart
	) {
		self.optic = build()
		self.update = update
	}
	
	public func get(_ whole: Whole) async -> Part {
		await update(optic.get(whole))
	}
}

extension AsyncGetterOptic {
	public func map<MappedPart>(
		_ update: @escaping (Part) -> MappedPart
	) -> MapAsyncGetter<Self, MappedPart> {
		MapAsyncGetter({ self }, update)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapAsyncGetter<Self, MappedPart> {
		MapAsyncGetter({ self }, conversion.to)
	}
}
