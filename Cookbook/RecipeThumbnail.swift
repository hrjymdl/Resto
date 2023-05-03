import SwiftUI

struct RecipeThumbnail: View {
    let imageURL : String
    let imageSize : CGFloat = 115
    var body: some View {
        AsyncImage(
            url: URL(string: imageURL + "/preview"),
                        content: { image in
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(maxWidth: imageSize, maxHeight: imageSize)
                                 .cornerRadius(4)
                        },
                        placeholder: {
                            HStack{
                                ProgressView()
                            }
                            .frame(width: imageSize, height: imageSize)
                        }
                    )
        .frame(width: imageSize, height: imageSize, alignment: .leading)
        
    }
}

