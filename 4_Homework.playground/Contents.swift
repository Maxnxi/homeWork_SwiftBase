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
        willSet{
            if newValue == .engineOn && volume_of_fuel == .empty_tank {
                print("Невозможно завести двигатель! отсутствует топливо!")
                engineState = .engineOff
                print(engineState.rawValue)
                return
            }
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
    
    func action() {
        
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
    
     public func action(type: Sport_car_Actions, cargo: UInt = 0, speed: Double = 0, category_of_sport: Sport_Category = .luxary_sport_car) {
        
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
            print(Actions.put_cargo.rawValue)
            
        case .takeOff_cargo:
            print(Actions.takeOff_cargo.rawValue)
            
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

//Испытания

var car1 = SportCar(car_brand: "Lambordgini", engineState: .engineOff, doorsState: .doorClosed, windowsState: .windowsClosed, quantity_of_Doors: 2, quantity_of_Wheels: 4, volume_of_trunk: 100, max_speed: 250, car_design: .sharped, category_of_sport: .luxary_sport_car)

car1.statusInfo()
car1.action(type: .open_doors)
car1.reDisgn(type: .unique)
car1.action(type: .move)
car1.action(type: .open_windows)
car1.action(type: .speedUp)
car1.statusInfo()

var car2 = SportCar(car_brand: "Buugi-car", engineState: .engineOn, doorsState: .doorsOpen, windowsState: .windowsOpened, quantity_of_Doors: 3, quantity_of_Wheels: 3, volume_of_trunk: 20, max_speed: 100, car_design: .unique, category_of_sport: .raceCar)

car2.statusInfo()

car2.action(type: .speedUp)
car2.action(type: .stop)
car2.action(type: .put_cargo, cargo: 50)

car1 = car2

car1.statusInfo()
