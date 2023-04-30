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
}
