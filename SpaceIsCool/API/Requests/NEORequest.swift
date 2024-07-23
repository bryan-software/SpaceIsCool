//
//  NEORequest.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import Foundation

enum NEORequest: RequestProtocol {
    case getNEO(startDate: String?, endDate: String?)
    
    var path: String {
        "/neo/rest/v1/feed"
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var urlParams: [String : String?] {
        switch self {
        case .getNEO(let startDate, let endDate):
            return ["start_date": startDate, "end_date": endDate]
        }
    }
}
