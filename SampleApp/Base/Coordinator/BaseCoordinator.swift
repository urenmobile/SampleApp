//
//  BaseCoordinator.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import UIKit
import URENCombine

open class BaseCoordinator<InputViewModel>: Coordinator where InputViewModel: ViewModel {

    public private(set) var childCoordinators: [Coordinator] = []
    public var parentCoordinator: Coordinator?

    public let viewModel: InputViewModel
    public let cancelBag = CancelBag()

    public var didFinishSubject = PassthroughSubject<Void, Never>()

    public init(viewModel: InputViewModel) {
        self.viewModel = viewModel
    }

    open func start() { }

    open func finish() {
        removeChildCoordinators()
        parentCoordinator?.finish(coordinator: self)
        didFinishSubject.send()
    }

    open func start(coordinator: Coordinator) {
        addChildCoordinator(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }

    open func finish(coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }

    public func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    public func removeChildCoordinator(_ coordinator: Coordinator) {
        guard let coordinatorIndex = childCoordinators.firstIndex(where: { $0 === coordinator}) else { return }
        childCoordinators.remove(at: coordinatorIndex)
    }
    
    public func removeChildCoordinators() {
        childCoordinators.forEach { $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }
    
    deinit {
        debugPrint("****base deinit \(String(describing: self))")
    }
}
