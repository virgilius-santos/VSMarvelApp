//
//  DetailViewController.swift
//  VSMarvelApp
//
//  Created by Virgilius Santos on 23/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

struct DetailViewModel {
    let title: String
    let description: String
    let asset: DSAsset
}

class DetailViewController: UIViewController {
    
    let detailView = DSDetailView()
    let viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Layout: do {
            view.addSubview(detailView)
            detailView.snp.makeConstraints {
                $0.edges.equalTo(self.view)
            }
            detailView.setupLayout()
        }
        
        Data: do {
            title = viewModel.title
            detailView.descriptionLabel.text = viewModel.description
            detailView.imageView.image = viewModel.asset.image
            detailView.imageView.heroID = viewModel.asset.name
        }
    }
}
