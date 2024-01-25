//
//  VideoData.swift
//  VideoApp
//
//  Created by 최유리 on 1/24/24.
//

import Foundation

struct VideoData: Decodable {
    var title: String
    var thumbnailUrl: URL
    var videoUrl: URL
}
