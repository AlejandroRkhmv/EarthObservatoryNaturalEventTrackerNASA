//
//  CategoriesDomainModel.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation

struct CategoriesDomainModel: Decodable {
    
    let title: String
    let description: String
    let link: String
    let categories: [Categories]

    struct Categories: Decodable {
        
        let id: String
        let title: String
        let link: String
        let description: String
        let layers: String
        
    }
    
}

// MARK: - EventsDomainModel
struct EventsDomainModel: Codable {
    let title: String
    let description: String
    let link: String
    let events: [Events]
}

// MARK: - Event
struct Events: Codable {
    let id: String
    let title: String
    let description: String?
    let link: String
    let closed: String?
    let categories: [Category]
    let sources: [Source]
    let geometry: [Geometry]
}

// MARK: - Category
struct Category: Codable {
    let id: String
    let title: String
}

// MARK: - Geometry
struct Geometry: Codable {
    let magnitudeValue: Double?
    let magnitudeUnit: String?
    let date: String
    let type: String
    let coordinates: [Double]
}

// MARK: - Source
struct Source: Codable {
    let id: String
    let url: String
}
