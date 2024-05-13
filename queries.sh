#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo $($PSQL "SELECT SUM(winner_goals + opponent_goals) as total  FROM games")

echo -e "\nAverage number of goals in all games from the winning teams:"
echo $($PSQL "SELECT AVG(winner_goals) as average  FROM games")

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo $($PSQL "SELECT ROUND(AVG(winner_goals),2) as average_round  FROM games")

echo -e "\nAverage number of goals in all games from both teams:"
echo $($PSQL "SELECT AVG(winner_goals + opponent_goals) as average_both  FROM games")

echo -e "\nMost goals scored in a single game by one team:"
echo  $($PSQL "SELECT  GREATEST(MAX(winner_goals),MAX(opponent_goals)) as max_goals FROM games")

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo  $($PSQL "SELECT count(winner_goals)  FROM games WHERE winner_goals>2")

echo -e "\nWinner of the 2018 tournament team name:"
echo $($PSQL "SELECT name  FROM  games,teams  WHERE team_id=winner_id and round = 'Final' and year="2018"")

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo $($PSQL "SELECT name FROM(SELECT winner_id,opponent_id   FROM  games WHERE  round = 'Eighth-Final' and year='2014') as g,teams WHERE  team_id =
g.opponent_id or team_id=g.winner_id  ORDER BY name ASC")

echo -e "\nList of unique winning team names in the whole data set:"
echo $($PSQL "SELECT DISTINCT(name) FROM(SELECT winner_id  FROM  games) as g,teams WHERE team_id=g.winner_id  ORDER BY name ASC")

echo -e "\nYear and team name of all the champions:"
echo $($PSQL "SELECT year,name  FROM  games,teams  WHERE team_id=winner_id and round = 'Final' ORDER BY year ASC")

echo -e "\nList of teams that start with 'Co':"
echo $($PSQL "SELECT name FROM teams WHERE name ilike 'Co%'")
