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
                        flipped: true)
            
            counterView(count: counter.counter2,
                        increment: { counter.counter2 += 1 },
                        decrement: { counter.counter2 -= 1 },
                        flipped: false)
        }
        .background(.black)
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func counterView(count: Int, increment: @escaping () -> Void, decrement: @escaping () -> Void, flipped: Bool) -> some View {
        VStack() {
            Text("\(count)")
                .font(.system(size: 200).bold().italic())
                .foregroundStyle(.white)
                .padding(.bottom, 20)
                .animation(.spring(dampingFraction: 0.5), value: count)
                .contentTransition(.numericText())
            
            HStack() {
                Button(action: decrement) {
                    Image(systemName: "minus")
                        .font(.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }.foregroundColor(.gray)
                
                
                Button(action: increment) {
                    Image(systemName: "plus")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                }.foregroundColor(.gray)
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

