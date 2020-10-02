//
//  HomeScreenCell.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 30/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class HomeScreenCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    private lazy var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var pokemonId: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var pokemonName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var typeSlot1: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var typeSlot2: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Private Methods
    private func downloadImage(from url: URL?) {
        pokemonImage.sd_setImage(with: url)
    }
    
    private func setupPokemonIdLabel(with id: Int) {
        pokemonId.text = "#\(id)"
    }
    
    private func setupPokemonNameLabel(with name: String) {
        pokemonName.text = name
    }
    
    private func setCellBackgroundColor(for type: TypeClass) {
        self.backgroundColor = UIColor.backgroundTypeColor.switchBackgroundTypeColor(type: type)
    }
    
    private func setupTypeImages() {
        
    }
    
    func setupCell(url: URL?, id: Int, name: String, type: TypeClass) {
        downloadImage(from: url)
        setupPokemonIdLabel(with: id)
        setupPokemonNameLabel(with: name)
        setCellBackgroundColor(for: type)
    }
    
}

extension HomeScreenCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(pokemonImage)
        contentView.addSubview(pokemonId)
        contentView.addSubview(pokemonName)
    }
    
    func setupConstraints() {
        pokemonImage.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    func additionalConfigurations() {
        
    }
    
}

