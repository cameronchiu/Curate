//
//  DataService.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import SwiftUI
import Foundation

struct DataService{
    static func getRequest(withID id: UUID) -> Request? {
        if let obj = (DataService.requests).first(where: {$0.id == id}){
            return obj
        }
        return nil
    }
    
    static func getUser(withID id: UUID) -> User? {
        if let obj = (DataService.users).first(where: {$0.id == id}){
            return obj
        }
        return nil
    }
    
    static func getSong(withID id: UUID) -> Song? {
        if let obj = (DataService.songRecs).first(where: {$0.id == id}){
            return obj
        }
        return nil
    }
    

    
    static var requests: [Request] = [
        Request("Takes me back to my childhood", genreTags: [Genre("Classical"), Genre("Rock")]),
        Request("Blows my mind!"),
        Request("Is good for a wedding reception", genreTags: [Genre("Classical")]),
        Request("I can learn on the piano", genreTags: [Genre("Anime")]),
        Request("Reminds me of her :')", genreTags: [Genre("R&B"), Genre("Jazz"), Genre("Anime")]),
//        Request("Is your personal favorite"),
//        Request("I can cry to", genreTags: [Genre("Movie")]),
//        Request("Says 2020 like no other song", genreTags: [Genre("Pop")]),
//        Request("is bad ass", genreTags: [Genre("Rock")]),
//        Request("Makes me feel like I'm in an 80s movie and the main actor just died but", genreTags: [Genre("80s")]),
//        Request("was revolutionary"),
//        Request("Can educate me", genreTags: [Genre("Classical")]),
//        Request("Will likley get stuck in my head"),
    ]
    
    
    
    static var users: [User] = [
        User("krank1"),
        User("krank2"),
        User("krank3"),
        User("krank4"),
        User("krank6"),
        User("krank7"),
        User("krank8"),
        User("krank9"),
        User("krank10"),
        User("krank11"),
        User("krank12"),
        User("krank13"),
        User("krank14"),
        User("krank15"),
    ]
    
    
    static var songRecs: [Song] = [
        Song("Playing God", "Polyphia", "New Levels New Devils", "new-level-new-devils-img", ["Experimental", "Rock", "Classical", "Pop", "90s"], 2018),
        Song("When the Lights Go Out", "Naked Eye", "Fuel for the Fire", "fuel-for-the-fire-img", ["Synth Pop", "80s"], 1983),
        Song("Alone Again", "Love", "Forever Changes", "forever-changes-img", ["Psychedelic Rock"], 1967),
        Song("Sinfonia Concertante in E-flat Major", "Mozart", "Mozart Symphonies", "mozart-symphonies-img", ["Classical"], 1779),
        Song("Fool on the Hill", "The Beatles", "Magical Mystery Tour", "magical-mystery-tour-img", ["Psychedelic", "Pop"], 1967),
        Song("Bohemian Rhapsody", "Queen", "A Night at the Opera", "a-night-at-the-opera-img", ["Rock", "Classic Rock", "Progressive Rock"], 1975),
        Song("Smells Like Teen Spirit", "Nirvana", "Nevermind", "nevermind-img", ["Grunge", "Alternative Rock"], 1991),
        Song("Billie Jean", "Michael Jackson", "Thriller", "thriller-img", ["Pop", "R&B"], 1982),
        Song("Sweet Child o' Mine", "Guns N' Roses", "Appetite for Destruction", "appetite-for-desctruction-img", ["Rock", "Hard Rock"], 1987),
        Song("Boogie Wonderland", "Earth, Wind & Fire", "I Am", "i-am-img", ["Disco", "Funk"], 1979),
        Song("Thriller", "Michael Jackson", "Thriller", "thriller-img", ["Pop", "R&B"], 1982),
        Song("Hotel California", "Eagles", "Hotel California", "hotel-california-img", ["Rock", "Classic Rock"], 1976),
        Song("Imagine", "John Lennon", "Imagine", "imagine-img", ["Pop", "Rock"], 1971),
        Song("Stairway to Heaven", "Led Zeppelin", "Led Zeppelin IV", "led-zeppelin-iv-img", ["Rock", "Classic Rock"], 1971),
        Song("November Rain", "Guns N' Roses", "Use Your Illusion I", "use-your-illusion-i-img", ["Rock", "Hard Rock"], 1991),
    ]
    
