//
//  HeaderCollectionView.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 19/10/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit

class HeaderCollectionView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let reuseIdentifier = "headerIdentifier"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Pokédex"
        label.font = UIFont.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.text = "Search for Pokémon by name or using the National Pokédex Number."
        label.textColor = UIColor.TextColor.textGrey
        label.font = UIFont.description
        label.sizeToFit()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "What Pokémon are you looking for?"
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private lazy var pokeballImage: UIImageView = {
        let image = UIImageView(image: UIImage.Components.pokeballHome)
        return image
    }()
    
    private lazy var generationImage: UIImageView = {
        let image = UIImageView(image: UIImage.Icons.generation)
        return image
    }()
    
    private lazy var sortImage: UIImageView = {
        let image = UIImageView(image: UIImage.Icons.sort)
        return image
    }()
    
    private lazy var filterImage: UIImageView = {
        let image = UIImageView(image: UIImage.Icons.filter)
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 25
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
}

extension HeaderCollectionView: ViewCode {
    func buildViewHierarchy() {
        insertSubview(pokeballImage, at: 0)
        addSubview(title)
        addSubview(subtitle)
        addSubview(searchBar)
        addSubview(stackView)
        stackView.addArrangedSubview(generationImage)
        stackView.addArrangedSubview(sortImage)
        stackView.addArrangedSubview(filterImage)
    }
    
    func setupConstraints() {
        pokeballImage.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(0)
            $0.height.equalTo(200)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(100)
            $0.leading.equalTo(snp.leading).offset(40)
            $0.height.equalTo(38)
            $0.width.equalTo(334)
        }
        
        subtitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(10)
            $0.leading.equalTo(snp.leading).offset(40)
            $0.height.equalTo(45)
            $0.width.equalTo(334)
            
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(subtitle.snp.bottom).offset(25)
            $0.leading.equalTo(snp.leading).offset(40)
            $0.height.equalTo(60)
            $0.width.equalTo(334)
        }
        
        generationImage.snp.makeConstraints {
            $0.height.width.equalTo(20)
        }
        
        sortImage.snp.makeConstraints {
            $0.height.width.equalTo(20)
        }
        
        filterImage.snp.makeConstraints {
            $0.height.width.equalTo(20)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(15)
            $0.trailing.equalTo(snp.trailing).inset(30)
        }
    }

}

extension HeaderCollectionView: UISearchBarDelegate {
    
}
