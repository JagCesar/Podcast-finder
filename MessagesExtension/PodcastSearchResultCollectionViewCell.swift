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

            Alamofire.request(podcastSearchResult.artworkUrl100)
                .responseData { [weak self] response in
                    if let data = response.result.value {
                        self?.imageView.image = UIImage(data: data)
                    }
            }
        }
    }
}
