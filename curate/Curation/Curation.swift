//
//  PairingItem.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//
import SwiftUI
import Foundation
import PostgresClientKit

class Curation: Identifiable, ObservableObject{
    
    static var connection: Connection?{
        do{
            var config = PostgresClientKit.ConnectionConfiguration()
            config.host = "34.27.158.99"
            config.database = "curate_db"
            config.user = "basic"
            config.credential = .scramSHA256(password: "/]M~fgUo0sj`I?LI")
            return try PostgresClientKit.Connection(configuration: config)
            
        }
        catch{
            print("Error with connection: \(error)")
            return nil
        }
    }
    
    
    func getAllTracks() -> [(Track, Int)]{
        do{
            print("getting all tracks for a curation...")

            let text = """
                SELECT CurationTracks.rank,
                       Tracks.id as track_id, Tracks.name as track_name, Tracks.preview_url,
                       Albums.id as album_id, Albums.name as album_name, Albums.album_type, Albums.total_tracks
                FROM CurationTracks
                JOIN Tracks ON CurationTracks.track_id = Tracks.id
                JOIN Albums ON Tracks.album_id = Albums.id
                WHERE CurationTracks.curation_id = $1
            """
            
            
            let statement = try Curation.connection!.prepareStatement(text: text)
            defer { statement.close() }
        
            
            let cursor = try statement.execute(parameterValues: [self.id.uuidString])
            
            
            return try cursor.compactMap{ row in
                let columns = try row.get().columns
                
                // curation attributes
                let rank = try columns[0].int()
                
                // track attributes
                let track_id = try columns[1].string()
                let track_name = try columns[2].string()
                let preview_url = try columns[3].string()
                
                // album attributes
                let album_id = try columns[4].string()
                let album_name = try columns[5].string()
                let album_type = try columns[6].string()
                let total_tracks = try columns[7].int()
                
                // album object
                let album = Album(id: album_id, name: album_name, album_type: album_type, total_tracks: total_tracks)
                
                return (Track(id: track_id, name: track_name, preview_url: preview_url, album: album), rank)
            }

            
        }
        catch{
            print(error)
        }
        
        return []
    }
    
    static func getAllCurations() -> [Curation]{
        do{
            print("getting all curations...")

//            let text = "SELECT * FROM curations"
            
            let text = """
            SELECT Curations.id, Curations.title, Curations.description, Curations.color, Curations.numLikes,
                   CurationTracks.rank,
                   Tracks.id as track_id, Tracks.name as track_name, Tracks.preview_url,
                   Albums.id as album_id, Albums.name as album_name, Albums.album_type, Albums.total_tracks
            FROM Curations
            LEFT JOIN CurationTracks ON Curations.id = CurationTracks.curation_id
            LEFT JOIN Tracks ON CurationTracks.track_id = Tracks.id
            LEFT JOIN Albums ON Tracks.album_id = Albums.id
            """
            let statement = try Curation.connection!.prepareStatement(text: text)
            defer { statement.close() }

            let cursor = try statement.execute()
            defer { cursor.close() }
            
            var curationDict: [String : Curation] = [:]


            for row in cursor {
                
                let columns = try row.get().columns
                
                // curation attributes
                let id = try columns[0].string()
                let title = try columns[1].string()
                let description = try columns[2].string()
                let color = try columns[3].int()
                let numLikes = try columns[4].int()
                
                // make curationDict entry in case it doesn't exist yet
                if curationDict[id] == nil {
                    curationDict[id] = Curation(id: id, title: title, description: description, color: color, numLikes: numLikes)
                }

                
                do{
                    // curation track attributes
                    let rank = try columns[5].int()
                    
                    // track attributes
                    let track_id = try columns[6].string()
                    let track_name = try columns[7].string()
                    let preview_url = try columns[8].string()
                    
                    
                    // album attributes
                    let album_id = try columns[9].string()
                    let album_name = try columns[10].string()
                    let album_type = try columns[11].string()
                    let total_tracks = try columns[12].int()
                    
                    
                    let album = Album(id: album_id, name: album_name, album_type: album_type, total_tracks: total_tracks)
                    let track = Track(id: track_id, name: track_name, preview_url: preview_url, album: album)
                    
                    curationDict[id]?.tracksWithRanks.append((track, rank))
                    
                }
                catch{
                    
                }
                
                
                
                
            }
            
            return Array(curationDict.values)

            
        }
        catch{
            print(error)
        }
        
        return []
    }
    
    // makes an SQL call to add track to the curation in the DB
    func addTrack(track: Track) async {
//        DispatchQueue.global().async{
            do{
                
                // first add track to DB
                track.addToDB()
                
                // add curation_id <-> track_id to DB
                let text = """
                    INSERT INTO curationTracks (curation_id, track_id, rank)
                    VALUES ($1, $2, $3);
                    """
                let statement = try Curation.connection!.prepareStatement(text: text)
                let _ = try statement.execute(parameterValues: [self.id.uuidString, track.id, 0])
                
            }
            catch{
                print(error)
            }

//        }
        
        
        
        
    }
    
    func addToDB() async{
        do{
            let text = """
                INSERT INTO curations (id, title, description, color, numLikes)
                VALUES ($1, $2, $3, $4, $5);
                """
            let statement = try Curation.connection!.prepareStatement(text: text)
            
            let _ = try statement.execute(parameterValues: [self.id.uuidString, self.title, self.description, self.color.toHex(), self.numLikes])

            
        }
        catch{
            print(error)
        }
    }
    
    
    var id: UUID
    var title: String
    var description: String
//    var tracksWithRanks: [(Song, Int)]
    @Published var tracksWithRanks: [(Track, Int)]
    var tags: [Genre]
    @Published var numLikes: Int
    var color: UIColor
    
//    init(title: String, description: String, color: UIColor, tracks: [Song], tags: [Genre]){
//        self.id = UUID()
//        self.title = title
//        self.description = description
//        self.tracksWithRanks = tracks.map{ track in (track, 0) }
//        self.tags = tags
//        self.numLikes = 0
//        self.color = color
//    }
    
    // for db extraction
    init(id: String, title: String, description: String, color: Int, numLikes: Int){
        self.id = UUID(uuidString: id) ?? UUID()
        self.title = title
        self.description = description
        self.tracksWithRanks = [] // to be filled immediately after
        self.tags = [Genre("Any")]
        self.numLikes = numLikes
        self.color = UIColor(hex: UInt32(color))
    }
    
    init(title: String, description: String, tracks: [Track]){
        self.id = UUID()
        self.title = title
        self.description = description
        self.tracksWithRanks = tracks.map{($0,0)} // to be filled immediately after
        self.tags = [Genre("Any")]
        self.numLikes = 0
        self.color = UIColor(Color.black)
    }
    
    
    
}
