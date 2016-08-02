//
//  Gif.swift
//  GiphMe
//
//  Created by Ian Smith on 7/28/16.
//  Copyright © 2016 Ian Smith. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Gif {

    private let localAttributes: JSON?
    public let id: String?
    public let images: [String: JSON]?
    public let slug: String?
    public let source: String?

    init(attributes: JSON) {
        localAttributes = attributes
        id = attributes["id"].stringValue
        slug = attributes["slug"].stringValue
        source = attributes["source"].stringValue
        images = attributes["images"].dictionaryValue
    }
}