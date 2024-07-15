import SwiftUI

public struct GroupText: View {
    private var texts: [Text]
    
    public init(_ texts: [Text]) {
        self.texts = texts
    }
    
    var body: some View {
        expandTexts
    }
    
    var expandTexts: Text {
        texts.reduce(Text("")) { $0 + $1 }
    }
}
