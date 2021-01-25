//студент Максим Пономарев
//github
//1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//
//6. Вывести значения свойств экземпляров в консоль.

import Foundation
import UIKit

enum EngineStatus : String {
    case switchedOn = "Двигатель работает"
    case switchedOff = "Двигатель не работает"
}

enum WindowStatus : String {
    case opened_window = "Окна открыты"
    case closed_window = "Окна закрыты"
}

enum TrunkFulling {
    case load_trunk(cargoVolume: Double)
    case unload_trunk(cargoVolume: Double)
}

enum TrunkLidStatus : String{
    case opened_lid = "Дверь багажника открыта"
    case closed_lid = "Дверь багажника закрыта"
}

enum FuelQuantity : String {
    case full_tank = "полный бак"
    case half_tank = "половина бака"
    case empty_tank = "пустой бак"
}


// Structs
struct SportCar {
    let car_brand: String
    let year_issue: Int
    let volume_trunk: Double
    let quantity_of_wheels: Int
    private var cargo_volume: Double

    var engineState: EngineStatus {
        willSet{
            if fuel_quantity == .empty_tank {
                self.engineState = .switchedOff
                print("Не возможно запустить двигатель! нет топлива! Двигатель выключен!")
            }
        }
    }
    
    var windowState: WindowStatus
    var trunk_lid_state: TrunkLidStatus
    var fuel_quantity: FuelQuantity
    
    init(car_brand: String, year_issue: Int, volume_trunk: Double, cargo_volume: Double) {
        self.car_brand = car_brand
        self.year_issue = year_issue
        self.volume_trunk = volume_trunk
        self.cargo_volume = cargo_volume
        self.engineState = .switchedOff
        self.windowState = .closed_window
        self.trunk_lid_state = .closed_lid
        self.fuel_quantity = .full_tank
        self.quantity_of_wheels = 4
    }
    
    init?(car_brand: String, year_issue: Int, volume_trunk: Double, cargo_volume: Double, fuel_quatity: FuelQuantity,  engineState: EngineStatus, windowState: WindowStatus, trunk_lid_state: TrunkLidStatus, quantity_of_wheels: Int) {
        self.car_brand = car_brand
        self.year_issue = year_issue
        self.volume_trunk = volume_trunk
        self.cargo_volume = cargo_volume
        self.engineState = engineState
        self.windowState = windowState
        self.trunk_lid_state = trunk_lid_state
        self.fuel_quantity = fuel_quatity
        self.quantity_of_wheels = quantity_of_wheels
    }
    
    mutating func startEngine(){
        if self.engineState == .switchedOff {
            if self.fuel_quantity == .empty_tank {
                print("Невозможно запустить двигатель - нет топлива!")
            } else if fuel_quantity == .half_tank {
                self.engineState = .switchedOn
                print("Двигатель включен!")
                self.fuel_quantity = .empty_tank
            } else if fuel_quantity == .full_tank {
                self.engineState = .switchedOn
                self.fuel_quantity = .half_tank
                print("Двигатель включен! 123")
            }
        } else {
            print("Двигатель уже заведен!")
        }
    }
    
    mutating func stopEngine(){
        if self.engineState == .switchedOff{
            print("Двигатель уже выключен!")
        } else {
            self.engineState = .switchedOff
            print("Двигатель выключен!")
        }
    }
    
    mutating func fill_up_tank(){
        self.fuel_quantity = .full_tank
        print("Заправляем бак до полного!")
    }
    
    mutating func changeWindowsStatus(){
        if windowState == .closed_window {
            windowState = .opened_window
            print("Водитель открыл окна")
        } else {
            windowState = .closed_window
            print("Водитель закрыл окна")
        }
    }
    
    mutating func openWindow() {
        self.windowState = .opened_window
    }
    
    mutating func closeWindow() {
        self.windowState = .closed_window
    }
    
    mutating func open_trunk_lid(){
        self.trunk_lid_state = .opened_lid
    }
    mutating func close_trunk_lid(){
        self.trunk_lid_state = .closed_lid
    }
    
