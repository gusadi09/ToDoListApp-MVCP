//
//  EditProfilePresenter.swift
//  ToDoListApp
//
//  Created by Gus Adi on 18/10/21.
//

import Foundation

protocol EditProfilePresenterDelegate: NSObjectProtocol {
	func didUpdateUserSuccess(success: Bool)
	func didFailWithError(error: Error)
}

final class EditProfilePresenter {
	private let userService: UserService
	weak var delegate: EditProfilePresenterDelegate?

	init(userService: UserService) {
		self.userService = userService
	}

	func update(with token: String, name: String?, email: String?, age: Int?) {
		userService.update(with: token, name: name, email: email, age: age) { result, error in
			if result != nil {
				self.delegate?.didUpdateUserSuccess(success: result?.success ?? false)
			} else {
				self.delegate?.didFailWithError(error: error as! Error)
			}
		}
	}
}
