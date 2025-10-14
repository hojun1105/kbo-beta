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

CREATE TABLE game_highlights (
                                id BIGSERIAL PRIMARY KEY,
                                game_date DATE NOT NULL,
                                home_team VARCHAR(50) NOT NULL,
                                away_team VARCHAR(50) NOT NULL,
                                youtube_url VARCHAR(500) NOT NULL,
                                title VARCHAR(200),
                                description VARCHAR(1000),
                                thumbnail_url VARCHAR(500),
                                duration VARCHAR(20),
                                view_count BIGINT,
                                created_at TIMESTAMP,
                                updated_at TIMESTAMP
);