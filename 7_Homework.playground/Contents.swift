//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

import UIKit
import Foundation


//var regular_respond :
//var error_respond
//"Error need length between 0 and 20!"
enum Respond_Errors: Error {
    case irregular_respond
    case irregular_length_respond(lengthIs:Int)
}

class Respond {
    static let instance = Respond()
    
    init() {
    }
    
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
    //private var respond :Respond
    
    init(){
        //guard let respond.length == 11 else {return nil}
        //self.respond = respond
    }
    
    func extract_respond(respond: (String?, Respond_Errors?)) -> String {
        //TO DO
        return ("")
    }
    
    func convert_respond_to_String(respond:(String?, Respond_Errors?)) throws -> String {
        return ("\(respond)")
    }
    
//    func create_answer(respond:Respond) throws -> (String?, Respond_Errors?) {
//        guard
//
//        return (" ")
//    }
    
}



//generate_respond(mylength: 11)

// Задание №1
let respond_1 = Respond.instance.generate_respond(mylength: 3)
let respond_2 = Respond.instance.generate_respond(mylength: 21)
print(respond_1)
print(respond_2)

// Задание №2

let respond_Process1 = Respond_processing.instance.extract_respond(respond: respond_1)
print(respond_Process1)

public extension String {
  subscript(value: Int) -> Character {
    self[index(at: value)]
  }
}

public extension String {
  subscript(value: NSRange) -> Substring {
    self[value.lowerBound..<value.upperBound]
  }
}

public extension String {
  subscript(value: CountableClosedRange<Int>) -> Substring {
    self[index(at: value.lowerBound)...index(at: value.upperBound)]
  }

  subscript(value: CountableRange<Int>) -> Substring {
    self[index(at: value.lowerBound)..<index(at: value.upperBound)]
  }

  subscript(value: PartialRangeUpTo<Int>) -> Substring {
    self[..<index(at: value.upperBound)]
  }

  subscript(value: PartialRangeThrough<Int>) -> Substring {
    self[...index(at: value.upperBound)]
  }

  subscript(value: PartialRangeFrom<Int>) -> Substring {
    self[index(at: value.lowerBound)...]
  }
}

private extension String {
  func index(at offset: Int) -> String.Index {
    index(startIndex, offsetBy: offset)
  }
}


func extract_respond(respond: (String?, Respond_Errors?)) -> String {
    let tmpString = String(describing: respond.0)
    print(tmpString)
    let index1 = tmpString.lastIndex(of: ":")!
    let index2 = tmpString.lastIndex(of: "\"")!
    
    var tmp1 = String(tmpString[..<10])
//    tmp1.substring(from: index1)
//    tmp1.substring(to: index2)
    
    
    print("end", tmp1)
    //var respond = Decimal()
    
    //Scanner(string: tmpString).scanDecimal(&respond)
    //print(respond)
    return ("end")
}


extract_respond(respond: respond_1)
