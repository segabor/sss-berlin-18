import Vapor

/// Register your application's routes here.
public func routes(_ todos: Router) throws {
    // Basic "Hello, world!" example
    todos.get("hello") { req in
        return "Hello, world!"
    }

    struct JSONExample: Content {
        let name: String
        let age: Int
        let birthday: Date
    }

    todos.get("json") { req -> JSONExample in
        return JSONExample(name: "Hello", age: 28, birthday: Date())
    }

    // Example of configuring a controller
    let todoController = TodoController()
    let todos = todos.grouped("todos")
    let todo = todos.grouped(Todo.parameter)

    todos.get(use: todoController.index)
    todo.get(use: todoController.view)
    todos.post(use: todoController.create)
    todo.patch(use: todoController.update)
    todo.delete(use: todoController.delete)
    todos.delete(use: todoController.clear)
}
