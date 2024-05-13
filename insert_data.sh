#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS 
do 
  if [[ $YEAR != "year" ]]
  then
  # teams table
  #check WINNER name exist 
  WINNER_NAME=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
  
  # if not found
    if [[ -z $WINNER_NAME ]]
    then
    INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
      then 
      echo successfully inserted name, $WINNER
      # get the id name winner
      TEAM_WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      fi
    else
    # get the id name winner
    TEAM_WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi
  #check OPPONENT name exist
  OPPONENT_NAME=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
  
  # if not found
    if [[ -z $OPPONENT_NAME ]]
    then
    INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
      then 
      echo successfully inserted name, $OPPONENT
      # get the id name opponent
      TEAM_OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      fi
    else 
    # get the id name opponent
    TEAM_OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi

      #insertion in games table
      INSERT_DATA_games=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES('$YEAR', '$ROUND', '$WINNER_GOALS', '$OPPONENT_GOALS', '$TEAM_WINNER_ID', '$TEAM_OPPONENT_ID')")
      if [[ $INSERT_DATA_games == "INSERT 0 1" ]]
      then 
      echo successfully inserted data in games
      fi
  fi
done
