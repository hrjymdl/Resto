
import Foundation


class RecipeService {
    enum ResponseType {
        case successful
        case empty
    }
    
    enum QueryType {
        case byName
        case byId
    }
    
    

    
    func makeAPIcall(searchQuery: String, queryType: QueryType, completion: @escaping ([Recipe],ResponseType) -> Void){

        var queryParam = ""
        var domain = ""
        
        switch queryType {
        case .byName:
            domain = "https://www.themealdb.com/api/json/v1/1/search.php"
            queryParam = "s"
        case .byId:
            domain = "https://www.themealdb.com/api/json/v1/1/lookup.php"
            queryParam = "i"
        }

        
        guard let baseURL = URL(string: domain) else { return }
        var url = baseURL
        url.append(queryItems: [
            URLQueryItem(name: queryParam, value: searchQuery),
        ])

        print(url)
        let task = URLSession.shared.dataTask(with: url) {

            data, response, error in print("Done with call")
            if let error = error {
                print("Error with API call: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response(\(String(describing:response))")
                return
            }

            if let data = data,
               let response = try? JSONDecoder().decode(SearchResponse.self, from: data){
                print(response.recipes)
                print(type(of:response))
                DispatchQueue.main.async {
                    completion(response.recipes, ResponseType.successful)
                }

            } else {
                DispatchQueue.main.async {
                    let emptyResponse : [Recipe] = []
                    completion(emptyResponse, ResponseType.empty)
                }
                
            }
        }
        task.resume()
    }
    

    func getFavorites(favorites: [String]) -> [Recipe] {
        var favoriteRecipes : [Recipe] = []
        for favorite in favorites {
             self.makeAPIcall(searchQuery: favorite, queryType: QueryType.byId){ (recipes, responseType) in
                
                if responseType == RecipeService.ResponseType.successful {
                    
                    favoriteRecipes.append(recipes[0])
                }
            }
        }

        
        return favoriteRecipes
        
        
    }
    
}
