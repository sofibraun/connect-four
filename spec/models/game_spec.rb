require 'spec_helper'

describe Board do

  before(:each) do
    @game = Game.create(player_1_id: 1, player_2_id: 2)
    @board = @game.board
  end

  describe '.check_for_winner' do

    context 'when the user won horizontally' do
      before(:each) do
        @game.play!(2, 1)
        @game.play!(0, 2)
        @game.play!(1, 1)
        @game.play!(1, 2)
        @game.play!(4, 1)
        @game.play!(4, 2)
        @game.play!(3, 1)
      end

      it 'finds a winner' do
        expect(@board.check_for_winner([6, 3], 1)).to eq(true)
      end
    end

    context 'when the user won vertically' do
      before(:each) do
        @game.play!(2, 1)
        @game.play!(0, 2)
        @game.play!(2, 1)
        @game.play!(0, 2)
        @game.play!(2, 1)
        @game.play!(0, 2)
        @game.play!(2, 1)
      end

      it 'finds a winner' do
        expect(@board.check_for_winner([3, 2], 1)).to eq(true)
      end
    end

    context 'when the user won in a left diagonal' do
      before(:each) do
        @game.play!(0, 1)
        @game.play!(0, 2)
        @game.play!(0, 1)
        @game.play!(1, 2)
        @game.play!(0, 1)
        @game.play!(1, 2)
        @game.play!(1, 1)
        @game.play!(2, 2)
        @game.play!(2, 1)
        @game.play!(4, 2)
        @game.play!(3, 1)
      end

      it 'finds a winner' do
        expect(@board.check_for_winner([6, 3], 1)).to eq(true)
      end
    end

    context 'when the user won in a right diagonal' do
      before(:each) do        
        @game.play!(0, 1)
        @game.play!(1, 2)
        @game.play!(1, 1)
        @game.play!(2, 2)
        @game.play!(3, 1)
        @game.play!(2, 2)
        @game.play!(2, 1)
        @game.play!(3, 2)
        @game.play!(3, 1)
        @game.play!(4, 2)
        @game.play!(3, 1)
      end

      it 'finds a winner' do
        expect(@board.check_for_winner([3, 3], 1)).to eq(true)
      end
    end
  end
end
