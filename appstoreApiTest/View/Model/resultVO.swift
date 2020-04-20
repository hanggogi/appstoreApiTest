//
//  resultVO.swift
//  appstoreApiTest
//
//  Created by samga on 2020/04/16.
//  Copyright © 2020 samga. All rights reserved.
//

import Foundation
import ObjectMapper

class resultVO: NSObject, Mappable{
    var screenshotUrls : Array<Any> = []
    var supportedDevices : Array<Any> = []
    var isGameCenterEnabled : Bool = false
    var kind : String = ""
    var trackCensoredName : String = ""
    var language : Array<Any> = []
    var fileSizeBytes : String = ""
    var sellerUrl : String = ""
    var averageRating : Float = 0.0
    var trackViewUrl : String = ""
    var trackContentRating : String = ""
    var trackId : Int = 0
    var trackName : String = ""
    var releaseDate : String = ""
    var releaseNotes : String = ""
    var cellerName : String = ""
    var artistName : String = ""
    var price : Float = 0.0
    var desc : String = ""
    var genreIds : Array<Any> = []
    var formattedPrice : String = ""
    var primaryGenreName : String = ""
    var genres : Array<String> = []
    var contentAdvisoryRating : String = ""
    var averageUserRating : Float = 0.0
    var artistViewUrl : String = ""
    var artworkUrl512 : String = ""
    var version : String = ""
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        screenshotUrls <- map["screenshotUrls"]
        supportedDevices <- map["supportedDevices"]
        trackName <- map["trackName"]
        trackViewUrl <- map["trackViewUrl"]
        fileSizeBytes <- map["fileSizeBytes"]
        contentAdvisoryRating <- map["contentAdvisoryRating"]
        averageUserRating <- map["averageUserRating"]
        releaseNotes <- map["releaseNotes"]
        desc <- map["description"]
        artistName <- map["artistName"]
        genres <- map["genres"]
        formattedPrice <- map["formattedPrice"]
        artistViewUrl <- map["artistViewUrl"]
        artworkUrl512 <- map["artworkUrl512"]
        version <- map["version"]
        trackContentRating <- map["trackContentRating"]
    }
}
