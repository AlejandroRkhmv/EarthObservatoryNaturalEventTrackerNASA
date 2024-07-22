//
//  ErrorView.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 07.07.2024.
//

import UIKit

final class ErrorView: UIView {
    
    let errorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setErrorLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setErrorLabel() {
        errorLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 100)
        errorLabel.center.x = center.x
        errorLabel.textAlignment = .center
        errorLabel.textColor = .black
        errorLabel.font = UIFont(name: "Courier new", size: 30.0)
        addSubview(errorLabel)
    }
    
}
