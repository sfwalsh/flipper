//
//  UIImageView+Cache.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

extension UIImage {

  func getThumbnail() -> UIImage? {

    guard let imageData = self.pngData() else { return nil }

    let options = [
        kCGImageSourceCreateThumbnailWithTransform: true,
        kCGImageSourceCreateThumbnailFromImageAlways: true,
        kCGImageSourceThumbnailMaxPixelSize: 300] as CFDictionary

    guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
    guard let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) else { return nil }

    return UIImage(cgImage: imageReference)

  }
}

extension UIImageView {
    
    func loadImage(forURL urlString: String) {
        guard let imageURL = URL(string: urlString) else { return }
        
        let request = URLRequest(url: imageURL)
        
        let cache = URLCache.shared
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageData = cache.cachedResponse(for: request)?.data,
                let image = UIImage(data: imageData) {
                
                DispatchQueue.main.async { [weak self] in
                    self?.fadeToImage(image: image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data,
                        let response = response,
                        ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                        let image = UIImage(data: data),
                        let thumbImage = image.getThumbnail(),
                        let thumbData = image.pngData() {
                        let cacheItem = CachedURLResponse(response: response, data: thumbData)
                        cache.storeCachedResponse(cacheItem, for: request)
                        DispatchQueue.main.async { [weak self] in
                            self?.fadeToImage(image: thumbImage)
                        }
                    }
                }).resume()
            }
        }
    }
    
    func fadeToImage(image: UIImage) {
        UIView.transition(with: self,
                          duration: 0.26,
                          options: [.transitionCrossDissolve],
                          animations: {
            self.image = image
        }, completion: nil)
    }
}
