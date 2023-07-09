//
//  DiscoverView.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import SwiftUI
//import UIImageColors

struct DiscoverView: View {
    
    @State var pairingItems:[Curation] = [Curation]()
    
    
    var body: some View {
        ZStack{
            Color("bgColor")
            VStack(spacing: 10){
                Spacer().frame(height: 70)
                TitleView()
                Text("Search________________________________________")
                    .font(.body)
                    .foregroundColor(Color("fgColor"))
                
                GenreSearchList()
    
                
                Spacer().frame(height: 10)
                
                Text("Here's a song that...")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color("fgColor"))
                
                
                List(pairingItems) { pair in
                    CurationListRow(pairing: pair)
                }
                .listStyle(PlainListStyle())
                .onAppear(){
                    // Call for the data
                    pairingItems = DataService.pairings
                }
               
 
                
                
            }
            .background(Color.clear)
            
        }
        .ignoresSafeArea()
        .padding(.horizontal, -10)
        .padding(.bottom, 0.1)
    }
        
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
