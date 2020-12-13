//
//  ImageCacheProvider.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import UIKit

public protocol ImageCacheProvider {
    func image(forKey: String) -> UIImage?
    func cacheImage(_ image: UIImage, forKey: String)
    func clearCache()
}
