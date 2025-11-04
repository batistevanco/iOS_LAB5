import SwiftUI

struct AddEventView: View {
    @Environment(UurroosterDataStore.self) private var dataStore
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var location: String = ""
    @State private var allDay: Bool = false
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var type: Int = 0   // 0 = academic, 1 = course

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            // titel bovenaan rechtszoals in screenshot
            HStack {
                Spacer()
                Text("ADD EVENT")
                    .font(.headline)
                Spacer()
            }

            // formulier
            VStack(alignment: .leading, spacing: 16) {

                HStack(alignment: .center) {
                    Text("Title?")
                        .frame(width: 120, alignment: .trailing)
                    TextField("Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                }

                HStack(alignment: .center) {
                    Text("Location?")
                        .frame(width: 120, alignment: .trailing)
                    TextField("Location", text: $location)
                        .textFieldStyle(.roundedBorder)
                }

                HStack(alignment: .center) {
                    Text("") // lege label voor uitlijning
                        .frame(width: 120, alignment: .trailing)
                    Toggle("All day?", isOn: $allDay)
                        .toggleStyle(.switch)
                        .frame(alignment: .leading)
                }

                HStack(alignment: .center) {
                    Text("Start date & time?")
                        .frame(width: 120, alignment: .trailing)
                    DatePicker("", selection: $startDate, displayedComponents: allDay ? [.date] : [.date, .hourAndMinute])
                        .labelsHidden()
                }

                HStack(alignment: .center) {
                    Text("End date & time?")
                        .frame(width: 120, alignment: .trailing)
                    DatePicker("", selection: $endDate, displayedComponents: allDay ? [.date] : [.date, .hourAndMinute])
                        .labelsHidden()
                }

                HStack(alignment: .center) {
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
                Button("SAVE") {
                    saveEvent()
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
    }

    private func saveEvent() {
        // EventModel uit jouw project is een class zonder init -> we maken hem zo:
        let newEvent = EventModel()
        newEvent.id = UUID().uuidString
        newEvent.title = title
        newEvent.location = location
        newEvent.allDay = allDay
        newEvent.startDateTime = startDate
        newEvent.endDateTime = endDate
        newEvent.type = type

        dataStore.addEvent(event: newEvent)
        dismiss()
    }
}

#Preview {
    let store = UurroosterDataStore()
    return AddEventView()
        .environment(store)
}
