ORG 10 //Start at memory location 10
FST, SKI       // look for input
BUN FST   // Repeat until input
CLA       // clear AC
INP       // input to AC
ADD HEX-30
STA Multiplier //Store multiplier

SZA 
BUN NotZeroCase //Jump to not zero case if input is not zero

BUN ZeroCase //Jump to zero case if input is zero

NotZeroCase, ADD Dec-1 //Case if input is not zero
SZA 
BUN NotOneCase //Jump to not zero case if input is greater than one
BUN oneTwoCase //Jump to zero case if input is one

NotOneCase, ADD Dec-1 //Case if input is not zero or one
SZA 
BUN NotTwoCase //Jump to not zero case if input is greater than one
BUN oneTwoCase //Jump to zero case if input is one

NotTwoCase, ADD DEC1 //Case if input is not zero, one or two
STA LoopCounter //Store loop counter
STA MultiplicationCounter //Store counter for multiplication
BUN Loop //Start loop

Loop, LDA LoopCounter //Load loop counter
STA MultiplicationCounter //Reset multiplication counter

MultiplicationLoop, LDA Number //Multiplication loop
ADD Multiplier //Add the multiplier to number
STA Number //Store new number
LDA MultiplicationCounter //Load multiplication counter
ADD DEC-1 //Decrement
STA MultiplicationCounter //store multiplication counter
SZA 
BUN MultiplicationLoop //Exit multiplication loop if counter is 0

LDA LoopCounter //Load loop counter
ADD DEC-1 //Decrement
STA LoopCounter //Decrement outside loop counter

SZA 
BUN finishFactorial //If not zero, continue
BUN Convert //Exit

finishFactorial, LDA Number //Load number
STA Multiplier //Set multiplier to Number
CLA //Clear AC
STA Number //Reset Number
LDA LoopCounter //Load loop counter
SZA 
BUN Loop //Go back to beginning of loop if counter != 0

ZeroCase, LDA Multiplier //If input number was zero
AND OOOF
ADD HEX30
ADD DEC1 //Add 1 because zero factorial is 1
OUT
BUN HLT

OneTwoCase, LDA Multiplier //If input number was one or two
AND OOOF
ADD HEX30
OUT
BUN HLT

Convert, LDA Number //Load factorial number

AND OFOO //isolate one nibble
CLE //Clear E bit (so it doesn't interfere with rotation)
CIR //R-shift 8 times to get the nibble over to the right side
CIR
CIR
CIR
CIR
CIR
CIR
CIR

STA TEMP //The digit that is decremented to deal with if it is <10 or >9
STA DIGIT //Digit (does not get changed in counter stuff)

SZA 
BUN loopFirst //If the digit is > 0
BUN under10First //If the digit is 0

loopFirst, ADD DEC-1 //Decrement actual number
STA TEMP
LDA CTR //Load counter
ADD DEC-1 //Decrement counter
STA CTR //Store counter
SZA 
BUN contLoopFirst //Continue loop if counter != 0
BUN above9First //End loop if counter is 0

contLoopFirst, LDA TEMP //Load temp
SZA 
BUN loopFirst //Continue looping if temp != 0
BUN under10First //End loop if temp is 0

under10First, LDA DIGIT //Load digit (if digit is under 10)
ADD HEX30 //Add 30 to get the correct ascii character
OUT //Print
BUN secondConvert //Continue

above9First, LDA DIGIT //Load digit (if digit is above 30)
ADD HEX41 //Add 41 to get the "correct" ascii character
ADD HEX-A //Subtract A to get the actual correct ascii character
OUT //Print
BUN secondConvert //Continue

secondConvert, LDA Number //Load number
AND OOFO //Isolate nibble
CLE //Clear E bit
CIR //Rotate to bring nibble to right side
CIR
CIR
CIR

STA TEMP //The digit that is decremented to deal with if it is <10 or >9
STA DIGIT //Digit (does not get changed in counter stuff)

LDA DEC10 //Load 10
STA CTR //Reset counter
LDA TEMP //Reload temp

SZA 
BUN loopSecond //If the digit is > 0
BUN under10Second //If the digit is 0

loopSecond, ADD DEC-1 //Decrement actual number
STA TEMP
LDA CTR //Load counter
ADD DEC-1 //Decrement counter
STA CTR //Store counter
SZA 
BUN contLoopSecond //Continue loop if counter != 0
BUN above9Second //End loop if counter is 0

contLoopSecond, LDA TEMP //Load temp
SZA 
BUN loopSecond //Continue looping if temp != 0
BUN under10Second //End loop if temp is 0

under10Second, LDA DIGIT //Load digit (if digit is under 10)
ADD HEX30 //Add 30 to get the correct ascii character
OUT //Print
BUN thirdConvert //Continue

above9Second, LDA DIGIT //Load digit (if digit is above 30)
ADD HEX41 //Add 41 to get the "correct" ascii character
ADD HEX-A //Subtract A to get the actual correct ascii character
OUT //Print
BUN thirdConvert //Continue

thirdConvert, LDA Number //Load number
AND OOOF //Isolate nibble

STA TEMP //The digit that is decremented to deal with if it is <10 or >9
STA DIGIT //Digit (does not get changed in counter stuff)

LDA DEC10 //Load 10
STA CTR //Reset counter
LDA TEMP //Reload temp

SZA 
BUN loopThird//If the digit is > 0
BUN under10Third //If the digit is 0

loopThird, ADD DEC-1 //Decrement actual number
STA TEMP
LDA CTR //Load counter
ADD DEC-1 //Decrement counter
STA CTR //Store counter
SZA 
BUN contLoopThird //Continue loop if counter != 0
BUN above9Third //End loop if counter is 0

contLoopThird, LDA TEMP //Load temp
SZA 
BUN loopThird //Continue looping if temp != 0
BUN under10Third //End loop if temp is 0

under10Third, LDA DIGIT //Load digit (if digit is under 10)
ADD HEX30 //Add 30 to get the correct ascii character
OUT //Print
BUN HLT //End

above9Third, LDA DIGIT //Load digit (if digit is above 30)
ADD HEX41 //Add 41 to get the "correct" ascii character
ADD HEX-A //Subtract A to get the actual correct ascii character
OUT //Print
BUN HLT //End

HLT, HLT       // quit
DIGIT, DEC 0
CTR, DEC 10
TEMP, DEC 0
DEC-10, DEC -10
DEC10, DEC 10
LoopCounter, DEC 0
MultiplicationCounter, DEC 0
Multiplier, DEC 0
Number, DEC 0   // Stores decimal number
Dec-1, DEC -1 //Decimal -1 for decrementing
Dec1, DEC 1 //Decimal 1 for incrementing
OFOO, HEX 0F00 //Hex version of 0000111100000000 for addition (getting nibble)
OOFO, HEX 00F0 //Hex version of 0000000011110000 for addition (getting nibble)
OOOF, HEX 000F //Hex version of 0000000000001111 for addition (getting nibble)
HEX30, HEX 30 //Hex 30 (for getting the correct ASCII character for < 10)
HEX-30, HEX -30 //Hex -30 (for getting the correct ASCII character for < 10)
HEX41, HEX 41 //Hex 41 (for getting the correct ASCII character for > 9)
HEX-A, HEX -A //Hex -A (for getting the correct ASCII character for > 9)
    END       // End of the program