import Foundation

public protocol SetterOptic<Whole, Part, NewWhole, NewPart> { //}: OptionalSetterOptic {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole
}

extension SetterOptic {
	public func setting(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		self.updating(in: whole) { _ in newValue }
	}
}

extension SetterOptic {
	@inlinable
	public func update(
		in whole: inout Whole,
		update f: @escaping (inout Part) -> Void
	) -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = self.updating(in: whole) { part in
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
		in whole: inout Whole,
		to newValue: NewPart
	) where NewWhole == Whole, NewPart == Part {
		update(in: &whole) { part in
			part = newValue
		}
	}
	
	@inlinable
	public func updating(
		in whole: Whole,
		update f: @escaping (inout Part) -> Void
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		self.update(in: &copy, update: f)
		return copy
	}
	
	@inlinable
	public func updater(
		update f: @escaping (Part) -> NewPart
	) -> (Whole) -> NewWhole {
		{ whole in
			self.updating(in: whole, update: f)
		}
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
		in void: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updating(in: self.whole, update: f)
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
	public func updating(
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.updating(in: (), update: f)
	}
	
	public func setting(
		to newValue: NewPart
	) -> NewWhole {
		self.setting(in: (), to: newValue)
	}
}
