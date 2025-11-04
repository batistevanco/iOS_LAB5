import SwiftUI

struct UurroosterDetailView: View {
    let event: EventModel   // 👈 we krijgen hem nu binnen

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // header
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text(event.location)
                        .foregroundStyle(.white.opacity(0.8))
                        .font(.subheadline)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(event.type == 0 ? .red : .blue)
                .clipShape(RoundedRectangle(cornerRadius: 18))

                // tijden
                VStack(alignment: .leading, spacing: 8) {
                    Label {
                        Text(format(date: event.startDateTime))
                    } icon: {
                        Image(systemName: "play.circle")
                    }

                    Label {
                        Text(format(date: event.endDateTime))
                    } icon: {
                        Image(systemName: "stop.circle")
                    }
                }
                .font(.body)

                // soort
                HStack {
                    Text(event.type == 0 ? "Academisch" : "Vak / les")
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(.gray.opacity(0.1))
                        .clipShape(Capsule())
                    if event.allDay {
                        Text("Hele dag")
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.orange.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Uurrooster detail")
    }

    private func format(date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        return df.string(from: date)
    }
}
