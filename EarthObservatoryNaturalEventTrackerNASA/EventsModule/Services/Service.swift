//
//  Service.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation
import Combine

final class Service {
    
    let store = Store()
    
    var eventsPublisher: AnyPublisher<EventsDomainModel?, Never> {
        store.eventsPublisher.eraseToAnyPublisher()
    }
    
    var categoriesPublisher: AnyPublisher<CategoriesDomainModel?, Never> {
        store.categoriesPublisher.eraseToAnyPublisher()
    }
    
    func updateEventsDomainModel(with model: EventsDomainModel) {
        store.eventsPublisher.send(model)
    }
    
    func updateCategoriesDomainModel(with model: CategoriesDomainModel) {
        store.categoriesPublisher.send(model)
    }
    
}
