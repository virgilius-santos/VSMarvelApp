
import Foundation

@propertyWrapper
struct Inject<Object> {
    let object: Object

    var wrappedValue: Object { object }

    init() {
        object = AppContainer.shared.resolve(Object.self)
    }
}
