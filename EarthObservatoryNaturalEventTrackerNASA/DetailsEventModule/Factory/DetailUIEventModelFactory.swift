//
//  DetailUIEventModelFactory.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 14.07.2024.
//

import Foundation

final class DetailUIEventModelFactory {
    
    func createDetailsUIEventModel(from event: Event, place: String) -> DetailEventUIModel? {
        let title = event.title
        let description = event.description
        guard let categorieTitle = event.categorieTitle.first else { return nil }
        guard let latitude = event.coordinates.first?[0],
              let longitude = event.coordinates.first?[1] else { return nil }
        let coordinates = "latitude: \(latitude), longitude: \(longitude)"
        let closed = event.closed != "" ? "closed: " + event.closed! : "open"
        
        return DetailEventUIModel(
            title: title,
            categorieTitle: categorieTitle,
            description: description,
            coordinates: coordinates,
            point: place, 
            closed: closed
        )
    }
    
}
