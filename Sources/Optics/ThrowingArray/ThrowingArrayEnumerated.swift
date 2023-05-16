import Foundation

public struct ThrowingArrayEnumerated<O: ThrowingArrayOptic>: ThrowingArrayOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = (Int, O.Part)
	public typealias NewPart = (Int, O.NewPart)
	
	public let optic: O
	
	@inlinable
	public init(
		@ThrowingArrayOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		try optic.getAll(whole)
			.enumerated()
			.map { index, part in
				(index, part)
			}
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		var index = 0
		
		return try optic.updatingAll(in: whole) { oPart in
			defer { index += 1 }
			return try f((index, oPart)).1
		}
	}
}

extension ThrowingArrayOptic {
	public func enumerated() -> ThrowingArrayEnumerated<Self> {
		.init {
			self
		}
	}
}
