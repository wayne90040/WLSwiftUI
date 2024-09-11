import SwiftUI

/// Below iOS 17: Change the background color of FullScreenCover to transparent
public struct ClearBackgroundViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .background(ClearBackground())
    }
    
    struct ClearBackground: UIViewRepresentable {
        func makeUIView(context _: Context) -> some UIView {
            InnerView()
        }
        
        func updateUIView(_: UIViewType, context _: Context) { }
        
        /// 為了解決某楨會有白色閃爍
        private class InnerView: UIView {
            override func didMoveToWindow() {
                super.didMoveToWindow()
                superview?.superview?.backgroundColor = .clear
            }
        }
    }
}

public extension View {
    var clearBackground: some View {
        modifier(ClearBackgroundViewModifier())
    }
}
