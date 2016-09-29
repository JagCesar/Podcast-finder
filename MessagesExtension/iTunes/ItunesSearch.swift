//
//  ItunesSearch.swift
//  messageApplication
//
//  Created by Cesar Pinto Castillo on 2016-08-31.
//  Copyright © 2016 JagCesar. All rights reserved.
//

import Foundation
import Alamofire

class ItunesSearch {
    static func searchPodcast(term: String, completion:@escaping (_ results: [PodcastSearchResult]?, _ error: NSError?) -> Void) {
        let request = URLRequest(url: URL(string: "https://itunes.apple.com/search?media=podcast&entity=podcast&term=\(term)")!)

        Alamofire.request(request)
            .responseJSON { response in
                if let JSON = response.result.value as? [String: AnyObject],
                    let results = JSON["results"] as? [[String: AnyObject]] {
                    let podcasts = results.map { PodcastSearchResult(dictionary: $0) }.flatMap { $0 }
                    completion(podcasts, nil)
                } else {
                    completion(nil, NSError(domain: "se.jagcesar",
                                            code: 1,
                                            userInfo: nil))
                }
        }
    }
}

class PodcastSearchResult {
    let feedUrl: URL
    let itunesUrl: URL
    let artworkUrl30: URL
    let artworkUrl60: URL
    let artworkUrl100: URL
    let artworkUrl600: URL
    let collectionName: String
    let trackCount: String

    init?(dictionary: [String: AnyObject]) {
        guard let feedUrlString = dictionary["feedUrl"] as? String,
            let feedUrl = URL(string: feedUrlString),
            let itunesUrlString = dictionary["trackViewUrl"] as? String,
            let itunesUrl = URL(string: itunesUrlString),
            let artworkUrl30String = dictionary["artworkUrl30"] as? String,
            let artworkUrl30 = URL(string: artworkUrl30String),
            let artworkUrl60String = dictionary["artworkUrl60"] as? String,
            let artworkUrl60 = URL(string: artworkUrl60String),
            let artworkUrl100String = dictionary["artworkUrl100"] as? String,
            let artworkUrl100 = URL(string: artworkUrl100String),
            let artworkUrl600String = dictionary["artworkUrl600"] as? String,
            let artworkUrl600 = URL(string: artworkUrl600String),
            let collectionName = dictionary["collectionName"] as? String,
            let trackCount = dictionary["trackCount"] as? NSNumber else {
                return nil
        }
        self.feedUrl = feedUrl
        self.itunesUrl = itunesUrl
        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
        self.artworkUrl600 = artworkUrl600
        self.collectionName = collectionName
        self.trackCount = trackCount.stringValue
    }
}
