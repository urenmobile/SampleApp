//
//  URENImageView.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import UIKit

public class URENImageView: UIImageView {
    
    private var imageUrl: URL?
    
    public func loadImageFrom(url: URL, imageCache: ImageCacheProvider? = ImageManager.shared) {
        updateImage(with: nil)
        imageUrl = url
        
        if let imageCache = imageCache, let image = imageCache.image(forKey: url.absoluteString) {
            updateImage(with: image)
        } else {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    debugPrint("Image download error: \(error)")
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                imageCache?.cacheImage(image, forKey: url.absoluteString)
                if self?.imageUrl == url {
                    self?.updateImage(with: image)
                }
            }
            
            task.resume()
        }
    }
    
    private func updateImage(with image: UIImage?) {
        DispatchQueue.main.async {
            self.image = image ?? UIImage(named: "placeholder")
        }
    }
}
