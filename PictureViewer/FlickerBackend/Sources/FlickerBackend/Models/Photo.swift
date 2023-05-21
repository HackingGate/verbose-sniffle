//
//  File.swift
//  
//
//  Created by H G on 2023/05/21.
//

import Foundation

/*
 Docs:
 https://www.flickr.com/services/api/flickr.photos.search.html
 
 Sample:
 {
 "id": "52913790503",
 "owner": "187113622@N05",
 "secret": "cd98f2b713",
 "server": "65535",
 "farm": 66,
 "title": "RR Media  E: rrphotomedia@gmail.com  W: https://www.wsimages.com",
 "ispublic": 1,
 "isfriend": 0,
 "isfamily": 0,
 "url_m": "https://live.staticflickr.com/65535/52913790503_cd98f2b713.jpg",
 "height_m": 500,
 "width_m": 334
},
 */

public struct Photo: Codable, Identifiable {
    public let id: String
    public let title: String
    public let description: Description?
    public let date_upload: String?
    public let date_taken: String?
    public let owner_name: String?
    public let geo: String?
    public let url_m: String?
}

