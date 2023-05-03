import SwiftUI


private func tagColor(tag : String) -> Color {
    switch tag {
    case "Seafood" : return Color.blue
    case "Pork" : return Color.pink
    case "Beef" : return Color.brown
    case "Vegetarian" : return Color.green
    case "Chicken" : return Color.yellow
    case "Side" : return Color.orange
    case "Starter" : return Color.indigo
    case "Lamb" : return Color.red
    case "Dessert" : return Color.mint
    default: return Color.black
    }
}

struct RecipeTag: View {
    let tag : String
    var body: some View {
        Capsule()
            .fill(
                tagColor(tag: tag)
            )
            .overlay(
                Text(tag)
                    .font(.system(size: 10, design: .rounded))
                    .foregroundColor(.white)
            )
            .frame(width: 11 + (CGFloat(max(tag.count, 5) * 6)), height: 20)
    }
}

