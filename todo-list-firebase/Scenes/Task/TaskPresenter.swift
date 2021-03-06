//
//  TaskPresenter.swift
//  todo-list-firebase
//
//  Created by Eldar Goloviznin on 22/09/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation

enum TaskError {
    case invalidTitle
}

protocol TaskView: class {
    func setupNew()
    func set(title: String, description: String?, deadline: Date?, done: Bool)
    func error(error: TaskError)
}

class TaskPresenter {
    
    fileprivate let router: Router
    
    fileprivate var task: Task
    
    fileprivate let setupAsNew: Bool
    
    init(task: Task, router: Router) {
        self.task = task
        self.router = router
        setupAsNew = false
    }
    
    init(router: Router) {
        self.task = Task(id: "", title: "", description: nil, date: nil, done: false)
        self.router = router
        setupAsNew = true
    }
    
    fileprivate lazy var interactor: TaskInteractor = TaskInteractor()
    
    weak var view: TaskView? {
        didSet {
            if setupAsNew {
                view?.setupNew()
            } else {
                view?.set(title: task.title, description: task.description, deadline: task.date, done: task.done)
            }
        }
    }
    
    func set(title: String) {
        task.title = title
    }
    
    func set(description: String?) {
        task.description = description
    }
    
    func set(deadline: Date?) {
        task.date = deadline
    }
    
    func toggleDone() -> Bool {
        assert(!setupAsNew)
        task.done.toggle()
        return task.done
    }
    
    func create() {
        assert(setupAsNew)
        
        guard !task.title.isEmpty else {
            view?.error(error: .invalidTitle)
            return
        }
        
        interactor.add(task: task)
        
        router.dismiss()
    }
    
    func dismiss() {
        if !setupAsNew && task.title.isEmpty {
            view?.error(error: .invalidTitle)
            return
        }
        
        if !setupAsNew {
            interactor.edit(task: task)
        }
        
        router.dismiss()
    }
    
}
