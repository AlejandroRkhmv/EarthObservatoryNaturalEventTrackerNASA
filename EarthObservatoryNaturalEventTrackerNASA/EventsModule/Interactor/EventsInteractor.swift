//
//  CategoriesInteractor.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation
import Combine

protocol EventsInteractorProtocol: AnyObject {
    
    var eventsPublisher: AnyPublisher<EventsDomainModel?, Never> { get }
    var categoriesPublisher: AnyPublisher<CategoriesDomainModel?, Never> { get }
    
    func getEvents(with filters: [FilterType: String]?) async throws
    func getCategories() async throws
    
}

final class EventsInteractor: EventsInteractorProtocol {
    
    let networkService = NetworkService()
    let service = Service()
    
    var eventsPublisher: AnyPublisher<EventsDomainModel?, Never> {
        service.eventsPublisher.eraseToAnyPublisher()
    }
    
    var categoriesPublisher: AnyPublisher<CategoriesDomainModel?, Never> {
        service.categoriesPublisher.eraseToAnyPublisher()
    }
    
    func getEvents(with filters: [FilterType: String]?) async throws {
        let eventDomaiModel = try await networkService.getEvents(with: filters)
        service.updateEventsDomainModel(with: eventDomaiModel)
    }
    
    func getCategories() async throws {
        let categoriesDomainModel = try await networkService.getCategories(with: nil)
        service.updateCategoriesDomainModel(with: categoriesDomainModel)
    }
    
}
