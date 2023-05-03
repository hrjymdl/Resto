import SwiftUI


let values = ["hey", "heyyy", "hello"]
struct ResultsView: View {
    enum status {
        case notstarted
        case ongoing
        case emptyresponse
        case success
    }
    @State var searchStatus = status.notstarted
    @State var searchQuery = ""
    @State var recipes : [Recipe] = []
    @State var lastSearchQuery = ""
    @State var favoriteRecipes : [Recipe] = []
    
    var body: some View {
        

        VStack{
            
            VStack(spacing: 0) {
                    Spacer()

                    
                NavigationStack() {

                    Searchbar(
                        searchQuery: $searchQuery,
                        recipes: $recipes,
                        searchStatus: $searchStatus,
                        lastSearchQuery: $lastSearchQuery
                    )

                    Spacer()

                    if  searchStatus == status.success {
                        
                        List($recipes, id: \.self.id){ recipe in
                            NavigationLink(destination: RecipeDetailsView(recipe: recipe, favoriteRecipes: $favoriteRecipes)) {
                                    RecipeRow(recipe: recipe)
                            }
                            .listRowSeparator(.hidden)
                            .navigationTitle("")
                            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
                            .toolbarBackground(.ultraThinMaterial, for: .navigationBar, .tabBar)
                            

                                                            
                        }

                        .padding(.top, 0)
                        .listStyle(.plain)
                        .navigationBarHidden(true)
                        
                        
                        recipes.count == 1 ?
                        Text("\(recipes.count) result")
                            .padding(.bottom, 10)
                            .foregroundColor(Color.gray)
                        :
                        Text("\(recipes.count) results")
                            .padding(.bottom, 10)
                            .foregroundColor(Color.gray)
                        
                        
                        
                        }
                    
                    
                    else if searchStatus == status.notstarted {
                            Text("What are you craving?")
                            .font(.system(size: 20, design: .rounded))
                            Spacer()
                            Spacer()
                    }
                    else if searchStatus == status.emptyresponse {
                        
                            Text("No results for \"\(lastSearchQuery)\"")
                            .font(.system(size: 15, design: .rounded))
                            Spacer()
                            Spacer()
                    }
                    else if searchStatus == status.ongoing {
                        HStack{
                            ProgressView()
                        }
                        Spacer()
                    }
                    }

                    .accentColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                

                }
                .padding(.top, 0)
                .background(.white)
                
                .transition(.slide)
        }
        .ignoresSafeArea(edges: .top)
        .background(Color.green.ignoresSafeArea(edges: .top))
        .toolbarBackground(.visible, for: .navigationBar, .tabBar)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar, .tabBar)

        
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
