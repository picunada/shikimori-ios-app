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

struct AnimeInfo: Codable {
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
    var ratesScoresStats, ratesStatusesStats: [String]?
    var updatedAt: String
    var nextEpisodeAt: String?
    var fansubbers, fandubbers, licensors, genres: [String]?
    var studios, videos, screenshots: [String]?
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

// MARK: - Image
struct AnimeImage: Codable {
    let original, preview, x96, x48: String
}
