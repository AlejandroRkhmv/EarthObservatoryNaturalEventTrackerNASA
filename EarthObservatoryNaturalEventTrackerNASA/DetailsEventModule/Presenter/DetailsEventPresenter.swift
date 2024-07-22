//
//  DetailsEventPresenter.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 14.07.2024.
//

import Foundation

protocol DetailsEventPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func update(event: Event)
    
}

final class DetailsEventPresenter: DetailsEventPresenterProtocol {
    
    weak var viewController: DetailsEventViewControllerProtocol?
    let factory = DetailUIEventModelFactory()
    var event: Event
    var place: String = ""
    
    init(viewController: DetailsEventViewControllerProtocol?, event: Event) {
        self.viewController = viewController
        self.event = event
    }
    
    func viewDidLoad() {
        guard let detailEvent = factory.createDetailsUIEventModel(from: event, place: place) else { return }
        Task { @MainActor [weak self] in
            self?.viewController?.updateView(with: detailEvent)
        }
    }
    
    func update(event: Event) {
        self.event = event
        guard let detailEvent = factory.createDetailsUIEventModel(from: event, place: place) else { return }
        Task { @MainActor [weak self] in
            self?.viewController?.updateView(with: detailEvent)
        }
    }
    
}