    mutating func operateWithCargo(cargoVolumeToOperate:TrunkFulling) {
        if trunk_lid_state == .opened_lid {
            switch cargoVolumeToOperate {
                case .load_trunk(cargoVolume: let newCargoVolume):
                    if (volume_trunk - cargo_volume) < newCargoVolume {
                        print("Мало места! можно загрузить только: \(volume_trunk - cargo_volume) кг. !")
                    } else {
                        print("загружаем", newCargoVolume, " кг.")
                        self.cargo_volume += newCargoVolume
                    }
                case .unload_trunk(cargoVolume: let newCargoVolume):
                    if self.cargo_volume < newCargoVolume {
                        print("Груза меньше, чем вы думаете: \(cargo_volume) кг. ")
                    } else {
                        print("разгружаем", newCargoVolume, " кг.")
                        self.cargo_volume -= newCargoVolume
                    }
            }
        } else {
            print("Сначала откройте багажник!")
        }
    }
    
    func carStatus(){
        print("\nВаш автомобиль:", car_brand, " Год производства:", year_issue, "Количество колес", quantity_of_wheels , " Объем багажника:", volume_trunk, " Багажник заполнен на: \((cargo_volume/volume_trunk * 100).rounded()) % " )
        print(engineState.rawValue, windowState.rawValue, fuel_quantity.rawValue, separator: ", ", terminator: ". Конец отчета!\n")
    }
}

struct TrunkCar {
    let car_brand: String
    let year_issue: Int
    let volume_trunk: Double
    let quantity_of_wheels: Int
    private var cargo_volume: Double

    var engineState: EngineStatus {
        willSet{
            if fuel_quantity == .empty_tank {
                self.engineState = .switchedOff
                print("Не возможно запустить двигатель! нет топлива! Двигатель выключен!")
            }
        }
    }
    
    var windowState: WindowStatus
    var trunk_lid_state: TrunkLidStatus
    var fuel_quantity: FuelQuantity
    
    init(car_brand: String, year_issue: Int, volume_trunk: Double, cargo_volume: Double) {
        self.car_brand = car_brand
        self.year_issue = year_issue
        self.volume_trunk = volume_trunk
        self.cargo_volume = cargo_volume
        self.engineState = .switchedOff
        self.windowState = .closed_window
        self.trunk_lid_state = .closed_lid
        self.fuel_quantity = .full_tank
        self.quantity_of_wheels = 6
    }
    
    init?(car_brand: String, year_issue: Int, volume_trunk: Double, cargo_volume: Double, fuel_quatity: FuelQuantity,  engineState: EngineStatus, windowState: WindowStatus, trunk_lid_state: TrunkLidStatus, quantity_of_wheels: Int) {
        self.car_brand = car_brand
        self.year_issue = year_issue
        self.volume_trunk = volume_trunk
        self.cargo_volume = cargo_volume
        self.engineState = engineState
        self.windowState = windowState
        self.trunk_lid_state = trunk_lid_state
        self.fuel_quantity = fuel_quatity
        self.quantity_of_wheels = quantity_of_wheels
    }
    
    mutating func startEngine(){
        if self.engineState == .switchedOff {
            if self.fuel_quantity == .empty_tank {
                self.stopEngine()
                print("Невозможно запустить двигатель - нет топлива! Двигатель автоматически выключен!")
            } else if fuel_quantity == .half_tank {
                self.engineState = .switchedOn
                print("Двигатель включен!")
                self.fuel_quantity = .empty_tank
            } else if fuel_quantity == .full_tank {
                self.engineState = .switchedOn
                self.fuel_quantity = .half_tank
                print("Двигатель включен!")
            }
        } else {
            print("Двигатель уже заведен!")
        }
    }
    
    mutating func stopEngine(){
        if self.engineState == .switchedOff{
            print("Двигатель уже выключен!")
        } else {
            self.engineState = .switchedOff
            print("Двигатель выключен!")
        }
    }
    
    mutating func fill_up_tank(){
        self.fuel_quantity = .full_tank
        print("Заправляем бак до полного!")
    }
    
    mutating func changeWindowsStatus(){
        if windowState == .closed_window {
            windowState = .opened_window
            print("Водитель открыл окна")
        } else {
            windowState = .closed_window
            print("Водитель закрыл окна")
        }
    }
    
    mutating func openWindow() {
        self.windowState = .opened_window
    }
    
    mutating func closeWindow() {
        self.windowState = .closed_window
    }
    
