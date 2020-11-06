//
//  HomeScreenView.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 30/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        setupView()
        viewModel.fetchPokemonUrlList(url: Urls.pokemonListUrl)
        viewModel.collectionViewModel = collectionViewModel
    }
    
    // MARK: - ViewModel
    private var viewModel: HomeScreenViewModelProtocol
    private var collectionViewModel: CollectionViewModel
    
    // MARK: - Init
    init(viewModel: HomeScreenViewModelProtocol, collectionViewModel: CollectionViewModel) {
        self.viewModel = viewModel
        self.collectionViewModel = collectionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    private lazy var collectionView: UICollectionView = createCollection()
    
    // MARK: - Private Methods
    private func createCollection() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 40
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(HomeScreenCollectionViewCell.self, forCellWithReuseIdentifier: HomeScreenCollectionViewCell.reuseIdentifier)
        collectionView.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 40, right: 0)
        return collectionView
    }
    
}

// MARK: - UICollectionViewDataSource
extension HomeScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewModel.getPokemonListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 321)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier, for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath)
        if let customCell = cell as? HomeScreenCollectionViewCell {
            customCell.setupCell(
                url: collectionViewModel.getPokemonImageUrl(indexPathRow: indexPath.row),
                id: collectionViewModel.getPokemonId(indexPathRow: indexPath.row),
                name: collectionViewModel.getPokemonName(indexPathRow: indexPath.row),
                types: collectionViewModel.getPokemonTypes(indexPathRow: indexPath.row)
            )
        }
        return cell
    }
    
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 334, height: 115)
    }
}

extension HomeScreenViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.bottom.leading.trailing.equalTo(view.safeAreaInsets)
        }
    }
    
    func additionalConfigurations() {
        collectionViewModel.delegate = self
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
    }
    
}

extension HomeScreenViewController: CollectionViewModelDelegate {
    func reloadData() {
        self.collectionView.reloadData()
    }
}

extension HomeScreenViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY / (contentHeight - scrollView.frame.size.height) >= 0.8 {
            viewModel.fetchPokemonUrlList(url: viewModel.getNextPageUrl())
        }
    }
}

//extension HomeScreenViewController: UISearchBarDelegate {
//
//    @objc func searchPokemon(name: String) {
//        viewModel.searchPokemon(name: name)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        NSObject.cancelPreviousPerformRequests(withTarget: self,
//                                               selector: #selector(searchPokemon(name:)),
//                                               object: nil)
//
//        perform(#selector(searchPokemon(name:)),
//                with: searchBar.searchTextField.text?.lowercased(), afterDelay: 1.0)
//
//    }
//}
