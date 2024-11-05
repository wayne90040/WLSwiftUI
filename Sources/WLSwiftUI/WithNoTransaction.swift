import SwiftUI

// TODO: 搬到 WLSwiftUI
public func withNoTransaction<T>(_ body: () -> T) -> T {
    var transaction = Transaction()
    transaction.disablesAnimations = true
    return withTransaction(transaction) {
        body()
    }
}
