//
//  Photo.swift
//  Photorama
//
//  Created by franklin smith on 1/5/21.
//

import Foundation

class Photo: Codable{
    let title: String
    let remoteURL: URL?
    let photoID: String
    let dateTaken: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }
    
}
