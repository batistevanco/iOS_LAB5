//
//  UurroosterDataStore.swift
//  Uurrooster
//
//  Created by Dirk Hostens on 14/10/2022.
//

import Foundation
import Observation
import Combine

@Observable
class UurroosterDataStore {
    var uurrooster : [EventModel]
    
    init() {
        self.uurrooster = [EventModel]()
    }
    
    private func sort(){
        uurrooster.sort(by: { $0.startDateTime < $1.startDateTime })
    }
    
    func addEvent(event: EventModel ){
        uurrooster.append(event)
        sort()
    }
    
    func updateEvent(event: EventModel) {
        if let index = uurrooster.firstIndex(where: { $0.id == event.id }) {
            uurrooster[index] = event
            sort()
        }
    }
    
    func deleteEvent(id: String) {
        uurrooster.removeAll() { $0.id == id }
        sort()
    }
    
    func getEvent(id: String) -> EventModel {
        if let event = uurrooster.first(where: { $0.id == id }) {
            return event
        }
        return EventModel()
    }
    
    func addNewEvent(id: String, allDay: Bool, title: String, location: String?, type: Int, startDateTime: Date, endDateTime: Date){
        let newEvent = EventModel()
        newEvent.id = id
            newEvent.allDay = allDay
            newEvent.title = title
            newEvent.location = location ?? ""
            newEvent.startDateTime = startDateTime
            newEvent.endDateTime = endDateTime
        newEvent.type = type
        addEvent(event: newEvent)
    }
    
    func updateNewEvent(id: String, allDay: Bool, title: String, location: String?, type: Int, startDateTime: Date, endDateTime: Date) {
        let newEvent = EventModel()
        newEvent.id = id
        newEvent.allDay = allDay
        newEvent.title = title
        newEvent.location = location ?? ""
        newEvent.startDateTime = startDateTime
        newEvent.endDateTime = endDateTime
        newEvent.type = type

        updateEvent(event: newEvent)   // nu werkt dit wél omdat updateEvent op id zoekt
    }
    
    func loadData() async {
        //simulate async call
        do {
            print("⏳ Simulating 2-second load delay...")
            try await Task.sleep(for: .seconds(2)) // Simulate long load
            let data: [EventModelJson] = try load("uurrooster.json")
            //Hier komt mapping naar array van EventModel -> uurrooster
            self.uurrooster = data.map{ $0.toEventModel() }
            sort()
            print("✅ Data loaded successfully.")
            
        } catch {
            print("❌ Failed to load uurrooster:", error)
            uurrooster = [EventModel]()
        }
    }

}

private struct EventModelJson: Hashable, Codable, Identifiable {
    var id:String = ""
    var allDay: Bool = false
    var title: String = ""
    var location: String? = nil
    var type: String = ""
    var startDateTime: String = ""
    var endDateTime: String = ""
    
    var formattedStartDateTime: String {
        get {
            return startDateTime.replacingOccurrences(of: "T", with: " ")
        }
    }
    var formattedEndDateTime: String {
        get {
            return endDateTime.replacingOccurrences(of: "T", with: " ")
        }
    }
    var formattedAllDayStartTime: String {
        get {
            return String(startDateTime.split(separator: "T")[0])
        }
    }
    func getEventInput() -> (title: String, location: String, allDay: Bool, startDate: Date, endDate: Date, type: Int ) {
        return (self.title, self.location == nil ? "" : location!, allDay, DateUtil.getDate(string: startDateTime), DateUtil.getDate(string: endDateTime), type.elementsEqual("academic") ? 0 : 1)
    }
    
    func toEventModel() -> EventModel {
        let eventModel = EventModel()
        eventModel.id = self.id
        eventModel.allDay = self.allDay
        eventModel.title = self.title
        eventModel.location = self.location ?? ""
        eventModel.startDateTime = DateUtil.getDate(string: self.startDateTime)
        eventModel.endDateTime = DateUtil.getDate(string: self.endDateTime)
        if self.type.elementsEqual("academic") {
            eventModel.type = 0
        } else {
            eventModel.type = 1
        }
        return eventModel
    }
}
