//
//  PhotoStore.swift
//  Photorama
//
//  Created by franklin smith on 1/5/21.
//

import Foundation

class PhotoStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()


        func fetchInterestingPhotos() {
            
            let url = FlickrAPI.interestingPhotosURL
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request){
                (data, response, error) in
                
//                if let jsonData = data {
//                    if let jsonString = String(data: jsonData, encoding:.utf8){
//                        print(jsonString)
//                    }
//                } else if let requestError = error {
//                    print("Error fetching interesting photos: \(requestError)")
//                } else {
//                    print("Unexpected error with the request")
//                }
                let result = self.processPhotosRequest(data: data, error: error)
                
            }
            task.resume()
        }
    
    private func processPhotosRequest(data: Data?,
                                      error: Error?) -> Result<[Photo], Error>{
        guard let jsonData = data else {
            return .failure(error!)
        }
        return FlickrAPI.photos(fromJSON: jsonData)
    }
}
