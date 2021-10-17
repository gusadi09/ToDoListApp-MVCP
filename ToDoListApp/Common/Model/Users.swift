//
//  Users.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import Foundation

// MARK: - User
struct UserResponse: Codable {
	var age: Int
	var id, name, email, createdAt: String
	var updatedAt: String
	var v: Int

	enum CodingKeys: String, CodingKey {
		case age
		case id = "_id"
		case name, email, createdAt, updatedAt
		case v = "__v"
	}
}
