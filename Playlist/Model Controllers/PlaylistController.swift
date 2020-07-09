//
//  PlaylistController.swift
//  PlaylistCodable
//
//  Created by Aaron Martinez on 11/1/17.
//  Copyright © 2017 Aaron Martinez. All rights reserved.
//

import Foundation

class PlaylistController {
    
    // MARK: - Shared Instance
    static let shared = PlaylistController()
    
    // MARK: - Properties
    var playlists = [Playlist]()
    
    // MARK: - Crud Methods
    // Create
    func add(playlistWithName name: String) {
        let playlist = Playlist(name: name, songs: [])
        playlists.append(playlist)
        saveToPersistentStore()
    }
    
    // Update
    func add(song: Song, toPlaylist playlist: Playlist) {
        playlist.songs.append(song)
        saveToPersistentStore()
    }
    
    func remove(song: Song, fromPlaylist playlist: Playlist) {
        guard let index = playlist.songs.index(of: song) else { return }
        playlist.songs.remove(at: index)
        saveToPersistentStore()
    }
    
    // Delete
    func delete(playlist: Playlist) {
        guard let index = playlists.index(of: playlist) else { return }
        playlists.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filename = "playlists.json"
        let fullURL = documentsDirectory.appendingPathComponent(filename)
        return fullURL
    }
    
    func saveToPersistentStore() {
        do {
            let data =  try JSONEncoder().encode(playlists)
            print(data)
            print(String(data: data, encoding: .utf8)!)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving playlist \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            let playlists = try JSONDecoder().decode([Playlist].self, from: data)
            self.playlists = playlists
        } catch let error {
            print("Error loading data from disk \(error)")
        }
    }
}
