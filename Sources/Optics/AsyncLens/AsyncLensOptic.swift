import Foundation

public protocol AsyncLensOptic<Whole, Part, NewWhole, NewPart>: AsyncGetterOptic, AsyncSetterOptic {
	associatedtype _LensBody
	
	typealias LensBody = _LensBody

	@AsyncLensOpticBuilder
	var body: LensBody { get }
}

extension AsyncLensOptic where LensBody == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: LensBody {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access a LensOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension AsyncLensOptic where LensBody: AsyncLensOptic, LensBody.Whole == Whole, LensBody.Part == Part, LensBody.NewWhole == NewWhole, LensBody.NewPart == NewPart {
	
	@inlinable
	public func get(_ whole: Whole) async -> Part {
		await self.body.get(whole)
	}
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await self.body.updating(whole, f)
	}
}

public typealias SimpleAsyncLensOptic<Whole, Part> = AsyncLensOptic<Whole, Part, Whole, Part>

extension AsyncLensOptic {
	@inlinable
	public func each<Element, NewElement>() -> Each<Self, Element, NewElement>
	where Part == [Element], NewPart == [NewElement] {
		Each {
			self
		}
	}
}
