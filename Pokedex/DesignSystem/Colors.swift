//
//  Colors.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 02/10/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct TypeColor {
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
    
    struct BackgroundTypeColor {
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
        
        static func switchBackgroundTypeColor(type: TypeClass?) -> UIColor {
            switch type?.name {
            case "bug": return UIColor.BackgroundTypeColor.bug ?? UIColor()
            case "dark": return UIColor.BackgroundTypeColor.dark ?? UIColor()
            case "dragon": return UIColor.BackgroundTypeColor.dragon ?? UIColor()
            case "eletric": return UIColor.BackgroundTypeColor.eletric ?? UIColor()
            case "fairy": return UIColor.BackgroundTypeColor.fairy ?? UIColor()
            case "fighting": return UIColor.BackgroundTypeColor.fighting ?? UIColor()
            case "fire": return UIColor.BackgroundTypeColor.fire ?? UIColor()
            case "flying": return UIColor.BackgroundTypeColor.flying ?? UIColor()
            case "ghost": return UIColor.BackgroundTypeColor.ghost ?? UIColor()
            case "grass": return UIColor.BackgroundTypeColor.grass ?? UIColor()
            case "ground": return UIColor.BackgroundTypeColor.ground ?? UIColor()
            case "ice": return UIColor.BackgroundTypeColor.ice ?? UIColor()
            case "normal": return UIColor.BackgroundTypeColor.normal ?? UIColor()
            case "poison": return UIColor.BackgroundTypeColor.poison ?? UIColor()
            case "psychic": return UIColor.BackgroundTypeColor.psychic ?? UIColor()
            case "rock": return UIColor.BackgroundTypeColor.rock ?? UIColor()
            case "steel": return UIColor.BackgroundTypeColor.steel ?? UIColor()
            case "water": return UIColor.BackgroundTypeColor.water ?? UIColor()
            default: return .white
            }
        }
    }
    
    struct TextColor {
        static let textWhite = UIColor(named: "text-white")
        static let textBlack = UIColor(named: "text-black")
        static let textGrey = UIColor(named: "text-grey")
        static let textNumber = UIColor(named: "text-number")
    }
    
    struct BackgroundColor {
        static let backgroundWhite = UIColor(named: "background-white")
        static let backgroundrPessedInput = UIColor(named: "background-pressed-input")
        static let backgroundModal = UIColor(named: "background-modal")
        static let backgroundDefaultInput = UIColor(named: "background-default-input")
    }
    
    struct GradientColor {
        static let pokeballGreyTopLeft = UIColor(named: "gradient-pokeball-grey-top-left")
        static let pokeballGreyBottomRight = UIColor(named: "gradient-pokeball-grey-bottom-right")
        static let pokeballCenterCenter = UIColor(named: "gradient-pokeball-center-center")
        static let pokeballBottomCenter = UIColor(named: "gradient-pokeball-bottom-center")
    }
    
}
