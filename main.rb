NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9]

SUDOKU = [
  [5,1,3,4,nil,nil,nil,2,6],
  [nil,nil,4,7,5,2,nil,1,nil],
  [nil,7,nil,3,1,6,nil,9,5],
  [nil,6,9,nil,3,8,nil,nil,1],
  [2,nil,1,5,nil,nil,nil,6,3],
  [7,3,5,nil,9,1,nil,nil,nil],
  [nil,nil,6,nil,7,nil,nil,nil,nil],
  [nil,nil,nil,nil,nil,4,nil,nil,nil],
  [3,nil,nil,nil,nil,nil,2,nil,9]
]

def check(row, column)
  puts "Available at row:"
  p availabe_at_row = check_row(row)
  puts "Available at column:"
  p availabe_at_column = check_column(column)
  puts "Available at square:"
  p availabe_at_square = check_square(row,column)
  puts "Available:"
  p availabe_at_row & availabe_at_column & availabe_at_square
end

def check_row(row)
  NUMBERS  - SUDOKU[row]
end

def check_column(column)
  NUMBERS  - SUDOKU.transpose[column]
end

def check_square(row,column)
  square = []
  row_start = ( row / 3 ) * 3
  row_end = row_start + 2
  column_start = ( column / 3 ) * 3
  column_end = column_start + 2
  SUDOKU[row_start..row_end].each do |row|
    row[column_start..column_end].each do |value|
      square << value
    end
  end
  NUMBERS - square
end

def complete?
  SUDOKU.each do |row|
    return false if row.any?(nil)
  end
  true
end

def solve
  begin
    SUDOKU.each_with_index do |row_array, row|
      row_array.each_with_index do |value, column|
        if !value
          possibilities = check(row,column)
          p "[#{row}][#{column}] - #{possibilities}"
          if possibilities.size == 1
            SUDOKU[row][column] = possibilities.first
            raise
          end
        end
      end
    end
  rescue
    if complete?
      p "Horay!"
    else
      solve
    end
  end
end
