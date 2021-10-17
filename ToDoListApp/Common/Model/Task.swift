//
//  Task.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import Foundation

struct ToDo: Codable {
	var count: Int
	var data: [DataToDo]
}

struct ParamsTask: Codable {
	var completed: Bool?
	var description: String?
}

struct AddResponse: Codable {
	var success: Bool
	var data: DataToDo
}

// MARK: - Datum
struct DataToDo: Codable {
	var completed: Bool?
	var id, datumDescription, owner, createdAt: String?
	var updatedAt: String?
	var v: Int?

	enum CodingKeys: String, CodingKey {
		case completed
		case id = "_id"
		case datumDescription = "description"
		case owner, createdAt, updatedAt
		case v = "__v"
	}
}
