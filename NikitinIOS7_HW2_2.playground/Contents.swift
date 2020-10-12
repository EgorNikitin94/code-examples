//https://github.com/netology-code/aios-homeworks/blob/master/2.2_homework.md

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Задача 1 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
struct Track {
    let name: String
    let singer: String
    let duration: (minutes: Int, seconds: Int)
    let country: String
}

class Category {
    // Category properties
    let categoryName: String
    lazy var listOfTracks: [Track] = []
    var trackCount: Int  { listOfTracks.count }
    
    // Category initializer
    init (categoryName: String) {
        self.categoryName = categoryName
    }
    
    // Category methods
    func addTrack(_ track: Track) -> [Track] {
        listOfTracks.append(track)
        return listOfTracks
    }
    func removeTrack(numberOfTrack: Int) -> [Track] {
        let indexOfTrack = numberOfTrack - 1
        if indexOfTrack < listOfTracks.count && indexOfTrack >= 0 {
            listOfTracks.remove(at: indexOfTrack)
        } else {
            print("трека под номером \(numberOfTrack) не существует")
        }
        
        return listOfTracks
    }
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Задача 2 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
class Library {
    // Library properties
    let libraryName: String
    lazy var categorys = Dictionary<String, Category>()
    var categorysCount: Int  {self.categorys.count}
    
    // Library initializer
    init(libraryName: String) {
        self.libraryName = libraryName
    }
    
    // Library methods
    func addCategory(nameOfCategory: String, category: Category) -> [String: Category] {
        categorys[nameOfCategory] = category
        return categorys
    }
    
    func removeCategory(nameOfCategory: String) {
        categorys.removeValue(forKey: nameOfCategory)
    }
    // Задача 3*
    func exchangeTracks(track: Track, numberOfTrack: Int, from: String, to: String) { // не наме оф трак
        var categoryOne: Category?
        var categoryTwo: Category?
        for value in categorys {
            if from == value.key {
                categoryOne = value.value
            }
            if to == value.key {
                categoryTwo = value.value
            }
        }
        
        if let one = categoryOne, let two = categoryTwo {
            one.removeTrack(numberOfTrack: numberOfTrack)
            two.addTrack(track)
        } else {
            print("Категория не найдена. Перенос трека между категориями не выполнен.")
        }
    }
}
let comeAsYouAre = Track(name: "Come As You Are", singer: "Nirvana", duration: (minutes: 3, seconds: 39), country: "USA")
let selfEsteem = Track(name: "Self Esteem", singer: "The Offspring", duration: (minutes: 4, seconds: 18), country: "USA")
let punkRock = Category(categoryName: "Punk rock")
let alternative = Category(categoryName: "Alternative")
punkRock.addTrack(selfEsteem)
alternative.addTrack(comeAsYouAre)
let myLibrary = Library(libraryName: "Моя библиотека")
myLibrary.addCategory(nameOfCategory: "Punk rock", category: punkRock)
myLibrary.addCategory(nameOfCategory: "Alternative", category: alternative)

myLibrary.exchangeTracks(track: selfEsteem, numberOfTrack: 1, from: "Punk rock", to: "Alternative")
punkRock.listOfTracks
alternative.listOfTracks
myLibrary.exchangeTracks(track: comeAsYouAre, numberOfTrack: 1, from: "Alternative", to: "Punk rock")
punkRock.listOfTracks
alternative.listOfTracks
