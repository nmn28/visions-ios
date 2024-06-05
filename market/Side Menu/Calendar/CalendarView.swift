//
//  CalendarView.swift
//  market
//
//  Created by Nicholas Nelson on 1/29/24.
//


import SwiftUI

struct MainCalendarView: View {
    /// View Properties
    @State private var selectedMonth: Date = .currentMonth
    @State private var selectedDate: Date = .now
//    var safeArea: EdgeInsets
   
    @EnvironmentObject var viewModel: MainViewModel
    @Binding var text: String
    @State static var searchText = ""
    var onSearchChanged: (String) -> Void
    var body: some View {
        GeometryReader { geometry in
            let totalHeight = geometry.size.height
            let safeAreaTop = geometry.safeAreaInsets.top
            let maxHeight = calendarHeight - (calendarTitleViewHeight + weekLabelHeight + 50 + topPadding + bottomPadding - 50)
//            CalendarCustomToolbar()
            CustomSearchBar(text: MainCalendarView.$searchText, onSearchChanged: { _ in })
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    
                    CalendarView()
//                        .padding(.top, geometry.safeAreaInsets.top)
                    VStack(spacing: 15) {
                        ForEach(1...15, id: \.self) { _ in
                            CardView()
                        }
                    }
                    .padding(15)
                }
            }
            .scrollIndicators(.hidden)
//            .scrollTargetBehavior(CustomScrollBehaviour(maxHeight: maxHeight))
            .ignoresSafeArea()
            .padding(.top, geometry.safeAreaInsets.top)
            
        }
    }
    
    /// Test Card View (For Scroll Content)
    @ViewBuilder
    func CardView() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.blue.gradient)
            .frame(height: 70)
            .overlay(alignment: .leading) {
                HStack(spacing: 12) {
                    Circle()
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading, spacing: 6, content: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 100, height: 5)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 70, height: 5)
                    })
                }
                .foregroundStyle(.white.opacity(0.25))
                .padding(15)
            }
    }
    
    /// Calendar View
    @ViewBuilder
    func CalendarView() -> some View {
        GeometryReader {
            let size = $0.size
            let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
            /// Converting Scroll into Progress
            let maxHeight = size.height - (calendarTitleViewHeight + weekLabelHeight  + 50 + topPadding + bottomPadding - 50)
            let progress = max(min((-minY / maxHeight), 1), 0)
            
            VStack(alignment: .leading, spacing: 0, content: {
                Text(currentMonth)
                    .font(.system(size: 35 - (10 * progress)))
                    .offset(y: -50 * progress)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .overlay(alignment: .topLeading, content: {
                        GeometryReader {
                            let size = $0.size
                            
                            Text(year)
                                .font(.system(size: 25 - (10 * progress)))
                                .offset(x: (size.width + 5) * progress, y: progress * 3)
                        }
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(alignment: .topTrailing, content: {
                        HStack(spacing: 35) {
                            Button(action: {
                                // Update to Previous Month
                                monthUpdate(false)
                            }) {
                                Image(systemName: "chevron.left")
                            }
                            .contentShape(Rectangle())
                            
                            Button(action: {
                                // Update to Next Month
                                monthUpdate(true)
                            }) {
                                Image(systemName: "chevron.right")
                            }
                            .contentShape(Rectangle())
                            
                        }
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .offset(x: 150 * progress)
                    })

                    .frame(height: calendarTitleViewHeight)
                
                VStack(spacing: 0) {
                    /// Day Labels
                    HStack(spacing: 0) {
                        ForEach(Calendar.current.weekdaySymbols, id: \.self) { symbol in
                            Text(symbol.prefix(3))
                                .font(.caption)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(height: weekLabelHeight, alignment: .bottom)
                    
                    /// Calendar Grid View
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7), spacing: 0, content: {
                        ForEach(selectedMonthDates) { day in
                            Text(day.shortSymbol)
                                .foregroundStyle(day.ignored ? .secondary : .primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .overlay(alignment: .bottom, content: {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 5, height: 5)
                                        .opacity(Calendar.current.isDate(day.date, inSameDayAs: selectedDate) ? 1 : 0)
                                        .offset(y: progress * -2)
                                })
                                .contentShape(.rect)
                                .onTapGesture {
                                    selectedDate = day.date
                                }
                        }
                    })
                    .frame(height: calendarGridHeight - ((calendarGridHeight - 50) * progress), alignment: .top)
                    .offset(y: (monthProgress * -50) * progress)
                    .contentShape(.rect)
                    .clipped()
                }
                .offset(y: progress * -50)
            })
            .foregroundStyle(.white)
            .padding(.horizontal, horizontalPadding)
            .padding(.top, topPadding)
//            .padding(.top, safeArea.top)
            .padding(.bottom, bottomPadding)
            .frame(maxHeight: .infinity)
            .frame(height: size.height - (maxHeight * progress), alignment: .top)
            .background(.red.gradient)
            /// Sticking it to top
            .clipped()
            .contentShape(.rect)
            .offset(y: -minY)
        }
        .frame(height: calendarHeight)
//        .frame(height: 450)
        .zIndex(1000)
    }
    
    /// Date Formatter
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: selectedMonth)
    }
    
    /// Month Increment/Decrement
    func monthUpdate(_ increment: Bool = true) {
        let calendar = Calendar.current
        guard let month = calendar.date(byAdding: .month, value: increment ? 1 : -1, to: selectedMonth) else { return }
        guard let date = calendar.date(byAdding: .month, value: increment ? 1 : -1, to: selectedDate) else { return }
        selectedMonth = month
        selectedDate = date
    }
    
    /// Selected Month Dates
    var selectedMonthDates: [Day] {
        return extractDates(selectedMonth)
    }
    
    /// Current Month String
    var currentMonth: String {
        return format("MMMM")
    }
    
    /// Selected Year
    var year: String {
        return format("YYYY")
    }
    
    var monthProgress: CGFloat {
        let calendar = Calendar.current
        if let index = selectedMonthDates.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: selectedDate) }) {
            return CGFloat(index / 7).rounded()
        }
        
        return 1.0
    }
    
    /// View Heights & Paddings
    var calendarHeight: CGFloat {
        return calendarTitleViewHeight + weekLabelHeight + calendarGridHeight  + topPadding + bottomPadding
    }
    
    var calendarTitleViewHeight: CGFloat {
        return 75.0
    }
    
    var weekLabelHeight: CGFloat {
        return 30.0
    }
    
    var calendarGridHeight: CGFloat {
        return CGFloat(selectedMonthDates.count / 7) * 50
    }
    
    var horizontalPadding: CGFloat {
        return 15.0
    }
    
    var topPadding: CGFloat {
        return 15.0
    }
    
    var bottomPadding: CGFloat {
        return 5.0
    }
}

