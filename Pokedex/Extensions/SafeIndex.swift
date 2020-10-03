//
//  SafeIndex.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 02/10/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
