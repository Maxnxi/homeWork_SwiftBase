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
    case window_open = "Окна открыты"
    case window_closed = "Окна закрыты"
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
    case light_break = "легкая поломка, течет масло"
    case not_broken = "машина на ходу"
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
    func printInfoCar()
    
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
    
    func printInfoCar(){
        print("\n--------------------")
        print("Марка автомобиля: \(brand)")
        print("Год производства: \(year)")
        print("Мощность автомобиля \(engine_power) л.с.")
        print(break_state.rawValue)
        print(engine_state.rawValue , window_state.rawValue , tank_fullness.rawValue, break_state.rawValue, separator: ", ", terminator: ".\n")
        if (status_JB == .jb_activated) {
            print(status_JB.rawValue)
        }
        print("--------------------")
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
    case upgraded = "усовершенствован(ы)"
    case upgraded_Off = "стандартный(ые)"
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
            print("Раскраска автомобиля - ",painted.rawValue)
        }
    }
    private var sport_body_kit : Sport_body_kit{
        didSet {
            print(sport_body_kit.rawValue)
        }
    }
    private var wheels : Upgrades {
        didSet {
            print("Колеса - ",wheels.rawValue)
        }
    }
    private var engine : Upgrades {
        didSet {
            print("Двигатель - ",engine.rawValue)
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
            print("Ваш автомобиль - новый, Технический осмотр - не требуется!")
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
    
    func printInfoSportCar(){
    printInfoCar()
        print("Ваш автомобиль - Спорткар")
        print("Вид раскраски автомобиля - \(painted.rawValue)")
        print(sport_body_kit.rawValue)
        print("Двигатель - \(engine.rawValue)")
        print("Колеса - \(wheels.rawValue)")
        print("--------------------\n")
    }
    
    deinit {
        print("Объект удален!")
    }
    
}

extension SportCar : CustomStringConvertible {
    var description: String {
        return ("Ваш автомобиль - \(brand)")
    }
        
    }
//enum для  TrunkCar

enum TrunkKind :String {
    case coverred_trunk = "крытый кузов"
    case opened_trunk = "открытый кузов"
    case refrigerator = "кузов Холодильник"
}

enum TrailSetup : String {
    case trail_on = "Прицеп подключен"
    case trail_off = "Прицеп снят"
}

// Классс TrunkCar

class TrunkCar: Car {
    var brand: String
    var year: UInt
    var engine_power: Double
    var engine_state: EngineStatus
    var window_state: WindowStatus
    var tank_fullness: FuelQuantity
    var break_state: BreakageStatus
    var status_JB: JamesBondStatus
    
    private var trunk_kind: TrunkKind {
        didSet{
            print(trunk_kind.rawValue)
        }
    }
    private var trail_state: TrailSetup {
        didSet{
            print(trail_state.rawValue)
        }
    }
    func action() {
        
    }
    
    init(brand: String, year:UInt, engine_power: Double,
         engine_state:EngineStatus = .engineOff,
         window_state: WindowStatus = .window_closed,
         tank_fullness: FuelQuantity = .full_tank,
         break_state: BreakageStatus = .not_broken,
         trail_state: TrailSetup = .trail_off,
         trunk_kind: TrunkKind = .opened_trunk,
         status_JB: JamesBondStatus = .jb_deactivated){
        
        self.brand = brand
        self.year = year
        self.engine_power = engine_power
        self.engine_state = engine_state
        self.window_state = window_state
        self.tank_fullness = tank_fullness
        self.break_state = break_state
        self.trail_state = trail_state
        self.trunk_kind = trunk_kind
        self.status_JB = status_JB
        
    }
    
    func changeTrunk(type:TrunkKind){
        trunk_kind = type
    }
    
    func changeTrail(){
        if (trail_state == .trail_on) {
            trail_state = .trail_off
        } else {
            trail_state = .trail_on
        }
    }
    
    func printInfoTrunkCar(){
    printInfoCar()
        print("Ваш автомобиль - Грузовой")
        print("Вид кузова - \(trunk_kind.rawValue)")
        print(trail_state.rawValue)
        print("--------------------\n")
    }
    
    deinit {
        print("Объект удален!")
    }
    
    
}

extension TrunkCar : CustomStringConvertible {
    var description: String {
        return ("Ваш автомобиль - \(brand)")
    }
}



//Испытания

var sportCar1 = SportCar(brand: "Audi", year: 2020, engine_power: 262.5)

sportCar1.printInfoCar()

sportCar1.engineStart()
sportCar1.openWindow()
sportCar1.checkCarForTechnicControll()
sportCar1.refill_tank()
sportCar1.action_JB_On()
sportCar1.repair()
sportCar1.printInfoSportCar()

sportCar1.paint(type: .painted_camouflage)
sportCar1.change_sportKit()
sportCar1.upgrades(part: .engine, set: .upgraded)

sportCar1.printInfoSportCar()

print(sportCar1)

var sportCar2 = SportCar(brand: "Aston martin", year: 1958, engine_power: 300.7)
sportCar2.engineStart()
sportCar2.action_JB_On()


sportCar1 = sportCar2

print(sportCar1)

sportCar1.printInfoCar()

var sportCar3 = SportCar(brand: "TVR", year: 2011, engine_power: 526.3)

sportCar3.engineStart()

sportCar1 = sportCar3
sportCar1.printInfoCar()

var trunk1 = TrunkCar(brand: "Kamaz", year: 2019, engine_power: 400.5)
trunk1.changeTrunk(type: .refrigerator)
trunk1.changeTrail()
print(trunk1)
trunk1.printInfoTrunkCar()
