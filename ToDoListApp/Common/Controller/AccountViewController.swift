//
//  AccountViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit
import Alamofire

class AccountViewController: UIViewController {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var logoutBtn: UIButton!
	@IBOutlet weak var editBtn: UIButton!

	var age: UInt = 0

	let token = UserDefaults.standard.object(forKey: "auth.accessToken") as? String

	let baseUrl = "https://api-nodejs-todolist.herokuapp.com"

	var httpHeader: HTTPHeaders = [
			"Content-Type" : "application/json",
			"Accept" : "application/json"
		]

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()

		getUser(with: self.token ?? "")
    }

	func setupUI() {
		logoutBtn.layer.cornerRadius = 10
		logoutBtn.layer.masksToBounds = false
		logoutBtn.clipsToBounds = true

		editBtn.layer.cornerRadius = 10
		editBtn.layer.masksToBounds = false
		editBtn.clipsToBounds = true
	}
    
	@IBAction func logoutPressed(_ sender: UIButton) {
		logout(with: self.token ?? "")
	}

	@IBAction func editPressed(_ sender: UIButton) {
		self.performSegue(withIdentifier: "toEdit", sender: self)
	}

	func getUser(with token: String) {
		httpHeader.add(.authorization(bearerToken: token))

		AF.request(URL(string: baseUrl + "/user/me")!, method: .get, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseData { response in
				if let data = response.data {
					self.parseJSONGetUser(data)
				}
			}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let view = segue.destination as? EditProfileViewController
		if segue.identifier == "toEdit" {
			view?.email = emailLabel.text ?? ""
			view?.nama = nameLabel.text ?? ""
			view?.age = String(age)
		}
	}

	func logout(with token: String) {
		httpHeader.add(.authorization(bearerToken: token))

		AF.request(URL(string: baseUrl + "/user/logout")!, method: .post, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseData { response in
				if let data = response.data {
					self.parseJSONLogout(data)
				}
			}
	}

	func parseJSONLogout(_ Data: Data) {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(LogoutResponse.self, from: Data)
			debugPrint(decodedData)

			self.performSegue(withIdentifier: "logoutRoute", sender: self)
		} catch {
			print(error)
		}
	}

	func parseJSONGetUser(_ Data: Data) {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(UserResponse.self, from: Data)
			debugPrint(decodedData)

			DispatchQueue.main.async {
				self.nameLabel.text = decodedData.name
				self.emailLabel.text = decodedData.email
				self.age = UInt(decodedData.age)
			}
		} catch {
			print(error)
		}
	}
}
