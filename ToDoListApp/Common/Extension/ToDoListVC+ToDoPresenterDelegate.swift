//
//  ToDoListVC+ToDoPresenterDelegate.swift
//  ToDoListApp
//
//  Created by Gus Adi on 25/10/21.
//

import Foundation

extension ToDoListViewController: ToDoPresenterDelegate {
	func didUpdateList(list: [DataToDo]) {
		arr = list
		toDoTable.reloadData()
	}

	func didFailWithError(error: Error) {
		print(error)
	}
}
