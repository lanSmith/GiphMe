//
//  DataManager.swift
//  GiphMe
//
//  Created by Ian Smith on 7/28/16.
//  Copyright © 2016 Ian Smith. All rights reserved.
//

import Foundation

class DataManager {

    static let sharedManager = DataManager()

    var trendingGifs = [Gif]()
    var searchedGifs = [Gif]()

}
