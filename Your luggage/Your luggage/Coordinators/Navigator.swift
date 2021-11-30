import UIKit

protocol NavigatorProtocol: AnyObject {
    var coordinator: CoordinatorProtocol? { get set }

    func push(_ viewController: UIViewController, animated: Bool)
    func set(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
}

extension NavigatorProtocol {
    func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }

    func set(_ viewController: UIViewController) {
        set(viewController, animated: true)
    }

    func pop() {
        pop(animated: true)
    }

    func popToRoot() {
        popToRoot(animated: true)
    }
}

class Navigator: NavigatorProtocol {
    weak var coordinator: CoordinatorProtocol?
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = UIColor.lightGray
    }

    func push(_ viewController: UIViewController, animated: Bool) {
        viewController.coordinator = coordinator
        if navigationController.viewControllers.isEmpty {
            navigationController.setViewControllers([viewController], animated: animated)
        } else {
            navigationController.pushViewController(viewController, animated: animated)
        }
    }

    func set(_ viewController: UIViewController, animated: Bool) {
        viewController.coordinator = coordinator
        navigationController.setViewControllers([viewController], animated: animated)
    }

    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool) {
        let viewController = navigationController.viewControllers.last { viewController in
            guard let anyCoordinator = viewController.coordinator as? CoordinatorProtocol else {
                return false
            }

            return anyCoordinator !== coordinator
        }

        if let target = viewController {
            coordinator = target.coordinator as? CoordinatorProtocol
            navigationController.popToViewController(target, animated: animated)
        } else {
            navigationController.popToRootViewController(animated: animated)
        }
    }
}

final class NavigatorMock: NavigatorProtocol {
    weak var coordinator: CoordinatorProtocol?

    var pushCalled = false
    func push(_ viewController: UIViewController, animated: Bool) {
        pushCalled = true
    }

    var setCalled = false
    func set(_ viewController: UIViewController, animated: Bool) {
        setCalled = true
    }

    var popCalled = false
    func pop(animated: Bool) {
        popCalled = true
    }

    var popToRootCalled = false
    func popToRoot(animated: Bool) {
        popToRootCalled = true
    }
}
