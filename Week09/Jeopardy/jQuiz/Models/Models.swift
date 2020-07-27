//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

// MARK: - Clue
struct Clue: Codable, Equatable {
    let id: Int
    let answer, question: String
    let value: Int?
    let airdate, createdAt, updatedAt: String
    let categoryID: Int
    let category: Category

    enum CodingKeys: String, CodingKey {
        case id, answer, question, value, airdate
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryID = "category_id"
        case category
    }
    
    static func == (lhs: Clue, rhs: Clue) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let title, createdAt, updatedAt: String
    let cluesCount: Int

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case cluesCount = "clues_count"
    }
}
