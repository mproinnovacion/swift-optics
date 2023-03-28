import Foundation

public struct Zip<L: LensOptic>: LensOptic {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = L.Part
	public typealias NewPart = L.NewPart
	
	public let lens: L

	@inlinable
	public init(
		@ZipLensBuilder with build: () -> L
	) {
		self.lens = build()
	}
	
	public func get(_ whole: Whole) -> Part {
		lens.get(whole)
	}
	
	public func update(_ whole: Whole, _ f: @escaping (Part) -> NewPart) -> NewWhole {
		lens.update(whole, f)
	}
}

@resultBuilder
public enum ZipLensBuilder {
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: LensOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> ZipCombination<O0, O1> {
		ZipCombination(lhs: o0, rhs: o1)
	}
}

public struct ZipCombination<LHS: LensOptic, RHS: LensOptic>: LensOptic
where LHS.Whole == RHS.Whole, LHS.NewWhole == RHS.NewWhole, LHS.NewWhole == LHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = (LHS.Part, RHS.Part)
	public typealias NewPart = (LHS.NewPart, RHS.NewPart)
	
	public func get(_ whole: Whole) -> Part {
		(
			lhs.get(whole),
			rhs.get(whole)
		)
	}
	
	public func update(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		let lhsPart = lhs.get(whole)
		let rhsPart = rhs.get(whole)
		
		let updated = lhs.update(whole) { lhsPart in
			f((lhsPart, rhsPart)).0
		}
				
		return rhs.update(updated) { rhsPart in
			f((lhsPart, rhsPart)).1
		}
	}
}
