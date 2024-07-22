//
//  StartSupportingService.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation

final class StartSupportingService {
    
    func getDataFromBundle(with type: TypeTitle) async throws -> String {
        guard let url = Bundle.main.url(forResource: "URLsPropertyList", withExtension: "plist"),
              let dataDictionary = NSDictionary(contentsOf: url) as? [String: String] else { throw DataFromFileErrors.canNotCreateDictionaryData }
        guard let title = dataDictionary[type.rawValue] else { throw DataFromFileErrors.canNotCreateTitle }
        return title
    }
    
    func getButtonImageData() async throws -> Data {
        let urlString = try await getDataFromBundle(with: TypeTitle.buttonImage)
        guard let url = URL(string: urlString) else { throw NetworkErrors.canNotCreateURLFromUrlString }
        let data = try Data(contentsOf: url)
        return data
    }
    
}

enum TypeTitle: String {
    
    case title
    case subTitle
    case buttonImage
    
}
