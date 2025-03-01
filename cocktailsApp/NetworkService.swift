//
//  NetworkService.swift
//  cocktailsApp
//
//  Created by Anna Melekhina on 28.02.2025.
//

import UIKit

protocol NetworkServiceDelegate {
    func didUpdateData(cocktails: [CocktailModel])
    func didFailWithError(error: Error)
}

struct NetworkService {
    
    
    var delegate: NetworkServiceDelegate?


    func performRequest(name: String? = nil, ingredient: String? = nil, completion: @escaping ([CocktailModel]) -> Void) {
        var components = URLComponents(string: "https://api.api-ninjas.com/v1/cocktail")
           var queryItems: [URLQueryItem] = []
           
           if let name = name, !name.isEmpty {
               queryItems.append(URLQueryItem(name: "name", value: name))
           } else if let ingredient = ingredient, !ingredient.isEmpty {
               queryItems.append(URLQueryItem(name: "ingredients", value: ingredient))
           }
           
           components?.queryItems = queryItems
           
           guard let url = components?.url else {
               print("Invalid URL")
               return
           }
        
        var request = URLRequest(url: url)

        request.setValue("37dzcC9ewolb+jdrMMi3ZQ==rm21imKoXto6vJJd", forHTTPHeaderField: "X-Api-Key")
        let session = URLSession(configuration: .default)
            
             let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Ошибка запроса: \(error.localizedDescription)")
                    return
                }
                
                if let safeData = data {
                    if let cocktailModel = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateData(cocktails: cocktailModel)
                        }
                    }
                }
            }
            
             task.resume()
        }
    
    
    func parseJSON(_ cocktailData: Data) -> [CocktailModel]? {
        let decoder = JSONDecoder()
        
        do {
                let decodedData = try decoder.decode([CocktailData].self, from: cocktailData)
                
                let cockArray = decodedData.map { cocktail in
                    CocktailModel(
                        ingredients: cocktail.ingredients.joined(separator: ",\n"), 
                        instructions: cocktail.instructions,
                        name: cocktail.name
                    )
                }
                
                print(cockArray)
                return cockArray
            
        } catch {
            print("Ошибка декодирования: \(error)")
            return nil
        }
    }
}
