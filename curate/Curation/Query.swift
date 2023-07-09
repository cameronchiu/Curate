//
//  Query.swift
//  curate
//
//  Created by Cameron Chiu on 7/9/23.
//

import Foundation
import PostgresClientKit

struct Query{
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
    
    
    // executes a specified query a returns the cursor object
    @discardableResult
    static func executeQuery(query: String, params: [PostgresValueConvertible?] = []) -> Cursor?{
        do{
            let queryCmd = Query.queries[query]
            let statement = try Query.connection!.prepareStatement(text: queryCmd!)
//            defer { statement.close() }

            let cursor = try statement.execute(parameterValues: params)
//            defer { cursor.close() }
            
            return cursor
            
        }
        catch{
            return nil
        }
        
    }
    
    static var queries: [String : String] = [
        
        /// WRITE
        // Adds a track to a curation
        "addTrackToCuration" : """
                INSERT INTO curationTracks (curation_id, track_id, rank)
                VALUES ($1, $2, $3);
        """,
        
        "addCuration" : """
                INSERT INTO curations (id, title, description, color, numLikes)
                VALUES ($1, $2, $3, $4, $5);
        """,
        
        
        /// READ
        // Fetches all tracks with album info for a given curation
        "tracksForCuration" : """
                SELECT CurationTracks.rank,
                       Tracks.id as track_id, Tracks.name as track_name, Tracks.preview_url,
                       Albums.id as album_id, Albums.name as album_name, Albums.album_type, Albums.total_tracks
                FROM CurationTracks
                JOIN Tracks ON CurationTracks.track_id = Tracks.id
                JOIN Albums ON Tracks.album_id = Albums.id
                WHERE CurationTracks.curation_id = $1
        """,
        
        // Fetches all curations with track with album info
        "curations" : """
                SELECT Curations.id, Curations.title, Curations.description, Curations.color, Curations.numLikes,
                       CurationTracks.rank,
                       Tracks.id as track_id, Tracks.name as track_name, Tracks.preview_url,
                       Albums.id as album_id, Albums.name as album_name, Albums.album_type, Albums.total_tracks
                FROM Curations
                LEFT JOIN CurationTracks ON Curations.id = CurationTracks.curation_id
                LEFT JOIN Tracks ON CurationTracks.track_id = Tracks.id
                LEFT JOIN Albums ON Tracks.album_id = Albums.id
        """
    
    ]
    
    
}

