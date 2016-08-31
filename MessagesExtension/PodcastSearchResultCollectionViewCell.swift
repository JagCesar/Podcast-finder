//
//  PodcastSearchResultCollectionViewCell.swift
//  messageApplication
//
//  Created by Cesar Pinto Castillo on 2016-08-31.
//  Copyright © 2016 JagCesar. All rights reserved.
//

import UIKit
import Alamofire

class PodcastSearchResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
    }

    var podcastSearchResult: PodcastSearchResult? {
        didSet {
            guard let podcastSearchResult = podcastSearchResult else { return }
            Alamofire.request(URLRequest(url: podcastSearchResult.artworkUrl100))
                .response { [weak self] request, response, data, error in
                    if let data = data {
                        self?.imageView.image = UIImage(data: data)
                    }
            }
        }
    }
}
