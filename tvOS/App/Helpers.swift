import Foundation

struct RandomName {
    
    static let basicColors: [String] = ["Black", "Blue", "Brown", "Gray", "Green", "Orange", "Pink", "Purple", "Red", "White", "Yellow"]
    static let basicEmotions: [String] = ["Amused", "Bold", "Calm", "Edgy", "Guilty", "Happy", "Kind", "Magical", "Powerful", "Wise"]
    static let basicAnimals: [String] = ["Monkey", "Tiger", "Panda", "Horse", "Deer", "Pig", "Sheep", "Elephant", "Wolf", "Fox", "Bear", "Owl"]
    
    static func generateRandomName() -> String {
        return basicColors.randomItem() + basicEmotions.randomItem() + basicAnimals.randomItem()
    }
}

extension Array {
    func randomItem() -> Element {
        let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
        return self[randomIndex]
    }
}