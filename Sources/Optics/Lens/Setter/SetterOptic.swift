import Foundation

public protocol SetterOptic<Whole, Part, NewWhole, NewPart> { //}: OptionalSetterOptic {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole
}

extension SetterOptic {
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		self.updating(whole, { _ in newValue })
	}
}

extension SetterOptic {
	@inlinable
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = self.updating(whole) { part in
			var copy = part
			f(&copy)
			return copy
		}
	}
}

public typealias SimpleSetterOptic<Whole, Part> = SetterOptic<Whole, Part, Whole, Part>

extension SetterOptic {
	@inlinable
	public func `set`(
		_ whole: inout Whole,
		to newValue: NewPart
	) where NewWhole == Whole, NewPart == Part {
		update(&whole) { part in
			part = newValue
		}
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newValue: Part
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		self.set(&copy, to: newValue)
		return copy
	}
	
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		self.update(&copy, f)
		return copy
	}
}

public struct SetterProvidedWholeOptic<O: SetterOptic>: SetterOptic {
	public typealias Whole = Void
	public typealias Part = O.Part
	public typealias NewWhole = O.NewWhole
	public typealias NewPart = O.NewPart
	
	public let optic: O
	public let whole: O.Whole
	
	public init(
		optic: O,
		whole: O.Whole
	) {
		self.optic = optic
		self.whole = whole
	}
	
	public func updating(
		_ void: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updating(self.whole, f)
	}
}

extension SetterOptic {
	public func provide(
		_ whole: Whole
	) -> SetterProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension SetterOptic where Whole == Void {
	func updating(
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.updating((), f)
	}
}
