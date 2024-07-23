//
//  Neo.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import Foundation

// MARK: - Neo
struct Neo: Codable {
    let links: NeoLinks
    let elementCount: Int
    let nearEarthObjects: [String: [NearEarthObject]]

    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}

// MARK: - NeoLinks
struct NeoLinks: Codable {
    let next, previous, linksSelf: String

    enum CodingKeys: String, CodingKey {
        case next, previous
        case linksSelf = "self"
    }
}

// MARK: - NearEarthObject
struct NearEarthObject: Codable {
    let links: NearEarthObjectLinks
    let id, neoReferenceID, name: String
    let nasaJplURL: String
    let absoluteMagnitudeH: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachDatum]
    let isSentryObject: Bool

    enum CodingKeys: String, CodingKey {
        case links, id
        case neoReferenceID = "neo_reference_id"
        case name
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }
}

// MARK: - CloseApproachDatum
struct CloseApproachDatum: Codable {
    let closeApproachDate, closeApproachDateFull: String
    let epochDateCloseApproach: Int
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: OrbitingBody

    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
}

// MARK: - MissDistance
struct MissDistance: Codable {
    let astronomical, lunar, kilometers, miles: String
}

extension MissDistance {
    static func mock() -> Self {
        .init(astronomical: "0.1252852555", lunar: "48.7359643895", kilometers: "18742407.365205785", miles: "11645991.904918433")
    }
}

enum OrbitingBody: String, Codable {
    case earth = "Earth"
}

// MARK: - RelativeVelocity
struct RelativeVelocity: Codable {
    let kilometersPerSecond, kilometersPerHour, milesPerHour: String

    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
}

// MARK: - EstimatedDiameter
struct EstimatedDiameter: Codable {
    let kilometers, meters, miles, feet: Feet
}

// MARK: - Feet
struct Feet: Codable {
    let estimatedDiameterMin, estimatedDiameterMax: Double

    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}

// MARK: - NearEarthObjectLinks
struct NearEarthObjectLinks: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}


#if DEBUG
extension Neo {
    static func mock() -> Self {
        .init(
            links: .init(
                next: "",
                previous: "",
                linksSelf: ""
            ),
            elementCount: 999,
            nearEarthObjects: [
                "2024-07-21": []
            ]
        )
    }
}

extension NearEarthObject {
    static func mock() -> Self {
        .init(
            links: .mock(),
            id: "99999",
            neoReferenceID: "99999",
            name: "357621 (2005 EG94)",
            nasaJplURL: "I am a URL",
            absoluteMagnitudeH: 18.82,
            estimatedDiameter: .mock(),
            isPotentiallyHazardousAsteroid: true,
            closeApproachData: [
                .mock()
            ],
            isSentryObject: true
        )
    }
}

extension CloseApproachDatum {
    static func mock() -> Self {
        .init(
            closeApproachDate: "2024-07-29",
            closeApproachDateFull: "2024-Jul-29 17:50",
            epochDateCloseApproach: 1722275400000,
            relativeVelocity: .mock(),
            missDistance: .mock(),
            orbitingBody: .earth
        )
    }
}

extension RelativeVelocity {
    static func mock() -> Self {
        .init(kilometersPerSecond: "15", kilometersPerHour: "53758", milesPerHour: "33403")
    }
}

extension EstimatedDiameter {
    static func mock() -> Self {
        .init(kilometers: .mock(), meters: .mock(), miles: .mock(), feet: .mock())
    }
}

extension Feet {
    static func mock() -> Self {
        .init(estimatedDiameterMin: 999.0, estimatedDiameterMax: 999.0)
    }
}

extension NearEarthObjectLinks {
    static func mock() -> Self {
        .init(linksSelf: "I am a link")
    }
}
#endif
