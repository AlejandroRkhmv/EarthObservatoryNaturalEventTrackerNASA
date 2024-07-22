//
//  FilterViewController.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 07.07.2024.
//

import UIKit

protocol FilterViewControllerDelegate {
    
    func tapOn(_ filter: Filters, value: String)
    func dismissSheet()
    
}

final class FilterViewController: UIViewController {
    
    let tableView = UITableView()
    let closeButton = UIButton()
    let titleLabel = UILabel()
    var delegate: FilterViewControllerDelegate?
    var filter: Filters?
    var categories: [CategoriesUIModel]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCloseButton()
        setupTitleLabel()
        setupTableView()
    }
    
    private func setupCloseButton() {
        closeButton.sizeToFit()
        closeButton.configuration = .textButtonConfiguration(title: "Close", font: UIFont(name: "Courier new", size: 20.0), color: .purple)
        let size = CGSize(width: 100.0, height: 44.0)
        let origin = CGPoint(x: view.bounds.maxX - size.width, y: 0.0)
        closeButton.frame = CGRect(origin: origin, size: size)
        view.addSubview(closeButton)
        
        let action = UIAction { [weak self] _ in
            self?.dismissSelf()
        }
        closeButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = filter?.rawValue
        titleLabel.font = UIFont(name: "Courier new", size: 24.0)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        let size = CGSize(width: view.bounds.width - (closeButton.bounds.width * 2), height: 44.0)
        let origin = CGPoint(x: view.bounds.midX - size.width / 2, y: 0.0)
        titleLabel.frame = CGRect(origin: origin, size: size)
        view.addSubview(titleLabel)
    }
    
    private func setupTableView() {
        tableView.register(FilterCell.self, forCellReuseIdentifier: String(describing: FilterCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        let size = CGSize(width: view.bounds.width, height: view.bounds.height - 150)
        let origin = CGPoint(x: view.bounds.minX, y: titleLabel.bounds.height)
        tableView.frame = CGRect(origin: origin, size: size)
        view.addSubview(tableView)
    }
    
    private func dismissSelf() {
        self.dismiss(animated: true)
        delegate?.dismissSheet()
    }
    
}

extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filter else { return }
        guard let categories else { return }
        let filterModel = FiltersDataModels(filterType: filter, categories: categories)
        if case .categories = filter {
            delegate?.tapOn(filter, value: categories[indexPath.row].id)
        } else {
            delegate?.tapOn(filter, value: filterModel.filters[indexPath.row])
        }
        let cell = tableView.cellForRow(at: indexPath) as? FilterCell
        cell?.label.textColor = .purple
        dismissSelf()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let filter else { return 0.0 }
        if case .categories = filter {
            return 150.0
        } else {
            return 50.0
        }
    }
    
}

extension FilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filter else { return 0 }
        guard let categories else { return 0 }
        let filterModel = FiltersDataModels(filterType: filter, categories: categories)
        return filterModel.filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilterCell.self), for: indexPath) as! FilterCell
        guard let filter else { return UITableViewCell() }
        guard let categories else { return UITableViewCell() }
        let filterModel = FiltersDataModels(filterType: filter, categories: categories)
        cell.label.text = filterModel.filters[indexPath.row]
        return cell
    }
    
    
}


extension UIButton.Configuration {
    
    public static func textButtonConfiguration(title: String, font: UIFont?, color: UIColor) -> Self {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = color
        configuration.titleAlignment = .center
        var attributedTitle = AttributedString(title)
        attributedTitle.font = font
        configuration.attributedTitle = attributedTitle
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
        return configuration
    }
    
}
