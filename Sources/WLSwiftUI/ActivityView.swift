import SwiftUI
import UIKit

public struct ActivityView: UIViewControllerRepresentable {
    public var items: [Any]
    public var activities: [UIActivity]?
    
    public func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: activities)
    }
    
    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
}

public struct ActivityViewModifier: ViewModifier {
    @Binding public var isPresented: Bool
    
    public var items: [Any] = []
    
    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                ActivityView(items: items)
            }
    }
}

public extension View {
    func activity(isPresented: Binding<Bool>, items: [Any]) -> some View {
        modifier(ActivityViewModifier(isPresented: isPresented, items: items))
    }
}
