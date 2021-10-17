//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, LoginPresenterDelegate {
	@IBOutlet weak var loginLabel: UILabel!
	@IBOutlet weak var emailTf: UITextField!
	@IBOutlet weak var passTf: UITextField!
	@IBOutlet weak var loginBtn: UIButton!

	let presenter = LoginPresenter(service: AuthService.shared)

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()

		presenter.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		self.navigationController?.navigationBar.isHidden = true
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		self.navigationController?.navigationBar.isHidden = false
	}

	func setupUI() {
		loginBtn.layer.cornerRadius = 10
		loginBtn.layer.masksToBounds = false
		loginBtn.clipsToBounds = true
	}

	@IBAction func registerPressed(_ sender: UIButton) {
		self.performSegue(withIdentifier: "toRegister", sender: self)
	}

	@IBAction func loginPressed(_ sender: UIButton) {
		if let email = emailTf.text, let pass = passTf.text {
			presenter.login(with: email, by: pass)
		} else {
			print("Cant empty")
		}
	}

	func didUpdateToken(token: String) {
		debugPrint(token)
		UserDefaults.standard.set(token, forKey: "auth.accessToken")
		self.performSegue(withIdentifier: "toHome", sender: self)
	}

	func didFailWithError(error: Error) {
		print(error)
	}
}
