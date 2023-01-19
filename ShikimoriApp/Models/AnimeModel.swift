//
//  AnimeModel.swift
//  ShikimoriApp
//
//  Created by Danil Bezuglov on 12/23/22.
//

import Foundation

// MARK: - Welcome
struct Anime: Codable, Identifiable {
    
    let id: Int
    let name, russian: String
    let image: AnimeImage
    let url, kind, score, status: String
    let episodes, episodesAired: Int
    let airedOn: String
    let releasedOn: String?

    enum CodingKeys: String, CodingKey {
        case id, name, russian, image, url, kind, score, status, episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }
}

struct AnimeInfo: Codable, Identifiable {
    var id: Int
    var name, russian: String
    var image: AnimeImage
    var url, kind, score, status: String
    var episodes, episodesAired: Int
    var airedOn, releasedOn: String?
    var rating: String
    var english, japanese: [String?]
    var synonyms: [String]?
    var licenseNameRu: String?
    var duration: Int
    var description: String?
    var descriptionHTML: String
    var descriptionSource, franchise: String?
    var favoured, anons, ongoing: Bool
    var threadID, topicID, myanimelistID: Int
    var ratesScoresStats: [AnimeScoresStats]?
    var ratesStatusesStats: [AnimeStatusesStats]?
    var updatedAt: String
    var nextEpisodeAt: String?
    var fansubbers, fandubbers, licensors: [String]?
    var genres: [Genre]
    var studios: [Studio]
    var videos: [Video]
    var screenshots: [[String: String]]?
    var userRate: String?

    enum CodingKeys: String, CodingKey {
        case id, name, russian, image, url, kind, score, status, episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
        case rating, english, japanese, synonyms
        case licenseNameRu = "license_name_ru"
        case duration, description
        case descriptionHTML = "description_html"
        case descriptionSource = "description_source"
        case franchise, favoured, anons, ongoing
        case threadID = "thread_id"
        case topicID = "topic_id"
        case myanimelistID = "myanimelist_id"
        case ratesScoresStats = "rates_scores_stats"
        case ratesStatusesStats = "rates_statuses_stats"
        case updatedAt = "updated_at"
        case nextEpisodeAt = "next_episode_at"
        case fansubbers, fandubbers, licensors, genres, studios, videos, screenshots
        case userRate = "user_rate"
    }
}

struct AnimeScoresStats: Codable  {
    var name: Int
    var value: Int
}

struct AnimeStatusesStats: Codable  {
    var name: String
    var value: Int
}

struct Genre: Codable {
    var id: Int
    var name, russian, kind: String
}

struct Studio: Codable {
    var id: Int
    var name, filteredName: String
    var real: Bool
    var image: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case filteredName = "filtered_name"
        case real, image
    }
}

struct Video: Codable {
    var id: Int
        var url: String
        var imageURL: String
        var playerURL: String
        var name: String
        var kind, hosting: String

        enum CodingKeys: String, CodingKey {
            case id, url
            case imageURL = "image_url"
            case playerURL = "player_url"
            case name, kind, hosting
        }
}

// MARK: - Image
struct AnimeImage: Codable {
    let original, preview, x96, x48: String
}
