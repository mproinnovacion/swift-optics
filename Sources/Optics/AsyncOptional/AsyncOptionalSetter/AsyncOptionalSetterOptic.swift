import Foundation

public protocol AsyncOptionalSetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype Part
	associatedtype NewWhole
	associatedtype NewPart
	
	func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole
	
	func trySetting(_ whole: Whole, to: NewPart) async -> NewWhole
}

extension AsyncOptionalSetterOptic {
	public func trySetting(_ whole: Whole, to newPart: NewPart) async -> NewWhole {
		await self.tryUpdating(whole) { _ in
			newPart
		}
	}
}

public typealias SimpleAsyncOptionalSetterOptic<Whole, Part> = AsyncOptionalSetterOptic<Whole, Part, Whole, Part>

extension AsyncOptionalSetterOptic {
	@inlinable
	public func tryUpdate(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) async throws -> Void
	) async rethrows -> Void
	where Part == NewPart, Whole == NewWhole {
		whole = try await self.tryUpdating(whole, { part in
			var copy = part
			try await f(&copy)
			return copy
		})
	}
	
	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (inout Part) async throws -> Void
	) async rethrows -> Whole
	where Part == NewPart, Whole == NewWhole {
		try await self.tryUpdating(whole) { part in
			var result = part
			try await f(&result)
			return result
		}
	}
	
	@inlinable
	public func tryUpdate(
		_ whole: inout Whole,
		_ f: @escaping (Part) async -> NewPart
	) async -> Void
	where Part == NewPart, Whole == NewWhole {
		await self.tryUpdate(&whole) { part in
			part = await f(part)
		}
	}
	
	@inlinable
	public func trySet(
		_ whole: inout Whole,
		to newPart: NewPart
	) async where Part == NewPart, Whole == NewWhole {
		whole = await self.trySetting(whole, to: newPart)
	}
	
	@inlinable
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) async -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		await self.trySet(&copy, to: newValue)
		return copy
	}
}
