def shuffle()   
    suits = ["H", "D", "C", "S"]
    ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

    deck = []

    for suit in suits do
        for rank in ranks do
            deck.append(suit+rank)
        end
    end

    deck = deck.shuffle()
    return deck
end

def deal(deck)
    playerhand = $deck[0..4]
    $deck = $deck.drop(5)
    return playerhand
end

def rank(playerhand)

    rank = []
    for card in playerhand do 
        if card[1] == 'A'
            rank.append(1)
        elsif card[1] == 'J'
            rank.append(11)
        elsif card[1] == 'Q'
            rank.append(12)
        elsif card[1] == 'K'
            rank.append(13)
        elsif card[1] == '1'
            rank.append(10)
        else
            rank.append((card[1]).to_i)
        end
    end
    return rank.sort
end

def highcard(playerhand)
    playerhand = rank(playerhand)
    return playerhand[4]
end

$deck = shuffle

player1hand = deal($deck)
player2hand = deal($deck)
player3hand = deal($deck)
player4hand = deal($deck)
player5hand = deal($deck)

p highcard(player1hand)
