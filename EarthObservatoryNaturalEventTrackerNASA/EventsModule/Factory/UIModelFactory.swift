//
//  UIModelFactore.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation

final class UIModelFactory {
    
    func createUIModel(from domainModel: EventsDomainModel) -> EventsUIModel {
        guard !domainModel.events.isEmpty else { return EventsUIModel(title: domainModel.title, description: domainModel.description, events: nil)}
        
        let allEvents: [DateEvent] = domainModel.events.map { event -> DateEvent in
            return DateEvent(
                id: event.id,
                title: event.title,
                description: event.description,
                closed: event.closed,
                categorieId: event.categories.map(\.id),
                categorieTitle: event.categories.map(\.title),
                sourcesURL: event.sources.map(\.url),
                magnitudeValue: event.geometry.map(\.magnitudeValue),
                magnitudeUnit: event.geometry.map(\.magnitudeUnit),
                date: convertDateStringToDate(dateString: event.geometry.map(\.date)[0]),
                type: event.geometry.map(\.type),
                coordinates: event.geometry.map(\.coordinates))
        }
        
        let sortedEvents = allEvents
            .sorted { $0.date < $1.date }
            .map { sortedEvent -> Event in
                return Event(
                    id: sortedEvent.id,
                    title: sortedEvent.title,
                    description: sortedEvent.description,
                    closed: convertClosed(string: sortedEvent.closed),
                    categorieId: sortedEvent.categorieId,
                    categorieTitle: sortedEvent.categorieTitle,
                    sourcesURL: sortedEvent.sourcesURL,
                    magnitudeValue: sortedEvent.magnitudeValue,
                    magnitudeUnit: sortedEvent.magnitudeUnit,
                    date: convertDateToString(date: sortedEvent.date),
                    type: sortedEvent.type,
                    coordinates: sortedEvent.coordinates
                )
            }
        
        var resultEvents = [[Event]]()
        var tempDateEvents = [Event]()
        
        var day = Calendar.current.component(.day, from: convertDateStringToDate(otherDateString: sortedEvents[0].date))
        var month = Calendar.current.component(.month, from: convertDateStringToDate(otherDateString: sortedEvents[0].date))
        var year = Calendar.current.component(.year, from: convertDateStringToDate(otherDateString: sortedEvents[0].date))
        
        for event in sortedEvents {
            
            if day != Calendar.current.component(.day, from: convertDateStringToDate(otherDateString: event.date)) ||
               month != Calendar.current.component(.month, from: convertDateStringToDate(otherDateString: event.date)) ||
               year != Calendar.current.component(.year, from: convertDateStringToDate(otherDateString: event.date)) {
                
                resultEvents.append(tempDateEvents)
                tempDateEvents.removeAll()
                
                day = Calendar.current.component(.day, from: convertDateStringToDate(otherDateString: event.date))
                month = Calendar.current.component(.month, from: convertDateStringToDate(otherDateString: event.date))
                year = Calendar.current.component(.year, from: convertDateStringToDate(otherDateString: event.date))
                
                tempDateEvents.append(event)
            } else {
                tempDateEvents.append(event)
            }
        }
        return EventsUIModel(title: domainModel.title, description: domainModel.description, events: resultEvents.reversed())
    }

    private func convertClosed(string: String?) -> String {
        guard let string else { return ""}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: string) else { return "" }
        return convertDateToString(date: date)
    }
    
    private func convertDateStringToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else { return Date() }
        return date
    }
    
    private func convertDateStringToDate(otherDateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
        guard let date = dateFormatter.date(from: otherDateString) else { return Date() }
        return date
    }
    
    private func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func createCategoriesUIModels(from model: CategoriesDomainModel) -> [CategoriesUIModel] {
        return model.categories.map { category -> CategoriesUIModel in
            CategoriesUIModel(id: category.id, title: category.title, description: category.description)
        }
    }
    
}
