//
//  EventCell.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 07.07.2024.
//

import UIKit

final class EventCell: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier new", size: 17.0)
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier new", size: 12.0)
        return label
    }()
    
    let status: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier new", size: 12.0)
        return label
    }()
    
    override func layoutSubviews() {
            super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        label.frame = CGRect(x: 16, y: 5, width: contentView.bounds.width - 32, height: 35)
        contentView.addSubview(label)
        
        typeLabel.frame = CGRect(x: 16, y: 45, width: contentView.bounds.width / 2, height: 15)
        contentView.addSubview(typeLabel)
        
        status.frame = CGRect(x: contentView.bounds.width / 3 + 16, y: 45, width: contentView.bounds.width / 2, height: 15)
        contentView.addSubview(status)
    }
    
}
