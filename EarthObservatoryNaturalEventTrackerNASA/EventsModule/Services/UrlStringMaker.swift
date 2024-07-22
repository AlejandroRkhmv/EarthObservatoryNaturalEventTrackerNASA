//
//  UrlStringMaker.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation

enum EventType: String {
    
    case categories = "categoriesList"
    case allEvents

}

enum FilterType: String {
    
    case category
    case limit
    case days
    case status
    
    init(filter: Filters) {
        switch filter {
        case .categories: 
            self = .category
        case .days: 
            self = .days
        case .limit: 
            self = .limit
        case .status: 
            self = .status
        }
    }
    
}

final class UrlStringMaker {
    
    func makeUrlString(with endPoints: [FilterType: String]?, type: EventType) async throws -> String {
        var urlString = try await getUrlFromBundle(with: type.rawValue)
        var limit = "&limit=100"
        let statusParameter = "?status=all"
        guard let endPoints else { return urlString  + statusParameter + limit }
        var count = endPoints.count
        urlString += "?"
        
        for (key, value) in endPoints {
            count -= 1
            
            if key.rawValue == "limit" {
                limit = ""
            }
            
            urlString += key.rawValue
            urlString += "="
            urlString += value
            urlString += count > 1 ? "&" : ""
        }
        
        return urlString + limit
    }

    private func getUrlFromBundle(with type: String) async throws -> String {
        guard let url = Bundle.main.url(forResource: "URLsPropertyList", withExtension: "plist"),
              let dataDictionary = NSDictionary(contentsOf: url) as? [String: String] else { throw DataFromFileErrors.canNotCreateDictionaryData }
        guard let urlString = dataDictionary[type] else { throw DataFromFileErrors.canNotCreateURLString }
        return urlString
    }
    
}

enum DataFromFileErrors: Error {
    
    case canNotCreateDictionaryData
    case canNotCreateURLString
    case canNotCreateTitle
    
}
