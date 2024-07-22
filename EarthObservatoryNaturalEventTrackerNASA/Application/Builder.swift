//
//  Builder.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import UIKit

final class Builder {
    
    func createEventViewController(router: RouterProtocol) -> UIViewController {
        let viewController = EventsViewController()
        let interactor = EventsInteractor()
        let factory = UIModelFactory()
        let presenter = EventsPresenter(viewController: viewController, interctor: interactor, factory: factory, router: router)
        viewController.presenter = presenter
        return viewController
    }
    
    func createDetailsEventViewController(with event: Event, delegate: DetailsEventModuleDelegate) -> UIViewController {
        let detailsEventViewController = DetailsEventViewController()
        detailsEventViewController.delegate = delegate
        let presenter = DetailsEventPresenter(viewController: detailsEventViewController, event: event)
        detailsEventViewController.presenter = presenter
        return detailsEventViewController
    }
    
}
