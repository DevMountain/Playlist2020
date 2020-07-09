//
//  Song.swift
//  PlaylistCodable
//
//  Created by Aaron Martinez on 11/1/17.
//  Copyright © 2017 Aaron Martinez. All rights reserved.
//

import Foundation

class Song: Codable {
    
    init(name: String, artist: String) {
        self.name = name
        self.artist = artist
    }
    
    // MARK: Properties
    
    let name: String
    let artist: String
}

extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.name == rhs.name && lhs.artist == rhs.artist
    }
}
