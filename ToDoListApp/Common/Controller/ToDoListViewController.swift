//
//  ToDoListViewController.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit
import Alamofire

class ToDoListViewController: UIViewController {

	@IBOutlet weak var toDoTable: UITableView!

	var arr = [DataToDo]()

	let presenter = ToDoPresenter(service: TaskService.shared)

	let token = UserDefaults.standard.object(forKey: "auth.accessToken") as? String
	let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
		toDoTable.delegate = self
		toDoTable.dataSource = self

		presenter.delegate = self
		presenter.getList(with: token ?? "")

		refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
		toDoTable.addSubview(refreshControl)
	}

	@objc func refresh(_ sender: AnyObject) {
		presenter.getList(with: token ?? "")
		toDoTable.reloadData()
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			self.refreshControl.endRefreshing()
		}
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
					self.presenter.addTask(with: self.token ?? "", desc: answer)
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
