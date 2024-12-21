import SwiftUI
import SwiftData

@Model
class CounterData {
    var counter1: Int
    var counter2: Int
    
    init(counter1: Int = 20, counter2: Int = 20) {
        self.counter1 = counter1
        self.counter2 = counter2
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [CounterData]
    
    var counter: CounterData {
        if let firstCounter = counters.first {
            return firstCounter
        } else {
            let newCounter = CounterData()
            modelContext.insert(newCounter)
            return newCounter
        }
    }
    
    var body: some View {
        VStack() {
            counterView(count: counter.counter1,
                        increment: { counter.counter1 += 1 },
                        decrement: { counter.counter1 -= 1 },
                        holdIncement: { counter.counter1 += 10 },
                        holdDecrement: { counter.counter1 -= 10 },
                        flipped: true)
            
            counterView(count: counter.counter2,
                        increment: { counter.counter2 += 1 },
                        decrement: { counter.counter2 -= 1 },
                        holdIncement: { counter.counter2 += 10 },
                        holdDecrement: { counter.counter2 -= 10 },
                        flipped: false)
        }
        .background(.black)
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func counterView(
        count: Int,
        increment: @escaping () -> Void,
        decrement: @escaping () -> Void,
        holdIncement: @escaping () -> Void,
        holdDecrement: @escaping () -> Void,
        flipped: Bool
    ) -> some View {
        VStack() {
            Text("\(count)")
                .font(.system(size: 200).bold().italic())
                .foregroundStyle(.white)
                .padding(.bottom, 20)
                .animation(.spring(dampingFraction: 0.5), value: count)
                .contentTransition(.numericText())
            
            HStack() {
                Button(action: {}) {
                    Image(systemName: "minus")
                        .font(.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .foregroundColor(.gray)
                .simultaneousGesture(TapGesture().onEnded { decrement() })
                 .simultaneousGesture(LongPressGesture(minimumDuration: 0.7).onEnded { _ in
                     holdDecrement()
                 })
                
                Button(action: {}) {
                    Image(systemName: "plus")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                }
                .foregroundColor(.gray)
                .simultaneousGesture(TapGesture().onEnded { increment() })
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.7).onEnded { _ in
                     holdIncement()
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .rotationEffect(.degrees(flipped ? 180: 0))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: CounterData.self, inMemory: true)
}

