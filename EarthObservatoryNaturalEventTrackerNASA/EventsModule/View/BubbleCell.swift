//
//  BubbleCell.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 07.07.2024.
//

import UIKit

class BubbleCell: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.textAlignment = .center
        label.font = UIFont(name: "Courier new", size: 15.0)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.alpha = isSelected ? 0.5 : 1.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = frame.height / 2
        
        let labelWidth = contentView.bounds.width
        let labelHeight = contentView.bounds.height
        
        label.frame = CGRect(x: 0, y: 0, width:  labelWidth, height:  labelHeight)
        contentView.addSubview(label)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
