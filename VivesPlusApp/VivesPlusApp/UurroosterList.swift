import SwiftUI

struct UurroosterList: View {
    @Environment(UurroosterDataStore.self) private var dataStore
    @State private var loading = true
    @State private var selectedEventId: String?

    var body: some View {
        NavigationSplitView {
            // LINKERKOLOM
            Group {
                if loading {
                    ProgressView("Uurrooster laden...")
                } else {
                    List(dataStore.uurrooster, id: \.id, selection: $selectedEventId) { event in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title).font(.headline)
                            Text(event.location)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(DateFormatter.localizedString(from: event.startDateTime,
                                                               dateStyle: .short,
                                                               timeStyle: .short))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 2)
                    }
                }
            }
            .navigationTitle("Uurrooster")
            .task {
                await dataStore.loadData()
                loading = false
                selectedEventId = dataStore.uurrooster.first?.id
            }
            .toolbar {
                // plus links
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: AddEventView()) {
                        Image(systemName: "plus")
                    }
                }
            }

        } detail: {
            // RECHTERKANT
            if let selectedEventId,
               let event = dataStore.uurrooster.first(where: { $0.id == selectedEventId }) {

                UurroosterDetailView(event: event)
                    .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                NavigationLink(destination: EditEventView(event: event)) {
                                    Image(systemName: "square.and.pencil")
                                }
                            }
                        }

            } else if loading {
                ProgressView()
            } else {
                ContentUnavailableView("Kies een event", systemImage: "calendar")
            }
        }
    }
}

#Preview {
    UurroosterList()
}
