//
//  Colors.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 02/10/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct typeColor {
        static let bug = UIColor(named: "type-bug")
        static let dark = UIColor(named: "type-dark")
        static let dragon = UIColor(named: "type-dragon")
        static let eletric = UIColor(named: "type-eletric")
        static let fairy = UIColor(named: "type-fairy")
        static let fighting = UIColor(named: "type-fighting")
        static let fire = UIColor(named: "type-fire")
        static let flying = UIColor(named: "type-flying")
        static let ghost = UIColor(named: "type-ghost")
        static let grass = UIColor(named: "type-grass")
        static let ground = UIColor(named: "type-ground")
        static let ice = UIColor(named: "type-ice")
        static let normal = UIColor(named: "type-normal")
        static let poison = UIColor(named: "type-poison")
        static let psychic = UIColor(named: "type-psychic")
        static let rock = UIColor(named: "type-rock")
        static let steel = UIColor(named: "type-steel")
        static let water = UIColor(named: "type-water")
    }
    
    struct backgroundTypeColor {
        static func switchBackgroundTypeColor(type: TypeClass) -> UIColor{
            switch type.name {
            case "bug": return UIColor.backgroundTypeColor.bug ?? UIColor()
            case "dark": return UIColor.backgroundTypeColor.dark ?? UIColor()
            case "dragon": return UIColor.backgroundTypeColor.dragon ?? UIColor()
            case "eletric": return UIColor.backgroundTypeColor.eletric ?? UIColor()
            case "fairy": return UIColor.backgroundTypeColor.fairy ?? UIColor()
            case "fighting": return UIColor.backgroundTypeColor.fighting ?? UIColor()
            case "fire": return UIColor.backgroundTypeColor.fire ?? UIColor()
            case "flying": return UIColor.backgroundTypeColor.flying ?? UIColor()
            case "ghost": return UIColor.backgroundTypeColor.ghost ?? UIColor()
            case "grass": return UIColor.backgroundTypeColor.grass ?? UIColor()
            case "ground": return UIColor.backgroundTypeColor.ground ?? UIColor()
            case "ice": return UIColor.backgroundTypeColor.ice ?? UIColor()
            case "normal": return UIColor.backgroundTypeColor.normal ?? UIColor()
            case "poison": return UIColor.backgroundTypeColor.poison ?? UIColor()
            case "psychic": return UIColor.backgroundTypeColor.psychic ?? UIColor()
            case "rock": return UIColor.backgroundTypeColor.rock ?? UIColor()
            case "steel": return UIColor.backgroundTypeColor.steel ?? UIColor()
            case "water": return UIColor.backgroundTypeColor.water ?? UIColor()
            default: return .white
            }
            
        }
        
        static let bug = UIColor(named: "background-type-bug")
        static let dark = UIColor(named: "background-type-dark")
        static let dragon = UIColor(named: "background-type-dragon")
        static let eletric = UIColor(named: "background-type-eletric")
        static let fairy = UIColor(named: "background-type-fairy")
        static let fighting = UIColor(named: "background-type-fighting")
        static let fire = UIColor(named: "background-type-fire")
        static let flying = UIColor(named: "background-type-flying")
        static let ghost = UIColor(named: "background-type-ghost")
        static let grass = UIColor(named: "background-type-grass")
        static let ground = UIColor(named: "background-type-ground")
        static let ice = UIColor(named: "background-type-ice")
        static let normal = UIColor(named: "background-type-normal")
        static let poison = UIColor(named: "background-type-poison")
        static let psychic = UIColor(named: "background-type-psychic")
        static let rock = UIColor(named: "background-type-rock")
        static let steel = UIColor(named: "background-type-steel")
        static let water = UIColor(named: "background-type-water")
    }
}
