import Foundation

public protocol ThrowingArraySetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype Part
	associatedtype NewWhole
	associatedtype NewPart
	
	func updatingAll(_ whole: Whole, _ f: @escaping (Part) throws -> NewPart) throws -> NewWhole
}

extension ThrowingArraySetterOptic {
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.updatingAll(whole, f)
	}
}

extension ThrowingArraySetterOptic {
	public func settingAll(_ whole: Whole, to newPart: NewPart) throws -> NewWhole {
		try self.updatingAll(whole) { _ in
			newPart
		}
	}
}
public typealias SimpleThrowingArraySetterOptic<Whole, Part> = ThrowingArraySetterOptic<Whole, Part, Whole, Part>

extension ThrowingArraySetterOptic where NewWhole == Whole {
	@inlinable
	public func setAll(
		_ whole: inout Whole,
		to newPart: NewPart
	) throws {
		whole = try self.updatingAll(whole) { _ in
			newPart
		}
	}
}

extension ThrowingArraySetterOptic {
	@inlinable
	public func updateAll(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) throws -> Void
	) throws -> Void
	where Part == NewPart, Whole == NewWhole {
		whole = try self.updatingAll(whole, { part in
			var copy = part
			try f(&copy)
			return copy
		})
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (inout Part) throws -> Void
	) throws -> Whole
	where Part == NewPart, Whole == NewWhole {
		try self.updatingAll(whole) { part in
			var result = part
			try f(&result)
			return result
		}
	}
	
	@inlinable
	public func updateAll(
		_ whole: inout Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> Void
	where Part == NewPart, Whole == NewWhole {
		try self.updateAll(&whole) { part in
			part = try f(part)
		}
	}
	
	@inlinable
	public func settingAll(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		try self.setAll(&copy, to: newValue)
		return copy
	}
}
