suits = ["H", "D", "C", "S"]
ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

deck = []

for suit in suits do
    for rank in ranks do
        deck.append(suit+rank)
    end
end

deck = deck.shuffle()

def deal(deck)
    playerhand = deck[0..4]
    deck = deck.drop(5)
    return playerhand
end

player1hand = deal(deck)
p player1hand