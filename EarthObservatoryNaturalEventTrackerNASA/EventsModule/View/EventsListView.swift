//
//  EventsListView.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 07.07.2024.
//

import UIKit

final class EventsListView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        
        register(EventCell.self, forCellReuseIdentifier: String(describing: EventCell.self))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
