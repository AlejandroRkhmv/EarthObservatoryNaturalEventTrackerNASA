//
//  Store.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation
import Combine

final class Store {
    
    var eventsPublisher = CurrentValueSubject<EventsDomainModel?, Never>(nil)
    var categoriesPublisher = CurrentValueSubject<CategoriesDomainModel?, Never>(nil)
    
}
