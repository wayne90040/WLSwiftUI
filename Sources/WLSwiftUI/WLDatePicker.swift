import Swift

public struct WLDatePicker<T: View>: View {
    @Binding public var selected: Date
    public let label: () -> T
    
    @State private var isPresented = false
    
    public init(selected: Binding<Date>, label: @escaping () -> T) {
        self._selected = selected
        self.label = label
    }
    
    public var body: some View {
        Button {
            isPresented.toggle()
            hideKeyboard()  // TODO: 暫時解
        } label: {
            label()
        }
        .fullScreenCover(isPresented: $isPresented) {
            ZStack(alignment: .bottom) {
                VStack {
                    Spacer()
                    datepicker
                }
                .clearBackground
                .onTapGesture {
                    isPresented.toggle()
                }
            }
            .ignoresSafeArea()
        }
    }
    
    private var datepicker: some View {
        HStack {
            DatePicker(
                "",
                selection: $selected,
                displayedComponents: .date
            )
            .datePickerStyle(.wheel)
            .frame(maxWidth: .infinity)
            .labelsHidden()
            .padding(.bottom, 35)
            .environment(\.colorScheme, .light)
        }
        .background(Color.white)
        .cornerRadius(10, corners: [.topLeft, .topRight])
    }
}
