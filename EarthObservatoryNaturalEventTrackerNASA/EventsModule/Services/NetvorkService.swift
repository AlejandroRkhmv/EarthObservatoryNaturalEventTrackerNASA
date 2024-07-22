//
//  NetvorkService.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation

protocol NetvorkServiceProtocol: AnyObject {
    
    func getCategories(with endPoints: [FilterType: String]?) async throws -> CategoriesDomainModel
    func getEvents(with endPoints: [FilterType: String]?) async throws -> EventsDomainModel
    
}

final class NetvorkService: NetvorkServiceProtocol {
    
    let urlStringMaker = UrlStringMaker()
    let decoderService = JSONDecoderService()
    let session = URLSession(configuration: .default)
    
    func getCategories(with endPoints: [FilterType: String]?) async throws -> CategoriesDomainModel {
        let urlString = try await urlStringMaker.makeUrlString(with: endPoints, type: .categories)
        guard let url = URL(string: urlString) else { throw NetworkErrors.canNotCreateURLFromUrlString }
        
        let response = try await session.data(from: url)
        
        let categoriesDomainModel = try await decoderService.decodeCategories(from: response.0)
        return categoriesDomainModel
    }
    
    func getEvents(with endPoints: [FilterType: String]?) async throws -> EventsDomainModel {
        let urlString = try await urlStringMaker.makeUrlString(with: endPoints, type: .allEvents)
        guard let url = URL(string: urlString) else { throw NetworkErrors.canNotCreateURLFromUrlString }
        
        let response = try await session.data(from: url)
        
        let eventsDomainModel = try await decoderService.decodeEvents(from: response.0)
        return eventsDomainModel
    }
    
    
}

enum NetworkErrors: Error {
    
    case canNotCreateURLFromUrlString
    case requestError
    
}


//} catch(DataFromFileErrors.canNotCreateDictionaryData) {
//    print(DataFromFileErrors.canNotCreateDictionaryData.localizedDescription)
//} catch(DataFromFileErrors.canNotCreateURLString) {
//    print(DataFromFileErrors.canNotCreateURLString.localizedDescription)
//} catch {
//    print("Some unrealized error")
//}
