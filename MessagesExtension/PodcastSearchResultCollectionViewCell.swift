//
//  PodcastSearchResultCollectionViewCell.swift
//  messageApplication
//
//  Created by Cesar Pinto Castillo on 2016-08-31.
//  Copyright © 2016 JagCesar. All rights reserved.
//

import UIKit
import AlamofireImage

class PodcastSearchResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
    }

    var podcastSearchResult: PodcastSearchResult? {
        didSet {
            guard let podcastSearchResult = podcastSearchResult else { return }

            imageView.af_setImage(withURL: podcastSearchResult.artworkUrl600,
                                  filter: ScaledToSizeFilter(size: CGSize(width: 100, height: 100)),
                                  imageTransition: UIImageView.ImageTransition.crossDissolve(0.24),
                                  runImageTransitionIfCached: false)
        }
    }
}
