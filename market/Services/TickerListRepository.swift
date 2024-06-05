//
//  IdeaListRepository.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import Foundation

protocol IdeaListRepository {
    func save(_ current: [Idea]) async throws
    func load() async throws -> [Idea]
}

class IdeaPlistRepository: IdeaListRepository {
    
    private var saved: [Idea]?
    private let filename: String
    
    private var url: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appending(component: "\(filename).plist")
    }
    
    init(filename: String = "my_tickers") {
        self.filename = filename
    }
    
    func save(_ current: [Idea]) throws {
        if let saved, saved == current {
            return
        }
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        let data = try encoder.encode(current)
        try data.write(to: url, options: [.atomic])
        self.saved = current
    }
    
    
    func load() throws -> [Idea] {
        let data = try Data(contentsOf: url)
        let current = try PropertyListDecoder().decode([Idea].self, from: data)
        self.saved = current
        return current
    }
    
}
