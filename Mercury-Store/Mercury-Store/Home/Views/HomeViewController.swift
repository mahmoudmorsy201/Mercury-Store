//
//  HomeViewController.swift
//  Mercury-Store
//
//  Created by mac hub on 16/05/2022.
//

import UIKit

class HomeViewController: UIViewController, HomeBaseCoordinated {
    var coordinator: HomeBaseCoordinator?
    
    init(coordinator: HomeBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Home"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBarButton()
        view.backgroundColor = .green
    }
    
    private func createSearchBarButton() {
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBtnTapped))
        self.navigationItem.rightBarButtonItem = search
    }
    
    @objc func searchBtnTapped() {
        coordinator?.moveTo(flow: .home(.searchScreen), userData: nil)
    }
    
    
    
}
