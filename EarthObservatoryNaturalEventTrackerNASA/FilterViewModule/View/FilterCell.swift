//
//  FilterCell.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 14.07.2024.
//

import UIKit

class FilterCell: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier new", size: 18.0)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.alpha = isSelected ? 0.5 : 1.0
        }
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        label.frame = CGRect(x: 16, y: 5, width: contentView.bounds.width - 32, height: contentView.bounds.height)
        contentView.addSubview(label)
    }

}
