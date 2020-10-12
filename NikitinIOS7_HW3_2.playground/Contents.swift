// https://github.com/netology-code/aios-homeworks/blob/master/3.2_homework.md

enum Brand {
    case kia
    case hyundai
    case renault
    case toyota
    case bmw
}

enum Color {
    case black
    case white
    case gray
    case blue
    case red
    case yellow
}

enum Accessories {
    case toning
    case signaling
    case sportsDiscs
    case antiNoise
    case ceramicCoating
    case medicineСhest
    case fireExtinguisher
    
}

protocol CarProtocol {
    var model: String {get}
    var color: Color {get}
    var buildDate: (day: Int, month: Int, year: Int) {get}
    var price: Double {get set}
    var accessories: [Accessories] {get set}
    var isServiced: Bool {get set}
}


protocol DealershipProtocol: AnyObject {
    var name: Brand {get}
    var showroomCapacity: Int {get}
    var stockCars: [Car] {get set}
    var showroomCars: [Car] {get set}
    var cars: [Car] {get set}
    
    func offerAccesories(_ accessories : [Accessories])
    func presaleService(_ car: inout Car)
    func addToShowroom(_ car: inout Car)
    func sellCar(_ car: inout Car)
    func orderCar(_ car: Car)
}

protocol SpecialOfferProtocol {
    func addEmergencyPack()
    func makeSpecialOffer()
}

// MARK: - Создаем структуры и классы

struct Car: CarProtocol {
    let model: String
    let color: Color
    let buildDate: (day: Int, month: Int, year: Int)
    var price: Double
    var accessories: [Accessories]
    var isServiced: Bool
}

extension Car: Equatable {
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.model == rhs.model &&
        lhs.color == rhs.color &&
        lhs.buildDate == rhs.buildDate &&
        lhs.price == rhs.price &&
        lhs.accessories == rhs.accessories &&
        lhs.isServiced == rhs.isServiced
    }
}

class Dealership: DealershipProtocol {
    var name: Brand
    var showroomCapacity: Int
    var stockCars: [Car] = []
    var showroomCars: [Car] = []
    var cars: [Car] {
        get {return stockCars + showroomCars}
        
        set {}
    }
    
    init(name: Brand,showroomCapacity: Int) {
        self.name = name
        self.showroomCapacity = showroomCapacity
        
    }
    
    func offerAccesories(_ accessories : [Accessories]) {
        print("Наш дилерский центр может предложить вам \(accessories)")
    }
    
    func presaleService(_ car: inout Car) {
        if car.isServiced == false {
            car.isServiced.toggle()
            print("Предпродажная подготовка на автомобиле выполнена")
        } else {
            print("Предпродажная подготовка на данном автомобиле  уже была проведена")
        }
    }
    
    func addToShowroom(_ car: inout Car) {
        var removeIndex: Int = 0
        let carName = stockCars.map( {$0.model} )
        for (index, value) in stockCars.enumerated(){
            if value.model == car.model {
                removeIndex = index
            }
        }
        if carName.contains(car.model) == true {
            if showroomCars.count < showroomCapacity {
                stockCars.remove(at: removeIndex)
                presaleService(&car)
                showroomCars.append(car)
                print("Автомобиль \(car.model) перегнали с парковки в шоу рум")
            } else {
                print("Шоу рум переполнен. Автомобиль \(car.model) остается на парковке.")
            }
        } else {
            print("Автомобиль \(car.model) на отсутствует на парковке дилерского центра")
        }
    }
    
    func sellCar(_ car: inout Car) {
        let additionalOptions: [Accessories] = [.antiNoise, .ceramicCoating, .signaling, .sportsDiscs, .toning]
        var removeIndex = 0
        for (index, value) in showroomCars.enumerated() {
            if value.model == car.model {
                removeIndex = index
            }
        }
        if showroomCars.contains(car) == true {
            if car.isServiced == true && car.accessories.isEmpty == false {
                showroomCars.remove(at: removeIndex)
                print("Автомобиль \(car.model) продан!")
            } else if car.isServiced == true && car.accessories.isEmpty == true {
                offerAccesories(additionalOptions)
                car.accessories.append(contentsOf: additionalOptions)
                showroomCars.remove(at: removeIndex)
                print("Клиент согласился на установку всего дополнительного оборудования. Автомобиль \(car.model)  продан!")
            } else {
                print("Необходимо провести предпродажную  подготовку на автомобиле \(car.model) перед продажей")
            }
        } else {
            print("Автомобиль \(car.model) отсутствует в шоуруме :(")
        }
    }
    
