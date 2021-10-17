//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit

class LoginViewController: UIViewController {
	@IBOutlet weak var loginLabel: UILabel!
	@IBOutlet weak var emailTf: UITextField!
	@IBOutlet weak var passTf: UITextField!
	@IBOutlet weak var loginBtn: UIButton!


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
		self.performSegue(withIdentifier: "toHome", sender: self)
	}
}

