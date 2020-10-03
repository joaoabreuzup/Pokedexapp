//
//  Images.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 02/10/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit

extension UIImage {
    
    struct Badges {
        static let bug = UIImage(named: "bug")
        static let dark = UIImage(named: "dark")
        static let dragon = UIImage(named: "dragon")
        static let eletric = UIImage(named: "eletric")
        static let fairy = UIImage(named: "fairy")
        static let fighting = UIImage(named: "fighting")
        static let fire = UIImage(named: "fire")
        static let flying = UIImage(named: "flying")
        static let ghost = UIImage(named: "ghost")
        static let grass = UIImage(named: "grass")
        static let ground = UIImage(named: "ground")
        static let ice = UIImage(named: "ice")
        static let normal = UIImage(named: "normal")
        static let poison = UIImage(named: "poison")
        static let psychic = UIImage(named: "psychic")
        static let rock = UIImage(named: "rock")
        static let steel = UIImage(named: "steel")
        static let water = UIImage(named: "water")
        
        static func switchBadgeImage(type: TypeClass) -> UIImage {
            switch type.name {
            case "bug": return UIImage.Badges.bug ?? UIImage()
            case "dark": return UIImage.Badges.dark ?? UIImage()
            case "dragon": return UIImage.Badges.dragon ?? UIImage()
            case "eletric": return UIImage.Badges.eletric ?? UIImage()
            case "fairy": return UIImage.Badges.fairy ?? UIImage()
            case "fighting": return UIImage.Badges.fighting ?? UIImage()
            case "fire": return UIImage.Badges.fire ?? UIImage()
            case "flying": return UIImage.Badges.flying ?? UIImage()
            case "ghost": return UIImage.Badges.ghost ?? UIImage()
            case "grass": return UIImage.Badges.grass ?? UIImage()
            case "ground": return UIImage.Badges.ground ?? UIImage()
            case "ice": return UIImage.Badges.ice ?? UIImage()
            case "normal": return UIImage.Badges.normal ?? UIImage()
            case "poison": return UIImage.Badges.poison ?? UIImage()
            case "psychic": return UIImage.Badges.psychic ?? UIImage()
            case "rock": return UIImage.Badges.rock ?? UIImage()
            case "steel": return UIImage.Badges.steel ?? UIImage()
            case "water": return UIImage.Badges.water ?? UIImage()
            default: return UIImage()
            }
        }
    }
    
}
