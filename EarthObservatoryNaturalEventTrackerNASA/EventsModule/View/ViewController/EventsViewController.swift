//
//  ViewController.swift
//  EarthObservatoryNaturalEventTrackerNASA
//
//  Created by Александр Рахимов on 06.07.2024.
//

import UIKit

enum State {
    
    case empty
    case loading
    case loaded
    case error
    
}

protocol EventsViewControllerProtocol: AnyObject {
    
    func setViewController(state: State)
    func updateView(with viewModel: EventsUIModel)
    
}

final class EventsViewController: UIViewController {
    
    var presenter: EventsPresenterProtocol?
    var state: State = .empty
    
    var eventsView = EventsView()
    var loadingView = LoadingView()
    var errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingView()
        setErrorView()
        setEventsView()
        presenter?.viewDidLoad()
    }
    
    func setEventsView() {
        eventsView = EventsView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        eventsView.center.x = view.center.x
        eventsView.center.y = view.center.y
        view.addSubview(eventsView)
        eventsView.delegate = self
    }
    
    func setLoadingView() {
        loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        loadingView.center.x = view.center.x
        loadingView.center.y = view.center.y
        view.addSubview(loadingView)
        loadingView.loading.text = "Loading events"
    }
    
    func setErrorView() {
        errorView = ErrorView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        view.addSubview(errorView)
        errorView.errorLabel.text = "Error"
    }


}

// MARK: -
extension EventsViewController: EventsViewControllerProtocol {
    
    func setViewController(state: State) {
        self.state = state
        switch state {
        case .empty:
            break
        case .loading:
            loadingView.isHidden = false
            loadingView.indicator.startAnimating()
            eventsView.isHidden = true
            errorView.isHidden = true
        case .error:
            loadingView.isHidden = true
            loadingView.indicator.stopAnimating()
            eventsView.isHidden = true
            errorView.isHidden = false
        case .loaded:
            loadingView.isHidden = true
            loadingView.indicator.stopAnimating()
            eventsView.isHidden = false
            errorView.isHidden = true
        }
    }
    
    func updateView(with viewModel: EventsUIModel) {
        setTitleView(with: viewModel.title)
        eventsView.viewModel = viewModel
        eventsView.eventsListView?.reloadData()
        guard let count = viewModel.events?.count else {
            eventsView.emptyLabel.isHidden = false
            return
        }
        eventsView.emptyLabel.isHidden = count > 0
    }
    
    private func setTitleView(with title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Courier new", size: 20.0)
        titleLabel.textColor = UIColor.black
        titleLabel.sizeToFit()

        navigationItem.titleView = titleLabel
    }
    
}

extension EventsViewController: EventViewDelegate {
    
    func didTapOnFilter(filterType: Filters) {
        let filterViewController = FilterViewController()
        filterViewController.filter = filterType
        filterViewController.categories = presenter?.getCagories()
        filterViewController.delegate = self
        if let sheet = filterViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(filterViewController, animated: true)
    }
    
    func didTapOn(event: Event) {
        presenter?.openEvent(event: event, delegate: self)
    }

}

extension EventsViewController: FilterViewControllerDelegate {
    
    func tapOn(_ filter: Filters, value: String) {
        let filter = [FilterType(filter: filter): value]
        presenter?.filterTap(with: filter)
    }
    
    func dismissSheet() {
        guard let filterView = eventsView.filterView else { return }
        guard let indexPath = eventsView.selectedIndexPath else { return }
        filterView.deselectItem(at: indexPath, animated: true)
        eventsView.selectedIndexPath = nil
    }
    
}

extension EventsViewController: DetailsEventModuleDelegate {
    
    func openEvent(type: DetailsEventType) {
        presenter?.updateEvent(eventType: type)
    }
    
}
