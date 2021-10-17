//
//  LoginView+LoginPresenter.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import Foundation

extension LoginViewController: LoginPresenterDelegate {
	func didUpdateToken(token: String) {
		debugPrint(token)
		UserDefaults.standard.set(token, forKey: "auth.accessToken")
		self.performSegue(withIdentifier: "toHome", sender: self)
	}

	func didFailWithError(error: Error) {
		print(error)
	}
}
