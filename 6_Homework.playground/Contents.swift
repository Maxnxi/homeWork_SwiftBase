//1. Реализовать свой тип коллекции «очередь» (queue) (1,2,3 -> 1,2,3) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример:
//filter для массивов)
//3. *Добавить свой subscript, который будет возвращать nil в случае обращения к
//несуществующему индексу.

//Реализация коллекции - Космичесие Объекты
//Солнце, Планеты, Спутники, мусор

typealias Size = Double

import UIKit

protocol SpaceObjects {
    
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

struct Stack<GenericSpaceObjects> {
    private var elements: [GenericSpaceObjects] = []
    
    mutating func push(_ element: GenericSpaceObjects) {
        elements.append(element)
    }
    
    mutating func pop() -> GenericSpaceObjects? {
        return elements.removeFirst()
    }
}

var sun_galaxy = Stack<SpaceObjects>()

sun_galaxy.push(Sun(size: 100, gravity: 100))
sun_galaxy.push(Planet(size: 2, gravity: 2))
sun_galaxy.push(Planet(size: 2.5, gravity: 2))
sun_galaxy.push(Sputnik(size: 0.3, human_done: false, parentObject: Planet(size: 2.5, gravity: 2)))
sun_galaxy.push(Planet(size: 5, gravity: 4))
sun_galaxy.push(Sputnik(size: 0.01, human_done: false, parentObject: Planet(size: 5, gravity: 4)))
//sun_galaxy.push(Space_Garbage(size: 0.1, human_done: true, parentObject: Planet(size: 5, gravity: 4))
sun_galaxy.push(Planet(size: 3, gravity: 2))

let sun = sun_galaxy.pop()
let mercury = sun_galaxy.pop()
let venus = sun_galaxy.pop()
let venus_sputnik = sun_galaxy.pop()
let earth = sun_galaxy.pop()

var planets = Stack<Planet>()

