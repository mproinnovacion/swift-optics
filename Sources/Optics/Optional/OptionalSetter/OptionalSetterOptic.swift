import Foundation

public protocol OptionalSetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype Part
	associatedtype NewWhole
	associatedtype NewPart
	
	func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole
	
	func trySetting(_ whole: Whole, to: NewPart) -> NewWhole
}

extension OptionalSetterOptic {
	public func trySetting(_ whole: Whole, to newPart: NewPart) -> NewWhole {
		self.tryUpdating(whole) { _ in
			newPart
		}
	}
}

public typealias SimpleOptionalSetterOptic<Whole, Part> = OptionalSetterOptic<Whole, Part, Whole, Part>

extension OptionalSetterOptic {
	@inlinable
	public func tryUpdate(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Void
	where Part == NewPart, Whole == NewWhole {
		whole = self.tryUpdating(whole, { part in
			var copy = part
			f(&copy)
			return copy
		})
	}
	
	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Whole
	where Part == NewPart, Whole == NewWhole {
		self.tryUpdating(whole) { part in
			var result = part
			f(&result)
			return result
		}
	}
	
	@inlinable
	public func tryUpdate(
		_ whole: inout Whole,
		_ f: @escaping (Part) -> NewPart
	) -> Void
	where Part == NewPart, Whole == NewWhole {
		self.tryUpdate(&whole) { part in
			part = f(part)
		}
	}
	
	@inlinable
	public func trySet(
		_ whole: inout Whole,
		to newPart: NewPart
	) where Part == NewPart, Whole == NewWhole {
		whole = self.trySetting(whole, to: newPart)
	}
	
	@inlinable
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		self.trySet(&copy, to: newValue)
		return copy
	}
	
	@inlinable
	public func updater(
		_ f: @escaping (Part) -> NewPart
	) -> (Whole) -> NewWhole {
		{ whole in
			self.tryUpdating(whole, f)
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
		_ void: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(self.whole, f)
	}
	
	public func trySetting(_ whole: Void, to newPart: O.NewPart) -> O.NewWhole {
		optic.trySetting(self.whole, to: newPart)
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
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.tryUpdating((), f)
	}
	
	public func trySetting(
		to newPart: NewPart
	) -> NewWhole {
		self.trySetting((), to: newPart)
	}
}
