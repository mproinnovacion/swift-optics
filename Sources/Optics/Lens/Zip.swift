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
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(whole, f)
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
	
	public static func buildPartialBlock<O0: LensOptic, O1: LensOptic, O2: LensOptic>(accumulated o0: O0, next: ZipCombination<O1, O2>) -> ZipCombination3<O0, O1, O2> {
		ZipCombination3(o0: o0, o1: next.lhs, o2: next.rhs)
	}
	
	public static func buildExpression<O: LensOptic>(_ expression: O) -> O {
		expression
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
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		let lhsPart = lhs.get(whole)
		let rhsPart = rhs.get(whole)
		
		let updated = lhs.updating(whole) { lhsPart in
			f((lhsPart, rhsPart)).0
		}
				
		return rhs.updating(updated) { rhsPart in
			f((lhsPart, rhsPart)).1
		}
	}
}

public struct ZipCombination3<O0: LensOptic, O1: LensOptic, O2: LensOptic>: LensOptic
where O0.Whole == O1.Whole, O0.NewWhole == O1.NewWhole, O0.NewWhole == O0.Whole, O0.Whole == O2.Whole, O2.NewWhole == O2.Whole {
	let o0: O0
	let o1: O1
	let o2: O2
	
	public typealias Whole = O0.Whole
	public typealias NewWhole = O0.NewWhole
	public typealias Part = (O0.Part, O1.Part, O2.Part)
	public typealias NewPart = (O0.NewPart, O1.NewPart, O2.NewPart)
	
	public func get(_ whole: Whole) -> Part {
		(
			o0.get(whole),
			o1.get(whole),
			o2.get(whole)
		)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		let o0Part = o0.get(whole)
		let o1Part = o1.get(whole)
		let o2Part = o2.get(whole)
		
		var updated = o0.updating(whole) { o0Part in
			f((o0Part, o1Part, o2Part)).0
		}
				
		updated = o1.updating(updated) { o1Part in
			f((o0Part, o1Part, o2Part)).1
		}
		
		updated = o2.updating(updated) { o2Part in
			f((o0Part, o1Part, o2Part)).2
		}
		
		return updated
	}
}
