//
//  ExploreView.swift
//  curate
//
//  Created by Cameron Chiu on 6/27/23.
//

import SwiftUI
import SwiftUIIntrospect

struct ExploreView: View {
    
    @EnvironmentObject var spotify: Spotify
    @ObservedObject var content: ContentStream
    @Binding var isExpanded: Bool
    @State private var selectedItemIdx: Int = -1
    @State private var buildCurationViewLoaded = false
    
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    Text("Explore")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("fgColor"))
                    
                    Spacer()
                    Menu{
                        Button(
                            action: {
                                
                            },
                            label: {
                                Text("recommendation")
                            }
                        )
                        Button(
                            action: {
                                buildCurationViewLoaded = true
                                
                            },
                            label: {
                                Text("curation")
                            }
                        )
                        
                    }
                    label:{
                        Image(systemName: "plus.circle")
                            .font(.system(size: 45))
                            .foregroundColor(Color("fgColor"))
                        
                        
                    }
                }
                .padding()
    
                Spacer()
                
            }
            VStack{
                Spacer().frame(height: isExpanded ? 0 : 80)
                ScrollView(){
                    ScrollViewReader{ proxy in
                        LazyVStack{
                            ForEach(content.stream.indices.reversed(), id: \.self){ idx in
                                switch content.stream[idx]{
                                case .musthear(let musthear):
                                    MustHearListRow(mustHear: musthear)
                                        .id(idx)

                                case .request(let request):
                                    RequestListRow(request: request)
                                        .id(idx)
                                        .padding(5)


                                case .curation(let curation):
                                    CurationListRow(itemIdx: idx, selectedItemIdx: $selectedItemIdx, isExpanded: $isExpanded, curation: curation)
                                        .id(idx)
                                        .padding(getPadding(forIndex: idx))
                                }
                                
                                
                            }
                            .onChange(of: isExpanded){ newVal in
                                withAnimation{
                                    proxy.scrollTo(selectedItemIdx, anchor: .center)
                                }
                            }
                        }
                    }
                }
                .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17)){ scrollView in
                    scrollView.isScrollEnabled = !isExpanded
                    
                }
 
//                .scrollDisabled(isExpanded ? true : false)
                .listStyle(PlainListStyle())
                .onAppear(){
                    // Call for the data
                    print("We are initializing the stream")
                    content.initStream()
                }
                
            }
            .sheet(isPresented: $buildCurationViewLoaded){
                BuildCurationView(isPresented: $buildCurationViewLoaded, content: content)
            }
            
            
        }
        
        

    }
    
    func getPadding(forIndex index: Int) -> CGFloat {
        let expand = (index == selectedItemIdx) && isExpanded
        return expand ? 0 : 5
    }
    
}


struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(content: ContentStream(), isExpanded: .constant(false))
    }
}


// Preference key to capture the bounds of the anchor view
struct BoundsPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect? = nil
    
    static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {
        value = value ?? nextValue()
    }
}
