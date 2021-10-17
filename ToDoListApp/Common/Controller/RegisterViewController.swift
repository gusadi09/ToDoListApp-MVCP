//
//  RegisterViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit

class RegisterViewController: UIViewController {
	@IBOutlet weak var registerLabel: UILabel!
	@IBOutlet weak var nameTf: UITextField!
	@IBOutlet weak var emailTf: UITextField!
	@IBOutlet weak var passTf: UITextField!
	@IBOutlet weak var ageTf: UITextField!
	@IBOutlet weak var registerBtn: UIButton!

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
		
	}
	
	@IBAction func closePressed(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
}
