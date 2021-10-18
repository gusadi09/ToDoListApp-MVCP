//
//  EditProfileViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit
import Alamofire

class EditProfileViewController: UIViewController, EditProfilePresenterDelegate, AccountPresenterDelegate {

	@IBOutlet weak var nameTf: UITextField!
	@IBOutlet weak var emailTf: UITextField!
	@IBOutlet weak var ageTf: UITextField!
	@IBOutlet weak var saveBtn: UIButton!
	
	var nama = ""
	var email = ""
	var age = ""

	let token = UserDefaults.standard.object(forKey: "auth.accessToken") as? String

	let presenter = EditProfilePresenter(userService: UserService.shared)
	let AccPresenter = AccountPresenter(service: AuthService.shared, userService: UserService.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
		saveBtn.layer.cornerRadius = 10
		saveBtn.layer.masksToBounds = false
		saveBtn.clipsToBounds = true

		presenter.delegate = self
		AccPresenter.delegate = self

		AccPresenter.getUser(with: token ?? "")
    }

	@IBAction func savePressed(_ sender: UIButton) {
		if let name = nameTf.text, let emails = emailTf.text, let ageStr = ageTf.text, let age = Int(ageStr) {
			presenter.update(with: token ?? "", name: name, email: emails, age: age)
		}
	}

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

	func didUpdateUser(name: String, email: String, age: Int) {
		nameTf.text = name
		emailTf.text = email
		ageTf.text = String(age)
	}

	@IBAction func backPressed(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
}
