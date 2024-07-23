//
//  Apod.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import Foundation

struct Apod: Codable {
    let copyright, date, explanation: String?
    let hdurl: String
    let mediaType, serviceVersion, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}

#if DEBUG
    extension Apod {
        static func mock() -> Self {
            .init(
                copyright: "Dominic Bryan",
                date: "2024-07-21",
                explanation: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi auctor iaculis mi at blandit. Fusce et pharetra augue. Pellentesque bibendum ligula at tortor mollis, eget bibendum quam rhoncus. Etiam nec enim non nisl gravida venenatis. Vestibulum ut dolor interdum, iaculis erat at, vulputate mi. Aenean ac tempor ipsum, id pellentesque mi. Cras eu ultrices lacus. Nullam quis volutpat tellus, id lobortis ipsum.",
                hdurl: "",
                mediaType: "",
                serviceVersion: "",
                title: "Astronomy Picture of the Day",
                url: ""
            )
        }
    }
#endif
