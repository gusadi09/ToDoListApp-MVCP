//
//  AccountPresenter.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import Foundation

protocol AccountPresenterDelegate: NSObjectProtocol {
	func didUpdateSuccesLogout(success: Bool)
	func didUpdateUser(name: String, email: String, age: Int)
	func didFailWithError(error: Error)
}

final class AccountPresenter {
	private let authService: AuthService
	private let userService: UserService
	weak var delegate: AccountPresenterDelegate?

	init(service: AuthService, userService: UserService) {
		self.authService = service
		self.userService = userService
	}

	func logout(with token: String) {
		authService.logout(with: token) { result, error in
			if result != nil {
				self.delegate?.didUpdateSuccesLogout(success: result?.success ?? false)
			} else {
				self.delegate?.didFailWithError(error: error as! Error)
			}
		}
	}

	func getUser(with token: String) {
		userService.getUser(with: token) { result, error in
			if result != nil {
				debugPrint(result)
				self.delegate?.didUpdateUser(name: result?.name ?? "", email: result?.email ?? "", age: result?.age ?? 0)
			} else {
				self.delegate?.didFailWithError(error: error as! Error)
			}
		}
	}
}
