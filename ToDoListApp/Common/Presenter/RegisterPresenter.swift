//
//  RegisterPresenter.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit

protocol RegisterPresenterDelegate: NSObjectProtocol {
	func didUpdateToken(token: String)
	func didFailWithError(error: Error)
}

final class RegisterPresenter {
	private let regisService: AuthService
	weak var delegate: RegisterPresenterDelegate?

	init(service: AuthService) {
		self.regisService = service
	}

	func register(name: String, email: String, pass: String, age: UInt) {
		regisService.register(name: name, email: email, pass: pass, age: age) { result, error in
			if result != nil {
				self.delegate?.didUpdateToken(token: result?.token ?? "")
			} else {
				self.delegate?.didFailWithError(error: error as! Error)
			}
		}
	}
}