    func orderCar(_ car: Car) {
        stockCars.append(car)
        print("Автомобиль \(car.model) добавлен на парковку дилерского центра")
    }
}

extension Dealership: SpecialOfferProtocol {
    func addEmergencyPack() {
        var emptyArrayOne: [Car] = []
        var emptyArrayTwo: [Car] = []
        
        var emptyArrayThree: [Car] = []
        var emptyArrayFour: [Car] = []
        
        for car in stockCars {
            if car.buildDate.year < 2020 {
                var carIn = car
                let accessories = car.accessories + [.medicineСhest, .fireExtinguisher]
                carIn.accessories = accessories
                emptyArrayOne.append(carIn)
            } else {
                emptyArrayTwo.append(car)
            }
        }
        for car in showroomCars {
            if car.buildDate.year < 2020 {
                var carIn = car
                let accessories = car.accessories + [.medicineСhest, .fireExtinguisher]
                carIn.accessories = accessories
                emptyArrayThree.append(carIn)
            } else {
                emptyArrayFour.append(car)
            }
        }
    stockCars = emptyArrayOne + emptyArrayTwo
    showroomCars = emptyArrayThree + emptyArrayFour
}

func makeSpecialOffer(){
    addEmergencyPack()
    var emptyArrayTwo: [Car] = []
    
    var emptyArrayThree: [Car] = []
    var emptyArrayFour: [Car] = []
    
    for car in stockCars {
        if car.buildDate.year < 2020 {
            var carIn = car
            let price = car.price * 0.85
            carIn.price = price
            addToShowroom(&carIn)
        } else {
            emptyArrayTwo.append(car)
        }
    }
    
    for car in showroomCars {
        if car.buildDate.year < 2020 {
            var carIn = car
            let price = car.price * 0.85
            carIn.price = price
            emptyArrayThree.append(carIn)
        } else {
            emptyArrayFour.append(car)
        }
    }
    stockCars = emptyArrayTwo
    showroomCars = emptyArrayThree + emptyArrayFour
}
}

class KiaDealership: Dealership {
    let tagline = "The Power to Surprise"
}

class HyundaiDealership: Dealership {
    let tagline = "New thinking"
    
}

class RenaultDealership: Dealership {
    let tagline = "Renault - Passion for life"
}

class ToyotaDealership: Dealership {
    let tagline = "Управляй мечтой!"
}

class BmwDealership: Dealership {
    let tagline = "Восторг восхищает мощью"
}


// MARK: - Экземпляры
var seltos = Car(model: "KIA Seltos", color: .yellow, buildDate: (day: 03, month: 04, year: 2020), price: 2_100_000, accessories: [], isServiced: false)
var ceed = Car(model: "KIA Cee'd", color: .blue, buildDate: (day: 06, month: 07, year: 2017), price: 930_000, accessories: [.signaling], isServiced: true)
var stinger = Car(model: "KIA Stinger", color: .red, buildDate: (day: 01, month: 01, year: 2018), price: 1_930_000, accessories: [.signaling, .ceramicCoating, .sportsDiscs], isServiced: true)

var sonata = Car(model: "Hyundai Sonata", color: .black, buildDate: (day: 15, month: 12, year: 2019), price: 2_000_000, accessories: [.signaling, .toning], isServiced: true)
var santaFe = Car(model: "Hyundai Santa Fe", color: .gray, buildDate: (day: 25, month: 11, year: 2019), price: 2_200_000, accessories: [.signaling], isServiced: false)
var solaris = Car(model: "Hyundai Solaris", color: .white, buildDate: (day: 11, month: 12, year: 2020), price: 700_000, accessories: [], isServiced: false)

var arcana = Car(model: "Renault Arcana", color: .red, buildDate: (day: 10, month: 02, year: 2020), price: 1_200_000, accessories: [.signaling], isServiced: false)
var duster = Car(model: "Renault Duster", color: .gray, buildDate: (day: 23, month: 10, year: 2018), price: 954_678, accessories: [], isServiced: true)
var kaleos = Car(model: "Renault Kaleos", color: .white, buildDate: (day: 03, month: 05, year: 2018), price: 1_800_00, accessories: [.antiNoise, .signaling], isServiced: true)

