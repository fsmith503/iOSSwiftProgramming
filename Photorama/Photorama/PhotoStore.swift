//
//  PhotoStore.swift
//  Photorama
//
//  Created by franklin smith on 1/5/21.
//

//import Foundation
import UIKit
import CoreData

enum PhotoError: Error {
    case imageCreationError
    case missingImageURL
}

class PhotoStore {
    
    let imageStore = ImageStore()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Photorama")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error))")
            }
        }
        return container
    }()
    
    
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()


        func fetchInterestingPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
            
            let url = FlickrAPI.interestingPhotosURL
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request){
                (data, response, error) in
                //let result = self.processPhotosRequest(data: data, error: error)
                
                
                var result = self.processPhotosRequest(data: data, error: error)
                if case .success = result {
                    do {
                        try self.persistentContainer.viewContext.save()
                    } catch {
                        result = .failure(error)
                    }
                }
                
                
                OperationQueue.main.addOperation {
                    completion(result)
                }
                
            }
            task.resume()
        }
    
    private func processPhotosRequest(data: Data?,
                                      error: Error?) -> Result<[Photo], Error>{
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        let context = persistentContainer.viewContext
        
        switch FlickrAPI.photos(fromJSON: jsonData){
        case let .success(FlickrPhotos):
            let photos = FlickrPhotos.map { flickrPhoto -> Photo in
                let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
                let predicate = NSPredicate(
                    format: "\(#keyPath(Photo.photoID)) == \(flickrPhoto.photoID)"
                )
                fetchRequest.predicate = predicate
                var fetchedPhotos: [Photo]?
                context.performAndWait {
                    fetchedPhotos = try? fetchRequest.execute()
                }
                if let existingPhoto = fetchedPhotos?.first {
                    return existingPhoto
                }
                
                
                
            var photo: Photo!
            context.performAndWait {
                photo = Photo(context: context)
                photo.title = flickrPhoto.title
                photo.photoID = flickrPhoto.photoID
                photo.remoteURL = flickrPhoto.remoteURL
                photo.dateTaken = flickrPhoto.dateTaken
            }
                return photo
            }
            return .success(photos)
        case let .failure(error):
            return .failure(error)
        }
    }
    
    
    func fetchImage(for photo: Photo, completion: @escaping (Result<UIImage, Error>) -> Void){
        
        guard let photoKey = photo.photoID else {
            preconditionFailure("Photo expected to have a photoID.")
        }
        if let image = imageStore.image(forKey: photoKey){
            OperationQueue.main.addOperation{
                completion(.success(image))
            }
            return
        }
        guard let photoURL = photo.remoteURL else{
            completion(.failure(PhotoError.missingImageURL))
            return
        }
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            
            OperationQueue.main.addOperation {
                completion(result)
            }
            //completion(result)
        }
        task.resume()
    }
    
    
    private func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
            
                // Couldn't create an image
            if data == nil {
                return .failure(error!)
            } else {
                return .failure(PhotoError.imageCreationError)
            }
        }
        return .success(image)
    }
        
    
    func fetchAllPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        let sortByDateTaken = NSSortDescriptor(key: #keyPath(Photo.dateTaken), ascending: true)
        fetchRequest.sortDescriptors = [sortByDateTaken]
        
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            do {
                let allPhotos = try viewContext.fetch(fetchRequest)
                completion(.success(allPhotos))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchAllTags(completion: @escaping (Result<[Tag], Error>) -> Void){
        let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        let sortByname = NSSortDescriptor(key: #keyPath(Tag.name), ascending: true)
        fetchRequest.sortDescriptors = [sortByname]
        
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            do {
                let allTags = try fetchRequest.execute()
                completion(.success(allTags))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
    
    
}
