//
//  Coordinator.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/6/20.
//

import Foundation

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func finish()
    func start(coordinator: Coordinator)
    func finish(coordinator: Coordinator)
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinators()
}
