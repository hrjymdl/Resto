import SwiftUI

struct MainView: View {
    var body: some View {
       
            TabView {
                
                
                ResultsView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")

                        
                    }
                    .colorScheme(.light)
                
                
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")

                    }
                    .colorScheme(.light)
                    
                
            }
            .accentColor(.black)
            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar, .tabBar)
            .colorScheme(.light)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
