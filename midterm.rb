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

def suit(playerhand)

    suit = []
    for card in playerhand do
        suit.append(card[0])
    end

    return suit
end

def highcard(playerhand)
    playerhand = rank(playerhand)
    return playerhand[4]
end

def onepair(playerhand)
    playerhand = rank(playerhand)
    for card1 in playerhand
        playerhand = playerhand.drop(1)
        for card2 in playerhand
            if card1 = card2
                return true
            end
        end
    end
end

def twopair(playerhand)
    playerhand = rank(playerhand)
    pair = 0
    for card1 in playerhand do
        playerhand = playerhand.drop(1)
        for card2 in playerhand do
            p card1
            p card2
            p "===="
            if card1 == card2
                pair = pair + 1
            end
        end
    end
    if pair == 2
        return true
    end
end

def threeofakind(playerhand)
    pair = 0
    temp = 0
    playerhand = rank(playerhand)
    for card1 in playerhand
        playerhand = playerhand.drop(1)
        for card2 in playerhand
            if card1 == card2
                
                temp = temp + 1
                p temp
            end
        end
        if temp == 2
            return true
        end
    end
    return false
end

def straight(playerhand)
    rank = rank(playerhand)
    allranks = [1,2,3,4,5,6,7,8,9,10,11,12,13]

    for i in 0..8
        if rank == allranks[i..i+4]
            return true
        end
    end
    return false
end

def flush(playerhand)
    suits = suit(playerhand)
    for suit in suits do 
        if suits[0] != suit
            return false
        end
    end
    return true
end

def fullhouse(playerhand)
    ranks = rank(playerhand)
    temp1 = 0
    temp2 = 0

    for i in 1..2
        if ranks[0] == ranks[i]
            temp1 = temp1 + 1
        end
    end
    for i in 1..2
        if ranks[4] == ranks[5-i]
            temp2 = temp2 + 1
        end
    end

    if temp1 == 1 && temp2 == 2
        return true
    end

    if temp2 == 1 && temp1 == 2
        return true
    end

    return false
end

def straightflush(playerhand)

    if straight(playerhand) == true && flush(playerhand) == true
        return true
    end
    return false
end

def royalflush(playerhand)
    royale = [1,10,11,12,13]
    ranks = rank(playerhand)

    if flush(playerhand) == true && ranks == royale
        return true
    end
    return false
end

$deck = shuffle

player1hand = deal($deck)
player2hand = deal($deck)
player3hand = deal($deck)
player4hand = deal($deck)
player5hand = deal($deck)

player1hand = ["CA", "CK", "CQ", "CJ", "C10"]
p highcard(player1hand)
