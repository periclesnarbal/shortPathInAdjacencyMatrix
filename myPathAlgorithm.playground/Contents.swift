import Foundation

struct Element {
    let value: Int
    let pos: (row: Int, col: Int)
}

func findLessCostPath(board: [[Int]]) -> Int {
    let rows = board.count
    let cols = board[0].count
    
    var resultArray = Array(repeating: Array(repeating: 0, count: cols), count: rows)
    
    var bestCurrentCostArray = [Element(value: board[0][0], pos: (0, 0))]
    resultArray[0][0] = board[0][0]
    
    var foundElement = true
    
    repeat {
        
        let element = bestCurrentCostArray.removeFirst()
        
        let possibleMoveArray = getPossibleMove((element.pos.row, element.pos.col), matrix: resultArray)
        
        let possibleElementsArray = possibleMoveArray.map({Element(value: element.value + board[$0.row][$0.col], pos: $0)}).sorted(by: { $0.value < $1.value
        })
        
        bestCurrentCostArray += possibleElementsArray
        bestCurrentCostArray = bestCurrentCostArray.sorted(by: {$0.value < $1.value})
        
        if let newElement = bestCurrentCostArray.first {
            if resultArray[newElement.pos.row][newElement.pos.col] == 0 {
                resultArray[newElement.pos.row][newElement.pos.col] = newElement.value
            } else if resultArray[newElement.pos.row][newElement.pos.col] > newElement.value {
                resultArray[newElement.pos.row][newElement.pos.col] = newElement.value
            }
            foundElement = newElement.pos == (rows - 1, cols - 1)
        }
        
        printMatrix(resultArray)
        printArray(bestCurrentCostArray)
        
    } while !foundElement
    
    return resultArray[rows - 1][cols - 1] - board[rows - 1][cols - 1]
}

func getPossibleMove(_ currentPosition: (row: Int, col: Int), matrix: [[Int]]) -> [(row: Int, col: Int)] {
    var arrayPositions = [(row: Int, col: Int)]()
    
    if isValidMove((currentPosition.row, currentPosition.col - 1), matrix: matrix) {
        arrayPositions.append((currentPosition.row, currentPosition.col - 1))
    }
    
    if isValidMove((currentPosition.row, currentPosition.col + 1), matrix: matrix) {
        arrayPositions.append((currentPosition.row, currentPosition.col + 1))
    }
    
    if isValidMove((currentPosition.row - 1, currentPosition.col), matrix: matrix) {
        arrayPositions.append((currentPosition.row - 1, currentPosition.col))
    }
    
    if isValidMove((currentPosition.row + 1, currentPosition.col), matrix: matrix) {
        arrayPositions.append((currentPosition.row + 1, currentPosition.col))
    }
    
    return arrayPositions
}

func isValidMove(_ newPosition: (row: Int, col: Int), matrix: [[Int]]) -> Bool {
    let rowInRange = newPosition.row >= 0 && newPosition.row < matrix.count
    let colInRange = newPosition.col >= 0 && newPosition.col < matrix[0].count
    return rowInRange && colInRange && matrix[newPosition.row][newPosition.col] == 0
}

func printMatrix(_ matrix: [[Int]]) {
    for row in matrix {
        print("[", terminator: " ")
        for (index, element) in row.enumerated() {
            print(element, terminator: "")
            if index != row.count - 1 {
                print(" ", terminator: "")
            }
        }
        print(" ]")
    }
    print()
}

func printArray(_ array: [Element]) {
    var result = "[ "
    for row in array {
        result += "\(row.value) "
    }
    result += "]\n"
    print(result)
}

let test1 = findLessCostPath(board: [
    [42, 51, 22, 10, 0],
    [2, 50, 7, 6, 15],
    [4, 36, 8, 30, 20],
    [0, 40, 10, 100, 1],
  ])

// 140

