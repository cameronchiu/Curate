import Foundation
import PostgresClientKit

struct Track: Codable {
//    static func get(byId id: String) -> Track{
//        do{
//            var config = PostgresClientKit.ConnectionConfiguration()
//            config.host = "34.27.158.99"
//            config.database = "curate_db"
//            config.user = "basic"
//            config.credential = .scramSHA256(password: "/]M~fgUo0sj`I?LI")
//            let connection = try PostgresClientKit.Connection(configuration: config)
//            let text = "SELECT (id, name, album_id, preview_url, url) FROM tracks WHERE id = $1"
//            let statement = try connection.prepareStatement(text: text)
//
//            let cursor = try statement.execute(parameterValues: [id])
//            let columns = cursor.first.get().columns
//            // extract
//            let id = try columns[0].string()
//            let name = try columns[1].string()
//            let album_id = try columns[2].string()
//            let preview_url = try columns[4].string()
//            let url = try columns[4].string()
            
//        }
//        catch {
//            print(error)
//        }
//    }
    
    func addToDB() {
        do{
            
            // Adds all artists to DB
            for artist in (self.artists) {
                artist.addToDB()
            }
            
            // Adds album to DB
            self.album.addToDB()
            
            
            // Add track
            var config = PostgresClientKit.ConnectionConfiguration()
            config.host = "34.27.158.99"
            config.database = "curate_db"
            config.user = "basic"
            config.credential = .scramSHA256(password: "/]M~fgUo0sj`I?LI")
            let connection = try PostgresClientKit.Connection(configuration: config)
            let text = """
                INSERT INTO tracks (id, name, album_id, preview_url)
                VALUES ($1, $2, $3, $4);
                """
            let statement = try connection.prepareStatement(text: text)
            
            let _ = try statement.execute(parameterValues: [self.id, self.name, self.album.id, self.preview_url ?? ""])
            
            
            
        }
        catch{
            print(error)
        }
    }
    let id: String
    let name: String
    let album: Album
    let artists: [Artist]
    let preview_url: String?
    var url: String{
        return("https://open.spotify.com/track/\(id)")
    }
    
//    var bg_color: UIColor
//    var prim_color: UIColor
//    var sec_color: UIColor
//    var det_color: UIColor
//    var avgColor: UIColor
    
    // Other properties specific to a track
    private enum CodingKeys: String, CodingKey{
        case id
        case name
        case album
        case artists
        case preview_url
        
//        case external_urls = "external_urls"
        
    }
    
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        album = try container.decode(Album.self, forKey: .album)
//        artists = try container.decode([Artist].self, forKey: .artists)
//        preview_url = try container.decode(String?.self, forKey: .preview_url)
//        let externalURLs = try container.decode([String: String].self, forKey: .external_urls)
//        if let spot_url = externalURLs["spotify"]{
//            url = spot_url
//        }
//        else{
//            url = ""
//        }
//
//
//    }
    
    init(id : String, name: String, preview_url: String, album: Album){
        self.id = id
        self.name = name
        self.preview_url = preview_url
        self.album = album
        self.artists = [] // TODO
    }

}
