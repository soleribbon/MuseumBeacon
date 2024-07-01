//
//  DailyCalendarView.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 01/07/24.
//

import SwiftUI

struct DailyCalendarView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let date: Date = Date()

    let events: [Event] = {
        let calendar = Calendar.current
        let today = Date()
        let startOfDay = calendar.startOfDay(for: today)

        return [
            Event(startDate: calendar.date(byAdding: .hour, value: 9, to: startOfDay)!,
                  endDate: calendar.date(byAdding: .hour, value: 10, to: startOfDay)!,
                  title: "Morning Meeting"),
            Event(startDate: calendar.date(byAdding: .hour, value: 11, to: startOfDay)!,
                  endDate: calendar.date(byAdding: .hour, value: 12, to: startOfDay)!,
                  title: "Project Review"),
            Event(startDate: calendar.date(byAdding: .hour, value: 13, to: startOfDay)!,
                  endDate: calendar.date(byAdding: .minute, value: 90, to: calendar.date(byAdding: .hour, value: 13, to: startOfDay)!)!,
                  title: "Lunch Break"),
            Event(startDate: calendar.date(byAdding: .hour, value: 15, to: startOfDay)!,
                  endDate: calendar.date(byAdding: .minute, value: 55, to: calendar.date(byAdding: .hour, value: 15, to: startOfDay)!)!,
                  title: "Delegate Meeting in Room 1"),
            Event(startDate: calendar.date(byAdding: .hour, value: 17, to: startOfDay)!,
                  endDate: calendar.date(byAdding: .hour, value: 18, to: startOfDay)!,
                  title: "Europe Team Meeting")
        ]
    }()

    let hourHeight = 50.0

    var body: some View {
        VStack(alignment: .leading) {

            headerView

            ScrollView {
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(7..<19) { hour in
                            HStack {
                                Text("\(hour)")
                                    .foregroundStyle(Color("wfpBlue"))
                                    .font(.avenirNext(size: 10))
                                    .frame(width: 20, alignment: .trailing)
                                Color.gray
                                    .frame(height: 1)
                            }
                            .frame(height: hourHeight)
                        }
                    }

                    ForEach(events) { event in
                        eventCell(event)
                    }
                }
            }.scrollIndicators(.hidden)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .padding()
    }

    private var headerView: some View {
        // Date headline stack
        VStack (alignment: .leading){
            HStack {
                Text(date.formatted(.dateTime.day().month()))
                    .font(.avenirNext(size: 28))
                    .bold()
                Text(date.formatted(.dateTime.year()))
                    .font(.avenirNext(size: 28))

            }
            Text(date.formatted(.dateTime.weekday(.wide)))
                .font(.avenirNext(size: 20))
        }
        .padding([.top, .leading, .trailing])
        .foregroundStyle(Color("wfpBlue"))

    }

    func eventCell(_ event: Event) -> some View {
        let duration = event.endDate.timeIntervalSince(event.startDate)
        let height = duration / 60 / 60 * hourHeight

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: event.startDate)
        let minute = calendar.component(.minute, from: event.startDate)
        let offset = Double(hour-7) * hourHeight + Double(minute) / 60 * hourHeight

        return VStack(alignment: .leading) {
            Text(event.startDate.formatted(.dateTime.hour().minute()))
            Text(event.title)
                .fontWeight(.semibold)
        }
        .font(.avenirNext(size: 12))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(4)
        .frame(height: height, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.teal).opacity(0.5)
        )
        .padding(.trailing, 30)
        .offset(x: 30, y: offset + 24)
    }

    private var backButton : some View { Button(action: {
        presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.left")
                .accessibilityHidden(true)
                .font(.avenirNext(size: 18))
                .bold()
                .foregroundStyle(Color("wfpBlue"))
                .accessibilityLabel("Go back to the main page")
                .padding(.vertical)

            Text("Back")
                .font(.avenirNext(size: 18))
                .bold()
                .foregroundStyle(Color("wfpBlue"))
                .accessibilityLabel("Go back to the main page")
                .padding(.vertical)
        }
        .accessibilityElement(children: .combine)
    }

    }
}

struct Event: Identifiable {
    let id = UUID()
    var startDate: Date
    var endDate: Date
    var title: String
}


#Preview {
    DailyCalendarView()
}
