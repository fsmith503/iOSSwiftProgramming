//
//  ViewController.swift
//  Photorama
//
//  Created by franklin smith on 1/5/21.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
   // @IBOutlet private var imageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        //store.fetchInterestingPhotos() {
        store.fetchInterestingPhotos() {
            (photosResult) in
            
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
//                if let firstPhoto = photos.first {
//                    self.updateImageView(for: firstPhoto)
//                }
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        
        let photo = photoDataSource.photos[indexPath.row]
        
        // Download the image data, which could take some time
        store.fetchImage(for: photo) { (result) -> Void in
            
            // the index path for the photo might have changed between the
            // time the request started and finished, so find the most
            // recent index path
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                  case let .success(image) = result else {
                    return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // when the request finishes, find the current cell for this photo
            if let cell = self.collectionView.cellForItem(at: photoIndexPath)
                as? PhotoCollectionViewCell {
                cell.update(displaying: image)
            }
        }
    }
    
    
//    func updateImageView(for photo: Photo){
//        store.fetchImage(for: photo) {
//            (imageResult) in
//
//            switch imageResult {
//            case let .success(image):
//                self.imageView.image = image
//            case let .failure(error):
//                print("Error downloading image: \(error)")
//            }
//        }
//    }

}

