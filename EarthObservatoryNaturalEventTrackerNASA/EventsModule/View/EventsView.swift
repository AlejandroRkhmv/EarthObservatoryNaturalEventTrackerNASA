//
//  EventsView.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 07.07.2024.
//

import UIKit

protocol EventViewDelegate {
    
    func didTapOnFilter(filterType: Filters)
    func didTapOn(event: Event)
    
}

final class EventsView: UIView {
    
    
    var filterView: FilterView?
    var eventsListView: EventsListView?
    var selectedIndexPath: IndexPath?
    var viewModel: EventsUIModel?
    var delegate: EventViewDelegate?
    let emptyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        filterView = FilterView(frame: CGRect(x: 0, y: 100, width: bounds.width, height: 60), collectionViewLayout: layout)
        filterView?.dataSource = self
        filterView?.delegate = self
    
        addSubview(filterView!)
        
        eventsListView = EventsListView(frame: CGRect(x: 0, y: 170, width: bounds.width, height: bounds.height - 170))
        eventsListView?.dataSource = self
        eventsListView?.delegate = self
        
        addSubview(eventsListView!)
        
        emptyLabel.text = "It has no events, please, use other filter"
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = 0
        emptyLabel.font = UIFont(name: "Courier new", size: 30.0)
        emptyLabel.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: 150)
        emptyLabel.center.x = center.x
        emptyLabel.center.y = center.y
        addSubview(emptyLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - CollectionView

extension EventsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = Filters.allCases[indexPath.item].rawValue
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width + 100
        return CGSize(width: width, height: 40)
    }
    
}

extension EventsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Filters.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BubbleCell.self), for: indexPath) as! BubbleCell
        cell.label.text = Filters.allCases[indexPath.item].rawValue
        cell.isSelected = selectedIndexPath == indexPath
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          if let selectedIndexPath = selectedIndexPath, selectedIndexPath == indexPath {
              collectionView.deselectItem(at: indexPath, animated: true)
              self.selectedIndexPath = nil
          } else {
              if let previousSelectedIndexPath = selectedIndexPath {
                  collectionView.deselectItem(at: previousSelectedIndexPath, animated: true)
              }
              selectedIndexPath = indexPath
              collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
          }
        
        self.delegate?.didTapOnFilter(filterType: Filters.allCases[indexPath.item])
    }
    
}

// MARK: - TableView

extension EventsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sections = viewModel?.events else { return nil }
        let labelView = UILabel()
        let title = sections[section][0].date.components(separatedBy: " ")
        labelView.text = title[1]
        labelView.font = UIFont(name: "Courier new", size: 20.0)
        labelView.largeContentImageInsets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        labelView.backgroundColor = .lightGray
        labelView.textAlignment = .center
        return labelView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let event = viewModel?.events?[indexPath.section][indexPath.row] else { return }
        delegate?.didTapOn(event: event)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension EventsView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = viewModel?.events?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = viewModel?.events else { return 0 }
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self), for: indexPath) as! EventCell
        cell.selectionStyle = .gray
        guard let sections = viewModel?.events else { return UITableViewCell() }
        cell.label.text = sections[indexPath.section][indexPath.row].title
        cell.typeLabel.text = sections[indexPath.section][indexPath.row].categorieTitle[0]
        
        if let status = sections[indexPath.section][indexPath.row].closed, status != "" {
            cell.status.text = "closed: \(status)"
        } else {
            cell.status.text = "open"
        }
        return cell
    }
    
}
