import UIKit

func workHard(comletion: () -> ()) {
    for _ in 1...100 {
        print("wokr wokr wokr")
    }
    comletion()
}

workHard {
    print("done man")
}

let handler: ([String]) -> Void = { (array) in
    print("Done working, \(array)")
}

func workSuperHard(completion: ([String]) -> Void) {
    for _ in 1...100 {
        print("But you gotta put in 🔨, 🔨, 🔨")
    }
    completion(["Blog", "Course", "Editing", "Helping"])
}

workSuperHard { (thingsivedone) in
    handler(thingsivedone)
}

workSuperHard(completion: handler)
