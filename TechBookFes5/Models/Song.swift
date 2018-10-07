//
//  Song.swift
//  TechBookFes5
//
//  Created by crea on 2018/10/07.
//  Copyright © 2018 crea. All rights reserved.
//

import Foundation

struct Data: Decodable {
    let data: Songs
}
struct Songs: Decodable {
    let songs: [Song]
}
struct Song: Decodable {
    let name:         String
    let duration:     Int?
    let times:        Int?
    let premiereDate: String
    let performedAt:  [Live]
}

struct Live: Decodable {
    let name: String
    let date: String
}
