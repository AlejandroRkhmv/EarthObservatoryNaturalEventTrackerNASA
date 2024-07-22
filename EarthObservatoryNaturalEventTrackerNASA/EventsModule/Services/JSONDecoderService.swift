//
//  JSONDecoderService.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation

final class JSONDecoderService {
    
    func decodeEvents(from data: Data) async throws -> EventsDomainModel {
        let eventDomainModel = try JSONDecoder().decode(EventsDomainModel.self, from: data)
        return eventDomainModel
    }
    
    func decodeCategories(from data: Data) async throws -> CategoriesDomainModel {
        let categoriesDomainModel = try JSONDecoder().decode(CategoriesDomainModel.self, from: data)
        return categoriesDomainModel
    }
    
}

enum DecodeErrors: Error {
    
    case canNotDecodeEventsDomainModel
    case canNotDecodeCategoriesDomainModel
    
}
