import Foundation

public struct SetterFunc0<R, NewPart>: SetterOptic {
	public typealias Whole = () -> R
	public typealias Part = R
	public typealias NewWhole = () -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{
			f(whole())
		}
	}
}
