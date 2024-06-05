//
//  MockIdeaListRepository.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import Foundation
//import XCAStocksAPI

#if DEBUG
struct MockIdeaListRepository: IdeaListRepository {
    
    var stubbedLoad: (() async throws -> [Idea])!
    func load() async throws -> [Idea] {
        try await stubbedLoad()
    }
    
    func save(_ current: [Idea]) async throws {}
    
}


#endif
