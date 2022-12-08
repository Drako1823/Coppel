//
//  UIImageExtension.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import  UIKit

extension UIImageView {
    
    func loadImage(withName strImage: String, withPlaceHolder bPlaceHolder:Bool = true) {
        
        if bPlaceHolder {
            self.image = UIImage(named: "imgPlaceHolder")
        }
        if let url = URL(string: "https://image.tmdb.org/t/p/original/\(strImage)"){
            UIImageLoader.loader.load(url, for: self)
        }
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}

class ImageLoader{
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            defer {self.runningRequests.removeValue(forKey: uuid) }
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            guard let error = error else {
                return
            }
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}

class UIImageLoader {
    static let loader = UIImageLoader()
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {}
    
    func load(_ url: URL, for imageView: UIImageView) {
        let imgDownloaded = imageLoader.loadImage(url) { [weak self] result in
            guard let self = self else { return }
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async{
                    imageView.image = image
                }
            } catch {
                print("Can't Download image")
            }
        }
        if let imgDownloaded = imgDownloaded {
            uuidMap[imageView] = imgDownloaded
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        draw(in: CGRect(x     : 0,
                        y     : 0,
                        width : newSize.width,
                        height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
