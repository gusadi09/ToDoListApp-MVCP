//
//  Auth.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import Foundation

struct LoginResponse: Codable {
	var user: UserResponse
	var token: String
}

struct Login: Codable {
	var email: String
	var password: String
}

struct Register: Codable {
	var name: String
	var email: String
	var password: String
	var age: UInt
}

struct LogoutResponse: Codable {
	var success: Bool
}
