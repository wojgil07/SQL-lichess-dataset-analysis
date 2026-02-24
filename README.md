# Chess Games Analysis: SQL-Driven Insights into Performance and Strategy
**All queries and results are fully reproducible** from the included `chess_games.csv`.

## Dataset

- **Source**: Processed Lichess chess games (public domain)
- **Format**: CSV
- **Size**: 20,058

## Methodology & Technical Skills

- **Database**: MySQL / PostgreSQL compatible
- **Advanced SQL techniques used**:
  - Common Table Expressions (CTEs)
  - Window functions for percentage calculations
  - String parsing (`SUBSTRING_INDEX`)
  - Conditional aggregation (`CASE WHEN`)
  - Self-union for player-level analysis
- All queries are modular, commented, and optimized for large datasets


## Key Analyses & Findings

### 1. Win/Draw Distribution – Rated vs Casual Games
**Question**: How do outcomes differ between competitive (rated) and casual games?

**Findings**:
- In rated games: White wins **49.8%**, Black wins **45.7%**, Draws **4.5%**
- In casual games: White wins **49.9%**, Black wins **44.1%**, Draws **5.9%**
- Rated games show **1.4 p.p.** lower draw rate compared to casual play

### 2. Most Common First Moves in Winning Games
**Question**: Which opening moves are most successful for White?

**Findings**:
- Top first move for White victories: **e4** – **63.7%** of all White wins

### 3. Rating Advantage & Win Probability
**Question**: How much does having the higher rating increase win chance?

**Findings**:
- Overall win rate when holding higher rating: **64.64%**
- White with higher rating wins **65.28%** of their games
- Black with higher rating wins **63.94%** of their games
- Rating advantage is statistically significant across both colors

### 4. Top Performing Player
**Question**: Who won the most games and how often did they have the rating advantage?

**Findings**:
- Top player: **`taranga`** with **72** total wins
- Percentage of wins achieved with higher rating then opponent: **50%**

## Reproducibility

1. Clone the repository
2. Import `data/chess_games.csv` into your SQL database
3. Run queries from the `/queries/` folder in order

---

Wojciech Gil  
[LinkedIn][(https://www.linkedin.com/in/wojciech-gil07/)]

*Last updated: February 2026*
