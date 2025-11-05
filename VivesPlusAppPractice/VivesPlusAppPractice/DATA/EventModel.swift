//
//  UurroosterModel.swift
//  Uurrooster
//
//  Created by Dirk Hostens on 23/08/2022.
//

import Foundation

@Observable
class EventModel: Identifiable, Hashable {
    var id:String = ""
    var allDay: Bool = false
    var title: String = ""
    var location: String = ""
    var type: Int = 0
    var startDateTime: Date = Date()
    var endDateTime: Date = Date()
    
    //Equatable
    static func == (lhs: EventModel, rhs: EventModel) -> Bool {
        lhs.id == rhs.id
    }
    
    //Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        /*hasher.combine(allDay)
        hasher.combine(title)
        hasher.combine(location)
        hasher.combine(type)
        hasher.combine(startDateTime)
        hasher.combine(endDateTime)*/
    }
    
    init() {
        
    }
    
    init(from: EventModel) {
        self.id = from.id
        self.allDay = from.allDay
        self.title = from.title
        self.location = from.location
        self.type = from.type
        self.startDateTime = from.startDateTime
        self.endDateTime = from.endDateTime
    }
}