    static var songRecIds: [UUID] = songRecs.map{$0.id}
    
    static var mustHears: [MustHear] = zip(users, songRecs).map { user, song in
        MustHear(userID: user.id, songID: song.id)
    }
    
    static var recommendations: [Recommendation] = zip(users, songRecs).map { user, song in
        Recommendation(recommenderID: user.id, recommendationType: "song", songID: song.id)
    }
    static var curations: [Curation] = Curation.getAllCurations()
    
//    static var curations: [Curation] = [
//        Curation(title: "House Music",
//                 description: "Say goodbye to your roof",
//                 color: UIColor(hex: 0x51053C),
//                 tracks: songRecs,
//                 tags: Genre.stringsToGenres(["House", "Party", "Techno"])),
//        Curation(title: "Bad ass tracks",
//                 description: "Songs that make you want to shoot up a school",
//                 color: UIColor(hex: 0x398476),
//                 tracks: songRecs,
//                 tags: Genre.stringsToGenres(["Experimental", "Rock", "Classical"])),
//        Curation(title: "Bubble Gum Drop",
//                 description: "Yup.",
//                 color: UIColor(hex: 0xCD4AA8),
//                 tracks: songRecs,
//                 tags: Genre.stringsToGenres(["Pop", "Any"])),
//        Curation(title: "Music that makes you feel alive",
//                 description: "I'm talking about those songs that make your body move. Songs that you can't help but to dance to!",
//                 color: UIColor(hex: 0xAC9D8B),
//                 tracks: songRecs,
//                 tags: Genre.stringsToGenres(["Any"])),
//        Curation(title: "Epic Soundscapes",
//                 description: "Immerse yourself in breathtaking soundscapes that transport you to another world.",
//                 color: UIColor(hex: 0x234567),
//                 tracks: songRecs,
//                 tags: Genre.stringsToGenres(["Ambient", "Cinematic", "Orchestral"])),
//        Curation(title: "Hip Hop Heat",
//                 description: "Get your groove on with the hottest hip hop tracks of the moment.",
//                 color: UIColor(hex: 0xFFA500),
//                 tracks: songRecs,
//                 tags: Genre.stringsToGenres(["Hip Hop", "Rap", "Trap"])),
//        Curation(title: "Soothing Acoustics",
//                 description: "Unwind and relax to the soothing melodies of acoustic guitar and gentle vocals.",
//                 color: UIColor(hex: 0xE0D5B2),
//                 tracks: songRecs,
//                 tags: Genre.stringsToGenres(["Acoustic", "Folk", "Singer-Songwriter"])),
//        Curation(title: "EDM Extravaganza",
//                 description: "Experience the high-energy beats and electrifying drops of electronic dance music.",
//                 color: UIColor(hex: 0xFF00FF),
//                 tracks: songRecs,
//                 tags: Genre.stringsToGenres(["EDM", "Progressive House", "Trance"])),
//        Curation(title: "Chill Vibes",
//                 description: "Sit back, relax, and let the mellow tunes create a peaceful atmosphere.",
//                 color: UIColor(hex: 0x87CEEB),
//                 tracks: songRecs,
//                 tags: Genre.stringsToGenres(["Chillout", "Downtempo", "Lounge"]))
//        
//    
//    ]
    
    static private func interleaveArrays<T>(_ array1: [T], _ array2: [T]) -> [T] {
        var interleavedArray = [T]()
        let totalCount = array1.count + array2.count
        var index1 = 0
        var index2 = 0
        
        for _ in 0..<totalCount {
            let randomIndex = Int.random(in: 0...1)
            
            if randomIndex == 0 && index1 < array1.count {
                interleavedArray.append(array1[index1])
                index1 += 1
            } else if index2 < array2.count {
                interleavedArray.append(array2[index2])
                index2 += 1
            }
        }
        
        return interleavedArray
    }
    
    
    
    
    
}
