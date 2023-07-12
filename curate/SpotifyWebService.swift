import Foundation

enum NetworkError: Error {
    case badURL
    case badID
}

extension SpotifyController{
    
    
    // Function to perform a search for tracks
    func getTracks(searchTerm: String, completion: @escaping (Result<[Track], Error>) -> Void) {
        if let token = self.accessToken {
            let baseURL = URL(string: "https://api.spotify.com/v1/search")!
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            
            components?.queryItems = [
                URLQueryItem(name: "q", value: searchTerm.trimmed()),
                URLQueryItem(name: "type", value: "track"),
                URLQueryItem(name: "limit", value: "50") // Adjust the limit as per your requirement
            ]
            
            guard let url = components?.url else {
                completion(.failure(NetworkError.badURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(NetworkError.badID))
                    return
                }
                
                do {
                    let searchResponse = try JSONDecoder().decode(TrackSearchResponse.self, from: data!)
                    completion(.success(searchResponse.tracks.items))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    
    func getTrackInfo(fromID id : String, completion: @escaping (Result<Track, Error>) -> Void) {
        if let token = self.accessToken {
            let baseURL = URL(string: "https://api.spotify.com/v1/tracks/\(id)")!
            let components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            
            guard let url = components?.url else {
                completion(.failure(NetworkError.badURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(NetworkError.badID))
                    return
                }
                
                do {
                    let searchResponse = try JSONDecoder().decode(Track.self, from: data!)
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }

}




// Helper struct for decoding the search response
struct TrackSearchResponse: Decodable {
    let tracks: TrackResults
    private enum CodingKeys: String, CodingKey{
        case tracks
    }

}

class TrackResults: Decodable {
    let href: String
    let items: [Track]
    
    private enum CodingKeys: String, CodingKey {
        case href
        case items
    }
}
