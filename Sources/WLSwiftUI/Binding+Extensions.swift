import SwiftUI

public extension Binding {
    var optional: Binding<Optional<Value>> {
        Binding<Optional<Value>>(
            get: { self.wrappedValue },
            set: {
                if let ele = $0 {
                    self.wrappedValue = ele
                }
            }
        )
    }
    
    func unwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
       Binding<T>(
           get: { self.wrappedValue ?? defaultValue },
           set: { self.wrappedValue = $0 }
       )
   }
}
