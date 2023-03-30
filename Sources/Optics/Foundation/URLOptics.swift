import Foundation

extension URL {
	public static func componentsOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, URLComponents> {
		OptionalRawOptic { url in
			URLComponents(url: url, resolvingAgainstBaseURL: resolvingAgainstBaseURL)
		} tryUpdate: { url, update in
			guard
				var components = URLComponents(
					url: url,
					resolvingAgainstBaseURL: resolvingAgainstBaseURL
				)
			else {
				return url
			}
			
			components = update(components)
			return components.url ?? url
		} trySet: { url, newComponents in
			newComponents.url ?? url
		}
	}
	
	public static func schemeOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, String> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			\URLComponents.scheme
			String?.optic()
		}
	}
	
	public static func hostOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, String> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			\URLComponents.host
			String?.optic()
		}
	}
	
	public static func userOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, String> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			\URLComponents.user
			String?.optic()
		}
	}
	
	public static func passwordOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, String> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			\URLComponents.password
			String?.optic()
		}
	}
	
	public static func portOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, Int> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			\URLComponents.port
			Int?.optic()
		}
	}
	
	public static func pathOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, String> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			
			Lens {
				\URLComponents.path
			}.map { (string: String) -> String in
				string.first == "/" ? String(string.dropFirst()) : string
			} to: { (string: String) -> String in
				string.first == "/" ? string : "/\(string)"
			}
		}
	}
	
	public static func queryOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, String> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			\URLComponents.query
			String?.optic()
		}
	}
	
	public static func fragmentOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, String> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			\URLComponents.fragment
			String?.optic()
		}
	}
	
	public static func queryItemsOptic(
		resolvingAgainstBaseURL: Bool = true
	) -> some SimpleOptionalOptic<URL, [URLQueryItem]> {
		Optionally {
			self.componentsOptic(resolvingAgainstBaseURL: resolvingAgainstBaseURL)
			\URLComponents.queryItems
			[URLQueryItem]?.optic()
		}
	}
}
