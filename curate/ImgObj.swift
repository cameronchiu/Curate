//
//  ImgObj.swift
//  curate
//
//  Created by Cameron Chiu on 7/7/23.
//

import Foundation

struct ImgObj: Codable{
    let url: String
    let height: Int
    let width: Int
    private enum CodingKeys: String, CodingKey{
        case url
        case height
        case width
    }
}
