import Foundation

public protocol ThrowingSetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype Part
	associatedtype NewWhole
	associatedtype NewPart
	
	func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole
	
	func setting(
		_ whole: Whole,
		to newPart: NewPart
	) throws -> NewWhole
}

extension ThrowingSetterOptic {
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.updating(whole, f)
	}
}

extension ThrowingSetterOptic {
	public func setting(_ whole: Whole, to newPart: NewPart) throws -> NewWhole {
		try self.updating(whole) { _ in
			newPart
		}
	}
}

public typealias SimpleThrowingSetterOptic<Whole, Part> = ThrowingSetterOptic<Whole, Part, Whole, Part>

extension ThrowingSetterOptic {
	@inlinable
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) throws -> Void
	) throws -> Void
	where Part == NewPart, Whole == NewWhole {
		whole = try self.updating(whole, { part in
			var copy = part
			try f(&copy)
			return copy
		})
	}
	
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (inout Part) throws -> Void
	) throws -> Whole
	where Part == NewPart, Whole == NewWhole {
		try self.updating(whole) { part in
			var result = part
			try f(&result)
			return result
		}
	}
	
	@inlinable
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (Part) -> NewPart
	) throws -> Void
	where Part == NewPart, Whole == NewWhole {
		try self.update(&whole) { part in
			part = f(part)
		}
	}
	
	@inlinable
	public func set(
		_ whole: inout Whole,
		to newPart: NewPart
	) throws where Part == NewPart, Whole == NewWhole {
		whole = try self.setting(whole, to: newPart)
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		try self.set(&copy, to: newValue)
		return copy
	}
}
