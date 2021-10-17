//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
	@IBOutlet weak var loginLabel: UILabel!
	@IBOutlet weak var emailTf: UITextField!
	@IBOutlet weak var passTf: UITextField!
	@IBOutlet weak var loginBtn: UIButton!

	let baseUrl = "https://api-nodejs-todolist.herokuapp.com"

	var httpHeader: HTTPHeaders = [
			"Content-Type" : "application/json",
			"Accept" : "application/json"
		]

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
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
			login(email: email, pass: pass)
		} else {
			print("Cant empty")
		}
	}

	func login(email: String, pass: String) {
		let params = Login(email: email, password: pass)

		AF.request(URL(string: baseUrl + "/user/login")!, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseData { response in
				if let data = response.data {
					self.parseJSON(data)
				}
			}
	}

	func parseJSON(_ Data: Data) {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(LoginResponse.self, from: Data)
			debugPrint(decodedData)

			UserDefaults.standard.set(decodedData.token, forKey: "auth.accessToken")

			self.performSegue(withIdentifier: "toHome", sender: self)
		} catch {
			print(error)
		}
	}
}

