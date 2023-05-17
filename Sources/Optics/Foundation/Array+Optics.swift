import Foundation

public struct ArraySingleOptic<Element>: PrismOptic {
	public typealias Whole = [Element]
	public typealias Part = Element
	
	public func embed(_ part: Part) -> Whole {
		[part]
	}
	
	public func extract(from whole: Whole) -> Part? {
		whole.first
	}
}

public struct ArrayFirstOptic<Element>: PrismOptic {
	public typealias Whole = [Element]
	public typealias Part = (Element, [Element])
	
	public func embed(_ part: Part) -> Whole {
		[part.0] + part.1
	}
	
	public func extract(from whole: Whole) -> Part? {
		guard let first = whole.first else {
			return nil
		}
		
		return (first, Array(whole.dropFirst()))
	}
}

public struct ArrayLastOptic<Element>: PrismOptic {
	public typealias Whole = [Element]
	public typealias Part = ([Element], Element)
	
	public func embed(_ part: Part) -> Whole {
		part.0 + [part.1]
	}
	
	public func extract(from whole: Whole) -> Part? {
		guard let last = whole.last else {
			return nil
		}
		
		return (Array(whole.dropLast()), last)
	}
}

extension Array {
	public static func optic() -> ArrayDefaultOptic<Element, Element> {
		.init()
	}
	
	public static func singleOptic() -> ArraySingleOptic<Element> {
		.init()
	}
	
	public static func firstElementOptic() -> ArrayFirstOptic<Element> {
		.init()
	}
	
	public static func lastElementOptic() -> ArrayLastOptic<Element> {
		.init()
	}
}
