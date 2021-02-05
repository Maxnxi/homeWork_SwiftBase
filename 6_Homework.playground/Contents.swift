//1. Реализовать свой тип коллекции «очередь» (queue) (1,2,3 -> 1,2,3) c использованием дженериков.

//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример:
//filter для массивов)

//3. *Добавить свой subscript, который будет возвращать nil в случае обращения к
//несуществующему индексу.

//Реализация коллекции - Космичесие Объекты
//Солнце, Планеты, Спутники, мусор

typealias Size = Double

import Foundation
import UIKit

//protocol Sizable {
//    var size : Size {get set}
//}
protocol SpaceObjects {
    var size: Size { get set }
}

protocol GiantObjects {
    var gravity: Double { get set }
}
protocol SmallObjects {
    var parentObject: GiantObjects { get set }
}

class Planet: SpaceObjects, GiantObjects {
    var size: Size
    var gravity: Double
    init(size:Size, gravity: Double){
        self.size = size
        self.gravity = gravity
    }
}

class Sun: SpaceObjects, GiantObjects {
    var size: Size
    var gravity: Double
    init(size:Size, gravity: Double){
        self.size = size
        self.gravity = gravity
    }
}

class Sputnik: SpaceObjects, SmallObjects {
    var size: Size
    let human_done: Bool
    var parentObject: GiantObjects
    
    init(size: Size, human_done: Bool, parentObject: GiantObjects) {
        self.size = size
        self.human_done = human_done
        self.parentObject = parentObject
    }
}

class Space_Garbage: SpaceObjects {
    var size: Size
    let human_done: Bool
    var parentObject: GiantObjects?
    
    init(size: Size, human_done: Bool, parentObject: GiantObjects) {
        self.size = size
        self.human_done = human_done
        self.parentObject = parentObject
    }
    
}

// Stack
struct Stack<GenericSpaceObjects> {
    
     var elements: [GenericSpaceObjects] = []
    
    mutating func push(_ element: GenericSpaceObjects) {
        elements.append(element)
    }
    
    mutating func pop() -> GenericSpaceObjects {
        return elements.removeFirst()
    }
    
    //Замыкание
     public let closureFilterPlanet: (GenericSpaceObjects?) -> Bool = { (object:GenericSpaceObjects?) -> Bool in return type(of: object) == Planet.self }

    mutating func filterPlanet(predicate: (GenericSpaceObjects?) -> Bool ) -> [GenericSpaceObjects] {
        var tmpArray:[GenericSpaceObjects] = []
        for element in elements {
            if predicate(element) {
                tmpArray.append(element)
            }
        }
        return tmpArray
     }
    
    subscript(indexes:UInt ...) -> Int {
        
        var total_count = 0
        for index in indexes //where index >= 0 && index < self.elements.count {
        {
            if index > self.elements.count {
                print("nil")
            } else {
                total_count += 1
                print("Элемент - #", index)
            }
    }
    return total_count
}
}


var sun_galaxy = Stack<SpaceObjects>()

sun_galaxy.push(Sun(size: 100, gravity: 100))
sun_galaxy.push(Planet(size: 2, gravity: 2))
sun_galaxy.push(Planet(size: 2.5, gravity: 2))
sun_galaxy.push(Sputnik(size: 0.3, human_done: false, parentObject: Planet(size: 2.5, gravity: 2)))
sun_galaxy.push(Planet(size: 5, gravity: 4))
sun_galaxy.push(Sputnik(size: 0.01, human_done: false, parentObject: Planet(size: 5, gravity: 4)))
sun_galaxy.push(Space_Garbage(size: 0.01, human_done: true, parentObject: Planet(size: 5, gravity: 4)))
sun_galaxy.push(Planet(size: 3, gravity: 2))

let sun = sun_galaxy.pop()
let mercury = sun_galaxy.pop()
let venus = sun_galaxy.pop()
let venus_sputnik = sun_galaxy.pop()
let earth = sun_galaxy.pop()




var new_galaxy = Stack<SpaceObjects>()

new_galaxy.push(Planet(size: 3, gravity: 2))
new_galaxy.push(Sun(size: 200, gravity: 200))
new_galaxy.push(Space_Garbage(size: 0.02, human_done: false, parentObject: Sun(size: 200, gravity: 200)))
new_galaxy.push(Planet(size: 5, gravity: 4))
new_galaxy.push(Planet(size: 7, gravity: 3))
new_galaxy.push(Space_Garbage(size: 0.03, human_done: false, parentObject: Planet(size: 7, gravity: 3)))
new_galaxy.push(Planet(size: 7, gravity: 4))



//Задание №2
//не много запутался и замыкание к функции из Stack - не работает
//вынес замыкание - проверка на класс Planet

var planet2 = new_galaxy.pop()
var sun2 = new_galaxy.pop()

let closure2FilterPlanet: (SpaceObjects) -> Bool = { (object:SpaceObjects) -> Bool in return type(of: object) == Planet.self }

closure2FilterPlanet(planet2)
closure2FilterPlanet(sun2)

//var new_Arr_Planets = new_galaxy.filterPlanet(predicate: Stack.closureFilterPlanet)



//Задание №3


new_galaxy[1,20,2,4,10]
