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
    
    private lazy var pokemonType1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var pokemonType2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
    
    private func setCellBackgroundColor(for types: [Types]) {
        backgroundColor = UIColor.BackgroundTypeColor.switchBackgroundTypeColor(type: types.first?.type ?? TypeClass(name: nil))
    }
    
    private func setupTypeImages(for types: [Types]) {
        if types.count > 1 {
            pokemonType1.image = UIImage.Badges.switchBadgeImage(type: types.first?.type ?? TypeClass(name: nil))
            pokemonType2.image = UIImage.Badges.switchBadgeImage(type: types[safe: 1]?.type ?? TypeClass(name: nil))
        } else {
            pokemonType1.image = UIImage.Badges.switchBadgeImage(type: types.first?.type ?? TypeClass(name: nil))
        }
    }
    
    private func pokemonType2IsNil() -> Bool {
        if pokemonType2.image == nil {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Constraint Methods
    private func setupPokemonImageConstraints() {
        pokemonImage.snp.makeConstraints {
            $0.width.height.equalTo(130)
            $0.trailing.equalTo(contentView.snp.trailing).inset(10)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
    }
    
    private func setupPokemonType1ImageConstraints() {
        pokemonType1.snp.makeConstraints {
            $0.width.equalTo(61)
            $0.height.equalTo(25)
            $0.leading.bottom.equalTo(contentView).inset(10)
        }
    }
    
    private func setupPokemonType2ImageConstraints() {
        pokemonType2.snp.makeConstraints {
            $0.width.equalTo(61)
            $0.height.equalTo(25)
            $0.leading.equalTo(pokemonType1.snp.trailing).offset(5)
            $0.bottom.equalTo(contentView).inset(10)
        }
    }
    
    // MARK: - setupCell
    func setupCell(url: URL?, id: Int, name: String, types: [Types]) {
        downloadImage(from: url)
        setupPokemonIdLabel(with: id)
        setupPokemonNameLabel(with: name)
        setCellBackgroundColor(for: types)
        setupTypeImages(for: types)
    }
    
}

extension HomeScreenCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(pokemonImage)
        contentView.addSubview(pokemonId)
        contentView.addSubview(pokemonName)
        contentView.addSubview(pokemonType1)
        if !pokemonType2IsNil() {
            contentView.addSubview(pokemonType2)
        }
    }
    
    func setupConstraints() {
        setupPokemonImageConstraints()
        setupPokemonType1ImageConstraints()
        if !pokemonType2IsNil() {
            setupPokemonType2ImageConstraints()
        }
    }
    
    func additionalConfigurations() {
    
    }
    
}

