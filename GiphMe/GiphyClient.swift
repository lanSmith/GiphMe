//
//  GiphyClient.swift
//  GiphMe
//
//  Created by Ian Smith on 7/28/16.
//  Copyright © 2016 Ian Smith. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class GiphyClient {

    class func getTrendingGiphys() {
        let trendingUrlString: NSString = (Constants.giphyBaseUrl as String) + (Constants.giphyTrendingUrl as String)
        let trendingUrl: NSURL = NSURL.init(string: trendingUrlString as String)!

        Alamofire.request(.GET, trendingUrl, parameters: ["api_key": Constants.giphyAPIKey])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)

                        let items = json["data"].arrayValue

                        for attributes in items {
                            let gif = Gif.init(attributes: attributes)
                            DataManager.sharedManager.trendingGifs.append(gif)
                        }
                    }

                case .Failure(let error):
                    print(error)
                }
        }
    }

    class func getGiphyImageAtAddress(url: NSURL, completion: (UIImage? -> Void)) -> (Request) {
        return Alamofire.request(.GET, url).responseImage { (response) -> Void in
            guard let image = response.result.value else { return }
            completion(image)
        }
    }

    class func searchGiphys(keywords: NSArray) {
        let searchUrlString: NSString = (Constants.giphyBaseUrl as String) + (Constants.giphySearchUrl as String)
        let searchUrl: NSURL = NSURL.init(string: searchUrlString as String)!
        let searchQuery: NSString = keywords.componentsJoinedByString("+")

        Alamofire.request(.GET, searchUrl, parameters: ["q": searchQuery, "api_key": Constants.giphyAPIKey])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)

                        let items = json["data"].arrayValue

                        for attributes in items {
                            let gif = Gif.init(attributes: attributes)
                            DataManager.sharedManager.searchedGifs.append(gif)
                        }
                    }

                case .Failure(let error):
                    print(error)
                }
        }
    }
}