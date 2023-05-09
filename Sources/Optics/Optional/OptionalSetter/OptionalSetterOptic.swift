import Foundation

public protocol OptionalSetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype Part
	associatedtype NewWhole
	associatedtype NewPart
	
	func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole
	
	func trySetting(in whole: Whole, to: NewPart) -> NewWhole
}

extension OptionalSetterOptic {
	// Allow to only implement tryUpdating
	@inlinable
	public func trySetting(in whole: Whole, to newPart: NewPart) -> NewWhole {
		self.tryUpdating(in: whole) { _ in
			newPart
		}
	}
}

public typealias SimpleOptionalSetterOptic<Whole, Part> = OptionalSetterOptic<Whole, Part, Whole, Part>

extension OptionalSetterOptic {
	@inlinable
	public func tryUpdate(
		in whole: inout Whole,
		update f: @escaping (inout Part) -> Void
	) -> Void
	where Part == NewPart, Whole == NewWhole {
		whole = self.tryUpdating(in: whole) { part in
			var copy = part
			f(&copy)
			return copy
		}
	}
	
	@inlinable
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (inout Part) -> Void
	) -> Whole
	where Part == NewPart, Whole == NewWhole {
		self.tryUpdating(in: whole) { part in
			var result = part
			f(&result)
			return result
		}
	}
	
	@inlinable
	public func tryUpdate(
		in whole: inout Whole,
		update f: @escaping (Part) -> NewPart
	) -> Void
	where Part == NewPart, Whole == NewWhole {
		self.tryUpdate(in: &whole) { part in
			part = f(part)
		}
	}
	
	@inlinable
	public func trySet(
		in whole: inout Whole,
		to newPart: NewPart
	) where Part == NewPart, Whole == NewWhole {
		whole = self.trySetting(in: whole, to: newPart)
	}
	
	@inlinable
	public func trySetting(
		in whole: Whole,
		to newValue: NewPart
	) -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		self.trySet(in: &copy, to: newValue)
		return copy
	}
	
	@inlinable
	public func updater(
		update f: @escaping (Part) -> NewPart
	) -> (Whole) -> NewWhole {
		{ whole in
			self.tryUpdating(in: whole, update: f)
		}
	}
}

public struct OptionalSetterProvidedWholeOptic<O: OptionalSetterOptic>: OptionalSetterOptic {
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
	
	public func tryUpdating(
		in void: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(in: self.whole, update: f)
	}
	
	public func trySetting(in whole: Void, to newPart: O.NewPart) -> O.NewWhole {
		optic.trySetting(in: self.whole, to: newPart)
	}
}

extension OptionalSetterOptic {
	public func provide(
		_ whole: Whole
	) -> OptionalSetterProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension OptionalSetterOptic where Whole == Void {
	public func tryUpdating(
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.tryUpdating(in: (), update: f)
	}
	
	public func trySetting(
		to newPart: NewPart
	) -> NewWhole {
		self.trySetting(in: (), to: newPart)
	}
}
