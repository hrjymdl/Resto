import SwiftUI


struct RecipeRow: View {
    @Binding var recipe : Recipe
    
    var body: some View {
        let rowBody : CGFloat = 18
        HStack {
            RecipeThumbnail(imageURL: recipe.imageURL)
                .padding(.trailing, 10)
            VStack{
                
                HStack{
                    RecipeTag(tag: recipe.category)
                    RecipeTag(tag: recipe.area)
                    Spacer()
                }
                    .padding(.top, 5)
                
        
                HStack {
                    Text(recipe.recipeName)
                        .font(.system(size: rowBody, design: .serif))
                    Spacer()
                }

                 
                Spacer()
            }
        }
            .frame(height: 115)
        

        
    }
        
}

