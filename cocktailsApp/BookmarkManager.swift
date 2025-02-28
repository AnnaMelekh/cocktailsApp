//
//  BookmarkManager.swift
//  QuotesApp
//
//  Created by Anna Melekhina on 23.02.2025.
//

import UIKit

class BookmarkManager {
    static let shared = BookmarkManager()
    
    private let key = "savedQuotes"
    
     func getSavedQuotes() -> [CocktailModel] {
        if let data = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            return (try? decoder.decode([CocktailModel].self, from: data)) ?? []
        }
        return []
    }
    
     func saveQuote(_ cocktail: CocktailModel) {
        var quotes = getSavedQuotes()
        if !quotes.contains(where: { $0.name == cocktail.name }) {
            quotes.append(cocktail)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(quotes) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
    
//     func removeQuote(_ quote: CocktailModel) {
//        var quotes = getSavedQuotes().filter { $0.quote != quote.quote }
//        if let encoded = try? JSONEncoder().encode(quotes) {
//            UserDefaults.standard.set(encoded, forKey: key)
//        }
//    }
}
