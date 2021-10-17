//
//  ToDoListPresenter.swift
//  ToDoListApp
//
//  Created by Gus Adi on 17/10/21.
//

import Foundation

protocol ToDoPresenterDelegate: NSObjectProtocol {
	func didUpdateList(list: [DataToDo])
	func didFailWithError(error: Error)
}

final class ToDoPresenter {
	private let taskService: TaskService
	weak var delegate: ToDoPresenterDelegate?

	init(service: TaskService) {
		self.taskService = service
	}

	func getList(with token: String) {
		taskService.getTask(with: token) { result, error in
			if result != nil {
				self.delegate?.didUpdateList(list: result?.data ?? [])
			} else {
				self.delegate?.didFailWithError(error: error as! Error)
			}
		}
	}

	func addTask(with token: String, desc: String) {
		taskService.addTask(with: token, desc: desc) { result, error in
			if result != nil {
				self.getList(with: token)
			} else {
				self.delegate?.didFailWithError(error: error as! Error)
			}
		}
	}

	func updateTask(with token: String, id: String, completed: Bool) {
		taskService.updateTask(with: token, id: id, completed: completed) { result, error in
			if result != nil {
				self.getList(with: token)
			} else {
				self.delegate?.didFailWithError(error: error as! Error)
			}
		}
	}

	func deleteTask(with token: String, id: String) {
		taskService.deleteTask(with: token, id: id) { result, error in
			if result != nil {
				self.getList(with: token)
			} else {
				self.delegate?.didFailWithError(error: error as! Error)
			}
		}
	}
}
