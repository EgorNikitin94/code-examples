// https://github.com/netology-code/aios-homeworks/blob/master/2.3_homework.md

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Задача 1 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

func calculateOfFuelConsumptionOne (weight: Double, distance: Double) -> Double {
    let fuelTankCapacity = 500
    let coefficient = 1.46
    let fuelConsumption = (Double(fuelTankCapacity) / distance) * coefficient * weight
    return fuelConsumption
}

func calculateOfFuelConsumptionTwo (weight: Double, distance: Double) -> Double {
    let fuelTankCapacity = 500
    let coefficient = 3.58
    let fuelConsumption = ((Double(fuelTankCapacity) * weight) / distance) * coefficient
    return fuelConsumption
}


func showResult (weight: Double, distance: Double, closure: (Double, Double) -> Double) {
    print(closure(weight, distance))
}

showResult(weight: 200, distance: 10000, closure: calculateOfFuelConsumptionOne)
showResult(weight: 200, distance: 10000, closure: calculateOfFuelConsumptionTwo)

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Задача 2 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
let fuelConsumptionOne: (Double, Double) -> Double = {(500.0 / $1) * $0 * 1.46}
let fuelConsumptionTwo: (Double, Double) -> Double = {((500.0 * $0) / $1) * 3.58}
showResult(weight: 200, distance: 10000, closure: fuelConsumptionOne)
showResult(weight: 200, distance: 10000, closure: fuelConsumptionTwo)

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Задача 3* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// длинная запись
showResult(weight: 200, distance: 10000, closure: {(weight: Double, distance: Double) -> Double in
    return (500.0 / distance) * 1.78 * weight
})
// укороченная запись
showResult(weight: 200, distance: 10000, closure: {(weight, distance) in
    return (500.0 / distance) * 1.78 * weight
})
// самая короткая запись
showResult (weight: 200, distance: 10000, closure: {(500.0 / $1) * $0 * 1.78})
// trailing closure
showResult(weight: 200, distance: 10000) {(500.0 / $1) * $0 * 1.78}



func example(param: () -> Void) {
    // ...
}
    
example {
    //...
}
/*
 Поскольку входящий параметр функции example функция, которая ничего не принимает и не возвращает, вызывая example и ставя фигурные скобки мы можем прописать логику этого входящего параметра. Если бы мы вызвали функцию example с круглыми скобками, то param необходимо было бы указать.
 */
