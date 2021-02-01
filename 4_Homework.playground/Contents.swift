//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//
//6. Вывести значения свойств экземпляров в консоль.


import UIKit

enum EngineStatus : String {
    case engineOn = "Двигатель включен"
    case engineOff = "Двигатель выключен"
}

enum DoorsStatus : String {
    case doorsOpen = "Двери открыты"
    case doorClosed = "Двери зыкрыты"
}

enum WindowsStatus : String {
    case windowsOpened = "Окна открыты"
    case windowsClosed = "Окна закрыты"
}
enum FuelStatus : String {
    case full_tank = "Полный бак"
    case half_tank = "Половина бака"
    case empty_tank = "Пустой бак"
}
enum Actions : String {
    case move = "\nПоехали"
    case stop = "\nОстановились"
    case open_window = "\nОткрыли окна"
    case close_window = "\nЗакрыли окна"
    case put_cargo = "\nЗагрузили"
    case takeOff_cargo = "\nРазгрузили"
}

//MARK -> Класс CAR
class Car {
    var car_brand : String
    var quantity_of_Doors : Int
    var quantity_of_Wheels : Int
    var volume_of_trunk : Double
    var volume_of_cargo : Double
    
    var volume_of_fuel : FuelStatus {
        didSet{
            print(volume_of_fuel.rawValue)
        }
    }
    
    var engineState: EngineStatus {
        didSet{
            print(engineState.rawValue)
        }
    }
    
    var doorsState: DoorsStatus {
        didSet{
            print(doorsState.rawValue)
        }
    }
    
    var windowsState: WindowsStatus {
        didSet {
            print(windowsState.rawValue)
        }
    }
    
    
    
    init(car_brand: String, engineState: EngineStatus, doorsState: DoorsStatus, windowsState: WindowsStatus, quantity_of_Doors: Int, quantity_of_Wheels: Int, volume_of_trunk: Double ) {
        self.car_brand = car_brand
        self.engineState = engineState
        self.doorsState = doorsState
        self.windowsState = windowsState
        self.quantity_of_Doors = quantity_of_Doors
        self.quantity_of_Wheels = quantity_of_Wheels
        self.volume_of_trunk = volume_of_trunk
        self.volume_of_cargo = 0.0
        self.volume_of_fuel = .full_tank
    }
    
    deinit {
        print("\nОбъект удален!")
    }
    
    public func action() {
        //print("Вызвана функция action!")
    }
    func fuelUp(){
        self.volume_of_fuel = .full_tank
    }
    
    public func statusInfo(){
        print("\nИнформация о Вашем автомобиле:")
        print("Марка автомобиля: ", car_brand)
        print("Состояние двигателя:", engineState.rawValue, ", ", doorsState.rawValue,", ", windowsState.rawValue)
        print("Количество дверей: \(quantity_of_Doors), количество колес: \(quantity_of_Wheels)")
        print("Обем багажника", volume_of_trunk, ", багажник заполнен на \((volume_of_cargo/volume_of_trunk)*100) %")
        print("Топлива - ", volume_of_fuel.rawValue)
    }
}

//конец класса Car

enum Sport_car_Actions : String {
    case move = "\nПоехали"
    case speedUp = "\nГоним на всю катушку"
    case stop = "\nОстановились"
    case open_windows = "\nОткрыли окна"
    case close_windows = "\nЗакрыли окна"
    case open_doors = "\nОткрыли двери"
    case close_doors = "\nЗакрыли двери"
    case put_cargo = "\nЗагрузили"
    case takeOff_cargo = "\nРазгрузили"
    case go_racing = "\nУчаствуем в гонке!"
}

enum Sport_Category : String {
    case raceCar = "спортивного трека"
    case street_race_Car = "уличных гонок"
    case luxary_sport_car = "езды по городу"
}

enum Design : String {
    case sharped = "Острые углы"
    case rounded = "Скругленные формы"
    case unique = "Уникальный дизайн, словами не описать"
}

class SportCar : Car {
    private var max_speed : Double
    private var car_design : Design {
        didSet{
            print(car_design.rawValue)
        }
    }
    
    private let category_of_sport : Sport_Category
    
