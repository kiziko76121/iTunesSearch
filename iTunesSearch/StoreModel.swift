//
//  StoreModel.swift
//  iTunesSearch
//
//  Created by MOJO on 2024/6/7.
//

import Foundation

struct StoreModel: Codable {
    let name: String
    let artist: String
    var trackTimeMillis: Int
//    let longDescription: String
    var artworkURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case trackTimeMillis
//        case longDescription
        case artworkURL = "artworkUrl100"
    }
   
}

struct SearchResponse: Codable {
    let results: [StoreModel]
}
