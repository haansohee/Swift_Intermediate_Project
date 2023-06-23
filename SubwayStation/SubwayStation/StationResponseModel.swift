//
//  StationResponseModel.swift
//  SubwayStation
//
//  Created by 한소희 on 2023/06/23.
//

import Foundation

struct StationResponseModel: Decodable {
    var stations: [Station] { searchInfo.row }  // StationResponseModel().searchInfo.row
    private let searchInfo: SearchInfoBySubwayNameServiceModel
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameServiceModel: Decodable {
        var row: [Station] = []
    }
}

struct Station: Decodable {
    let stationName: String
    let lineNumber: String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}
