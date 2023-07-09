//
//  Content.swift
//  curate
//
//  Created by Cameron Chiu on 6/28/23.
//

import Foundation

class ContentStream: ObservableObject{
    @Published var stream: [Content]
    static var perm_stream: [Content] = Curation.getAllCurations().map{.curation($0)}
    
//    static var stream: [Content] = Curation.getAllCurations().map{.curation($0)}
    
    func initStream(){
        if self.stream.isEmpty{
            print("fetching from DB")
            let curations = Curation.getAllCurations()
            self.stream = curations.map{.curation($0)}
        }
    }
    
    init(){
        print("relinking perm")
        self.stream = ContentStream.perm_stream
    }
    
    

}

enum Content: Identifiable{
    case musthear(MustHear)
    case request(Request)
    case curation(Curation)
    
    var id: UUID {
        switch self {
        case .musthear(let musthear):
            return musthear.id
        case .request(let request):
            return request.id
        case .curation(let curation):
            return curation.id
        }
    }
}
