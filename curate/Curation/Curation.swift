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
    
    
    
    func getAllTracks() -> [(Track, Int)]{
        do{
            if let cursor = Query.executeQuery(query: "tracksForCuration", params: [self.id.uuidString]){
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
                    let image = try columns[8].string()
                    let all_artists = try columns[9].string()
                    
                    // album object
                    let album = Album(id: album_id, name: album_name, album_type: album_type, total_tracks: total_tracks, image: image, all_artists: all_artists)
                    
                    return (Track(id: track_id, name: track_name, preview_url: preview_url, album: album), rank)
                }
                
            }
            
        }
        catch{
            print(error)
        }
        return []
    }
        

            
    
    // takes in a cursor of curation rows and returns a list of curation objects
    static func parseCurations(cursor: Cursor) throws -> [Curation]{
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
                let image = try columns[13].string()
                let all_artists = try columns[14].string()
                
                
                let album = Album(id: album_id, name: album_name, album_type: album_type, total_tracks: total_tracks, image: image, all_artists: all_artists)
                let track = Track(id: track_id, name: track_name, preview_url: preview_url, album: album)
                
                curationDict[id]?.tracksWithRanks.append((track, rank))
                
            }
            catch{
                // Curation has no tracks yet
            }

        }
        
        return Array(curationDict.values)
        
    }
    
    
    // extracts curations from DB and returns parsed result
    static func getAllCurations() -> [Curation]{
        print("getting all curations...")
        do{
            if let cursor = Query.executeQuery(query: "curations"){
                return try Curation.parseCurations(cursor: cursor)
            }
            
        }
        catch{
            print(error)
        }
        return []
    }
    
    // adds track to DB and adds track to curation
    func addTrack(track: Track) async {
        // first add track to DB
        await track.addToDB()
        // add track to curation
        Query.executeQuery(query: "add_track_to_curation", params: [self.id.uuidString, track.id, 0])
    }
    
    // adds curation to DB
    func addToDB() async{
        Query.executeQuery(query: "add_curation", params: [self.id.uuidString, self.title, self.description, self.color.toHex(), self.numLikes])
    }
    
    // adds Track object to Curation object
    func addToObj(track: Track) {
        for (track_, _) in self.tracksWithRanks{
            if(track_.id == track.id) {
                print("Duplicate track addition")
                return
            }
        }
        self.tracksWithRanks.append((track, 0))
    }
    
    
    var id: UUID
    var title: String
    var description: String
//    var tracksWithRanks: [(Song, Int)]
    @Published var tracksWithRanks: [(Track, Int)]
    var tags: [Genre]
    @Published var numLikes: Int
    var color: UIColor
    
    
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
    
    // basic
    init(title: String, description: String, tracks: [Track]){
        self.id = UUID()
        self.title = title
        self.description = description
        self.tracksWithRanks = tracks.map{($0,0)} // to be filled immediately after
        self.tags = [Genre("Any")]
        self.numLikes = 0
        self.color = UIColor(Color.black)
    }
    
    // shell
    init(){
        self.id = UUID()
        self.title = ""
        self.description = ""
        self.tracksWithRanks = [] // to be filled immediately after
        self.tags = []
        self.numLikes = 0
        self.color = UIColor(Color.black)
        
    }
    
    
    
}
