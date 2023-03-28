#!/bin/sh


echo "HELLO TO TIC TAC TOE GAME 2 PLAYERS - X and O \n\n"
BOARD=()
userType=1
numberOfRounds=0


printBoard() {
    echo "\n\nCURRENT BOARD STATUS\n"
    if [[ $userType -eq 1 ]]; 
    then echo "X PLAYER YOUR MOVE\n" 
    else 
    echo "O PLAYER YOUR MOVE\n" 
    fi
    echo "--------------------------\n\n"
    echo "\t${BOARD[0]}\t${BOARD[1]}\t${BOARD[2]}\n"
    echo "\t${BOARD[3]}\t${BOARD[4]}\t${BOARD[5]}\n"
    echo "\t${BOARD[6]}\t${BOARD[7]}\t${BOARD[8]]}\n"
    checkWinner "X"
    if [[ $? -eq 1 ]]
    then
        echo "X WON!! Congratulations!"
        exit
    fi

    checkWinner "O"
    if [[ $? -eq 1 ]]
    then
        echo "O WON!! Congratulations!"
        exit
    fi
}


checkWinner() {

    if [[ "${BOARD[0]}" == $1 ]] && [[ "${BOARD[1]}" == $1 ]] && [[ "${BOARD[2]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD[3]}" == $1 ]] && [[ "${BOARD[4]}" == $1 ]] && [[ "${BOARD[5]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD[6]}" == $1 ]] && [[ "${BOARD[7]}" == $1 ]] && [[ "${BOARD[8]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD[0]}" == $1 ]] && [[ "${BOARD[3]}" == $1 ]] && [[ "${BOARD[6]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD[1]}" == $1 ]] && [[ "${BOARD[4]}" == $1 ]] && [[ "${BOARD[7]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD[2]}" == $1 ]] && [[ "${BOARD[5]}" == $1 ]] && [[ "${BOARD[8]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD[0]}" == $1 ]] && [[ "${BOARD[4]}" == $1 ]] && [[ "${BOARD[8]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD[2]}" == $1 ]] && [[ "${BOARD[4]}" == $1 ]] && [[ "${BOARD[6]}" == $1 ]] ; then return 1; fi
    return 0
}

validate() {
    if [[ "$1" -ge 0 ]] && [[ $1 -le 8 ]] && [[ "${BOARD[$1]}" != "O" ]] && [[ "${BOARD[$1]}" != "X" ]]
    then
        BOARD[$1]=$2
        return 1
    else
        return 0
    fi
}

userTurn() {
    if [[ $userType -eq 1 ]]
    then
        userType=0
        echo "Input: "
        read NEXT_MOVE
        validate $NEXT_MOVE "X"
        local RES=$?
        if [[ $RES -eq 0 ]]
        then
            echo "Not a correct input. Input should be between 0 and 8"
            userTurn
        else
        printBoard
        userTurn
    fi
    else
        echo "O move turn"
        echo "Input: "
        userType=1
        read NEXT_MOVE
    validate $NEXT_MOVE "O"
    local RES=$?
    if [[ $RES -eq 0 ]]
    then
        echo "Not a correct input. Input should be between 0 and 8"
        userTurn
    else
        printBoard 
        userTurn
    fi
    fi
    
}

BOARD=(0 1 2 3 4 5 6 7 8) 
printBoard 
userTurn