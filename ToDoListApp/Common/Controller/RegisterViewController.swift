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

	let presenter = RegisterPresenter(service: AuthService.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()

		presenter.delegate = self
    }

	func setupUI() {
		registerBtn.layer.cornerRadius = 10
		registerBtn.layer.masksToBounds = false
		registerBtn.clipsToBounds = true
	}

	@IBAction func registerPressed(_ sender: UIButton) {
		if let name = nameTf.text, let email = emailTf.text, let pass = passTf.text, let ageStr = ageTf.text, let age = UInt(ageStr) {
			presenter.register(name: name, email: email, pass: pass, age: age)
		}
	}
	
	@IBAction func closePressed(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
}
