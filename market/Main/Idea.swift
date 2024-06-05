//
//  Idea.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import Foundation

public struct SearchIdeasResponse: Decodable {
    
    public let error: ErrorResponse?
    public let data: [Idea]?
    
    enum CodingKeys: CodingKey {
        case count
        case quotes
        case finance
    }
    
    enum FinanceKeys: CodingKey {
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decodeIfPresent([Idea].self, forKey: .quotes)
        error = try? container.nestedContainer(keyedBy: FinanceKeys.self, forKey: .finance)
            .decodeIfPresent(ErrorResponse.self, forKey: .error)
    }
}

public struct Idea: Codable, Identifiable, Hashable, Equatable {
    public let id = UUID()
    
    public let symbol: String
    public let quoteType: String?
    public let shortname: String?
    public let longname: String?
    public let sector: String?
    public let industry: String?
    public let exchDisp: String?
    
    public init(symbol: String, quoteType: String? = nil, shortname: String? = nil, longname: String? = nil, sector: String? = nil, industry: String? = nil, exchDisp: String? = nil) {
        self.symbol = symbol
        self.quoteType = quoteType
        self.shortname = shortname
        self.longname = longname
        self.sector = sector
        self.industry = industry
        self.exchDisp = exchDisp
    }
}
