//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

import UIKit
import Foundation


//var regular_respond :
//var error_respond
enum Respond_Errors: Error {
    case irregular_respond
    case irregular_length_respond
}

class Respond {
    var respond : String
    
    init(respond: String) {
        self.respond = respond
    }
}

class Respond_processing {
    private var respond :Respond
    
    init(respond:Respond){
        //guard let respond.length == 11 else {return nil}
        self.respond = respond
    }
    
    func convert_respond_2String(respond:Respond) throws -> String {
        return ("\(respond)")
    }
    
    func create_answer(respond:Respond) -> Void {
        
        return ()
    }
    
}