    mutating func open_trunk_lid(){
        self.trunk_lid_state = .opened_lid
    }
    mutating func close_trunk_lid(){
        self.trunk_lid_state = .closed_lid
    }
    
    mutating func operateWithCargo(cargoVolumeToOperate:TrunkFulling) {
        if trunk_lid_state == .opened_lid {
            switch cargoVolumeToOperate {
                case .load_trunk(cargoVolume: let newCargoVolume):
                    if (volume_trunk - cargo_volume) < newCargoVolume {
                        print("Мало места! можно загрузить только: \(volume_trunk - cargo_volume) кг. !")
                    } else {
                        print("загружаем", newCargoVolume, " кг.")
                        self.cargo_volume += newCargoVolume
                    }
                case .unload_trunk(cargoVolume: let newCargoVolume):
                    if self.cargo_volume < newCargoVolume {
                        print("Груза меньше, чем вы думаете: \(cargo_volume) кг. ")
                    } else {
                        print("разгружаем", newCargoVolume, " кг.")
                        self.cargo_volume -= newCargoVolume
                    }
            }
        } else {
            print("Чтобы загрузить Груз - откройте кузов!")
        }
    }
    
    func carStatus(){
        print("\nВаш автомобиль:", car_brand, " Год производства:", year_issue, "Количество колес", quantity_of_wheels , " Объем багажника:", volume_trunk, " Кузов заполнен на: \((cargo_volume/volume_trunk * 100).rounded()) % " )
        print(engineState.rawValue, windowState.rawValue, fuel_quantity.rawValue, separator: ", ", terminator: ". Конец отчета!\n")
    }
}

//Structs end

//Испытания

var car1 = SportCar(car_brand: "Ford", year_issue: 1965, volume_trunk: 300, cargo_volume: 0)
print(car1.carStatus())

car1.startEngine()
car1.openWindow()
print(car1.windowState.rawValue)

car1.changeWindowsStatus()
car1.operateWithCargo(cargoVolumeToOperate: .load_trunk(cargoVolume: 200))
car1.open_trunk_lid()
car1.operateWithCargo(cargoVolumeToOperate: .load_trunk(cargoVolume: 200))
car1.operateWithCargo(cargoVolumeToOperate: .load_trunk(cargoVolume: 200))
car1.operateWithCargo(cargoVolumeToOperate: .unload_trunk(cargoVolume: 100))
car1.operateWithCargo(cargoVolumeToOperate: .load_trunk(cargoVolume: 200))

car1.carStatus()


var car2 = SportCar(car_brand: "Маруся", year_issue: 2012, volume_trunk: 200, cargo_volume: 15, fuel_quatity: .empty_tank, engineState: .switchedOn, windowState: .opened_window, trunk_lid_state: .closed_lid, quantity_of_wheels: 3)
car2?.carStatus()

car2?.startEngine()
car2?.stopEngine()
car2?.startEngine()
car2?.open_trunk_lid()
car2?.operateWithCargo(cargoVolumeToOperate: .unload_trunk(cargoVolume: 100))
car2?.operateWithCargo(cargoVolumeToOperate: .unload_trunk(cargoVolume: 15))
car2?.changeWindowsStatus()
car2?.carStatus()

car2?.fill_up_tank()

let text = car2?.fuel_quantity.rawValue
let trimSpot = text?.firstIndex(of: " ") ?? text?.endIndex
let trimmedText = text![..<trimSpot!]
print("Бак - \(trimmedText)")
car2?.carStatus()


var car3 = TrunkCar(car_brand: "КАМАЗ", year_issue: 2020, volume_trunk: 5000, cargo_volume: 3500)
car3.carStatus()
car3.startEngine()
car3.openWindow()
car3.operateWithCargo(cargoVolumeToOperate: .load_trunk(cargoVolume: 500.6))
car3.open_trunk_lid()
car3.operateWithCargo(cargoVolumeToOperate: .load_trunk(cargoVolume: 5000))
car3.operateWithCargo(cargoVolumeToOperate: .unload_trunk(cargoVolume: 5000))
car3.stopEngine()
car3.stopEngine()
car3.startEngine()

print("\nПроверка бака - ", car3.fuel_quantity.rawValue)
car3.stopEngine()
car3.startEngine()
car3.fill_up_tank()
car3.startEngine()
car3.carStatus()
