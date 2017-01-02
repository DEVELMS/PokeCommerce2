//
//  ImagesDao.swift
//  NewsNow
//
//  Created by Lucas M Soares on 06/11/16.
//
//

import UIKit

struct Image {
 
    private static let cache = NSCache<NSString, UIImage>()
 
    private init() {}
    
    static func get(url: String, success: @escaping (_ image: UIImage) -> Void) {
        
        if let cachedImage = cache.object(forKey: url as NSString) {
            return success(cachedImage)
        }
        
        Request.sharedInstance.APIRequestImage(url: url,
            success: { image in
                
                guard let downloadedImage = UIImage(data: (image as! Data)) else {
                    return print("downloadedImage is not a valid image")
                }
                
                cache.setObject(downloadedImage, forKey: url as NSString)
                success(downloadedImage)

        }, failure: { failure in
            
                print("Não foi possível carregar imagem nesta url: \(url)")
        })
    }
}
