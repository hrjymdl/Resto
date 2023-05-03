import UIKit
import Foundation


struct SearchResponse: Codable {
    let recipes: [Recipe]

    enum CodingKeys: String, CodingKey {
        case recipes = "meals"
    }
}

struct Recipe: Codable {
    let id: String
    let recipeName: String
    let instructions: String
    let imageURL: String
    let category: String
    let area: String
    
    private let strIngredient1 : String?
    private let strIngredient2 : String?
    private let strIngredient3 : String?
    private let strIngredient4 : String?
    private let strIngredient5 : String?
    private let strIngredient6 : String?
    private let strIngredient7 : String?
    private let strIngredient8 : String?
    private let strIngredient9 : String?
    private let strIngredient10 : String?
    private let strIngredient11 : String?
    private let strIngredient12 : String?
    private let strIngredient13 : String?
    private let strIngredient14 : String?
    private let strIngredient15 : String?
    private let strIngredient16 : String?
    private let strIngredient17 : String?
    private let strIngredient18 : String?
    private let strIngredient19 : String?
    private let strIngredient20 : String?
    
    private let strMeasure1: String?
    private let strMeasure2: String?
    private let strMeasure3: String?
    private let strMeasure4: String?
    private let strMeasure5: String?
    private let strMeasure6: String?
    private let strMeasure7: String?
    private let strMeasure8: String?
    private let strMeasure9: String?
    private let strMeasure10: String?
    private let strMeasure11: String?
    private let strMeasure12: String?
    private let strMeasure13: String?
    private let strMeasure14: String?
    private let strMeasure15: String?
    private let strMeasure16: String?
    private let strMeasure17: String?
    private let strMeasure18: String?
    private let strMeasure19: String?
    private let strMeasure20: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case recipeName = "strMeal"
        case instructions = "strInstructions"
        case imageURL = "strMealThumb"
        case category = "strCategory"
        case area = "strArea"
        
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        
        
       
    }
}

extension Recipe {
    func getIngredients() -> [[String]] {
        let ingredients : [String] = [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        ].compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false ? $0 : nil }
        print(ingredients)
        print(ingredients.count)
        let measures = self.getMeasures()
        var consolidatedIngredients : [[String]] = []
        for i in 0...(ingredients.count - 1) {
            consolidatedIngredients.append([ingredients[i], measures[i]])
        }
        return consolidatedIngredients
    }
    
    func getMeasures() -> [String] {
        let measures : [String] = [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        ].compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false ? $0 : nil }
        print(measures)
        print(measures.count)
        return measures
    }
}


