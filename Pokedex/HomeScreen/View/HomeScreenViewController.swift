//
//  HomeScreenView.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 30/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        setupView()
        viewModel.fetchPokemonUrlList()
    }
    
    private var viewModel: HomeScreenViewModelProtocol
    
    init(viewModel: HomeScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = createCollection()
    
    private func createCollection() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 40
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(HomeScreenCollectionViewCell.self, forCellWithReuseIdentifier: "customCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .init(top: 40, left: 0, bottom: 40, right: 0)
        return collectionView
    }
    
}

extension HomeScreenViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.getPokemonListCount()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath)
        if let customCell = cell as? HomeScreenCollectionViewCell {
            customCell.setupCell(
                url: viewModel.getPokemonImageUrl(indexPathRow: indexPath.row),
                id: viewModel.getPokemonId(indexPathRow: indexPath.row),
                name: viewModel.getPokemonName(indexPathRow: indexPath.row),
                types: viewModel.getPokemonTypes(indexPathRow: indexPath.row)
            )
        }
        return cell
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 334, height: 115)
    }
}

extension HomeScreenViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.bottom.leading.trailing.equalTo(view.safeAreaInsets)
        }
    }
    
    func additionalConfigurations() {
        viewModel.delegate = self
        collectionView.backgroundColor = .white
    }
    
}

extension HomeScreenViewController: HomeScreenViewModelDelegate {
    func reloadData() {
        self.collectionView.reloadData()
    }
}
