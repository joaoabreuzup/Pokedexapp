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
    
    static let reuseIdentifier = "customCell"
    
    private var type: TypeClass? {
        didSet {
            backgroundColor = UIColor.BackgroundTypeColor.switchBackgroundTypeColor(type: type)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.BackgroundTypeColor.switchBackgroundTypeColor(type: type).cgColor
    }
    
    // MARK: - Views
    private lazy var pokeballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pokeballGradient")
        return imageView
    }()
    
    private lazy var patternImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pattern")
        return imageView
    }()
    
    private lazy var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var pokemonId: UILabel = {
        let label = UILabel()
        label.font = UIFont.pokemonNumber
        label.textColor = UIColor.TextColor.textNumber
        return label
    }()
    
    private lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.font = UIFont.pokemonName
        label.textColor = UIColor.TextColor.textWhite
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
    
    private func numberMask(id: Int) -> String {
        let number = String(id)
        let numberOfCharacters = number.count
        switch numberOfCharacters {
        case 1: return "#00\(number)"
        case 2: return "#0\(number)"
        default: return "#\(number)"
        }
    }
    
    private func downloadImage(from url: URL?) {
        pokemonImage.sd_setImage(with: url)
    }
    
    private func setupPokemonIdLabel(with id: Int) {
        pokemonId.text = numberMask(id: id)
    }
    
    private func setupPokemonNameLabel(with name: String) {
        pokemonName.text = name
    }
    
    private func setCellBackgroundColor(for types: [Types]) {
        type = types.first?.type
        
    }
    
    private func setupTypeImages(for types: [Types]) {
        if types.count > 1 {
            pokemonType1.image = UIImage.Badges.switchBadgeImage(type: types.first?.type ?? TypeClass(name: nil))
            pokemonType2.image = UIImage.Badges.switchBadgeImage(type: types[safe: 1]?.type ?? TypeClass(name: nil))
            pokemonType2.isHidden = false
        } else {
            pokemonType1.image = UIImage.Badges.switchBadgeImage(type: types.first?.type ?? TypeClass(name: nil))
            pokemonType2.isHidden = true
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
    private func setupPokemonIdConstraints() {
        pokemonId.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(20)
            $0.leading.equalTo(contentView.snp.leading).inset(20)
        }
    }
    
    private func setupPokemonNameConstraints() {
        pokemonName.snp.makeConstraints {
            $0.top.equalTo(pokemonId.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading).inset(20)
        }
    }
    
    private func setupPokemonType1ImageConstraints() {
        pokemonType1.snp.makeConstraints {
            $0.width.equalTo(61)
            $0.height.equalTo(25)
            $0.top.equalTo(pokemonName.snp.bottom).offset(5)
            $0.leading.equalTo(contentView.snp.leading).inset(20)
        }
    }
    
    private func setupPokemonType2ImageConstraints() {
        pokemonType2.snp.makeConstraints {
            $0.width.equalTo(61)
            $0.height.equalTo(25)
            $0.top.equalTo(pokemonName.snp.bottom).offset(5)
            $0.leading.equalTo(pokemonType1.snp.trailing).offset(5)
        }
    }
    
    private func setupPokemonImageConstraints() {
        pokemonImage.snp.makeConstraints {
            $0.width.height.equalTo(130)
            $0.trailing.equalTo(contentView.snp.trailing).inset(10)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
    }
    
    private func setupPokeballImageConstraints() {
        pokeballImage.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(130)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.top.equalTo(contentView.snp.top)
        }
    }
    
    private func setupPatternImageConstraints() {
        patternImage.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(5)
            $0.width.equalTo(74)
            $0.height.equalTo(32)
            $0.leading.equalTo(pokemonId.snp.trailing).offset(40)
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
        contentView.addSubview(pokemonType2)
        insertSubview(pokeballImage, at: 0)
        contentView.addSubview(patternImage)
    }
    
    func setupConstraints() {
        setupPokemonIdConstraints()
        setupPokemonNameConstraints()
        setupPokemonType1ImageConstraints()
        setupPokemonType2ImageConstraints()
        setupPokemonImageConstraints()
        setupPokeballImageConstraints()
        setupPatternImageConstraints()
        
    }
    
    func additionalConfigurations() {
        layer.cornerRadius = 10
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
    }
    
}

