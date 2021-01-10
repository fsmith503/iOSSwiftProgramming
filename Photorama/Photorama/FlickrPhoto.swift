//
//  Photo.swift
//  Photorama
//
//  Created by franklin smith on 1/5/21.
//

import Foundation

class FlickrPhoto: Codable{
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

extension FlickrPhoto: Equatable {
    static func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
        //two photos are the same if they have the same photoID
        return lhs.photoID == rhs.photoID
    }
}