var fortuner = Car(model: "Toyota Fortuner", color: .black, buildDate: (day: 15, month: 02, year: 2019), price: 2_800_000, accessories: [.signaling], isServiced: true)
var camry = Car(model: "Toyota Camry", color: .black, buildDate: (day: 31, month: 12, year: 2019), price: 2_000_000, accessories: [], isServiced: false)
var landCruiser200 = Car(model: "Toyota LandCruiser 200", color: .black, buildDate: (day: 15, month: 08, year: 2020), price: 6_000_000, accessories: [.signaling, .antiNoise, .toning], isServiced: false)

var bmw340i = Car(model: "BMW 340i", color: .red, buildDate: (day: 04, month: 03, year: 2020), price: 4_000_000, accessories: [.sportsDiscs], isServiced: false)
var bmw530d = Car(model: "BMW 530d", color: .blue, buildDate: (day: 07, month: 03, year: 2020), price: 6_700_000, accessories: [.sportsDiscs, .signaling], isServiced: false)
var bmw740i = Car(model: "BMW 740i", color: .black, buildDate: (day: 03, month: 02, year: 2020), price: 8_000_000, accessories: [.sportsDiscs, .ceramicCoating], isServiced: false)



let favoritKia = KiaDealership(name: .kia, showroomCapacity: 7)
favoritKia.orderCar(seltos)
favoritKia.orderCar(ceed)
favoritKia.orderCar(stinger)
favoritKia.addToShowroom(&seltos)
favoritKia.addToShowroom(&stinger)
favoritKia.sellCar(&ceed)
favoritKia.cars
print("-----------------------------")

let ascHyundai = HyundaiDealership(name: .hyundai, showroomCapacity: 5)
ascHyundai.orderCar(sonata)
ascHyundai.orderCar(santaFe)
ascHyundai.orderCar(solaris)
ascHyundai.addToShowroom(&sonata)
ascHyundai.addToShowroom(&solaris)
ascHyundai.sellCar(&solaris)
ascHyundai.addToShowroom(&santaFe)
ascHyundai.stockCars.append(solaris)
print(ascHyundai.cars.count)
print("-----------------------------")

let rolfRenault = RenaultDealership(name: .renault, showroomCapacity: 4)
rolfRenault.orderCar(arcana)
rolfRenault.orderCar(duster)
rolfRenault.orderCar(kaleos)
rolfRenault.addToShowroom(&arcana)
rolfRenault.addToShowroom(&kaleos)
print("-----------------------------")

let majorToyota = ToyotaDealership(name: .toyota, showroomCapacity: 7)
majorToyota.orderCar(fortuner)
majorToyota.orderCar(camry)
majorToyota.orderCar(landCruiser200)
majorToyota.addToShowroom(&fortuner)
majorToyota.addToShowroom(&landCruiser200)
print("-----------------------------")

let autoDomBmw = BmwDealership(name: .bmw, showroomCapacity: 7)
autoDomBmw.orderCar(bmw340i)
autoDomBmw.orderCar(bmw530d)
autoDomBmw.orderCar(bmw740i)
autoDomBmw.addToShowroom(&bmw340i)
autoDomBmw.addToShowroom(&bmw530d)
print("-----------------------------")


var autoBusiness: [Dealership] = []
autoBusiness.append(favoritKia)
autoBusiness.append(ascHyundai)
autoBusiness.append(rolfRenault)
autoBusiness.append(majorToyota)
autoBusiness.append(autoDomBmw)

for item in autoBusiness {
    if let dealer = item as? KiaDealership {
        print(dealer.tagline)
    }
    if let dealer = item as? HyundaiDealership {
        print(dealer.tagline)
    }
    if let dealer = item as? RenaultDealership {
        print(dealer.tagline)
    }
    if let dealer = item as? ToyotaDealership {
        print(dealer.tagline)
    }
    if let dealer = item as? BmwDealership {
        print(dealer.tagline)
    }
}
print("-----------------------------")



favoritKia.makeSpecialOffer()
favoritKia.cars

ascHyundai.makeSpecialOffer()
ascHyundai.cars

majorToyota.makeSpecialOffer()
majorToyota.cars


