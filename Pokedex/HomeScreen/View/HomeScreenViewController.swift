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
    }
    
    // MARK: - ViewModel
    private var viewModel: HomeScreenViewModelProtocol
    
    // MARK: - Init
    init(viewModel: HomeScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    private lazy var collectionView: UICollectionView = createCollection()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "What Pokémon are you looking for?"
        searchBar.searchTextField.adjustsFontSizeToFitWidth = true
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.searchTextField.backgroundColor = UIColor.BackgroundColor.backgroundDefaultInput
        searchBar.setImage(UIImage.Icons.search, for: .search, state: .normal)
        searchBar.barTintColor = .white
        searchBar.searchTextField.textColor = .black
        return searchBar
    }()
    
    // MARK: - Private Methods
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

// MARK: - UICollectionViewDataSource
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

// MARK: - UICollectionViewDelegateFlowLayout
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
        view.addSubview(searchBar)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.bottom.leading.trailing.equalTo(view.safeAreaInsets)
        }
        
        searchBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(60)
            $0.width.equalTo(334)
        }
    }
    
    func additionalConfigurations() {
        viewModel.delegate = self
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
    }
    
}

extension HomeScreenViewController: HomeScreenViewModelDelegate {
    func reloadData() {
        self.collectionView.reloadData()
    }
}

extension HomeScreenViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
//        print("offsetY: \(offsetY) | contentHeight: \(contentHeight - scrollView.frame.size.height)")
        if offsetY / (contentHeight - scrollView.frame.size.height) >= 0.5 {
//            print("fetching more data...")
            viewModel.fetchPokemonUrlList(url: viewModel.getNextPageUrl())
        }
    }
}

extension HomeScreenViewController: UISearchBarDelegate {
    
    @objc func searchPokemon(name: String) {
        viewModel.searchPokemon(name: name)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(searchPokemon(name:)),
                                               object: nil)

        perform(#selector(searchPokemon(name:)),
                with: searchBar.searchTextField.text?.lowercased(), afterDelay: 1.0)
        
    }
}
