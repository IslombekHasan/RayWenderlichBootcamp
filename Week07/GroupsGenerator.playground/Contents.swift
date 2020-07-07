//: ## Welcome to the GroupsGenerator.
/*: In order to use it, you need two things
 1. Number of people you need in a group;
 2.  an array of people, objects, actually anything you want so long as it conforms to `Equatable`.
 
 Ask your persons to choose a number between `1` and the maximum number of people you have.
 Once you have that, pass the values to the `generateGroups(of:with:)` and it'll give you the randomly generated groups with warnings if needed.
 */

func generateGroups<T: Equatable>(of numberOfPeople: Int, with people: [T]) -> [[T]] {
    var people = people
    var groups: [[T]] = []

    let margin = (Float(people.count) / Float(numberOfPeople)).rounded(.up)

    for _ in 0..<Int(margin) {
        var group: [T] = []

        while group.count < numberOfPeople && people.count > 0 {

            guard let person = people.randomElement(), let index = people.firstIndex(of: person) else {
                continue
            }

            group.append(person)
            people.remove(at: index)
        }
        if (group.count < numberOfPeople) {
            print("### Warning: the following group does not have enough members. \(numberOfPeople - group.count) more person(s) needed.")
        }
        print(group)
        groups.append(group)
    }
    print("------------------------------------------------")
    return groups
}

generateGroups(of: 4, with: Array(1...11))
generateGroups(of: 2, with: ["Mewtwo", "Pikachu", "Ash", "Naruto", "Sasuke", "Aang", "Zuko", "Uncle Iroh", "Islombek"])


