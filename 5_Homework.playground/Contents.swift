//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//
//6. Вывести сами объекты в консоль.

import UIKit

enum EngineStatus : String {
    case engineOn = "Двигатель заведен"
    case engineOff = "Двигатель выключен"
}
enum WindowStatus : String {
    case window_open = "Окно закрыто"
    case window_closed = "Окно открыто"
}
enum FuelQuantity : String {
    case full_tank = "Полный бак"
    case half_tank = "Половина бака"
    case empty_tank = "Пустой бак"
}
enum JamesBondStatus : String {
    case jb_activated = "включен режим секретности!"
    case jb_deactivated = "режим секретности выключен!"
}
enum BreakageStatus : String {
    case fully_broken = "машина сломана!"
    case light_break = "легкая поломка, течет масло."
    case not_broken = "машина на ходу."
}

protocol Car {
    var brand: String{ get set }
    var year: UInt { get set }
    var engine_power: Double { get set }
    var engine_state: EngineStatus { get set }
    var window_state: WindowStatus { get set }
    var tank_fullness: FuelQuantity { get set }
    var break_state: BreakageStatus { get set }
    var status_JB : JamesBondStatus { get set }
    
    func action()
    func printInfo()
    
}

extension Car {

    mutating func engineStart(){
        engine_state = .engineOn
        print(engine_state.rawValue)
    }
    mutating func engineStop(){
        engine_state = .engineOff
        print(engine_state.rawValue)
    }
    mutating func openWindow(){
        window_state = .window_open
        print(window_state.rawValue)
    }
    mutating func closeWindow(){
        window_state = .window_closed
        print(window_state.rawValue)
    }
    mutating func refill_tank(){
        tank_fullness = .full_tank
        print("Бензина в баке - ",tank_fullness.rawValue)
    }
    mutating func action_JB_On(){
        if self.brand == "Aston martin" {
            status_JB = .jb_activated
            print(status_JB.rawValue)
        } else {
        print("Access denied!")
        }
        
    }
    mutating func action_JB_Off(){
        if status_JB == .jb_activated{
            status_JB = .jb_deactivated
            print(status_JB.rawValue)
        } else {
            print("Access denied!")
        }
        
    }
    mutating func repair(){
        break_state = .not_broken
        print(break_state.rawValue)
    }
    mutating func crash_car(){
        break_state = .fully_broken
        print(break_state.rawValue)
    }
    
    func printInfo(){
        print("--------------------")
        print("Марка автомобиля: \(brand)")
        print("Год производства: \(year)")
        print("Можность автомобиля \(engine_power) л.с.")
        print()
    }
    
}

enum Painting_on_Car : String {
    case painted_camouflage = "камуфляж"
    case painted_bright = "яркая раскраска"
    case painted_dark = "темная раскраска"
    case standart_painted = "стандартный монотонная расскраска"
}
enum Sport_body_kit : String {
    case installed = "установлен спортивный обвес"
    case uninstalled = "снят спортвный обвес"
}
enum Upgrades : String {
    case upgraded = " усовершенствован"
    case upgraded_Off = " стандартный"
}
enum Part : String {
    case wheels = "Колеса"
    case engine = "Двигатель"
}

class SportCar: Car {
    internal var brand: String
    internal var year: UInt {
        didSet{
            checkCarForTechnicControll()
        }
    }
    internal var engine_power: Double {
        willSet {
            print("Мощность двигателя увеличена! Всего: \(newValue)")
        }
    }
    internal var engine_state: EngineStatus
    internal var window_state: WindowStatus
    internal var tank_fullness: FuelQuantity
    internal var break_state: BreakageStatus
    internal var status_JB: JamesBondStatus
    
    private var painted : Painting_on_Car {
        didSet {
            print(painted.rawValue)
        }
    }
    private var sport_body_kit : Sport_body_kit{
        didSet {
            print(sport_body_kit.rawValue)
        }
    }
    private var wheels : Upgrades {
        didSet {
            print(wheels.rawValue)
        }
    }
    private var engine : Upgrades {
        didSet {
            print(engine.rawValue)
        }
    }
    lazy var technicView_need = Bool()
    
    init(brand: String, year:UInt, engine_power: Double,
         engine_state:EngineStatus = .engineOff,
         window_state: WindowStatus = .window_closed,
         tank_fullness: FuelQuantity = .full_tank,
         break_state: BreakageStatus = .not_broken,
         painted: Painting_on_Car = .standart_painted,
         sport_body_kit: Sport_body_kit = .uninstalled,
         wheels:Upgrades = .upgraded_Off,
         engine:Upgrades = .upgraded_Off,
         status_JB: JamesBondStatus = .jb_deactivated){
        
        self.brand = brand
        self.year = year
        self.engine_power = engine_power
        self.engine_state = engine_state
        self.window_state = window_state
        self.tank_fullness = tank_fullness
        self.break_state = break_state
        self.painted = painted
        self.sport_body_kit = sport_body_kit
        self.wheels = wheels
        self.engine = engine
        self.status_JB = status_JB
        
    }
    
    func action() {
        
    }
    
    func checkCarForTechnicControll(){
        if self.year < 2018 {
            print("Вашему автомобилю необходимо проходить Технический осмотр раз в 2 года!")
            technicView_need = true
        } else {
            technicView_need = false
            print("Ваш автомобиль - новый, ТО - не требуется!")
        }
    }
    
    func paint(type:Painting_on_Car){
        self.painted = type
    }
    
    func change_sportKit(){
        if sport_body_kit == .uninstalled {
            sport_body_kit = .installed
        } else {
            sport_body_kit = .uninstalled
        }
    }
    
    func upgrades(part:Part, set: Upgrades) {
        switch part {
        case .engine:
            if engine != .upgraded{
                self.engine = .upgraded
            } else {
                self.engine = .upgraded_Off
            }
        case .wheels:
            if wheels != .upgraded {
                self.wheels = .upgraded
            } else {
                self.wheels = .upgraded_Off
            }
        }
    }
    
    
}

//extension SportCar : CustomStringConvertible {
//    var description: String {
//        return String(describing: SportCar(brand: self.brand, year: self.year, engine_power: self.engine_power))
//    }
//    
//    func printDescription(){
//        print(description)
//    }
//        
//    }
    

    

//class trunkCat: Car {}
//
//


//Испытания

var sportCar1 = SportCar(brand: "Audi", year: 2020, engine_power: 262.5)

//sportCar1.printDescription()
sportCar1.engineStart()
sportCar1.openWindow()
sportCar1.checkCarForTechnicControll()
sportCar1.refill_tank()
sportCar1.action_JB_On()
sportCar1.repair()

