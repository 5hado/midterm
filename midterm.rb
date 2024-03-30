require_relative 'class'

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

def result(results,handrank)
    temp = 0
    for i in 0..4
        if results[i] == true
            temp = temp + 1
        end

        if temp == 2
            return(tie(results,handrank))
        end
    end

    for i in 0..4
        if results[i] == true
            return "Player " + (i+1).to_s + " has won with " + handrank
        end
    end
end

def tie(result,handrank)
    string = ""
    for i in 0..4
        if result[i] == true
            string = string + " Player " + (i+1).to_s
        end
    end
    return "There is a tie between " + string + " with a " + handrank + ". So they will split the pot"
end

class Ranking
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
end
def play
    $deck = shuffle

    players = []
    for i in 0...4
        players.append(deal($deck))
    end
    bet = 0
    for i in 0..4
        p "Hello, Player" + i.to_s + ". Your hand is"
        p players[i]
        p "Would you like to discard any cards?(Y/N)"
        discard = gets.chomp
        if discard == "Y"
            for i in 0..2
                p"What card would you like to discard you have "+ (3 - i).to_s +  " more discards (One at a time and Q to exit)"
                number = gets.chomp
                if number == 'Q'
                    break
                end
                players[i].delete_at((number.to_i - 1))
                p "Your new hand is" 
                $deck = $deck.drop(1)
                players[i].append($deck[0])
                p players[i]
            end
        end
        system("clear")
    end

    result = []
    for player in players
        result.append(straightflush(player))
    end
    
    for i in result
        if i == true
            return result(result,"straight flush")
        end
    end


    result = []
    for player in players
        result.append(fullhouse(player))
    end

    for i in result
        if i == true
            return (result(result,"full house"))
        end
    end

    result = []
    for player in players
        result.append(flush(player))
    end

    for i in result
        if i == true
            return result(result,"flush")
        end
    end

    result = []
    for player in players
        result.append(straight(player))
    end
    for i in result
        if i == true
            return result(result,"straight")
        end
    end

    result = []
    for player in players
        result.append(threeofakind(player))
    end
    for i in result
        if i == true
            return result(result,"three of a kind")
        end
    end

    result = []
    for player in players
        result.append(twopair(player))
    end
    for i in result
        if i == true
            return result(result,"two pair")
        end
    end

    result = []
    for player in players
        result.append(onepair(player))
    end
    
    for i in result
        if i == true
            return result(result,"one pair")
        end
    end

end

players = []
for i in 0..4
    player = MyLibrary::Player.new(i.to_s, 0 , false, 200)
    players.append(player)
end


#print(play())
