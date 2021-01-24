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
    private var cargo_volume: Double
    
    var engineState: EngineStatus
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
    }
    
    init?(car_brand: String, year_issue: Int, volume_trunk: Double, cargo_volume: Double, fuel_quatity: FuelQuantity,  engineState: EngineStatus, windowState: WindowStatus, trunk_lid_state: TrunkLidStatus, fuel_quantity: FuelQuantity) {
        self.car_brand = car_brand
        self.year_issue = year_issue
        self.volume_trunk = volume_trunk
        self.cargo_volume = cargo_volume
        self.engineState = engineState
        self.windowState = windowState
        self.trunk_lid_state = trunk_lid_state
        self.fuel_quantity = fuel_quantity
    }
    
    mutating func startEngine(){
        self.engineState = .switchedOn
        print("Двигатель включен!")
    }
    
    mutating func stopEngine(){
        self.engineState = .switchedOff
        print("Двигатель выключен!")
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
    
    mutating func operateWithCargo(cargoVolumeToOperate:TrunkFulling) {
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
    }
    
    func carStatus(){
        print("\nВаш автомобиль:", car_brand, " Год производства:", year_issue, " Объем багажника:", volume_trunk, " Багажник заполнен на: \((cargo_volume/volume_trunk * 100).rounded()) % " )
        print(engineState.rawValue, windowState.rawValue, fuel_quantity.rawValue, separator: ", ", terminator: ". Конец отчета!")
    }
    
}




var car1 = SportCar(car_brand: "Ford", year_issue: 1965, volume_trunk: 300, cargo_volume: 0)
print(car1.carStatus())


car1.startEngine()
car1.openWindow()
print(car1.windowState.rawValue)
car1.changeWindowsStatus()
car1.operateWithCargo(cargoVolumeToOperate: .load_trunk(cargoVolume: 200))
print(car1.carStatus())



