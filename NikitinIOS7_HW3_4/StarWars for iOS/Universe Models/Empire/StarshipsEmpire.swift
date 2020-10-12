//
//  StarshipsEmpire.swift
//  StarWars
//
//  Created by Aleksey Rochev (Netology) on 19.11.2019.
//  Copyright © 2019 Aleksey Rochev (Netology). All rights reserved.
//

import Foundation

class DeathStar: StarshipImp {
        
    // MARK: - Constants
    
    private enum Constants {
        static let health = 10000
    }

    // MARK: - Lifecycle
    
    init(coordinate: Point) {
        super.init(name: "Death Star",
                   fraction: .empare,
                   coordinate: coordinate,
                   weapons: [SuperLazer()])
        health = Constants.health
    }
    
    deinit {
        print("Люк, я твой отец!")
    }
}

extension DeathStar: RadarObserver {
    func detected(object: SpaceObject) {
        do {
            try fire(to: object.coordinate)
        } catch WeaponsError.isEmpty {
            print("Нет патронов!")
        } catch {
            print("Ошибка не известна")
        }
    }
}
