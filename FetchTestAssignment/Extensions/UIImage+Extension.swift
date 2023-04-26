//
//  UIImage+Extension.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit


extension UIImageView {
    // Used from https://gist.github.com/amosavian/a05044e57c290b5e064f4f7acfc3b506
        func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil) {
            let cache = cache ?? URLCache.shared
            let request = URLRequest(url: url)
            
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                self.image = placeholder
                
                URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                    guard let data = data, let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode, let image = UIImage(data: data) else { return }
                    
                    let cachedData = CachedURLResponse(response: httpResponse, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }.resume()
            }
        }
}
