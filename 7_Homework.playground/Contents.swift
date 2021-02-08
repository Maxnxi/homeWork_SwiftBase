//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

import UIKit
import Foundation


enum Respond_Errors: Error {
    case irregular_respond
    case irregular_length_respond(lengthIs:Int)
}

class Respond {
    static let instance = Respond()
    
    public func generate_respond(mylength:Int) -> (String?, Respond_Errors?) {
        guard mylength >= 0 && mylength < 20 else {return (nil, Respond_Errors.irregular_length_respond(lengthIs: mylength)) }
        var tmp_respond = ""
        for _ in 0..<mylength {
            let random_Int = String("\(arc4random_uniform(10))")
            tmp_respond.append(random_Int)
        }
        return ("Respond length is:\(mylength) and self:\(tmp_respond)", nil)
    }
}

class Respond_processing {
    static let instance = Respond_processing()
    
    func extract_respond(respond: (String?, Respond_Errors?)) throws -> String {
        guard (respond.0 != nil) else {throw Respond_Errors.irregular_respond}
        let tmpString = String(describing: respond.0)
        
        //let errIndex: String.Index = tmpString.endIndex
        let index1: String.Index = tmpString.lastIndex(of: ":")! //?? errIndex
        let index2: String.Index = tmpString.lastIndex(of: "\"")! //?? errIndex
        let tmp1 = String(tmpString[..<index2])
        var tmp2 = String(tmp1[index1...])
        tmp2.remove(at: tmp2.startIndex)
        
        guard tmp2.count == 11 else {throw Respond_Errors.irregular_length_respond(lengthIs: tmp2.count)}
        return ("\(tmp2)")
    }
    
//    func convert_respond_to_String(respond:(String?, Respond_Errors?)) throws -> String {
//        return ("\(respond)")
//    }
//    func create_answer(respond:Respond) throws -> (String?, Respond_Errors?) {
//        guard (respond.0 != nil) else {throw Respond_Errors.irregular_respond}
//        guard tmp2.count == 11 else {throw Respond_Errors.irregular_length_respond(lengthIs: tmp2.count)}
//        return (" ")
//    }
    
}

//Испытания
// Задание №1
let example1 = "\nЗадание №1\n"
print(example1)
let respond_1 = Respond.instance.generate_respond(mylength: 3)
let respond_2 = Respond.instance.generate_respond(mylength: 11)
let respond_3 = Respond.instance.generate_respond(mylength: 11)
let respond_4 = Respond.instance.generate_respond(mylength: 21)
let respond_5 = Respond.instance.generate_respond(mylength: 11)
print(respond_1)
print(respond_2)
print(respond_3)
print(respond_4)
print(respond_5)

// Задание №2
let example2 = "\nЗадание №2\n"
print(example2)

do {
    let respond_Process1 = try Respond_processing.instance.extract_respond(respond: respond_1)
} catch Respond_Errors.irregular_respond {
  print("Не правильный отклик")
} catch Respond_Errors.irregular_length_respond(let mylength) {
    print("Не правильная длина отклика - \(mylength)")
}

do {
    let respond_Process2 = try Respond_processing.instance.extract_respond(respond: respond_2)
    print("отклик успешен")
    let respond_Process3 = try Respond_processing.instance.extract_respond(respond: respond_3)
    print("отклик успешен")
} catch Respond_Errors.irregular_respond {
  print("Не правильный отклик")
} catch Respond_Errors.irregular_length_respond(let mylength) {
    print("Не правильная длина отклика - \(mylength)")
}

do {
        let respond_Process4 = try Respond_processing.instance.extract_respond(respond: respond_4)
        let _ = try Respond_processing.instance.extract_respond(respond: respond_5) // не выпоняется из-за ошибки в respond_4
        print("отклик успешен")
    } catch Respond_Errors.irregular_respond {
      print("Не правильный отклик")
    } catch Respond_Errors.irregular_length_respond(let mylength) {
        print("Не правильная длина отклика - \(mylength)")
    }
