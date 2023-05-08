import Foundation

public struct MapArrayGetter<O: ArrayGetterOptic, MappedPart>: ArrayGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = MappedPart
	
	public let optic: O
	@usableFromInline let update: (O.Part) -> MappedPart
	
	@inlinable
	public init(
		@ArrayGetterOpticBuilder _ build: () -> O,
		_ update: @escaping (O.Part) -> MappedPart
	) {
		self.optic = build()
		self.update = update
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic.getAll(whole).map(update)
	}
}

extension ArrayGetterOptic {
	public func map<MappedPart>(
		_ update: @escaping (Part) -> MappedPart
	) -> MapArrayGetter<Self, MappedPart> {
		MapArrayGetter({ self }, update)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapArrayGetter<Self, MappedPart> {
		MapArrayGetter({ self }, conversion.to)
	}
}
