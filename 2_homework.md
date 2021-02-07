
//студент Максим Пономарев
//github




import Foundation


import UIKit

//Задание №1
let useMe = 256

func isItEven (value: Int) -> Bool {
//    заметка для себя - возможно использование - truncatingRemainder(dividingBy:2) == 0
        return (value % 2) == 0 && value != 0 ? true : false
}

print(isItEven(value: useMe))
//!! проверка на 0
print(isItEven(value: 0))

//конец задания №1
//-----------------------------------


//Задание №2
let useMe2 = 99

func isItDividedByThree (value: Int) -> Bool {
    return (value % 3) == 0 && value != 0 ? true : false
}

print(isItDividedByThree(value: useMe))
print(isItDividedByThree(value: useMe2))
//!! проверка на 0
print(isItDividedByThree(value: 0))
print(isItDividedByThree(value: -3))

//конец задания №2
//-----------------------------------


//Задание №3

var arrayOfValues: [Int] = []
for i in stride(from: 0, to: 100, by: 1) {
    arrayOfValues.append(i)
}
print(arrayOfValues)

//конец задания №3
//-----------------------------------


//Задание №4

for value in arrayOfValues {
    if isItEven(value:value) || isItDividedByThree(value:value) {
        arrayOfValues.remove(at: arrayOfValues.firstIndex(of: value)!)
    }
}

print(arrayOfValues)
//конец задания №4
//-----------------------------------


//Задание №5
print("Работаем с фибоначи")
func addIntoArrayFibonachi(array: inout [Int64]) {
//проверка если в массиве меньше 1 или 2 элементов
    if array.count >= 2 {
        let fn = array[array.count-1] + array[array.count-2]
        array.append(fn)
    } else if array.count == 1 {
        array.append(1)
    } else if array.isEmpty/*(array == [] )*/ {
        array.append(0)
        array.append(1)
    }
}

//print("\nЗаполняем Фибоначи, имеющийся массив")
//более 80 ошибка!
//for _ in (1...80){
//    addIntoArrayFibonachi(array: &arrayOfValues)
//}

print("\nЗаполняем Фибоначи, пустой массив")
var newArray:[Int64] = []

//более 92 ошибка!
for _ in (1...92){
    addIntoArrayFibonachi(array: &newArray)
}

print(newArray)

//конец задания №5
//-----------------------------------


//Задание №6
print("\nЗаполняем массив простыми числами")


let maxValue = 999

//a
var arrayForSimples:[Int] = (2...maxValue).map{$0}

//b
var peremennay_P:Int = 2

//c - Зачеркнуть в списке числа от 2 + p до n, считая шагом p
func makeNull(arrayForSimples: inout [Int], peremennay_P: Int){
    for index in arrayForSimples {
        if ((index % peremennay_P == 0) && (index != peremennay_P)) {
            arrayForSimples[arrayForSimples.firstIndex(of: index)!] = 0
        }
    }
}

//d
func increaseP(peremennay_P: inout Int) {
    let c = arrayForSimples.filter({$0 > peremennay_P})
    peremennay_P = c.first!
}

//e
repeat {
    makeNull(arrayForSimples: &arrayForSimples, peremennay_P: peremennay_P)
    increaseP(peremennay_P: &peremennay_P)
} while (peremennay_P < arrayForSimples.last!)



print("\nИтог!")
arrayForSimples.removeAll(where: {$0 == 0})
var arrayOfSimplesToPrint = arrayForSimples[1...100]
print(arrayOfSimplesToPrint)

