import SwiftUI


struct RecipeDetailsView: View {
    @Binding var recipe: Recipe
    @State var isFavorite : Bool = false
    @Binding var favoriteRecipes : [Recipe]
    @AppStorage("favorites")
    var favorites: Data = Data()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(
                    url: URL(string: recipe.imageURL),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .blur(radius: 2)
                            .cornerRadius(4)
                            .overlay(
                                VStack{
                                    Spacer()
                                    Spacer()
                                    Text(recipe.recipeName)
                                        .font(.system(size: 24, design: .serif))
                                        .foregroundColor(.white)
                                    Spacer()
                                }

                               
                                    
                            )
                    },
                    placeholder: {
                        HStack{
                            ProgressView()
                        }
                        .frame(width: nil, height: 300)
                    }
                )
                .frame(maxWidth: .infinity, maxHeight: 300)
            
                
                VStack(alignment: .leading) {
                    HStack {
                        RecipeTag(tag: recipe.category)
                        RecipeTag(tag: recipe.area)
                        Spacer()
                        Image(systemName: isFavorite ? "star.fill" : "star" )
                            .foregroundColor(isFavorite ? .yellow : .black)
                            .onTapGesture {
                                
                                if isFavorite {
                                    guard let decodedFavorites = try? JSONDecoder().decode([String].self, from: favorites) else { return }
                                    
                                    let newFavorites = decodedFavorites.filter{ $0 != recipe.id}
                                    guard let newFavoritesEncodable = try? JSONEncoder().encode(newFavorites) else { return }
                        
                                    self.favorites = newFavoritesEncodable
                                    isFavorite = !isFavorite
                                    favoriteRecipes = favoriteRecipes.filter{$0.id != recipe.id}
                                    
                                    
                                    
                                    
                                } else {
                                    guard let decodedFavorites = try? JSONDecoder().decode([String].self, from: favorites) else { return }
                                    
                                    var newFavorites = [recipe.id]
                                    newFavorites = newFavorites + decodedFavorites
                                    guard let newFavoritesEncodable = try? JSONEncoder().encode(newFavorites) else { return }
                        
                                    self.favorites = newFavoritesEncodable
                                    isFavorite = !isFavorite
                                    

                                }

                            }
                    }
                        .padding(.top, 10)
                    
                    HStack(alignment: .center){
                        (
                            Text("Ingredients  ")
                                .font(.system(size: 20, design: .serif))
                            +
                            Text(Image(systemName: "gauge"))
                                .font(.system(size: 14, design: .serif))
                                .foregroundColor(.black)
                                .baselineOffset(1.5)
                        )


                        Spacer()
                    }
                        .padding(.top, 10)
                    
                    
                    
                                        VStack(alignment: .leading){
                                            ForEach(recipe.getIngredients(), id: \.self) { item in
                                                HStack(spacing: 0) {
                                                    Text(LocalizedStringKey("\(item[1])"))
                                                        .padding(.bottom, 2)
                                                        .font(.system(size: 14, design: .rounded))
                                                        .textCase(.lowercase)
                                                        .foregroundColor(.gray)
                    
                                                    Text(LocalizedStringKey(" **\(item[0])**"))
                                                        .padding(.bottom, 2)
                                                        .font(.system(size: 14, design: .rounded))
                                                        .textCase(.lowercase)
                                                    Spacer()
                                                }
                                                Divider()
                                                
                                            }
                                           Spacer()
                                            
                                        }
                                            .padding(.top, 10)
                    
                    HStack(alignment: .center){
                        (
                            Text("Instructions  ")
                                .font(.system(size: 20, design: .serif))
                            +
                            Text(Image(systemName: "wand.and.stars"))
                                .font(.system(size: 14, design: .serif))
                                .foregroundColor(.black)
                                .baselineOffset(1.5)
                        )
                        Spacer()
                    }
                        .padding(.top, 20)
                    
                    Text(recipe.instructions)
                        .font(.system(size: 16, design: .rounded))
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                        .lineSpacing(2.5)
        
                }
                .padding(.horizontal, 30)
            }
            
            
        }
        .ignoresSafeArea(edges: .top)
        .toolbarBackground(.visible, for: .navigationBar, .tabBar)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar, .tabBar)
        .onAppear {
           guard let decodedFavorites = try? JSONDecoder().decode([String].self, from: favorites) else { return }
            isFavorite = decodedFavorites.contains(recipe.id)
        }
        .onDisappear {

        }
    }
    
}
    





