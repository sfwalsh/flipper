//
//  UIImageView+Cache.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

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
                        let image = UIImage(data: data) {
                        let cacheItem = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cacheItem, for: request)
                        DispatchQueue.main.async { [weak self] in
                            self?.fadeToImage(image: image)
                        }
                    }
                }).resume()
            }
        }
    }
    
    func fadeToImage(image: UIImage) {
        if self.image == image {
            return
        }
        
        UIView.transition(with: self,
                          duration: 0.26,
                          options: [.transitionCrossDissolve],
                          animations: {
            self.image = image
        }, completion: nil)
    }
}
