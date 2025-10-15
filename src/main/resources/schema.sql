CREATE TABLE team_info (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(50) NOT NULL,
                           logo VARCHAR(255)
);

CREATE TABLE player_info (
                             id BIGSERIAL PRIMARY KEY,
                             name VARCHAR(50) NOT NULL,
                             position VARCHAR(10),
                             team_id INT NOT NULL,
                             back_number INT,
                             birth_date DATE,
                             height_weight VARCHAR(255),
                             salary BIGINT,
                             debut_year INT,

                             CONSTRAINT fk_playerinfo_team FOREIGN KEY (team_id)
                                 REFERENCES team_info (id),
                             CONSTRAINT uq_playerinfo_name_team UNIQUE (name, team_id)
);

CREATE TABLE hitter_stat (
                             id BIGSERIAL PRIMARY KEY,
                             player_id BIGINT NOT NULL,
                             date DATE,
                             average DOUBLE PRECISION,
                             games INTEGER,
                             plate_appearances INTEGER,
                             at_bat INTEGER,
                             runs INTEGER,
                             hits INTEGER,
                             double_base INTEGER,
                             triple_base INTEGER,
                             home_run INTEGER,
                             total_base INTEGER,
                             runs_batted_in INTEGER,
                             stolen_base INTEGER,
                             caught_stealing INTEGER,
                             sacrifice_hit INTEGER,
                             sacrifice_fly INTEGER,
                             based_on_balls INTEGER,
                             intentional_based_on_balls INTEGER,
                             hit_by_pitch INTEGER,
                             strike_out INTEGER,
                             grounded_into_double_play INTEGER,
                             slugging_percentage DOUBLE PRECISION,
                             on_base_percentage DOUBLE PRECISION,
                             error INTEGER,
                             stolen_base_percentage DOUBLE PRECISION,
                             multi_hit INTEGER,
                             on_base_plus_slugging DOUBLE PRECISION,
                             runners_in_scoring_position DOUBLE PRECISION,
                             substitute_hitter_batting_average DOUBLE PRECISION,

                             CONSTRAINT fk_hitterstat_player FOREIGN KEY (player_id)
                                 REFERENCES player_info (id),
                             CONSTRAINT uq_hitterstat_player_date UNIQUE (player_id, date)
);

CREATE TABLE pitcher_stat (
                              id BIGSERIAL PRIMARY KEY,
                              player_id BIGINT NOT NULL,
                              "date" DATE NOT NULL,
                              rank INT,
                              era NUMERIC(5,2),
                              games INT,
                              wins INT,
                              losses INT,
                              saves INT,
                              holds INT,
                              winning_percentage NUMERIC(5,3),
                              innings_pitched NUMERIC(6,3),
                              hits INT,
                              home_runs INT,
                              walks INT,
                              hit_by_pitch INT,
                              strike_outs INT,
                              runs INT,
                              earned_runs INT,
                              whip NUMERIC(5,3),

                              CONSTRAINT uq_pitcher_stat UNIQUE (player_id, "date"),
                              CONSTRAINT fk_pitcher_stat_player FOREIGN KEY (player_id)
                                  REFERENCES player_info(id)
                                  ON DELETE CASCADE
);

CREATE TABLE users (
                       user_id VARCHAR(255) PRIMARY KEY,
                       nickname VARCHAR(255),
                       password VARCHAR(255) NOT NULL,
                       email VARCHAR(255) NOT NULL,
                       instagram_id VARCHAR(255)
);

CREATE TABLE today_games(
                    id BIGSERIAL PRIMARY KEY ,
                    home_team_id INT REFERENCES team_info(id),
                    home_team_ops NUMERIC(5,3),
                    home_team_era NUMERIC(5,2),
                    away_team_id INT REFERENCES team_info(id),
                    away_team_ops NUMERIC(5,3),
                    away_team_era NUMERIC(5,2),
                    temperature NUMERIC(5,2),
                    humidity NUMERIC(5,2)
);

CREATE TABLE game_predictions(
            id BIGSERIAL PRIMARY KEY,
            today_game_id BIGINT REFERENCES today_games(id),
            predicted_winner INT REFERENCES team_info(id)
)

CREATE TABLE IF NOT EXISTS community_posts (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    content VARCHAR(5000) NOT NULL,
    username VARCHAR(100) NOT NULL,
    -- images column removed (reverted)
    view_count INTEGER DEFAULT 0,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Comments for community posts
CREATE TABLE IF NOT EXISTS community_comments (
    id BIGSERIAL PRIMARY KEY,
    post_id BIGINT NOT NULL REFERENCES community_posts(id) ON DELETE CASCADE,
    username VARCHAR(100) NOT NULL,
    content VARCHAR(2000) NOT NULL,
    created_at TIMESTAMP
);

-- Votes for posts (unique per user per post)
CREATE TABLE IF NOT EXISTS community_post_votes (
    id BIGSERIAL PRIMARY KEY,
    post_id BIGINT NOT NULL REFERENCES community_posts(id) ON DELETE CASCADE,
    username VARCHAR(100) NOT NULL,
    vote INTEGER NOT NULL,
    created_at TIMESTAMP,
    CONSTRAINT uq_post_vote UNIQUE (post_id, username)
);