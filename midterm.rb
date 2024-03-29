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
            if card1 == card2
                return true
            end
        end
    end
    return false
end

def twopair(playerhand)
    # Make sure to put three of a kind before two pair
    playerhand = rank(playerhand)
    pair = 0
    for card1 in playerhand do
        for card2 in playerhand do
            if card1 == card2
                pair = pair + 1
                if pair == 2
                    return true
                end
            end
            pair = 0
        end
    end
    
    return false
end

def threeofakind(playerhand)
    # Make sure to put three of a kind before two pair
    pair = 0
    temp = 0
    playerhand = rank(playerhand)
    for card1 in playerhand
        playerhand = playerhand.drop(1)
        for card2 in playerhand
            if card1 == card2
                
                temp = temp + 1
            end
        end
        if temp == 2
            return true
        end
        temp = 0
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

    if temp1 == 2 and temp2 == 2
        return true
    end

    if temp2 == 2 and temp1 == 2
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

def royaleflush(playerhand)
    royale = [1,10,11,12,13]
    ranks = rank(playerhand)

    if flush(playerhand) == true && ranks == royale
        return true
    end
    return false
end

def play
    $deck = shuffle

    players = []
    for i in 0...5
        players.append(deal($deck))
    end

    for hands in players
        p hands
    end


    result = []
    for player in players
        result.append(straightflush(player))
    end
    
    for i in result
        if i == true
            puts "straightflush"
            return result
        end
    end

    result = []
    for player in players
        result.append(fullhouse(player))
    end

    for i in result
        if i == true
            puts "fullhouse"
            return result
        end
    end

    result = []
    for player in players
        result.append(flush(player))
    end

    for i in result
        if i == true
            puts "flush"
            return result
        end
    end

    result = []
    for player in players
        result.append(straight(player))
    end

    for i in result
        if i == true
            puts "straight"
            return result
        end
    end

    result = []
    for player in players
        result.append(threeofakind(player))
    end
    for i in result
        if i == true
            puts "threeofakind"
            return result
        end
    end

    result = []
    for player in players
        result.append(twopair(player))
    end
    for i in result
        if i == true
            puts twopair
            return result
        end
    end

    result = []
    for player in players
        result.append(onepair(player))
    end
    
    for i in result
        if i == true
            puts"one pair"
            return result
        end
    end

    result = []
    for player in players
        print("high card")
        result.append(highcard(player))
    end
    




end
print(play())
#player1hand = ["CQ", "HQ", "C10", "DA", "C8"]
#p player1hand
#p onepair(player1hand)
# Make sure to put three of a kind before two pair
#