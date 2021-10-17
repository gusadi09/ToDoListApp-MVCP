//
//  ToDoListViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit

class ToDoListViewController: UIViewController {
	@IBOutlet weak var toDoTable: UITableView!

	var arr = ["Test"]

    override func viewDidLoad() {
        super.viewDidLoad()
		toDoTable.delegate = self
		toDoTable.dataSource = self
    }

	@IBAction func addPressed(_ sender: UIBarButtonItem) {
		promptForAnswer()
	}

	func promptForAnswer() {
		let ac = UIAlertController(title: "Enter new task", message: nil, preferredStyle: .alert)
		ac.addTextField()

		let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned ac] _ in
			if let answer = ac.textFields?[0].text {
				if answer != "" {
					self.arr.append(answer)
				}
			}

			self.toDoTable.reloadData()
		}

		let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

		ac.addAction(submitAction)
		ac.addAction(cancel)

		present(ac, animated: true)
	}
}
