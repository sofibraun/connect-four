require 'spec_helper'

describe Board do

  before(:each) do
    @board = Board.new(1, 2, 7, 7)
  end

  describe '.check_for_winner' do

    context 'when the user won horizontally' do
      before(:each) do
        @board.play(2, 1)
        @board.play(0, 2)
        @board.play(1, 1)
        @board.play(1, 2)
        @board.play(4, 1)
        @board.play(4, 2)
        @board.play(3, 1)
      end

      it 'finds a winner' do
        expect(@board.check_for_winner([6, 3], 1)).to eq(true)
      end
    end

    context 'when the user won vertically' do
      before(:each) do
        @board.play(2, 1)
        @board.play(0, 2)
        @board.play(2, 1)
        @board.play(0, 2)
        @board.play(2, 1)
        @board.play(0, 2)
        @board.play(2, 1)
      end

      it 'finds a winner' do
        expect(@board.check_for_winner([3, 2], 1)).to eq(true)
      end
    end

    context 'when the user won in a left diagonal' do
      before(:each) do
        @board.play(0, 1)
        @board.play(0, 2)
        @board.play(0, 1)
        @board.play(1, 2)
        @board.play(0, 1)
        @board.play(1, 2)
        @board.play(1, 1)
        @board.play(2, 2)
        @board.play(2, 1)
        @board.play(4, 2)
        @board.play(3, 1)
      end

      it 'finds a winner' do
        expect(@board.check_for_winner([6, 3], 1)).to eq(true)
      end
    end

    context 'when the user won in a right diagonal' do
      before(:each) do        
        @board.play(0, 1)
        @board.play(1, 2)
        @board.play(1, 1)
        @board.play(2, 2)
        @board.play(3, 1)
        @board.play(2, 2)
        @board.play(2, 1)
        @board.play(3, 2)
        @board.play(3, 1)
        @board.play(4, 2)
        @board.play(3, 1)
      end

      it 'finds a winner' do
        expect(@board.check_for_winner([3, 3], 1)).to eq(true)
      end
    end
  end
end
