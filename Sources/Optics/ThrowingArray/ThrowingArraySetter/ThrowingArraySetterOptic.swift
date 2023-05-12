import Foundation

public protocol ThrowingArraySetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype Part
	associatedtype NewWhole
	associatedtype NewPart
	
	func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole
}

extension ThrowingArraySetterOptic {
	public func settingAll(
		in whole: Whole,
		to newPart: NewPart
	) throws -> NewWhole {
		try self.updatingAll(in: whole) { _ in
			newPart
		}
	}
}
public typealias SimpleThrowingArraySetterOptic<Whole, Part> = ThrowingArraySetterOptic<Whole, Part, Whole, Part>

extension ThrowingArraySetterOptic where NewWhole == Whole {
	@inlinable
	public func setAll(
		in whole: inout Whole,
		to newPart: NewPart
	) throws {
		whole = try self.updatingAll(in: whole) { _ in
			newPart
		}
	}
}

extension ThrowingArraySetterOptic {
	@inlinable
	public func updateAll(
		in whole: inout Whole,
		update f: @escaping (inout Part) throws -> Void
	) throws -> Void
	where Part == NewPart, Whole == NewWhole {
		whole = try self.updatingAll(in: whole) { part in
			var copy = part
			try f(&copy)
			return copy
		}
	}
	
	@inlinable
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (inout Part) throws -> Void
	) throws -> Whole
	where Part == NewPart, Whole == NewWhole {
		try self.updatingAll(in: whole) { part in
			var result = part
			try f(&result)
			return result
		}
	}
	
	@inlinable
	public func updateAll(
		in whole: inout Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> Void
	where Part == NewPart, Whole == NewWhole {
		try self.updateAll(in: &whole) { part in
			part = try f(part)
		}
	}
	
	@inlinable
	public func settingAll(
		in whole: Whole,
		to newValue: NewPart
	) throws -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		try self.setAll(in: &copy, to: newValue)
		return copy
	}
	
	@inlinable
	public func updater(
		update f: @escaping (Part) throws -> NewPart
	) -> (Whole) throws -> NewWhole {
		{ whole in
			try self.updatingAll(in: whole, update: f)
		}
	}
}

public struct ThrowingArraySetterProvidedWholeOptic<O: ThrowingArraySetterOptic>: ThrowingArraySetterOptic {
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

	public func updatingAll(
		in void: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try optic.updatingAll(in: self.whole, update: f)
	}
}

extension ThrowingArraySetterOptic {
	public func provide(
		_ whole: Whole
	) -> ThrowingArraySetterProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension ThrowingArraySetterOptic where Whole == Void {
	public func updatingAll(
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.updatingAll(in: (), update: f)
	}

	public func settingAll(
		to newValue: NewPart
	) throws -> NewWhole {
		try self.settingAll(in: (), to: newValue)
	}
}
