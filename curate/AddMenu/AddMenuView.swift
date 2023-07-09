//
//  AddMenuView.swift
//  curate
//
//  Created by Cameron Chiu on 6/27/23.
//

import SwiftUI

struct AddMenuView: View {
    var body: some View {
        ZStack{
            Color("fgColor")
            VStack(alignment: .center){
                Spacer()
                // Recommendation
                Button(
                    action: {
                        
                    },
                    label: {
                        Text("recommendation")
                            .fontWeight(.light)
                            .bold()
                            .foregroundColor(Color("bgColor"))
                            .font(.title2)
                    }
                )
                
                Spacer()
                Divider()
                    .frame(width: 150.0, height: 1.0)
                    .overlay(.gray)
                Spacer()

                
                // Curation
                Button(
                    action: {
                        
                    },
                    label: {
                        Text("curation")
                            .fontWeight(.light)
                            .bold()
                            .foregroundColor(Color("bgColor"))
                            .font(.title2)
                    }
                )
                Spacer()

            }
            
        }
        
        .padding()
        .navigationBarHidden(true)
        
    }
}

struct AddMenuView_Previews: PreviewProvider {
    static var previews: some View {
        AddMenuView()
    }
}
