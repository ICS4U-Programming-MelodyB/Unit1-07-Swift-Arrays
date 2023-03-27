// This program reads information from file, 
// it then calculates mean, median, and mode.
//
//  Created by Melody Berhane
//  Created on 2023-03-22.
//  Version 1.0
//  Copyright (c) 2023 Melody. All rights reserved.
import Foundation

import Foundation

// This function calculates the mean.
func calcMean(arrayNum: [Int]) -> Double {
    // Declare variables.
    var mean = 0.0
    var sum = 0.0
    // Loop to access elements to calculate mean.
    for aNum in arrayNum {
        sum += Double(aNum)
    }
    mean = sum / Double(arrayNum.count)
    // Return to main function.
    return mean
}

// This function calculates the median.
func calcMedian(arrayNum: [Int]) -> Double {
    // Declare variables.
    var median = 0.0
    let aNum = arrayNum.count

    // Calculate median, check for cases.
    // Case if odd.
    if aNum % 2 != 0 {
        median = Double(arrayNum[aNum / 2])
    } else {
        // Case if even.
        median = Double(arrayNum[aNum / 2 - 1] + arrayNum[aNum / 2]) / 2.0
    }
    // Return back to main.
    return median
}

// This function calculates the mode.
func calcMode(arrayNum: [Int]) -> [Int] {
  // Declare variables.
  var count = 0
  var maxCount = 0
  var count2 = 0

  // Declare list.
  var listOfModes: [Int] = []

  // Find the maximum count of any repeating elements.
  for aNum in arrayNum {
    count = 0
    for count3 in arrayNum {
      if count3 == aNum {
        count = count + 1
      }
    }

    // Clear array if count > maxCount,
    // if it's equalled to add the element
    // to list.
    if count > maxCount {
      maxCount = count
      listOfModes.removeAll()
      listOfModes.append(aNum)
    } else if count == maxCount {
      listOfModes.append(aNum)
    }
  }

  // Remove duplicates.
  if listOfModes.count > 1 {
    var aNumInModes = 1
    while aNumInModes < listOfModes.count {
      if listOfModes[aNumInModes] == listOfModes[aNumInModes - 1] {
        listOfModes.remove(at: aNumInModes)
      } else {
        aNumInModes = aNumInModes + 1
      }
    }
  }

  // Convert list to array.
  var arrayMode = [Int](repeating: 0, count: listOfModes.count)
  for aNum in listOfModes {
    arrayMode[count2] = Int(aNum)
    count2 = count2 + 1
  }
  // Returns to main function.
  return arrayMode
}

// Define input & output paths.
let inputFile = "Unit1-07-set3.txt"
let outputFile = "output.txt"

// Usage of file handle method to locate files,
// as well as opening input for file reading.
do {
    // Open input file for reading.
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        print("Error: cannot access input file for opening.")
        exit(1)
    }

    // Open output file for writing.
    guard let output = FileHandle(forWritingAtPath: outputFile) else {
        print("Error: cannot access output file for opening.")
        exit(1)
    }

    // Read context for file.
    let inputData = input.readDataToEndOfFile()

    // Convert data to a string.
    guard let inputString = String(data: inputData, encoding: .utf8) else {
        print("Error: Cannot convert input data to string.")
        exit(1)
    }
    // Split string into lines, ensuring reading empty line
    // also creating list.
    var intList: [Int] = []
    let inputLines = inputString.components(separatedBy: .newlines)

    // Convert from string of list to array of integers.
    for str in inputLines {
        if let intValue = Int(str) {
            intList.append(intValue)
        }
    }

    // Convert from list to array.
    var intArray = intList

    // Sort each element in the array.
    intArray.sort()

    // Call functions.
    let median = calcMedian(arrayNum: intArray)
    let mean = calcMean(arrayNum: intArray)
    let mode = calcMode(arrayNum: intArray)

    // Display to user on console.
    print("The mean is: ", mean)
    print("The median is: ", median)
    print("The mode is: ", mode)

    // Write to file.
    let data3 = Data("The mean is:  \(mean)\n".utf8)
    output.write(data3)
    let data = Data("The median is:  \(median)\n".utf8)
    output.write(data)
    let data2 = Data("The mode is:  \(mode)\n".utf8)
    output.write(data2)


    // Close input & output file.
    input.closeFile()
    output.closeFile()
}