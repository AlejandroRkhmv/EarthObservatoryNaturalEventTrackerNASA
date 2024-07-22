//
//  FilterView.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 07.07.2024.
//

import UIKit

enum Filters: String, CaseIterable {
    
    case categories = "Categories"
    case status = "Status"
    case limit = "Limit"
    case days = "Days"
    
}

final class FilterView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        
        register(BubbleCell.self, forCellWithReuseIdentifier: String(describing: BubbleCell.self))
        contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
