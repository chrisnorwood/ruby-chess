
ruby-chess
==========
Chess game implementation in Ruby.  Final Ruby project for The Odin Project.

To play: from project's root directory, type `ruby run.rb`

![Chess Screenshot](https://cloud.githubusercontent.com/assets/18252139/17306067/d95497fe-57e2-11e6-8b38-b6a5931e64b0.png)

This project posed a lot of difficult problem solving, and there is some work to be done in order to call this project complete.  As of August 1, 2016, after spending over a month putting time in on ruby-chess, I am going to move on for the time being to work on new projects.

This game is functional in basic piece movement and attacks (including the pawn's special rules), recognizing 'check', and recognizing *unequivocal* checkmate conditions (i.e. checked king cannot move *anywhere* without still being in check).  

To-Do List/Missing Features:

 - **Properly constrain checkmate feature**
 - Pawn Promotion
 - Castling
 - En-passant pawn attacks
 - Load/Save feature
 - Refactoring? (*always could be useful* :P)