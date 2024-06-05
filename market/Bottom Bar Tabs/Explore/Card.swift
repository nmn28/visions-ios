//
//  Card.swift
//  market
//
//  Created by Nicholas Nelson on 4/16/24.
//

import SwiftUI

struct Card: Identifiable,Decodable,Hashable {

    var id: String
    var download_url: String
    var author: String
}

