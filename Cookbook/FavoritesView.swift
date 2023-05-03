import SwiftUI


struct FavoritesView: View {
    
    @AppStorage("favorites")
    var favorites: Data = Data()
    @State var favoriteRecipes : [Recipe]  = []
    @State var decodedFavoritesSnapshot : [String] = []
    @State var firstLoad : Bool = true
    var body: some View {
        let recipeService = RecipeService()
        NavigationStack {
            
            
            if favoriteRecipes.count == 0 {

                Text("Your favorites will show up here.")
                    .padding(.top, 80)
            }
            List($favoriteRecipes, id: \.self.id){ recipe in
                NavigationLink(destination: RecipeDetailsView(recipe: recipe, favoriteRecipes: $favoriteRecipes)) {
                    RecipeRow(recipe: recipe)
                }
                .listRowSeparator(.hidden)
                .listStyle(.plain)
                .listRowSeparator(.hidden)
                .navigationTitle("")
                .toolbarBackground(.visible, for: .navigationBar, .tabBar)
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar, .tabBar)
            }
            .background(.white)
            .padding(.top, 0)
            .listStyle(.plain)
            .navigationBarHidden(true)
          
        }        .onAppear() {
            
            
            guard let decodedFavorites = try? JSONDecoder().decode([String].self, from: favorites) else { return }
                        
            if firstLoad && decodedFavorites != decodedFavoritesSnapshot {
                firstLoad = false
                decodedFavoritesSnapshot = decodedFavorites
                favoriteRecipes = []
                (decodedFavorites).forEach {
                    storedFave in
                    recipeService.makeAPIcall(searchQuery: storedFave, queryType: RecipeService.QueryType.byId){ (recipes, responseType) in
                        
                        if responseType == RecipeService.ResponseType.successful {
                            favoriteRecipes.append(recipes[0])
                        }
                    }
                }
                
            }
            
            
        }
        .onDisappear {
            firstLoad = true
        }
    }
}

