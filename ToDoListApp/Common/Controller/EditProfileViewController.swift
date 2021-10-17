//
//  EditProfileViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit
import Alamofire

class EditProfileViewController: UIViewController {
	@IBOutlet weak var nameTf: UITextField!
	@IBOutlet weak var emailTf: UITextField!
	@IBOutlet weak var ageTf: UITextField!
	@IBOutlet weak var saveBtn: UIButton!
	@IBOutlet weak var succesLabel: UILabel!
	
	var nama = ""
	var email = ""
	var age = ""

	let token = UserDefaults.standard.object(forKey: "auth.accessToken") as? String

	let baseUrl = "https://api-nodejs-todolist.herokuapp.com"

	var httpHeader: HTTPHeaders = [
			"Content-Type" : "application/json",
			"Accept" : "application/json"
		]

    override func viewDidLoad() {
        super.viewDidLoad()
		saveBtn.layer.cornerRadius = 10
		saveBtn.layer.masksToBounds = false
		saveBtn.clipsToBounds = true

		nameTf.text = nama
		emailTf.text = email
		ageTf.text = age
    }

	@IBAction func savePressed(_ sender: UIButton) {
		if let name = nameTf.text, let emails = emailTf.text, let ageStr = ageTf.text, let age = Int(ageStr) {
			update(with: token ?? "", name: name, email: emails, age: age)
		}
	}

	func update(with token: String, name: String?, email: String?, age: Int?) {
		httpHeader.add(.authorization(bearerToken: token))

		let params = Update(name: name, email: email, age: age)

		AF.request(URL(string: baseUrl + "/user/me")!, method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: httpHeader)
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
			let decodedData = try decoder.decode(EditResponse.self, from: Data)
			debugPrint(decodedData)

			succesLabel.isHidden = false

			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				self.succesLabel.isHidden = true
				self.dismiss(animated: true, completion: nil)
			}
		} catch {
			print(error)
		}
	}
}
