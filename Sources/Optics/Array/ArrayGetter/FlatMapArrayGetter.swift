import Foundation

public struct FlatMapArrayGetter<O: ArrayGetterOptic, MappedPart>: ArrayGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = MappedPart
	
	public let optic: O
	@usableFromInline let update: (O.Part) -> [MappedPart]
	
	@inlinable
	public init(
		@ArrayGetterOpticBuilder _ build: () -> O,
		_ update: @escaping (O.Part) -> [MappedPart]
	) {
		self.optic = build()
		self.update = update
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic.getAll(whole).flatMap(update)
	}
}

extension ArrayGetterOptic {
	public func flatMap<MappedPart>(
		_ update: @escaping (Part) -> [MappedPart]
	) -> FlatMapArrayGetter<Self, MappedPart> {
		FlatMapArrayGetter({ self }, update)
	}
	
	public func flatMap<MappedPart>(
		_ conversion: Conversion<Part, [MappedPart]>
	) -> FlatMapArrayGetter<Self, MappedPart> {
		FlatMapArrayGetter({ self }, conversion.to)
	}
}
