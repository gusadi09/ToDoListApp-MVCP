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

		cell.textLabel?.text = arr[indexPath.row]

		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

		if editingStyle == .delete {

			// remove the item from the data model
			arr.remove(at: indexPath.row)

			// delete the table view row
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}