    init(car_brand:String ,engineState: EngineStatus, doorsState: DoorsStatus, windowsState: WindowsStatus, quantity_of_Doors: Int, quantity_of_Wheels: Int, volume_of_trunk: Double, max_speed: Double, car_design: Design, category_of_sport: Sport_Category) {
        self.max_speed = max_speed
        self.car_design = car_design
        self.category_of_sport = category_of_sport
        
        super.init(car_brand: car_brand, engineState: engineState, doorsState: doorsState, windowsState: windowsState, quantity_of_Doors: quantity_of_Doors, quantity_of_Wheels: quantity_of_Wheels, volume_of_trunk: volume_of_trunk)
    }
    
    public func reDisgn(type: Design){
        switch type {
        case .rounded:
            car_design = .rounded
        case .sharped:
            car_design = .sharped
        case .unique:
            car_design = .unique
        default:
            print("Проблема с запчастями!")
        }
    }
    
    public func action(type: Sport_car_Actions, cargo: Double = 0, speed: Double = 0, category_of_sport: Sport_Category = .luxary_sport_car) {
        super.action()
        switch type {
        case .move:
            engineState = .engineOn
        case .stop:
            engineState = .engineOff
        case .open_windows:
            windowsState = .windowsOpened
        case .close_windows:
            windowsState = .windowsClosed
        case .open_doors:
            doorsState = .doorsOpen
        case .close_doors:
            doorsState = .doorClosed
        case .put_cargo where cargo > 0:
            print(Sport_car_Actions.put_cargo.rawValue)
            volume_of_cargo = cargo
        case .takeOff_cargo:
            print(Sport_car_Actions.takeOff_cargo.rawValue)
        //не реалитзован метод выгрузки
        case .speedUp:
            print("Максимальный разгон до: \(max_speed) км/ч" )
            
        default:
            print("Что-то пошло не так!")
        }
    }
    
    override public func statusInfo() {
        super.statusInfo()
        print("Максимальная скорость: \(max_speed) км/ч ")
        print("Внешний вид Вашей машиный:\(car_design.rawValue)")
        print("Ваш автомобиль подходит для: \(category_of_sport.rawValue)")
        
    }
}
//конец класса SportCar


enum Trunk_car_Actions : String {
    case move = "\nПоехали"
    case careful_drive = "\nЕдим аккуратно"
    case stop = "\nОстановились"
    case open_windows = "\nОткрыли окна"
    case close_windows = "\nЗакрыли окна"
    case open_doors = "\nОткрыли двери"
    case close_doors = "\nЗакрыли двери"
    case put_cargo = "\nЗагрузили"
    case takeOff_cargo = "\nРазгрузили"
}

enum Trunk_Category : String {
    case freight_with_trailer = "грузовой с пицепом"
    case quarry_truck = "карьерный грузовик"
    case small_freight_trunk = "малый грузовик"
}

enum Trunk_kind : String {
    case uncoverred_trunk = "Открытый кузов"
    case cover_trunk = "Закрытый кузов"
    case refrigerator_trunk = "морозильный кузов"
}

//клас TrunkCar
class TrunkCar : Car {
    private var max_speed : Double
    private let trunk_category : Trunk_Category
    
    private var trunk_kind : Trunk_kind {
        didSet{
            print(trunk_kind.rawValue)
        }
    }
    
    init(car_brand:String ,engineState: EngineStatus, doorsState: DoorsStatus, windowsState: WindowsStatus, quantity_of_Doors: Int, quantity_of_Wheels: Int, volume_of_trunk: Double, max_speed: Double, trunk_category: Trunk_Category, trunk_kind: Trunk_kind) {
        self.max_speed = max_speed
        self.trunk_category = trunk_category
        self.trunk_kind = trunk_kind
        
        super.init(car_brand: car_brand, engineState: engineState, doorsState: doorsState, windowsState: windowsState, quantity_of_Doors: quantity_of_Doors, quantity_of_Wheels: quantity_of_Wheels, volume_of_trunk: volume_of_trunk)
    }
    
    public func reDisgn(type: Trunk_kind){
        switch type {
        case .cover_trunk:
            trunk_kind = .cover_trunk
        case .refrigerator_trunk:
            trunk_kind = .refrigerator_trunk
        case .uncoverred_trunk:
            trunk_kind = .uncoverred_trunk
        default:
            print("Проблема с запчастями!")
        }
    }
    
