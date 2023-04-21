import Foundation

public protocol OptionalSetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype Part
	associatedtype NewWhole
	associatedtype NewPart
	
	func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole
	
	func trySetting(_ whole: Whole, to: NewPart) -> NewWhole
}

public typealias SimpleOptionalSetterOptic<Whole, Part> = OptionalSetterOptic<Whole, Part, Whole, Part>

extension OptionalSetterOptic {
	@inlinable
	public func tryUpdate(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) throws -> Void
	) rethrows -> Void
	where Part == NewPart, Whole == NewWhole {
		whole = try self.tryUpdating(whole, { part in
			var copy = part
			try f(&copy)
			return copy
		})
	}
	
	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (inout Part) throws -> Void
	) rethrows -> Whole
	where Part == NewPart, Whole == NewWhole {
		try self.tryUpdating(whole) { part in
			var result = part
			try f(&result)
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
