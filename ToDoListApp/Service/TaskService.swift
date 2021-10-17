//
//  TaskService.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import Foundation
import Alamofire

final class TaskService {
	static let shared = TaskService()

	let baseUrl = "https://api-nodejs-todolist.herokuapp.com"

	var httpHeader: HTTPHeaders = [
		"Content-Type" : "application/json",
		"Accept" : "application/json"
	]

	func getTask(with token: String, completion: @escaping ((ToDo?, String?) -> Void)) {
		httpHeader.add(.authorization(bearerToken: token))

		AF.request(URL(string: baseUrl + "/task")!, method: .get, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseString { response in
				switch response.response?.statusCode {
					case 200:
						do {
							let data = try JSONDecoder().decode(ToDo.self, from: response.data!)
							completion(data, nil)
						} catch let error as NSError {
							print(error)
						}
					default:
						completion(nil, response.value)
				}
			}
	}

	func addTask(with token: String, desc: String, completion: @escaping ((AddResponse?, String?) -> Void)) {
		httpHeader.add(.authorization(bearerToken: token))

		let params = ParamsTask(description: desc)

		AF.request(URL(string: baseUrl + "/task")!, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseString { response in
				switch response.response?.statusCode {
					case 201:
						do {
							let data = try JSONDecoder().decode(AddResponse.self, from: response.data!)
							completion(data, nil)
						} catch let error as NSError {
							print(error)
						}
					default:
						completion(nil, response.value)
				}
			}
	}

	func updateTask(with token: String, id: String, completed: Bool, completion: @escaping ((AddResponse?, String?) -> Void)) {
		httpHeader.add(.authorization(bearerToken: token))

		let params = ParamsTask(completed: completed)

		AF.request(URL(string: baseUrl + "/task/\(id)")!, method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseString { response in
				switch response.response?.statusCode {
					case 200:
						do {
							let data = try JSONDecoder().decode(AddResponse.self, from: response.data!)
							completion(data, nil)
						} catch let error as NSError {
							print(error)
						}
					default:
						completion(nil, response.value)
				}
			}
	}

	func deleteTask(with token: String, id: String, completion: @escaping ((AddResponse?, String?) -> Void)) {
		httpHeader.add(.authorization(bearerToken: token))

		AF.request(URL(string: baseUrl + "/task/\(id)")!, method: .delete, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseString { response in
				switch response.response?.statusCode {
					case 200:
						do {
							let data = try JSONDecoder().decode(AddResponse.self, from: response.data!)
							completion(data, nil)
						} catch let error as NSError {
							print(error)
						}
					default:
						completion(nil, response.value)
				}
			}
	}
}
