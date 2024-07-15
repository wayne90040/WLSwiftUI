import UIKit

public extension UIFont {
    @discardableResult
    static func register(family: String, type: String) -> Bool {
        guard
            let url = Bundle.main.url(forResource: family, withExtension: type),
            let provider = CGDataProvider(url: url as CFURL),
            let font = CGFont(provider)
        else {
            return false
        }
        var error: Unmanaged<CFError>?
        return CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
