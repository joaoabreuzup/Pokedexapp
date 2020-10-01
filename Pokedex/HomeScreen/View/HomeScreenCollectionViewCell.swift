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
    private lazy var image: UIImageView = {
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
    
    // MARK: - Methods
    private func downloadImage(from url: URL?) {
        image.sd_setImage(with: url)
    }
    
    private func setPokemonIdLabel(with id: Int) {
        pokemonId.text = "#\(id)"
    }
    
    private func setPokemonNameLabel(with name: String) {
        pokemonName.text = name
    }
    
    func setupCell(url: URL?, id: Int, name: String) {
        downloadImage(from: url)
        setPokemonIdLabel(with: id)
        setPokemonNameLabel(with: name)
    }
    
}

extension HomeScreenCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(image)
        contentView.addSubview(pokemonId)
        contentView.addSubview(pokemonName)
    }
    
    func setupConstraints() {
        
    }
    
    func additionalConfigurations() {
        backgroundColor = .red
    }
    
}

