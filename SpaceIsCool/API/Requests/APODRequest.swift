//
//  APODRequest.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import Foundation

enum APODRequest: RequestProtocol {
    case getAPOD(date: String?)
    
    var path: String {
        "/planetary/apod"
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var urlParams: [String : String?] {
        switch self {
        case .getAPOD(let date):
            return ["date": date]
        }
    }
}
