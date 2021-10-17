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

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }

	func setupUI() {
		logoutBtn.layer.cornerRadius = 10
		logoutBtn.layer.masksToBounds = false
		logoutBtn.clipsToBounds = true
	}
    
	@IBAction func logoutPressed(_ sender: UIButton) {
	}
}
