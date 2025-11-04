//
//  EditEventView.swift
//  VivesPlusApp
//
//  Created by Batiste Vancoillie on 04/11/2025.
//


import SwiftUI

struct EditEventView: View {
    @Environment(UurroosterDataStore.self) private var dataStore
    @Environment(\.dismiss) private var dismiss

    let originalEvent: EventModel

    // states gevuld met de waarden van het event
    @State private var title: String = ""
    @State private var location: String = ""
    @State private var allDay: Bool = false
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var type: Int = 0   // 0 = academic, 1 = course

    init(event: EventModel) {
        self.originalEvent = event
        // let op: @State kun je niet hier vullen, doen we in .onAppear
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // titel bovenaan
            HStack {
                Spacer()
                Text("EDIT EVENT")
                    .font(.headline)
                Spacer()
            }

            // originele titel zoals in screenshot
            VStack(alignment: .leading, spacing: 2) {
                Text(originalEvent.title)
                    .font(.body)
                    .bold()
                if !originalEvent.location.isEmpty {
                    Text(originalEvent.location)
                        .foregroundStyle(.secondary)
                }
            }

            // formulier
            VStack(alignment: .leading, spacing: 16) {

                HStack {
                    Text("Location?")
                        .frame(width: 120, alignment: .trailing)
                    TextField("Location", text: $location)
                        .textFieldStyle(.roundedBorder)
                }

                HStack {
                    Text("") // voor uitlijning
                        .frame(width: 120, alignment: .trailing)
                    Toggle("All day?", isOn: $allDay)
                }

                HStack {
                    Text("Start date & time?")
                        .frame(width: 120, alignment: .trailing)
                    DatePicker("",
                               selection: $startDate,
                               displayedComponents: allDay ? [.date] : [.date, .hourAndMinute])
                        .labelsHidden()
                }

                HStack {
                    Text("End date & time?")
                        .frame(width: 120, alignment: .trailing)
                    DatePicker("",
                               selection: $endDate,
                               displayedComponents: allDay ? [.date] : [.date, .hourAndMinute])
                        .labelsHidden()
                }

                HStack {
                    Text("Type")
                        .frame(width: 120, alignment: .trailing)
                    Picker("Type", selection: $type) {
                        Text("Academic").tag(0)
                        Text("Course").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 200)
                }
            }

            HStack {
                Spacer()
                Button("UPDATE") {
                    updateEvent()
                }
                .buttonStyle(.bordered)

                Button("CANCEL") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                Spacer()
            }

            Spacer()
        }
        .padding()
        .onAppear {
            // huidige waarden van het event in de velden zetten
            title = originalEvent.title
            location = originalEvent.location
            allDay = originalEvent.allDay
            startDate = originalEvent.startDateTime
            endDate = originalEvent.endDateTime
            type = originalEvent.type
        }
    }

    private func updateEvent() {
        // nieuwe EventModel op basis van de ingevulde data
        let updated = EventModel()
        updated.id = originalEvent.id          // 👈 zelfde id is superbelangrijk
        updated.title = title
        updated.location = location
        updated.allDay = allDay
        updated.startDateTime = startDate
        updated.endDateTime = endDate
        updated.type = type

        dataStore.updateEvent(event: updated)
        dismiss()
    }
}