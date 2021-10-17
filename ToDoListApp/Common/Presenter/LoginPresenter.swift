//
//  LoginPresenter.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit

protocol LoginPresenterDelegate: NSObjectProtocol {
	func didUpdateToken(token: String)
	func didFailWithError(error: Error)
}

final class LoginPresenter {
	private let loginService: AuthService
	weak var delegate: LoginPresenterDelegate?

	init(service: AuthService) {
		self.loginService = service
	}

	func login(with email: String, by pass: String) {
		loginService.login(email: email, pass: pass) { result, error in
			if result != nil {
				self.delegate?.didUpdateToken(token: result?.token ?? "")
			} else {
				self.delegate?.didFailWithError(error: error as! Error)
			}
		}
	}
}
