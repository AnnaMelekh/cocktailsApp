//
//  CocktailModel.swift
//  cocktailsApp
//
//  Created by Anna Melekhina on 28.02.2025.
//

import UIKit

struct CocktailModel: Codable, Equatable {
    var ingredients: String
    var instructions: String
    var name: String
}
