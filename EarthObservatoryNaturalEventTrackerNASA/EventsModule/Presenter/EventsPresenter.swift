//
//  CategoriesPresenter.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation
import Combine

enum DetailsEventType {
    
    case previous
    case next
    
}

protocol EventsPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func getCagories() -> [CategoriesUIModel]
    func filterTap(with filters: [FilterType: String])
    func openEvent(event: Event, delegate: DetailsEventModuleDelegate)
    func updateEvent(eventType: DetailsEventType)
    
}

final class EventsPresenter: EventsPresenterProtocol {
    
    weak var viewController: EventsViewControllerProtocol?
    let interctor: EventsInteractorProtocol
    let factory: UIModelFactory
    let router: RouterProtocol
    
    private var categories: [CategoriesUIModel] = []
    private var events: EventsUIModel?
    private var currentEvent: Event?
    
    var cancellable: Set<AnyCancellable> = []
    
    init(viewController: any EventsViewControllerProtocol, interctor: any EventsInteractorProtocol, factory: UIModelFactory, router: RouterProtocol) {
        self.viewController = viewController
        self.interctor = interctor
        self.factory = factory
        self.router = router
        
        subscribeOnEvents()
        subscribeOnCategories()
    }
    
    func viewDidLoad() {
        Task { @MainActor [weak self] in
            self?.viewController?.setViewController(state: .loading)
            try await self?.interctor.getEvents(with: nil)
            try await self?.interctor.getCategories()
        }
    }
    
    func filterTap(with filters: [FilterType: String]) {
        Task { @MainActor [weak self] in
            self?.viewController?.setViewController(state: .loading)
            try await self?.interctor.getEvents(with: filters)
        }
    }
    
    func getCagories() -> [CategoriesUIModel] {
        return categories
    }
    
    private func subscribeOnEvents() {
        interctor.eventsPublisher
            .sink { [weak self] domainModoel in
                guard let domainModoel else {
                    self?.viewController?.setViewController(state: .error)
                    return
                }
                guard let uiModel = self?.factory.createUIModel(from: domainModoel) else { return }
                self?.events = uiModel
                Task { @MainActor [weak self] in
                    self?.viewController?.setViewController(state: .loaded)
                    self?.viewController?.updateView(with: uiModel)
                }
            }
            .store(in: &cancellable)
    }
    
    private func subscribeOnCategories() {
        interctor.categoriesPublisher
            .sink { [weak self] domainModel in
                guard let domainModel else {
                    self?.categories = [CategoriesUIModel(id: "Empty", title: "Empty", description: "Empty")]
                    return
                }
                guard let uiModels = self?.factory.createCategoriesUIModels(from: domainModel) else { return }
                self?.categories = uiModels
            }
            .store(in: &cancellable)
    }
    
    func openEvent(event: Event, delegate: DetailsEventModuleDelegate) {
        router.openDetailEventModule(with: event, delegate: delegate)
        self.currentEvent = event
    }
    
    func updateEvent(eventType: DetailsEventType) {
        guard let events = events?.events else { return }
        guard let currentEvent else { return }
        let sortedEvents = events.flatMap { $0 }
        let eventIndex = sortedEvents.firstIndex { $0.id == currentEvent.id }
        
        guard let eventIndex else { return }
        var needEvent: Event?
        
        if case .previous = eventType, eventIndex != 0 {
            needEvent = sortedEvents[eventIndex - 1]
        } else if case .next = eventType, eventIndex < sortedEvents.count - 1 {
            needEvent = sortedEvents[eventIndex + 1]
        }
        
        guard let eventToUpdate = needEvent else { return }
        router.update(event: eventToUpdate)
        self.currentEvent = eventToUpdate
    }
    
}
