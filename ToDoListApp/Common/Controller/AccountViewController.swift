//
//  AccountViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit

class AccountViewController: UIViewController {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var logoutBtn: UIButton!
	@IBOutlet weak var editBtn: UIButton!

	var age: UInt = 0

	let token = UserDefaults.standard.object(forKey: "auth.accessToken") as? String

	let presenter = AccountPresenter(service: AuthService.shared, userService: UserService.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()

		presenter.delegate = self

		presenter.getUser(with: token ?? "")
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		presenter.getUser(with: token ?? "")
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
		presenter.logout(with: self.token ?? "")
	}

	@IBAction func editPressed(_ sender: UIButton) {
		self.performSegue(withIdentifier: "toEdit", sender: self)
	}
}
