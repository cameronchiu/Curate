//
//  ContentView.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import SwiftUI
import CoreData

struct RequestsView: View {
    
    @State var requestItems:[Request] = [Request]()
    

    var body: some View {
        ZStack{
            Color("bgColor")
            VStack(spacing: 10){
                Spacer().frame(height: 70)
                TitleView()
                Text("Search________________________________________")
                    .font(.body)
                    .foregroundColor(Color("fgColor"))
                
                GenreSearchList(tags: Genre.allGenres)
                
                Spacer().frame(height: 10)
                
                Text("Recommend a song that...")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color("fgColor"))
    
                
                List(requestItems) { request in
                    RequestListRow(request: request)
                }
                .listStyle(PlainListStyle())
                .onAppear(){
                    // Call for the data
                    requestItems = DataService.requests
                }
 
                
                
            }
            .background(Color.clear)
            
        }
        .ignoresSafeArea()
        .padding(.horizontal, -10)
        .padding(.bottom, 0.1)
        
        
    }

    

    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RequestsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
