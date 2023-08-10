import Foundation

public struct CompactMapArrayGetter<O: ArrayGetterOptic, MappedPart>: ArrayGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = MappedPart
	
	public let optic: O
	@usableFromInline let update: (O.Part) -> MappedPart?
	
	@inlinable
	public init(
		@ArrayGetterOpticBuilder _ build: () -> O,
		_ update: @escaping (O.Part) -> MappedPart?
	) {
		self.optic = build()
		self.update = update
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic.getAll(whole).compactMap(update)
	}
}

extension ArrayGetterOptic {
	public func compactMap<MappedPart>(
		_ update: @escaping (Part) -> MappedPart?
	) -> CompactMapArrayGetter<Self, MappedPart> {
		CompactMapArrayGetter({ self }, update)
	}
	
	public func compactMap<MappedPart>(
		_ conversion: Conversion<Part, MappedPart?>
	) -> CompactMapArrayGetter<Self, MappedPart> {
		CompactMapArrayGetter({ self }, conversion.to)
	}
}
