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

CREATE TABLE IF NOT EXISTS ticket_games (
    id BIGSERIAL PRIMARY KEY,
    home_team VARCHAR(255) NOT NULL,
    away_team VARCHAR(255) NOT NULL,
    game_date TIMESTAMP NOT NULL,
    stadium VARCHAR(255) NOT NULL,
    stadium_address VARCHAR(500),
    status VARCHAR(50) NOT NULL DEFAULT 'SCHEDULED',
    home_score INTEGER,
    away_score INTEGER,
    weather VARCHAR(255),
    temperature VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ticket_reservations (
    id BIGSERIAL PRIMARY KEY,
    owner_id VARCHAR(255) NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    game_id BIGINT NOT NULL REFERENCES ticket_games(id) ON DELETE CASCADE,
    seat_section VARCHAR(100) NOT NULL,
    seat_row VARCHAR(100) NOT NULL,
    seat_number VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'RESERVED',
    description VARCHAR(1000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_ticket_reservations_owner ON ticket_reservations(owner_id);
CREATE INDEX IF NOT EXISTS idx_ticket_reservations_game ON ticket_reservations(game_id);

INSERT INTO ticket_games (home_team, away_team, game_date, stadium, stadium_address, status, weather, temperature)
SELECT 'LG 트윈스', '두산 베어스', CURRENT_TIMESTAMP + INTERVAL '7 days', '잠실야구장', '서울특별시 송파구 올림픽로 25', 'SCHEDULED', '맑음', '22°C'
WHERE NOT EXISTS (SELECT 1 FROM ticket_games WHERE home_team = 'LG 트윈스' AND away_team = '두산 베어스');

INSERT INTO ticket_games (home_team, away_team, game_date, stadium, stadium_address, status, weather, temperature)
SELECT '한화 이글스', 'KIA 타이거즈', CURRENT_TIMESTAMP + INTERVAL '9 days', '대전 한화생명 이글스파크', '대전광역시 중구 대종로 373', 'SCHEDULED', '구름', '20°C'
WHERE NOT EXISTS (SELECT 1 FROM ticket_games WHERE home_team = '한화 이글스' AND away_team = 'KIA 타이거즈');

INSERT INTO ticket_games (home_team, away_team, game_date, stadium, stadium_address, status, weather, temperature)
SELECT '롯데 자이언츠', 'SSG 랜더스', CURRENT_TIMESTAMP + INTERVAL '11 days', '사직야구장', '부산광역시 동래구 사직로 45', 'SCHEDULED', '맑음', '23°C'
WHERE NOT EXISTS (SELECT 1 FROM ticket_games WHERE home_team = '롯데 자이언츠' AND away_team = 'SSG 랜더스');

-- stores 테이블 생성
CREATE TABLE IF NOT EXISTS stores (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    visitor_reviews VARCHAR(50),
    blog_reviews VARCHAR(50),
    operating_hours TEXT,
    address VARCHAR(255),
    phone_num VARCHAR(50),
    search_keyword VARCHAR(255),
    location VARCHAR(255),
    naver_place_id VARCHAR(50),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    CONSTRAINT stores_naver_place_id_key UNIQUE (naver_place_id)
    );