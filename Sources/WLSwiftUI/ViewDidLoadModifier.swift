import SwiftUI

public struct ViewDidLoadModifier: ViewModifier {
    
    @State private var isLoaded = false
    public let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content.onAppear {
            guard !isLoaded else {
                return
            }
            isLoaded = true
            action()
        }
    }
}

public extension View {
    public func onDidLoad(action: @escaping () -> Void) -> some View {
        modifier(ViewDidLoadModifier(action: action))
    }
}
