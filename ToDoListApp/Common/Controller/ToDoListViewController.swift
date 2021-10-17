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

	let baseUrl = "https://api-nodejs-todolist.herokuapp.com"

	var httpHeader: HTTPHeaders = [
			"Content-Type" : "application/json",
			"Accept" : "application/json"
		]

	let token = UserDefaults.standard.object(forKey: "auth.accessToken") as? String
	let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
		toDoTable.delegate = self
		toDoTable.dataSource = self

		getTask(with: token ?? "")

		refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
		toDoTable.addSubview(refreshControl)
	}

	@objc func refresh(_ sender: AnyObject) {
		getTask(with: token ?? "")
		toDoTable.reloadData()
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
					self.addTask(with: self.token ?? "", desc: answer)
				}
			}

			self.toDoTable.reloadData()
		}

		let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

		ac.addAction(submitAction)
		ac.addAction(cancel)

		present(ac, animated: true)
	}

	func getTask(with token: String) {
		httpHeader.add(.authorization(bearerToken: token))

		AF.request(URL(string: baseUrl + "/task")!, method: .get, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseData { response in
				if let data = response.data {
					self.parseJSON(data)
				}
			}
	}

	func addTask(with token: String, desc: String) {
		httpHeader.add(.authorization(bearerToken: token))

		let params = ParamsTask(description: desc)

		AF.request(URL(string: baseUrl + "/task")!, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseData { response in
				if let data = response.data {
					self.parseJSONAdd(data)
					self.toDoTable.reloadData()
				}
			}
	}

	func updateTask(with token: String, id: String, completed: Bool) {
		httpHeader.add(.authorization(bearerToken: token))

		let params = ParamsTask(completed: completed)

		AF.request(URL(string: baseUrl + "/task/\(id)")!, method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseData { response in
				if let data = response.data {
					self.parseJSONAdd(data)

					DispatchQueue.main.async {
						self.toDoTable.reloadData()
					}
				}
			}
	}

	func deleteTask(with token: String, id: String) {
		httpHeader.add(.authorization(bearerToken: token))

		AF.request(URL(string: baseUrl + "/task/\(id)")!, method: .delete, headers: httpHeader)
			.validate(statusCode: 200..<500)
			.responseData { response in
				if let data = response.data {
					self.parseJSONAdd(data)

					DispatchQueue.main.async {
						self.toDoTable.reloadData()
					}
				}
			}
	}

	func parseJSONAdd(_ Data: Data) {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(AddResponse.self, from: Data)
			debugPrint(decodedData)

			DispatchQueue.main.async {
				self.toDoTable.reloadData()
			}
		} catch {
			print(error)
		}
	}

	func parseJSON(_ Data: Data) {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(ToDo.self, from: Data)
			debugPrint(decodedData)

			DispatchQueue.main.async {
				self.arr = decodedData.data
				self.toDoTable.reloadData()
				self.refreshControl.endRefreshing()
			}
		} catch {
			print(error)
		}
	}
}
