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
        let vc = ViewController()
        self.navController.navigate(to: vc)
    }
}

class ViewController: UIViewController, DSNavigationBarStyleable, DSNavigationBarConfigurable {
        
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