    public func action(type: Trunk_car_Actions, cargo: Double = 0) {
        //super.action()
        switch type {
        case .move:
            engineState = .engineOn
        case .stop:
            engineState = .engineOff
        case .open_windows:
            windowsState = .windowsOpened
        case .close_windows:
            windowsState = .windowsClosed
        case .open_doors:
            doorsState = .doorsOpen
        case .close_doors:
            doorsState = .doorClosed
        case .put_cargo where cargo > 0:
            print(Trunk_car_Actions.put_cargo.rawValue, " \(cargo) кг. ")
            
            self.volume_of_cargo = cargo
        case .takeOff_cargo:
            print(Trunk_car_Actions.takeOff_cargo.rawValue)
            //не реалитзован метод выгрузки
        case .careful_drive:
            print(Trunk_car_Actions.careful_drive.rawValue)
        default:
            print("Что-то пошло не так!")
        }
    }
    
    override public func statusInfo() {
        super.statusInfo()
        print("Максимальная скорость: \(max_speed) км/ч ")
        print("Вид грузовика:\(trunk_category.rawValue)")
        print("Вид кузова: \(trunk_kind.rawValue)")
        
    }
}
//конец класса TrunkCar


//Испытания

var car1 = SportCar(car_brand: "Lambordgini", engineState: .engineOff, doorsState: .doorClosed, windowsState: .windowsClosed, quantity_of_Doors: 2, quantity_of_Wheels: 4, volume_of_trunk: 100, max_speed: 250, car_design: .sharped, category_of_sport: .luxary_sport_car)

car1.statusInfo()
car1.action(type: .open_doors)
car1.reDisgn(type: .unique)
car1.action(type: .move)
car1.action(type: .open_windows)
car1.action(type: .speedUp)
car1.statusInfo()

var car2 = SportCar(car_brand: "Buugi-car", engineState: .engineOn, doorsState: .doorsOpen, windowsState: .windowsOpened, quantity_of_Doors: 3, quantity_of_Wheels: 3, volume_of_trunk: 200, max_speed: 100, car_design: .unique, category_of_sport: .raceCar)

car2.statusInfo()

car2.action(type: .speedUp)
car2.action(type: .stop)
car2.action(type: .put_cargo, cargo: 50)

car1 = car2
car1.action(type: .go_racing)
//не определил в action .go_racing, а в enum есть
car1.statusInfo()

var trunk1 = TrunkCar(car_brand: "Kamaz", engineState: .engineOn, doorsState: .doorsOpen, windowsState: .windowsOpened, quantity_of_Doors: 2, quantity_of_Wheels: 8, volume_of_trunk: 5000, max_speed: 90, trunk_category: .freight_with_trailer, trunk_kind: .uncoverred_trunk)
trunk1.statusInfo()

trunk1.fuelUp()
trunk1.action(type: .careful_drive)
trunk1.action(type: .put_cargo, cargo: 800.5)
trunk1.reDisgn(type: .refrigerator_trunk)
trunk1.statusInfo()

var trunk2 = TrunkCar(car_brand: "Mercede-Benz", engineState: .engineOff, doorsState: .doorClosed, windowsState: .windowsClosed, quantity_of_Doors: 4, quantity_of_Wheels: 16, volume_of_trunk: 1000, max_speed: 150, trunk_category: .freight_with_trailer, trunk_kind: .cover_trunk)

trunk2.action(type: .open_doors)
trunk2.action(type: .open_windows)
trunk2.action(type: .move)
trunk2.action(type: .careful_drive)

trunk2.statusInfo()

var trunk3 = TrunkCar(car_brand: "Ford", engineState: .engineOff, doorsState: .doorClosed, windowsState: .windowsOpened, quantity_of_Doors: 4, quantity_of_Wheels: 4, volume_of_trunk: 500, max_speed: 180, trunk_category: .small_freight_trunk, trunk_kind: .uncoverred_trunk)

trunk1 = trunk3
trunk2 = trunk3

trunk1.action(type: .put_cargo, cargo: 400)
trunk1.statusInfo()

