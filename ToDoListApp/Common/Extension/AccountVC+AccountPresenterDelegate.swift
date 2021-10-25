//
//  AccountVC+AccountPresenterDelegate.swift
//  ToDoListApp
//
//  Created by Gus Adi on 25/10/21.
//

import Foundation

extension AccountViewController: AccountPresenterDelegate {
	func didUpdateSuccesLogout(success: Bool) {
		if success {
			self.performSegue(withIdentifier: "logoutRoute", sender: self)
		}
	}

	func didUpdateUser(name: String, email: String, age: Int) {
		DispatchQueue.main.async {
			self.nameLabel.text = name
			self.emailLabel.text = email
			self.age = UInt(age)
		}
	}

	func didFailWithError(error: Error) {
		print(error)
	}
}
