import Foundation
import PostgresClientKit

struct Track: Decodable {
    
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
    }

    
    init(id : String, name: String, preview_url: String, album: Album){
        self.id = id
        self.name = name
        self.preview_url = preview_url
        self.album = album
        self.artists = [] // TODO
    }
    
    static func grabXTracks(lim: Int) -> [Track]{
        print("fetching \(lim) tracks from DB...")
        do{
            if let cursor = Query.executeQuery(query: "tracks_lim", params: [lim]){
                return try cursor.compactMap{ row in
                    let columns = try row.get().columns
                    
                    // track attributes
                    let track_id = try columns[0].string()
                    let track_name = try columns[1].string()
                    let preview_url = try columns[2].string()
                    
                    // album attributes
                    let album_id = try columns[3].string()
                    let album_name = try columns[4].string()
                    let album_type = try columns[5].string()
                    let total_tracks = try columns[6].int()
                    let image = try columns[7].string()
                    
                    // album object
                    let album = Album(id: album_id, name: album_name, album_type: album_type, total_tracks: total_tracks, image: image)
                    return Track(id: track_id, name: track_name, preview_url: preview_url, album: album)
                }
                
            }
            
        }
        catch{
            print(error)
        }
        return []
    }
    
    func addToDB() async {
        // Adds all artists to DB
        for artist in (self.artists) {
            artist.addToDB()
        }
        
        // Adds album to DB
        self.album.addToDB()
        
        // Adds track to DB
        Query.executeQuery(query: "add_track", params: [self.id, self.name, self.album.id, self.preview_url ?? ""])
    }
    

}
