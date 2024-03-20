suits = ["H", "D", "C", "S"]
ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

deck = []

for suit in suits do
    for rank in ranks do
        deck.append(suit+rank)
    end
end

deck = deck.shuffle()
puts deck