import UIKit

extension UIViewController {
    private enum Constants {
        static var coordinatorAssociatedKey = "coordinatorAssociatedKey"
    }

    var coordinator: Any? {
        get {
            return objc_getAssociatedObject(
                self,
                &Constants.coordinatorAssociatedKey
            )
        }
        set {
            objc_setAssociatedObject(
                self,
                &Constants.coordinatorAssociatedKey,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
