import Foundation

public struct FlatMapOptionalGetter<O: OptionalGetterOptic, MappedPart>: OptionalGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = MappedPart
	
	public let optic: O
	@usableFromInline let update: (O.Part) -> MappedPart?
	
	@inlinable
	public init(
		@OptionalGetterOpticBuilder _ build: () -> O,
		_ update: @escaping (O.Part) -> MappedPart?
	) {
		self.optic = build()
		self.update = update
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		optic.tryGet(whole).flatMap(update)
	}
}

extension OptionalGetterOptic {
	public func flatMap<MappedPart>(
		_ update: @escaping (Part) -> MappedPart?
	) -> FlatMapOptionalGetter<Self, MappedPart> {
		FlatMapOptionalGetter({ self }, update)
	}
	
	public func flatMap<MappedPart>(
		_ conversion: Conversion<Part, MappedPart?>
	) -> FlatMapOptionalGetter<Self, MappedPart> {
		FlatMapOptionalGetter({ self }, conversion.to)
	}
}
