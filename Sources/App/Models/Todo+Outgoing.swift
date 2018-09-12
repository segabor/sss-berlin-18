import Vapor

extension Todo {
    struct Outgoing: Content {
        var id: Int?
        var title: String?
        var completed: Bool?
        var order: Int?
        var url: String
    }
}

extension Todo {
    func makeOutgoing(with req: Request) -> Outgoing {
        let idString = id?.description ?? ""
        let url = req.baseUrl + idString
        return Outgoing(id: id, title: title, completed: completed, order: order, url: url)
    }
}

extension Future where T == Todo {
    func makeOutgoing(with req: Request) -> Future<Todo.Outgoing> {
        return map { todo in
            return todo.makeOutgoing(with: req)
        }
    }
}
