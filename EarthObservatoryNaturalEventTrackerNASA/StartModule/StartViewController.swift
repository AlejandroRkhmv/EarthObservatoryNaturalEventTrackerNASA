//
//  StartViewController.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import UIKit

final class StartViewController: UIViewController {
    
    let viewModel: StartViewModel
    
    let abbTitle = UILabel()
    let subTitle = UILabel()
    let button = UIButton()
    
    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAbbTitle()
        setupSubTitle()
        setupButton()
        
        Task { @MainActor in
            await viewModel.viewDidLoad()
            abbTitle.text = viewModel.title
            subTitle.text = viewModel.subTitle
            guard let image = UIImage(data: viewModel.buttonImageData) else { 
                button.setTitle("Button title", for: .normal)
                return }
            button.setImage(image, for: .normal)
        }
        
    }
    
}

// MARK: -
extension StartViewController {
    
    func setupAbbTitle() {
        abbTitle.frame = CGRect(x: 0, y: 150, width: view.bounds.width, height: 50)
        abbTitle.center.x = view.center.x
        view.addSubview(abbTitle)
        
        abbTitle.font = UIFont(name: "Courier new", size: 30.0)
        abbTitle.textColor = .black
        abbTitle.textAlignment = .center
    }
    
    func setupSubTitle() {
        subTitle.frame = CGRect(x: 0, y: 200, width: view.bounds.width, height: 50)
        subTitle.center.x = view.center.x
        view.addSubview(subTitle)
        
        subTitle.numberOfLines = 0
        subTitle.font = UIFont(name: "Courier new", size: 20.0)
        subTitle.textColor = .black
        subTitle.textAlignment = .center
    }
    
    func setupButton() {
        button.frame = CGRect(x: 0, y: 400, width: 200, height: 200)
        button.center.x = view.center.x
        view.addSubview(button)
        
        button.setTitleColor(.black, for: .normal)
        
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        button.layer.shadowRadius = 10.0
        button.layer.shadowOpacity = 0.8
        
        let action = UIAction { [weak self] _ in
            self?.viewModel.buttonTapped()
        }
        button.addAction(action, for: .touchUpInside)
    }
    
}
