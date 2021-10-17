//
//  UserService.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import Foundation
import Alamofire

final class UserService {
	static let shared = UserService()

	let baseUrl = "https://api-nodejs-todolist.herokuapp.com"

	var httpHeader: HTTPHeaders = [
		"Content-Type" : "application/json",
		"Accept" : "application/json"
	]

	func getUser(with token: String, completion: @escaping ((UserResponse?, String?) -> Void)) {
		httpHeader.add(.authorization(bearerToken: token))

		AF.request(URL(string: baseUrl + "/user/me")!, method: .get, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseString { response in
				switch response.response?.statusCode {
					case 200:
						do {
							let data = try JSONDecoder().decode(UserResponse.self, from: response.data!)
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
