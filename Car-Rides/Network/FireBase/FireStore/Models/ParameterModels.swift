//
//  ParameterModels.swift
//  Car-Rides
//
//  Created by Decagon on 8/11/21.
//

import Foundation
struct Trip {
    var Destination = ""
    var price = ""
    var date = ""
    var source = ""
    var start = ""
    var stop = ""
}

struct Message {
    var sender = ""
    var date = Date()
    var body = ""
    var opened = ""
    var time = ""
    var title = ""
}


extension Trip: RequestParameter {
    
    var asParameter: Parameter {
        return ["destination": Destination, "price": price, "date": date, "source": source, "start" : start, "stop" : stop]
    }
}

extension Message: RequestParameter {
    var asParameter: Parameter {
        return ["sender": sender, "date": date, "body": body, "opened": opened, "time": time, "title": title]
    }
}
