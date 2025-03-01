//
//  Ingreds.swift
//  cocktailsApp
//
//  Created by Anna Melekhina on 01.03.2025.
//


import UIKit

enum Ingredient: String, CaseIterable {
    case vodka = "Vodka"
    case gin = "Gin"
    case tequila = "Tequila"
    case mint = "Mint"
    case apple = "Apple"
    case orange = "Orange"
    case grenadine = "Grenadine"
    case eggs = "Eggs"
    case coffee = "Coffee"
    case vanilla = "Vanilla"
    
    var image: UIImage? {
        switch self {
        case .vodka:
            return UIImage(named: "vodka")
        case .gin:
            return UIImage(named: "gin")
        case .tequila:
            return UIImage(named: "tequila")
        case .mint:
            return UIImage(named: "mint")
        case .apple:
            return UIImage(named: "apple")
        case .orange:
            return UIImage(named: "orange")
        case .grenadine:
            return UIImage(named: "grenadine")
        case .eggs:
            return UIImage(named: "eggs")
        case .coffee:
            return UIImage(named: "coffee")
        case .vanilla:
            return UIImage(named: "vanilla")
        }
    }
}
