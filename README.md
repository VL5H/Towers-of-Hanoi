# Towers-of-Hanoi
An exercise in assembly programming where I solve the classic Towers of Hanoi puzzle.

Created this as an experiment into the world of LC-3 assembly programming.

I have created an assembly script that solves the classic Towers of Hanoi puzzle, more on that here --> [Towers of Hanoi](https://www.geeksforgeeks.org/dsa/c-program-for-tower-of-hanoi/)

The script is designed to be used in the "LC3Tools" assembly environment --> [LC3Tools](https://github.com/chiragsakhuja/lc3tools)

The Towers of Hanoi puzzle presents you with a scenario where you must move "n" number of disks stacked from smallest to largest (top to bottom) on post 1 of posts 1, 2, and 3. You must then move these "n" disks from post 1 to post 3 while following these rules:
1. Only one disk can be moved at a time.
2. Each move consists of taking the upper disk from one of the stacks and placing it on top of another stack i.e. a disk can only be moved if it is the uppermost disk on a stack.
3. No disk may be placed on top of a smaller disk.

An example with 3 disks:

<img width="684" height="384" alt="tower-of-hanoi" src="https://github.com/user-attachments/assets/4440d85a-d333-44f3-846f-47c840832fd6" />

As such, this script assumes that the user wishes to move "n" number of disks from post 1 to post 3 in the Towers of Hanoi set-up. It takes in the number of disks the user wishes to move as input, reclusively calculates the correct set of moves, and outputs them step-by-step to the terminal. 

For example, upon receiving an input of "3", the program outputs the following:

<img width="503" height="395" alt="Sample_Output_Working" src="https://github.com/user-attachments/assets/f0a9d695-e677-48c2-9f25-4afda32f9ca6"/>

Installation/Set-Up:
1. Download the "towers_of_hanoi.asm" assembly source file.
2. Open the file in LC3Tools or an environment of your choice that supports LC-3 assembly.

Running/Usage:
1. Assemble the file into a binary ".obj" file.
2. Run the file in your assembly environment.
3. Enter the number of disks you wish to move and press enter to see your results.
