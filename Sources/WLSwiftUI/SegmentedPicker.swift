import SwiftUI

// https://github.com/KazaiMazai/SwiftySegmentedPicker
public struct SegmentedPicker<Element: Equatable, Content: View, Selection: View>: View {
    
    public typealias Data = [Element]
    
    @State
    private var frames: [CGRect]
    
    @Binding
    private var selectedIndex: Data.Index?
    
    private let data: Data
    private let selection: () -> Selection
    private let content: (Data.Element, Int, Bool) -> Content
    private let selectionAlignment: VerticalAlignment
    
    public init(
        _ data: Data,
        selectedIndex: Binding<Data.Index?>,
        selectionAlignment: VerticalAlignment = .center,
        @ViewBuilder content: @escaping (Data.Element, Int, Bool) -> Content,
        @ViewBuilder selection: @escaping () -> Selection
    ) {
        self.data = data
        self.content = content
        self.selection = selection
        self._selectedIndex = selectedIndex
        self._frames = State(wrappedValue: .init(repeating: .zero, count: data.count))
        self.selectionAlignment = selectionAlignment
    }
    
    public var body: some View {
        ZStack(alignment: .init(
            horizontal: .horizontalCenterAlignment,
            vertical: selectionAlignment)
        ) {
            
            if let selectedIndex = selectedIndex {
                selection()
                    .frame(
                        width: frames[selectedIndex].width,
                        height: frames[selectedIndex].height
                    )
                    .alignmentGuide(.horizontalCenterAlignment) {
                        $0[HorizontalAlignment.center]
                    }
            }
            
            HStack(spacing: .zero) {
                ForEach(data.indices, id: \.self) { index in
                    Button {
                        selectedIndex = index
                    } label: {
                        content(data[index], index, selectedIndex == index)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    if frames.count > index {
                                        frames[index] = proxy.frame(in: .global)
                                    }
                                }
                                // data 更新時, 同步更新 frames 的大小
                                .onChange(of: data) { _ in
                                    if frames.count > index {
                                        frames[index] = proxy.frame(in: .global)
                                    }
                                }
                        }
                    )
                    .alignmentGuide(
                        .horizontalCenterAlignment,
                        isActive: selectedIndex == index) {
                            $0[HorizontalAlignment.center]
                        }
                }
            }
        }
        // 當 Data 更新時, 因為 frames 為 @State, 所以好像沒有重置
        // 所以這邊加 onChange 同步更新 frames
        .onChange(of: data) {
            frames = .init(repeating: .zero, count: $0.count)
        }
    }
}

extension HorizontalAlignment {
    private enum CenterAlignmentID: AlignmentID {
        static func defaultValue(in dimension: ViewDimensions) -> CGFloat {
            return dimension[HorizontalAlignment.center]
        }
    }
    
    static var horizontalCenterAlignment: HorizontalAlignment {
        HorizontalAlignment(CenterAlignmentID.self)
    }
}

extension View {
    @ViewBuilder
    @inlinable func alignmentGuide(
        _ alignment: HorizontalAlignment,
        isActive: Bool,
        computeValue: @escaping (ViewDimensions) -> CGFloat) -> some View {
            if isActive {
                alignmentGuide(alignment, computeValue: computeValue)
            } else {
                self
            }
        }
    
    @ViewBuilder
    @inlinable func alignmentGuide(
        _ alignment: VerticalAlignment,
        isActive: Bool,
        computeValue: @escaping (ViewDimensions) -> CGFloat) -> some View {
            if isActive {
                alignmentGuide(alignment, computeValue: computeValue)
            } else {
                self
            }
        }
}
