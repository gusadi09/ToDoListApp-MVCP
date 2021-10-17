//
//  ListView+UITable.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import UIKit

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arr.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = toDoTable.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)

		cell.textLabel?.text = arr[indexPath.row].datumDescription
		cell.selectionStyle = .none
		if let completed = arr[indexPath.row].completed {
			cell.accessoryType = completed ? .checkmark : .none
		}

		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

		if editingStyle == .delete {

			// remove the item from the data model
			arr.remove(at: indexPath.row)

			// delete the table view row
			tableView.deleteRows(at: [indexPath], with: .fade)

			deleteTask(with: token ?? "", id: arr[indexPath.row].id ?? "")
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		updateTask(with: token ?? "", id: arr[indexPath.row].id ?? "", completed: arr[indexPath.row].completed ?? false ? false : true)
		tableView.reloadRows(at: [indexPath], with: .fade)
	}
}
