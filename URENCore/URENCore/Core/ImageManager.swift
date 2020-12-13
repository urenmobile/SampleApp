//
//  ImageManager.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import UIKit

public class ImageManager: ImageCacheProvider {
    
    private var imageCache = NSCache<NSString, AnyObject>()
    
    public static let shared: ImageManager = {
        let instance = ImageManager()
        instance.imageCache.countLimit = 100
        return instance
    }()
    
    public func image(forKey: String) -> UIImage? {
        return imageCache.object(forKey: forKey as NSString) as? UIImage
    }
    
    public func cacheImage(_ image: UIImage, forKey: String) {
        print("cacheImage key: \(forKey)")
        imageCache.setObject(image, forKey: forKey as NSString)
    }
    
    public func clearCache() {
        imageCache.removeAllObjects()
    }
}
