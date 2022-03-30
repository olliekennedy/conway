require './lib/conway'

RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length = nil

describe Board do
  describe '#initialize' do
    it 'create gospers' do
      board = Board.new(width: 45, height: 20, live_cells: [[26, 2], [24, 3], [26, 3], [14, 4], [15, 4], [22, 4], [23, 4], [36, 4], [37, 4], [13, 5], [17, 5], [22, 5], [23, 5], [36, 5], [37, 5], [2, 6], [3, 6], [12, 6], [18, 6], [22, 6], [23, 6], [2, 7], [3, 7], [12, 7], [16, 7], [18, 7], [19, 7], [24, 7], [26, 7], [12, 8], [18, 8], [26, 8], [13, 9], [17, 9], [14, 10], [15, 10]])
      expect(board.live_cells).to eq [[26, 2], [24, 3], [26, 3], [14, 4], [15, 4], [22, 4], [23, 4], [36, 4], [37, 4], [13, 5], [17, 5], [22, 5], [23, 5], [36, 5], [37, 5], [2, 6], [3, 6], [12, 6], [18, 6], [22, 6], [23, 6], [2, 7], [3, 7], [12, 7], [16, 7], [18, 7], [19, 7], [24, 7], [26, 7], [12, 8], [18, 8], [26, 8], [13, 9], [17, 9], [14, 10], [15, 10]].sort
    end
  end
  
  describe '#live_cells' do
    it 'gives the live cells of a gosper' do
      board = Board.new(width: 45,height: 20, live_cells: [[26, 2], [24, 3], [26, 3], [14, 4], [15, 4], [22, 4], [23, 4], [36, 4], [37, 4], [13, 5], [17, 5], [22, 5], [23, 5], [36, 5], [37, 5], [2, 6], [3, 6], [12, 6], [18, 6], [22, 6], [23, 6], [2, 7], [3, 7], [12, 7], [16, 7], [18, 7], [19, 7], [24, 7], [26, 7], [12, 8], [18, 8], [26, 8], [13, 9], [17, 9], [14, 10], [15, 10]])
      expect(board.live_cells).to eq [[26, 2], [24, 3], [26, 3], [14, 4], [15, 4], [22, 4], [23, 4], [36, 4], [37, 4], [13, 5], [17, 5], [22, 5], [23, 5], [36, 5], [37, 5], [2, 6], [3, 6], [12, 6], [18, 6], [22, 6], [23, 6], [2, 7], [3, 7], [12, 7], [16, 7], [18, 7], [19, 7], [24, 7], [26, 7], [12, 8], [18, 8], [26, 8], [13, 9], [17, 9], [14, 10], [15, 10]].sort
    end

  end
  
  describe '#lives_surrounding' do
    context 'not at edge' do
      it 'returns 0 on empty board' do
        board = Board.new(width: 3, height: 3)
        expect(board.live_neighbours(1, 1)).to eq 0
      end

      it 'returns 1 with a life on [0,0]' do
        board = Board.new(width: 3, height: 3, live_cells: [[0, 0]])
        expect(board.live_neighbours(1, 1)).to eq 1
      end

      it 'returns 3 with 3 surrounding lives' do
        board = Board.new(width: 3, height: 3, live_cells: [[0, 0], [2, 2], [1, 2]])
        expect(board.live_neighbours(1, 1)).to eq 3
      end
    end

    context 'at left edge' do
      it 'returns 0 on empty board' do
        board = Board.new(width: 3, height: 3)
        expect(board.live_neighbours(0, 1)).to eq 0
      end

      it 'returns 1 with a life on [0,0]' do
        board = Board.new(width: 3, height: 3, live_cells: [[0, 0]])
        expect(board.live_neighbours(0, 1)).to eq 1
      end

      it 'returns 3 with 3 surrounding lives' do
        board = Board.new(width: 3, height: 3, live_cells: [[0, 0], [1, 1], [0, 2]])
        expect(board.live_neighbours(0, 1)).to eq 3
      end
    end

    context 'at bottom right corner' do
      it 'returns 0 on empty board' do
        board = Board.new(width: 3, height: 3)
        expect(board.live_neighbours(2, 2)).to eq 0
      end

      it 'returns 1 with a life on [0,0]' do
        board = Board.new(width: 3, height: 3, live_cells: [[1, 1]])
        expect(board.live_neighbours(2, 2)).to eq 1
      end

      it 'returns 3 with 3 surrounding lives' do
        board = Board.new(width: 3, height: 3, live_cells: [[1, 2], [1, 1], [2, 1]])
        expect(board.live_neighbours(2, 2)).to eq 3
      end
    end

    context 'at top right corner' do
      it 'returns 0 on empty board' do
        board = Board.new(width: 3, height: 3)
        expect(board.live_neighbours(2, 0)).to eq 0
      end

      it 'returns 1 with a life on [0,0]' do
        board = Board.new(width: 3, height: 3, live_cells: [[1, 1]])
        expect(board.live_neighbours(2, 0)).to eq 1
      end

      it 'returns 3 with 3 surrounding lives' do
        board = Board.new(width: 3, height: 3, live_cells: [[1, 0], [1, 1], [2, 1]])
        expect(board.live_neighbours(2, 0)).to eq 3
      end
    end
  end

  describe '#should_it_live?' do
    let(:board) { Board.new(width: 3, height: 3) }

    context 'alive' do
      it 'returns false if 0' do
        expect(board.should_it_live?(true, 0)).to eq false
      end

      it 'returns true if 2' do
        expect(board.should_it_live?(true, 2)).to eq true
      end

      it 'returns true if 3' do
        expect(board.should_it_live?(true, 3)).to eq true
      end

      it 'returns false if 4' do
        expect(board.should_it_live?(true, 4)).to eq false
      end
    end

    context 'dead' do
      it 'returns false if 2' do
        expect(board.should_it_live?(false, 2)).to eq false
      end

      it 'returns true if 3' do
        expect(board.should_it_live?(false, 3)).to eq true
      end

      it 'returns false if 4' do
        expect(board.should_it_live?(false, 4)).to eq false
      end
    end
  end

  describe '#evolve' do
    context 'still life' do

      it 'keeps an empty board the same' do
        board = Board.new(width: 6, height: 6)
        board.evolve
        expect(board.live_cells).to eq [].sort
      end

      it 'block' do
        board = Board.new(width: 6, height: 6, live_cells: [[2, 2], [3, 2], [2, 3], [3, 3]])
        board.evolve
        expect(board.live_cells).to eq [[2, 2], [3, 2], [2, 3], [3, 3]].sort
      end

      it 'beehive' do
        board = Board.new(width: 6, height: 6, live_cells: [[2, 2], [3, 2], [1, 3], [4, 3], [2, 4], [3, 4]])
        board.evolve(10)
        expect(board.live_cells).to eq [[2, 2], [3, 2], [1, 3], [4, 3], [2, 4], [3, 4]].sort
      end
    end
    context 'any live cell with fewer than two live neighbours dies' do
      let(:board) { Board.new(width: 10, height: 10, live_cells: [[4, 1]]) }
      it 'kills a lone life' do
        board.evolve
        expect(board.live_cells).to eq [].sort
      end
    end

    context 'oscillators' do
      let(:board) { Board.new(width: 5, height: 5, live_cells: [[2, 1], [2, 2], [2, 3]]) }
      it 'blinker' do
        board.evolve
        expect(board.live_cells).to eq [[1, 2], [2, 2], [3, 2]].sort
        board.evolve
        expect(board.live_cells).to eq [[2, 1], [2, 2], [2, 3]].sort
      end
    end
    
    context 'gun' do
      let(:board) { Board.new(width: 45, height: 20, live_cells: [[26, 2], [24, 3], [26, 3], [14, 4], [15, 4], [22, 4], [23, 4], [36, 4], [37, 4], [13, 5], [17, 5], [22, 5], [23, 5], [36, 5], [37, 5], [2, 6], [3, 6], [12, 6], [18, 6], [22, 6], [23, 6], [2, 7], [3, 7], [12, 7], [16, 7], [18, 7], [19, 7], [24, 7], [26, 7], [12, 8], [18, 8], [26, 8], [13, 9], [17, 9], [14, 10], [15, 10]]) }
      it 'evolves the gosper glider gun correctly' do
        board.evolve(135)
        expect(board.live_cells).to eq [[2, 6], [2, 7], [3, 6], [3, 7], [6, 7], [7, 6], [7, 7], [7, 8], [8, 5], [8, 9], [9, 7], [10, 4], [10, 10], [11, 4], [11, 10], [12, 5], [12, 9], [13, 6], [13, 7], [13, 8], [18, 9], [21, 9], [22, 7], [22, 9], [23, 8], [23, 9], [27, 2], [27, 3], [27, 7], [27, 8], [28, 16], [29, 3], [29, 7], [29, 17], [30, 4], [30, 5], [30, 6], [30, 15], [30, 16], [30, 17], [31, 4], [31, 5], [31, 6], [36, 4], [36, 5], [36, 24], [37, 4], [37, 5], [37, 22], [37, 24], [38, 23], [38, 24], [43, 31], [44, 32], [45, 30], [45, 31], [45, 32], [51, 39], [52, 37], [52, 39], [53, 38], [53, 39]].sort
      end
    end
  end
end