struct MainCalendarView_Previews: PreviewProvider {
    @State static var isOpened = false
    @State static var searchText = ""
    static var previews: some View {
        MainCalendarView(text: MainCalendarView.$searchText, onSearchChanged: { _ in })
    }
}

/// Custom Scroll Behaviour
struct CustomScrollBehaviour: ScrollTargetBehavior {
    var maxHeight: CGFloat
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < maxHeight {
            target.rect = .zero
        }
    }
}


struct Day: Identifiable {
    var id: UUID = .init()
    var shortSymbol: String
    var date: Date
    /// Previous/Next Month Excess Dates
    var ignored: Bool = false
}

extension Date {
    static var currentMonth: Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(from: Calendar.current.dateComponents([.month, .year], from: .now)) else {
            return .now
        }
        
        return currentMonth
    }
}

extension View {
    /// Extracting Dates for the Given Month
    func extractDates(_ month: Date) -> [Day] {
        var days: [Day] = []
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        guard let range = calendar.range(of: .day, in: .month, for: month)?.compactMap({ value -> Date? in
            return calendar.date(byAdding: .day, value: value - 1, to: month)
        }) else {
            return days
        }
        
        let firstWeekDay = calendar.component(.weekday, from: range.first!)
        
        for index in Array(0..<firstWeekDay - 1).reversed() {
            guard let date = calendar.date(byAdding: .day, value: -index - 1, to: range.first!) else { return days }
            let shortSymbol = formatter.string(from: date)
            
            days.append(.init(shortSymbol: shortSymbol, date: date, ignored: true))
        }
        
        range.forEach { date in
            let shortSymbol = formatter.string(from: date)
            days.append(.init(shortSymbol: shortSymbol, date: date))
        }
        
        let lastWeekDay = 7 - calendar.component(.weekday, from: range.last!)
        
        if lastWeekDay > 0 {
            for index in 0..<lastWeekDay {
                guard let date = calendar.date(byAdding: .day, value: index + 1, to: range.last!) else { return days }
                let shortSymbol = formatter.string(from: date)
                
                days.append(.init(shortSymbol: shortSymbol, date: date, ignored: true))
            }
        }
        
        return days
    }
}

struct CalendarCustomToolbar: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        CustomToolbar(
            leftContent: {
                AnyView(VStack(alignment: .leading, spacing: -4) {
                    Text("Forecast.ai")
                        .font(.title3).fontWeight(.heavy)
                        .bold()
                    Text("date")
                        .font(.title3).fontWeight(.heavy)
                        .bold()
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                })
            },
            centerContent: {
                AnyView(Text("Calendar").font(.headline))
            },
            rightContent: {
                AnyView(HStack(spacing: 28) {
                    Button(action: {
                        viewModel.toggleSearchBarVisibility()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    Button(action: {
                        
                    }) {
                        Image(systemName: "menucard")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                })
            }
        )
    }
}
