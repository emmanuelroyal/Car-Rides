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
extension Trip: RequestParameter {
    
    var asParameter: Parameter {
        return ["destination": Destination, "price": price, "date": date, "source": source, "start" : start, "stop" : stop]
    }
}
