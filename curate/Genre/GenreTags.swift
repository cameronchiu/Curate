//
//  GenreTags.swift
//  curate
//
//  Created by Cameron Chiu on 6/24/23.
//

import SwiftUI

struct GenreTags: View {
    
    var genreTags: [Genre]
    var thresh: CGFloat
    let fontSize: CGFloat = 10.0
    let fontWeight: UIFont.Weight = .heavy
    let horizPad = 7.0
    let horizSpace = 2.0

    var body: some View {

     
        HStack(spacing: 2){
            let truncated = visibleGenreTags(sortedGenreTags())
            ForEach(truncated) { genre in
                Text(genre.name)
                    .padding(.horizontal, 7.0)
                    .padding(.vertical, 2.0)
                    .background(
                        Color("fgColor")
                            .opacity(0.5)
                    )
                    .cornerRadius(15)
                    
            }
            if truncated.count < genreTags.count{
                Text("...")
                    .padding(.horizontal, 7.0)
                    .padding(.vertical, 2.0)
                    .background(
                        Color("fgColor")
                            .opacity(0.5)
                    )
                    .cornerRadius(15)
            }
            
                
        }
        
        .fontWeight(.heavy)
        .foregroundColor(Color("bgColor"))
        .font(.system(size: fontSize))
        .lineLimit(1)
            
        
        
        
            
    }
    func sortedGenreTags() -> [Genre]{
         return genreTags.sorted { getTextSize($0.name) < getTextSize($1.name) }
    }
    // accounts for padding
    func getTextSize(_ text: String) -> CGFloat{
        return text.size(withAttributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)]).width + horizPad * 2
    }
    func visibleGenreTags(_ genres: [Genre]) -> [Genre] {
        var widthSum = getTextSize("...")
        var endIdx = 0
        for i in (0..<genres.count){
            let genreTextWidth = getTextSize(genres[i].name)
            widthSum += genreTextWidth + horizSpace
            if widthSum <= thresh{
                endIdx += 1
            }
            
        }
        return Array(genres[0..<endIdx])
    }
    

}

struct GenreTags_Previews: PreviewProvider {
    static var previews: some View {
        GenreTags(genreTags: Genre.allGenres, thresh: 147)
    }
}
