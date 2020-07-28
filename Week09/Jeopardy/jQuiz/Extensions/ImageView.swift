//
//  ImageView.swift
//  jQuiz
//
//  Created by Islombek Hasanov on 7/28/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

extension UIImageView {
    public static var imageStore: [String: UIImage] = [:]
    public func getImage(for url: URL?) {
        guard let url = url else {
            self.image = UIImage(named: "error")
            return
        }

        let key = url.absoluteString
        if let image = UIImageView.imageStore[key] {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            Networking.shared.requestDownload(url) { (data) in
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    UIImageView.imageStore[key] = self.image
                }
            }
        }
    }
}
