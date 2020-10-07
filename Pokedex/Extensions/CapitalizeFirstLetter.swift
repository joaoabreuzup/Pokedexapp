//
//  CapitalizeFirstLetter.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 07/10/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