let test2 = findLessCostPath(board: [
    [77, 43, 89, 88, 72, 20],
    [10, 72, 98, 39, 30, 6],
    [34, 39, 81, 23, 83, 30],
    [8, 64, 86, 51, 69, 46],
    [56, 21, 5, 3, 25, 62],
    [12, 98, 66, 92, 83, 25],
  ])

//301

let test3 = findLessCostPath(board: [
    [61, 86, 59, 80, 71, 70, 99, 55],
    [48, 49, 85, 9, 50, 93, 40, 0],
    [34, 61, 26, 32, 11, 18, 2, 1],
    [51, 76, 65, 91, 74, 39, 91, 77],
    [78, 96, 33, 49, 94, 75, 47, 29],
    [96, 55, 74, 39, 28, 88, 57, 4],
    [65, 13, 86, 95, 69, 88, 1, 88],
    [85, 7, 30, 74, 40, 78, 3, 75],
  ])
//465

let test4 = findLessCostPath(board: [
    [20, 1, 49, 64, 98, 4, 14, 50, 12, 82, 11, 36, 64, 93, 13, 39],
    [52, 85, 39, 77, 98, 33, 88, 84, 22, 40, 66, 13, 41, 18, 44, 44],
    [85, 23, 80, 61, 64, 16, 73, 19, 18, 45, 87, 84, 58, 25, 74, 28],
    [4, 51, 33, 99, 70, 76, 65, 85, 55, 9, 87, 42, 19, 34, 56, 71],
    [82, 81, 6, 22, 63, 30, 28, 51, 75, 38, 22, 23, 68, 65, 1, 3],
    [64, 1, 94, 63, 49, 53, 88, 9, 75, 25, 75, 60, 27, 58, 41, 57],
    [26, 14, 100, 100, 26, 95, 55, 78, 58, 95, 18, 3, 61, 25, 57, 98],
    [20, 57, 91, 21, 52, 1, 58, 42, 49, 2, 20, 28, 54, 34, 65, 39],
    [55, 72, 34, 66, 52, 0, 33, 5, 15, 20, 13, 98, 7, 40, 12, 47],
    [89, 43, 99, 33, 20, 67, 86, 70, 62, 78, 98, 80, 47, 3, 45, 98],
  ])
//704

let test5 = findLessCostPath(board: [
    [61, 58, 36, 35, 24, 59, 60, 40, 37, 1],
    [75, 98, 27, 42, 30, 12, 45, 87, 42, 41],
    [98, 86, 11, 70, 100, 48, 66, 33, 0, 85],
    [95, 90, 1, 73, 68, 42, 64, 92, 41, 74],
    [76, 72, 5, 20, 50, 82, 74, 98, 50, 52],
    [82, 75, 60, 70, 21, 64, 27, 35, 45, 100],
    [20, 70, 40, 22, 1, 50, 4, 22, 57, 13],
    [45, 2, 15, 84, 7, 67, 36, 75, 98, 40],
    [65, 15, 53, 95, 23, 5, 94, 65, 89, 48],
    [77, 7, 63, 28, 62, 16, 86, 99, 12, 79],
    [53, 66, 52, 25, 50, 88, 72, 92, 15, 28],
    [6, 61, 39, 62, 88, 32, 87, 29, 80, 3],
    [52, 1, 29, 63, 30, 20, 48, 5, 8, 58],
    [92, 33, 88, 7, 63, 90, 95, 34, 61, 90],
    [33, 19, 78, 92, 51, 96, 93, 70, 55, 86],
    [86, 92, 86, 27, 50, 22, 23, 61, 55, 37],
    [38, 23, 64, 95, 28, 72, 63, 57, 7, 92],
    [82, 76, 36, 60, 99, 77, 100, 22, 64, 26],
    [22, 68, 1, 19, 7, 68, 53, 75, 2, 69],
    [90, 15, 72, 96, 87, 59, 27, 15, 4, 38],
  ])
//791

