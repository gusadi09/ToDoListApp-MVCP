//
//  RegisterService.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import Foundation
import Alamofire

final class RegisterService {
	static let shared = RegisterService()

	let baseUrl = "https://api-nodejs-todolist.herokuapp.com"

	var httpHeader: HTTPHeaders = [
		"Content-Type" : "application/json",
		"Accept" : "application/json"
	]

	func register(name: String, email: String, pass: String, age: UInt, completion: @escaping ((LoginResponse?, String?) -> Void)) {
		let params = Register(name: name, email: email, password: pass, age: age)

		AF.request(URL(string: baseUrl + "/user/register")!, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseString { result in
				switch result.response?.statusCode {
					case 201:
						do {
							let data = try JSONDecoder().decode(LoginResponse.self, from: result.data!)
							completion(data, nil)
						} catch let error as NSError {
							print(error)
						}
					default:
						completion(nil, result.value)
				}
			}
	}
}
