//
//  Repository.swift
//  githubviewer
//
//  Created by Luiz Vasconcellos on 25/06/21.
//

import Foundation

struct Repository: Codable {
    let name: String
    let owner: Owner
    let language: String?

    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case language
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

