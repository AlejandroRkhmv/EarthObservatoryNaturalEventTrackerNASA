//
//  FiltersDataModels.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 07.07.2024.
//

import Foundation

struct FiltersDataModels {
    
    private let status = ["all", "open", "closed"]
    private let limit = ["10", "50", "100", "200", "500"]
    private let days = ["7", "14", "31", "90", "180", "365"]
    private let categories: [String]
    
    private let filterType: Filters
    
    var filters: [String] {
        switch filterType {
        case .days:
            return days
        case .limit:
            return limit
        case .status:
            return status
        case .categories:
            return categories
        }
    }
    
    init(filterType: Filters, categories: [CategoriesUIModel] = []) {
        self.filterType = filterType
        self.categories = categories.map { model -> String in
            "\"" + model.title + "\"" + "\n" + "\n" + model.description
        }
    }
    
}
