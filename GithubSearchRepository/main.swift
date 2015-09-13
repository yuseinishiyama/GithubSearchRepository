import Cocoa

if Process.arguments.count != 2 {
    print("Number of arguments must be 1")
    exit(1)
}

var keyword = Process.arguments[1]
let api = Search.Repository(searchKeyword: keyword)

do {
    try APIClient.sendRequest(api) {
        switch $0 {
        case let .Success(value):
            for item in value.items {
                print(item.owner.login + "/" + item.name)
            }
            exit(0)
        case let .Failure(error):
            print(error)
            exit(1)
        }
    }
} catch {
    print(error)
    exit(1)
}

NSThread.sleepForTimeInterval(100)
