//
//  Extension+UIImageView.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import UIKit

var imageToCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageViewWithCache(_ urlString: String) {
        self.image = nil
        
        if let cacheImage = imageToCache.object(forKey: NSString(string: urlString)) {
            self.image = cacheImage
        }

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                print("Something went wrong!")
            }
            guard let data = data, let downloadedImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                imageToCache.setObject(downloadedImage, forKey: NSString(string: urlString))
            }
        }.resume()
    }
}
