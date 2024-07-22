//
//  LoadingView.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 07.07.2024.
//

import UIKit

final class LoadingView: UIView {
    
    let loading = UILabel()
    let indicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLoading() {
        loading.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 50)
        loading.center.x = center.x
        loading.center.y = center.y
        addSubview(loading)
        loading.font = UIFont(name: "Courier new", size: 30.0)
        loading.textColor = .black
        loading.textAlignment = .center
        
        let indicatorSize = CGSize(width: 100, height: 100)
        let indicatorOrigin = CGPoint(x: center.x - indicatorSize.width / 2.0, y: center.y + 100 - indicatorSize.height / 2.0)
        indicator.frame = CGRect(origin: indicatorOrigin, size: indicatorSize)
        indicator.tintColor = .black
        addSubview(indicator)
    }
    
}
