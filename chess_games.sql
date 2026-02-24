#1 White / Black / Draw percentages split by rated and casual games
with count as (
    select 
        winner,
        sum(case when rated = 'FALSE' then 1 else 0 end) as unranked_games,
        sum(case when rated = 'TRUE' then 1 else 0 end) as ranked_games
    from chess_games
    group by 1
  )
select 
    winner,
    round((unranked_games * 100.0) / sum(unranked_games) over (), 1) as prc_of_winned_unranked_games,
    round((ranked_games * 100.0) / sum(ranked_games) over (), 1) as prc_of_winned_ranked_games,
    unranked_games,
    ranked_games
from count;

#2 What are the most common first moves in games won by Black and in games won by White?
-- most frequent first moves in black-won games
-- note: single query is possible, but two are clearer

select 
    substring_index(moves, ' ', 1) as first_move,
    count(*) as games_won_by_black,
    round(100.0 * count(*) / sum(count(*)) over (), 1) as prc_black_wins
from chess_games
where winner = 'black'
group by 1
order by 2 desc


-- most frequent first moves in white-won games
-- note: single query is possible, but two are clearer

select 
    substring_index(moves, ' ', 1) as first_move,
    count(*) as games_won_by_white,
    round(100.0 * count(*) / sum(count(*)) over (), 1) as prc_white_wins
from chess_games
where winner = 'white'
group by 1
order by 2 desc



#3 Win percentage when having the higher rating – overall and split by color
with count as
	(
	select
		sum(case when winner = "White" and white_rating > black_rating then 1 else 0 end) as white_higher_ranking_wins
		,sum(case when winner = "Black" and white_rating < black_rating then 1 else 0 end) as black_higher_ranking_wins
		,sum(case when winner = "Black" then 1 else 0 end) as black_wins
		,sum(case when winner = "White" then 1 else 0 end) as white_wins
	from chess_games
	)
select
	round(((white_higher_ranking_wins+black_higher_ranking_wins)*100)/(white_wins+black_wins),2) as prc_of_wins_when_higher_ranking
	,round(white_higher_ranking_wins*100/white_wins, 2) as prc_of_wins_when_white_has_higher_ranking_then_oponent
	,round(black_higher_ranking_wins*100/black_wins, 2)as prc_of_wins_when_black_has_higher_ranking_then_oponent
from count


#4 Which user won most games and in what percent that user has higher ranking then oponent?
with player_games as
	(
	    select 
	        white_id as player_id
	        ,white_rating as player_rating
	        ,black_rating as opponent_rating
	        ,case when winner = "White" then 1 else 0 end as win
	    from chess_games
	    union all
	    select 
	        black_id as player_id
	        ,black_rating as player_rating
	        ,white_rating as opponent_rating
	        ,case when winner = "Black" then 1 else 0 end as win
	    from chess_games
	),
	prep_agg as
	(
		select
			sum(case when (win = 1 and player_rating > opponent_rating) then 1 else 0 end) as wins_when_higher_ranking
			,sum(win) as total_wins
			,player_id
		from player_games
		group by 3
		order by 1 desc
	),
	top_player as
	(
		select
			total_wins
			,player_id
		from prep_agg
		order by 1 desc
		limit 1
	)
	select
		tp.player_id as player_with_biggest_amout_of_wins
		,tp.total_wins
		,round(pa.wins_when_higher_ranking*100.0/tp.total_wins,2) as prc_of_wins_while_higher_ranking_then_oponent
	from top_player tp
	join prep_agg pa on tp.player_id = pa.player_id 
	