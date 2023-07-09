//
//  GenreSearchList.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//


import SwiftUI

struct GenreSearchList: View {
    
    private var horizPad = 25.0
    var body: some View {
        HStack{
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(Genre.allGenres){ genre in
                        Text(genre.name)
                            .fontWeight(.bold)
                            .padding(.horizontal, 10.0)
                            .padding(.vertical, 2.0)
                            .background(
                                Color("fgColor")
                                    .opacity(0.5)
                            )
                            .cornerRadius(15)
                            .foregroundColor(Color("bgColor"))
                            .font(.subheadline)
                            .listRowInsets(EdgeInsets())
                        
                    }
                }
            }
            
        }
        .padding(.horizontal, horizPad)
    }
}

struct GenreSearchList_Previews: PreviewProvider {
    static var previews: some View {
        GenreSearchList()
    }
}
