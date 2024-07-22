//
//  DetailsEventViewController.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 07.07.2024.
//

import UIKit

protocol DetailsEventModuleDelegate {
    
    func openEvent(type: DetailsEventType)
    
}

protocol DetailsEventViewControllerProtocol: AnyObject {
    
    func updateView(with event: DetailEventUIModel)
    
}

final class DetailsEventViewController: UIViewController {
    
    let titleLabel = UILabel()
    let categorieTitle = UILabel()
    let descriptionLabel = UILabel()
    let coordinates = UILabel()
    let point = UILabel()
    var closedTitle = UILabel()
    
    var presenter: DetailsEventPresenterProtocol?
    var delegate: DetailsEventModuleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutMargins = UIEdgeInsets(
            top: view.safeAreaInsets.top,
            left: 16.0,
            bottom: view.safeAreaInsets.bottom,
            right: 16.0
        )
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        setupTitleLabel()
        setupClosedTitle()
        setupCategorieTitle()
        setupDescriptionLabel()
        setupCoordinates()
        setuPpoint()
        presenter?.viewDidLoad()
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont(name: "Courier new", size: 24.0)
        titleLabel.textColor = .purple
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        let size = CGSize(width: view.bounds.width - 32.0, height: 55.0)
        let origin = CGPoint(x: 16.0, y: 100.0)
        titleLabel.frame = CGRect(origin: origin, size: size)
        view.addSubview(titleLabel)
    }
    
    private func setupCategorieTitle() {
        categorieTitle.font = UIFont(name: "Courier new", size: 14.0)
        categorieTitle.textColor = .lightGray
        categorieTitle.textAlignment = .center
        let size = CGSize(width: view.bounds.width - 32.0, height: 44.0)
        let origin = CGPoint(x: 16.0, y: 200)
        categorieTitle.frame = CGRect(origin: origin, size: size)
        view.addSubview(categorieTitle)
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont(name: "Courier new", size: 18.0)
        descriptionLabel.textColor = .purple
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        let size = CGSize(width: view.bounds.width - 32.0, height: 300.0)
        let origin = CGPoint(x: 16.0, y: 250)
        descriptionLabel.frame = CGRect(origin: origin, size: size)
        view.addSubview(descriptionLabel)
    }
    
    private func setupCoordinates() {
        coordinates.font = UIFont(name: "Courier new", size: 14.0)
        coordinates.textColor = .black
        coordinates.textAlignment = .left
        coordinates.numberOfLines = 0
        let size = CGSize(width: view.bounds.width - 32.0, height: 44.0)
        let origin = CGPoint(x: 16.0, y: 600)
        coordinates.frame = CGRect(origin: origin, size: size)
        view.addSubview(coordinates)
    }
    
    private func setupClosedTitle() {
        closedTitle.font = UIFont(name: "Courier new", size: 14.0)
        closedTitle.textColor = .purple
        closedTitle.textAlignment = .left
        let size = CGSize(width: view.bounds.width - 32.0, height: 44.0)
        let origin = CGPoint(x: 16.0, y: 650)
        closedTitle.frame = CGRect(origin: origin, size: size)
        view.addSubview(closedTitle)
    }
    
    private func setuPpoint() {
        point.font = UIFont(name: "Courier new", size: 14.0)
        point.textColor = .black
        point.textAlignment = .left
        let size = CGSize(width: view.bounds.width / 2.0, height: 44.0)
        let origin = CGPoint(x: 16.0, y: 700)
        point.frame = CGRect(origin: origin, size: size)
        view.addSubview(point)
    }
    
    @objc
    func handleSwipe(gesture: UISwipeGestureRecognizer) {
            switch gesture.direction {
            case .left:
                delegate?.openEvent(type: .next)
            case .right:
                delegate?.openEvent(type: .previous)
            default:
                break
            }
        }
    
}

extension DetailsEventViewController: DetailsEventViewControllerProtocol {
    
    func updateView(with event: DetailEventUIModel) {
        titleLabel.text = event.title
        closedTitle.text = event.closed
        categorieTitle.text = event.categorieTitle
        descriptionLabel.text = event.description
        point.text = event.point
        coordinates.text = event.coordinates
        view.setNeedsLayout()
    }
    
}
