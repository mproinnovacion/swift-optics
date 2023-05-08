import Foundation

public struct MapOptionalGetter<O: OptionalGetterOptic, MappedPart>: OptionalGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = MappedPart
	
	public let optic: O
	@usableFromInline let update: (O.Part) -> MappedPart
	
	@inlinable
	public init(
		@OptionalGetterOpticBuilder _ build: () -> O,
		_ update: @escaping (O.Part) -> MappedPart
	) {
		self.optic = build()
		self.update = update
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		optic.tryGet(whole).map(update)
	}
}

extension OptionalGetterOptic {
	public func map<MappedPart>(
		_ update: @escaping (Part) -> MappedPart
	) -> MapOptionalGetter<Self, MappedPart> {
		MapOptionalGetter({ self }, update)
	}
	
	public func map<MappedPart>(
		_ conversion: Conversion<Part, MappedPart>
	) -> MapOptionalGetter<Self, MappedPart> {
		MapOptionalGetter({ self }, conversion.to)
	}
}
