import Foundation

public protocol ThrowingSetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype Part
	associatedtype NewWhole
	associatedtype NewPart
	
	func updating(
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole
}

extension ThrowingSetterOptic {
	public func setting(
		in whole: Whole,
		to newPart: NewPart
	) throws -> NewWhole {
		try self.updating(in: whole) { _ in
			newPart
		}
	}
}

public typealias SimpleThrowingSetterOptic<Whole, Part> = ThrowingSetterOptic<Whole, Part, Whole, Part>

extension ThrowingSetterOptic {
	@inlinable
	public func update(
		in whole: inout Whole,
		update f: @escaping (inout Part) throws -> Void
	) throws -> Void
	where Part == NewPart, Whole == NewWhole {
		whole = try self.updating(in: whole) { part in
			var copy = part
			try f(&copy)
			return copy
		}
	}
	
	@inlinable
	public func updating(
		in whole: Whole,
		update f: @escaping (inout Part) throws -> Void
	) throws -> Whole
	where Part == NewPart, Whole == NewWhole {
		try self.updating(in: whole) { part in
			var result = part
			try f(&result)
			return result
		}
	}
	
	@inlinable
	public func update(
		in whole: inout Whole,
		update f: @escaping (Part) -> NewPart
	) throws -> Void
	where Part == NewPart, Whole == NewWhole {
		try self.update(in: &whole) { part in
			part = f(part)
		}
	}
	
	@inlinable
	public func set(
		in whole: inout Whole,
		to newPart: NewPart
	) throws where Part == NewPart, Whole == NewWhole {
		whole = try self.setting(in: whole, to: newPart)
	}
	
	@inlinable
	public func setting(
		in whole: Whole,
		to newValue: NewPart
	) throws -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		try self.set(in: &copy, to: newValue)
		return copy
	}
	
	@inlinable
	public func updater(
		update f: @escaping (Part) throws -> NewPart
	) -> (Whole) throws -> NewWhole {
		{ whole in
			try self.updating(in: whole, update: f)
		}
	}
}

public struct ThrowingSetterProvidedWholeOptic<O: ThrowingSetterOptic>: ThrowingSetterOptic {
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
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try optic.updating(in: self.whole, update: f)
	}
}

extension ThrowingSetterOptic {
	public func provide(
		_ whole: Whole
	) -> ThrowingSetterProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension ThrowingSetterOptic where Whole == Void {
	public func updating(
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.updating(in: (), update: f)
	}

	public func setting(
		to newValue: NewPart
	) throws -> NewWhole {
		try self.setting(in: (), to: newValue)
	}
}
