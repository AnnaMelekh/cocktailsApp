//
//  CocktailData.swift
//  cocktailsApp
//
//  Created by Anna Melekhina on 28.02.2025.
//

import Foundation

struct CocktailData: Decodable {
    var ingredients: [String]
    var instructions: String
    var name: String
}
