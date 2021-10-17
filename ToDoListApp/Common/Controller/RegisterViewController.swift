//
//  RegisterViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
	@IBOutlet weak var registerLabel: UILabel!
	@IBOutlet weak var nameTf: UITextField!
	@IBOutlet weak var emailTf: UITextField!
	@IBOutlet weak var passTf: UITextField!
	@IBOutlet weak var ageTf: UITextField!
	@IBOutlet weak var registerBtn: UIButton!

	let baseUrl = "https://api-nodejs-todolist.herokuapp.com"

	var httpHeader: HTTPHeaders = [
			"Content-Type" : "application/json",
			"Accept" : "application/json"
		]

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }

	func setupUI() {
		registerBtn.layer.cornerRadius = 10
		registerBtn.layer.masksToBounds = false
		registerBtn.clipsToBounds = true
	}

	@IBAction func registerPressed(_ sender: UIButton) {
		if let name = nameTf.text, let email = emailTf.text, let pass = passTf.text, let ageStr = ageTf.text, let age = UInt(ageStr) {
			register(name: name, email: email, pass: pass, age: age)
		}
	}
	
	@IBAction func closePressed(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}

	func register(name: String, email: String, pass: String, age: UInt) {
		let params = Register(name: name, email: email, password: pass, age: age)

		AF.request(URL(string: baseUrl + "/user/register")!, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: httpHeader)
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

			self.performSegue(withIdentifier: "toHomeFromRegist", sender: self)
		} catch {
			print(error)
		}
	}
}
