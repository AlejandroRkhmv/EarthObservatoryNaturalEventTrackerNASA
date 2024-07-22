//
//  Router.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import UIKit

protocol RouterProtocol {
    
    func openEventsModule()
    func openDetailEventModule(with event: Event, delegate: DetailsEventModuleDelegate)
    func update(event: Event)
    
}

final class Router: RouterProtocol {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openStartViewController() {
        let viewModel = StartViewModel(router: self)
        let viewController = StartViewController(viewModel: viewModel)
        navigationController.viewControllers.append(viewController)
    }
    
    func openEventsModule() {
        let builder = Builder()
        let viewController = builder.createEventViewController(router: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func openDetailEventModule(with event: Event, delegate: DetailsEventModuleDelegate) {
        let builder = Builder()
        let viewController = builder.createDetailsEventViewController(with: event, delegate: delegate)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func update(event: Event) {
        guard let viewController = navigationController.viewControllers.last as? DetailsEventViewController else { return }
        viewController.presenter?.update(event: event)
    }
    
}
