import Foundation

public struct AsyncOptionally<Optics: AsyncOptionalOptic>: AsyncOptionalOptic {
	public typealias Whole = Optics.Whole
	public typealias NewWhole = Optics.NewWhole
	public typealias Part = Optics.Part
	public typealias NewPart = Optics.NewPart
	
	public let optic: Optics
	
	@inlinable
	public init(
		@AsyncOptionalOpticBuilder with build: () -> Optics
	) {
		self.optic = build()
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await optic.tryGet(whole)
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await optic.tryUpdating(whole, f)
	}
	
	public func trySetting(_ whole: Whole, to newValue: NewPart) async -> NewWhole {
		await optic.trySetting(whole, to: newValue)
	}
}

//extension AsyncOptionalOptic {
//	public func each<Element, NewElement>() -> EachAsyncOptional<Self, Element, NewElement>
//	where Part == [Element], NewPart == [NewElement] {
//		EachAsyncOptional {
//			self
//		}
//	}
//}
