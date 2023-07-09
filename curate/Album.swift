import Foundation
import PostgresClientKit

struct Album: Codable{
    
    static func get(byId id: String){
        
    }
    
    func addToDB(){
        do{
            var config = PostgresClientKit.ConnectionConfiguration()
            config.host = "34.27.158.99"
            config.database = "curate_db"
            config.user = "basic"
            config.credential = .scramSHA256(password: "/]M~fgUo0sj`I?LI")
            let connection = try PostgresClientKit.Connection(configuration: config)
            let text = """
                INSERT INTO albums (id, name, album_type, total_tracks)
                VALUES ($1, $2, $3, $4);
                """
            let statement = try connection.prepareStatement(text: text)
            
            let _ = try statement.execute(parameterValues: [self.id, self.name, self.album_type, self.total_tracks])
            
        }
        catch{
            print(error)
        }
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
    let images: [ImgObj]
    
    private enum CodingKeys: String, CodingKey{
        case id
        case name
        case album_type
        case total_tracks
//        case release_date
        case artists
        case images
    }
    
    init(id : String, name: String, album_type: String, total_tracks: Int){
        self.id = id
        self.name = name
        self.album_type = album_type
        self.total_tracks = total_tracks
        self.artists = []
        self.images = []
    }
}
