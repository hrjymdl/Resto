import SwiftUI

struct Searchbar: View {
    let possibleTextValues = [
        "Irish Stew",
        "Sushi",
        "Montreal Smoked Meat",
        "Chicken Couscous",
        "Thai Green Curry",
        "Salmon Prawn Risotto",
        "Duck Confit"
    ]
    
    @State var currentTextValue = "Spaghetti Bolognese"
    @Binding var searchQuery : String
    @Binding var recipes : [Recipe]
    @Binding var searchStatus : ResultsView.status
    @Binding var lastSearchQuery : String
    var body: some View {
        let recipeService = RecipeService()
        
        VStack(alignment: .leading) {
            Spacer()
            HStack(alignment: .center, spacing: 0){
                Text(Image(systemName: "magnifyingglass"))
                    .font(.system(size: 10, design: .rounded))
                    .foregroundColor(.black)
                TextField(currentTextValue, text: $searchQuery)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 3)
                    .font(.system(size: 14, design: .rounded))
                    .foregroundColor(.black)
                    .overlay(VStack{Divider().offset(x: 0, y: 20)})
                    .accentColor(.yellow)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 0.9, repeats: true) { _ in
                            let randomIndex = Int.random(in: 0..<self.possibleTextValues.count)
                            self.currentTextValue = self.possibleTextValues[randomIndex]
                        }
                    }
                    .onSubmit {
                        

                        if !searchQuery.isEmpty{
                            searchStatus = ResultsView.status.ongoing
                            lastSearchQuery = searchQuery
                            recipes = []
                            
                            recipeService.makeAPIcall(searchQuery: searchQuery, queryType: RecipeService.QueryType.byName) { (recipes, responseType) in
                                
                                if responseType == RecipeService.ResponseType.successful {
                                    self.searchStatus = ResultsView.status.success
                                    self.recipes = recipes
                                }
                                
                                if responseType == RecipeService.ResponseType.empty {
                                    self.searchStatus = ResultsView.status.emptyresponse
                                    self.recipes = recipes
                                }
                                
                                
                            }
                        }
                
                    }
                
            }
            .padding(.horizontal, 5)
            .background(.gray)
            .cornerRadius(10)
            .frame(height: 40)
            
           


        }
        .padding(.horizontal, 10)
        .frame(width: nil, height: 70)
        .background(Color.yellow.ignoresSafeArea(edges: .top))

    }
        
}
