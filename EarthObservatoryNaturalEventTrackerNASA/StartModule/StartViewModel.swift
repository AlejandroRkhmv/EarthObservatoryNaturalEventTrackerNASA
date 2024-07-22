//
//  StartViewModel.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import Foundation

final class StartViewModel {
    
    let service = StartSupportingService()
    let router: RouterProtocol
    
    private(set) var title: String = ""
    private(set) var subTitle: String = ""
    private(set) var buttonImageData = Data()
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func viewDidLoad() async {
        
        do {
            title = try await service.getDataFromBundle(with: TypeTitle.title)
        } catch(let error) {
            print(error.localizedDescription)
            title = "Sorry, title did not load"
        }
        
        do {
            subTitle = try await service.getDataFromBundle(with: TypeTitle.subTitle)
        } catch(let error) {
            print(error.localizedDescription)
            subTitle = "Sorry, title did not load"
        }
        
        do {
            buttonImageData = try await service.getButtonImageData()
        } catch(let error) {
            print(error.localizedDescription)
        }
        
    }
    
    func buttonTapped() {
        router.openEventsModule()
    }
    
}
