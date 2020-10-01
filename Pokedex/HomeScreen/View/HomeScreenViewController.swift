//
//  HomeScreenView.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 30/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    private var viewModel: HomeScreenViewModelProtocol
    
    init(viewModel: HomeScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private lazy var collectionView: UICollectionView = {
//        
//    }()
    
}
