//
//  AppCoordinator.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit
import SnapKit

final class AppCoordinator {
    
    var navController: VSNavigationControllerProtocol
    
    init(navController: VSNavigationControllerProtocol) {
        self.navController = navController
    }
    
    func start() {
        let vc = DetailViewController(viewModel: vmMock)
        self.navController.navigate(to: vc, using: NavigationType.push)
    }
}

class ViewController: UIViewController, DSNavigationBarStyleable, DSNavigationBarConfigurable, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let t = searchBar.text ?? ""
        print(t)
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        apply(style: .default)
        selected = true
        title = "Character"
        
        let desc = DSDetailView()
        view.addSubview(desc)
        desc.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
        desc.setup()
        
        addSearchBar(placeholder: "Type something here...",
                     scopeButtonTitles: "Title", "Genre", "Rating", "Actor")
    }
    
    var selected: Bool = true {
        didSet {
            let icon = selected ? DSIcon.gridIcon : DSIcon.listIcon
            configureRightButton(with: icon.image, target: self, action: #selector(accessibilitytes))
        }
    }
    @objc func accessibilitytes() {
        selected.toggle()
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}

let vmMock = DetailViewModel(title: "Spider-Man",
                             description: "Bitten by a radioactive spider, high school student Peter Parker gained the speed, strength and powers of a spider. Adopting the name Spider-Man, Peter hoped to start a career using his new abilities. Taught that with great power comes great responsibility, Spidey has vowed to use his powers to help people.",
                             asset: DSImage.image10)
