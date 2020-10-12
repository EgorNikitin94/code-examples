//
//  WeaponsJedi.swift
//  StarWars
//
//  Created by Aleksey Rochev (Netology) on 19.11.2019.
//  Copyright © 2019 Aleksey Rochev (Netology). All rights reserved.
//

import Foundation

struct Bomb: Weapons {
    var name: String = "Bomb"
    var damage: Int = 5000
    var distance: Int = 3
    var rateOfFire: Int = 2
    var ammunition: Int = 2
}

struct LazerBlaster: Weapons {
    var name: String = "Lazer Blaster"
    var damage: Int = 1000
    var distance: Int = 15
    var rateOfFire: Int = 60
    var ammunition: Int = 100
}
