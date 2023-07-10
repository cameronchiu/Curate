import Foundation
import PostgresClientKit

struct Album: Decodable{
    
    static func get(byId id: String){
        
    }
    
    func addToDB(){
        Query.executeQuery(query: "add_album", params: [self.id, self.name, self.album_type, self.total_tracks, self.image])
    }

    let id: String
    let name: String
    let album_type: String
    let total_tracks: Int
//    let release_date: String
    var url: String{
        return("https://open.spotify.com/album/\(id)")
    }
    let artists: [Artist]
    let image: String
    
    private enum CodingKeys: String, CodingKey{
        case id
        case name
        case album_type
        case total_tracks
        case images
        case artists
    }
    
    // Decoder Init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        album_type = try container.decode(String.self, forKey: .album_type)
        total_tracks = try container.decode(Int.self, forKey: .total_tracks)
        artists = try container.decode([Artist].self, forKey: .artists)
        let images = try container.decode([ImgObj].self, forKey: .images)
        image = images[0].url


    }
    
    // System init
    init(id : String, name: String, album_type: String, total_tracks: Int, image: String){
        self.id = id
        self.name = name
        self.album_type = album_type
        self.total_tracks = total_tracks
        self.artists = []
        self.image = image
    }
}
