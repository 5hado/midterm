module MyLibrary
    class Player
        attr_accessor :player, :bet, :fold, :cash

        def initialize(player, bet, fold,cash)
            @player = player
            @bet = bet
            @fold = fold
            @cash = cash
        end
    end
end