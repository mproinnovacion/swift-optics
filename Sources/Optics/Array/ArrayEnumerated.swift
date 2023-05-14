import Foundation

public struct ArrayEnumerated<O: ArrayOptic>: ArrayOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = (Int, O.Part)
	public typealias NewPart = (Int, O.NewPart)
	
	public let optic: O
	
	@inlinable
	public init(
		@ArrayOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic.getAll(whole)
			.enumerated()
			.map { index, part in
				(index, part)
			}
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var index = 0
		
		return optic.updatingAll(in: whole) { oPart in
			defer { index += 1 }
			return f((index, oPart)).1
		}
	}
}

extension ArrayOptic {
	public func enumerated() -> ArrayEnumerated<Self> {
		.init {
			self
		}
	}
}
