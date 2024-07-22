//
//  UIModel.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation

struct EventsUIModel {
    
    let title: String
    let description: String
    let events: [[Event]]?
    
}

struct Event {
    
    let id: String
    let title: String
    let description: String?
    let closed: String?
    let categorieId: [String]
    let categorieTitle: [String]
    let sourcesURL: [String]
    let magnitudeValue: [Double?]
    let magnitudeUnit: [String?]
    let date: String
    let type: [String]
    let coordinates: [[Double]]
    
}

struct DateEventsUIModel {
    
    let title: String
    let description: String
    let events: [DateEvent]
    
}

struct DateEvent {
    
    let id: String
    let title: String
    let description: String?
    let closed: String?
    let categorieId: [String]
    let categorieTitle: [String]
    let sourcesURL: [String]
    let magnitudeValue: [Double?]
    let magnitudeUnit: [String?]
    let date: Date
    let type: [String]
    let coordinates: [[Double]]
    
}
