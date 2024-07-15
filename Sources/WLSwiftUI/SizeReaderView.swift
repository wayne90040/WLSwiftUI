import SwiftUI

public struct SizeReaderView: View {
    public let sizeChanged: (CGSize) -> Void
    public var body: some View {
        GeometryReader { reader in
            Color.clear
                .onAppear {
                    sizeChanged(reader.size)
                }
                .onChange(of: reader.size) {
                    sizeChanged($0)
                }
        }
    }
}

public struct SizeReaderViewModifier: ViewModifier {
    private let sizeChanged: (CGSize) -> Void
    
    public init(sizeChanged: @escaping (CGSize) -> Void) {
        self.sizeChanged = sizeChanged
    }
    
    public func body(content: Content) -> some View {
        content
            .background(SizeReaderView(sizeChanged: sizeChanged))
    }
}

public extension View {
    func sizeChanged(sizeChanged: @escaping (CGSize) -> Void) -> some View {
        modifier(SizeReaderViewModifier(sizeChanged: sizeChanged))
    }
}
