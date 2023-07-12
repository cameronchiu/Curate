//
//  Artist.swift
//  curate
//
//  Created by Cameron Chiu on 7/7/23.
//

import Foundation
import PostgresClientKit

struct Artist: Codable{
    
    func addToDB(){
        do{
            
            var config = PostgresClientKit.ConnectionConfiguration()
            config.host = "34.27.158.99"
            config.database = "curate_db"
            config.user = "basic"
            config.credential = .scramSHA256(password: "/]M~fgUo0sj`I?LI")
            let connection = try PostgresClientKit.Connection(configuration: config)
            let text = """
                INSERT INTO artists (id, name, url)
                VALUES ($1, $2, $3);
                """
            let statement = try connection.prepareStatement(text: text)
            
            let _ = try statement.execute(parameterValues: [self.id, self.name, self.url])
            
        }
        catch{
            print(error)
        }
    }
    
    let id: String
    let name: String
    var url: String{
        return("https://open.spotify.com/artist/\(id)")
    }
    
    private enum CodingKeys: String, CodingKey{
        case id
        case name
    }
    
    init(id: String, name: String){
        self.id = id
        self.name = name
    }
    
    
}
