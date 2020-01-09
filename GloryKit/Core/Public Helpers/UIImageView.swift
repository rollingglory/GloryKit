//
//  UIImageView.swift
//  GloryKit
//
//  Created by Rolling Glory on 12/11/19.
//  Copyright © 2019 Rolling Glory. All rights reserved.
//

import Foundation
import Kingfisher

/// UIImageView's helper
public extension UIImageView {
    /// Set image using Kingfisher's function
    ///
    ///     soloImageView.setImage(urlString: "http://www.google.com/image/solo.jpg")
    ///
    /// - Parameter urlString: String of the url
    /// - Parameter placeholder: UIImage as a placeholder (optional)
    /// - Parameter fade: Should UIImageView fades in as image loaded or not
    /// - Parameter completion: Handles on finished image resource
    func setImage(urlString: String, placeholder: UIImage? = nil, fade: Bool = false, completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        guard let url = URL(string: urlString) else { return }
        let fadingTransition: KingfisherOptionsInfoItem = .transition(.fade(0.3))
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url,
                         placeholder: placeholder,
                         options: fade ? [fadingTransition] : [],
                         completionHandler: completion)
    }
}
