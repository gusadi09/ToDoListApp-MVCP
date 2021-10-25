//
//  EditVC+EditPresenterDelegate.swift
//  ToDoListApp
//
//  Created by Gus Adi on 25/10/21.
//

import Foundation

extension EditProfileViewController: EditProfilePresenterDelegate {
	func didUpdateUserSuccess(success: Bool) {
		if success {
			self.dismiss(animated: true, completion: nil)
		}
	}

	func didFailWithError(error: Error) {
		print(error)
	}

	func didUpdateSuccesLogout(success: Bool) {

	}
}
