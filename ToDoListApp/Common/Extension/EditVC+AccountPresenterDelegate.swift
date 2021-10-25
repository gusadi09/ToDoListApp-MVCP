//
//  EditVC+AccountPresenterDelegate.swift
//  ToDoListApp
//
//  Created by Gus Adi on 25/10/21.
//

import Foundation

extension EditProfileViewController: AccountPresenterDelegate {
	func didUpdateUser(name: String, email: String, age: Int) {
		nameTf.text = name
		emailTf.text = email
		ageTf.text = String(age)
	}
}
