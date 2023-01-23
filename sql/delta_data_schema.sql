-- CREATE delta_data SCHEMA v1.0 
-- Author: Ifhbiff
-- Created: 2023-01-21

DROP SCHEMA IF EXISTS delta_data CASCADE;

CREATE SCHEMA delta_data;

--
--Name: chron_load_page_tokens; Type: TABLE; Schema: delta_data;
--

CREATE TABLE IF NOT EXISTS delta_data.chron_load_page_tokens
(
    id integer NOT NULL,
    object_name character varying COLLATE pg_catalog."default",
    page_token character varying COLLATE pg_catalog."default",
    valid_until timestamp without time zone DEFAULT now()
);

CREATE SEQUENCE delta_data.chron_load_page_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE delta_data.chron_load_page_tokens_id_seq OWNED BY delta_data.chron_load_page_tokens.id;
ALTER TABLE ONLY delta_data.chron_load_page_tokens ALTER COLUMN id SET DEFAULT nextval('delta_data.chron_load_page_tokens_id_seq'::regclass);

--
-- Name: game_events_abyline; Type: TABLE; Schema: delta_data;
--

CREATE TABLE delta_data.game_events_abyline (
    id integer NOT NULL,
    game_id character varying(36),
    start_disp_order integer,
    defenders character varying,
    hit_msg character varying,
    field_msg character varying,
    balls integer,
    strikes integer,
    hit_loc character varying,
    fielder character varying,
    pa integer,
    ab integer,
    hit integer,
    totl_outs integer,
    out_on_play integer,
    extra_outs integer,
    runs integer,
    advances integer,
    bb integer,
    k integer,
    sng integer,
    dbl integer,
    trp integer,
    hr integer,
    fc integer,
    dp integer,
    tp integer,
    sac integer,
    error_msg character varying
);

CREATE SEQUENCE delta_data.game_events_abyline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE delta_data.game_events_abyline_id_seq OWNED BY delta_data.game_events_abyline.id;
ALTER TABLE ONLY delta_data.game_events_abyline ALTER COLUMN id SET DEFAULT nextval('delta_data.game_events_abyline_id_seq'::regclass);

--
-- Name: game_events_raw; Type: TABLE; Schema: delta_data;
--

CREATE TABLE delta_data.game_events_raw (
    id integer NOT NULL,
    game_id character varying(36),
    "timestamp" timestamp without time zone,
    bases_occupied character varying,
    baserunner_ids character varying,
    display_order integer,
    display_text character varying,
    batter_id character varying(36),
    pitcher_id character varying(36),
    balls integer,
    strikes integer,
    outs integer,
    away_score integer,
    home_score integer,
    inning integer,
    start_pa boolean DEFAULT false,
    pa_event_id integer
);

CREATE SEQUENCE delta_data.game_events_raw_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--

ALTER SEQUENCE delta_data.game_events_raw_id_seq OWNED BY delta_data.game_events_raw.id;
ALTER TABLE ONLY delta_data.game_events_raw ALTER COLUMN id SET DEFAULT nextval('delta_data.game_events_raw_id_seq'::regclass);

--
-- Name: games; Type: TABLE; Schema: delta_data;
--

CREATE TABLE delta_data.games (
    id integer NOT NULL,
    game_id character varying(36),
    season_id character varying(36),
    gameday integer,
    cancelled boolean,
    completed boolean,
    away_pitcher_id character varying(36),
    away_team_id character varying(36),
    home_pitcher_id character varying(36),
    home_team_id character varying(36),
    losing_team_id character varying(36),
    winning_team_id character varying(36),
    away_score numeric,
    home_score numeric,
    innings integer,
    balls_needed integer,
    strikes_needed integer,
    outs_needed integer,
    total_bases integer,
    shame boolean,
    weather character varying,
    number_in_series integer,
    series_length integer
);

CREATE SEQUENCE delta_data.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE delta_data.games_id_seq OWNED BY delta_data.games.id;
ALTER TABLE ONLY delta_data.games ALTER COLUMN id SET DEFAULT nextval('delta_data.games_id_seq'::regclass);

--
-- Name: player_heatmaps; Type: TABLE; Schema: delta_data
--

CREATE TABLE delta_data.player_heatmaps (
    id integer NOT NULL,
    player_id character varying(36),
    x integer,
    y integer,
    current_value numeric,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone
);

CREATE SEQUENCE delta_data.player_heatmaps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE delta_data.player_heatmaps_id_seq OWNED BY delta_data.player_heatmaps.id;
ALTER TABLE ONLY delta_data.player_heatmaps ALTER COLUMN id SET DEFAULT nextval('delta_data.player_heatmaps_id_seq'::regclass);

--
-- Name: players; Type: TABLE; Schema: delta_data;
--

CREATE TABLE delta_data.players (
    id integer NOT NULL,
    player_id character varying(36),
    player_name character varying,
    deceased boolean DEFAULT false,
    sight numeric,
    thwack numeric,
    ferocity numeric,
    control numeric,
    stuff numeric,
    guile numeric,
    reach numeric,
    magnet numeric,
    reflex numeric,
    hustle numeric,
    stealth numeric,
    dodge numeric,
    thrive numeric,
    survive numeric,
    drama numeric,
    batting_rating numeric DEFAULT '-1'::integer,
    pitching_rating numeric DEFAULT '-1'::integer,
    running_rating numeric DEFAULT '-1'::integer,
    defense_rating numeric DEFAULT '-1'::integer,
    vibes_rating numeric DEFAULT '-1'::integer,
    url_slug character varying,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone,
    hash uuid,
    temppositions character varying,
    tempmodifications character varying,
    tempheatmap character varying,
    temprosterlocation character varying,
    temprosterindex integer,
    tempteamid character varying(36),
    temppositionname character varying
);

CREATE SEQUENCE delta_data.players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE delta_data.players_id_seq OWNED BY delta_data.players.id;
ALTER TABLE ONLY delta_data.players ALTER COLUMN id SET DEFAULT nextval('delta_data.players_id_seq'::regclass);

--
-- Name: team_roster; Type: TABLE; Schema: delta_data; Owner: postgres
--

CREATE TABLE delta_data.team_roster (
    id integer NOT NULL,
    player_id character varying(36),
    team_id character varying(36),
    valid_from timestamp without time zone,
    valid_until timestamp without time zone,
    active boolean,
    location character varying,
    order_index integer
);

CREATE SEQUENCE delta_data.team_roster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE delta_data.team_roster_id_seq OWNED BY delta_data.team_roster.id;
ALTER TABLE ONLY delta_data.team_roster ALTER COLUMN id SET DEFAULT nextval('delta_data.team_roster_id_seq'::regclass);

--
-- Name: teams; Type: TABLE; Schema: delta_data
--

CREATE TABLE delta_data.teams (
    id integer NOT NULL,
    team_id character varying(36) NOT NULL,
    location_name character varying,
    nickname character varying,
    fullname character varying,
    team_shorthand character varying(10),
    team_primarycolor character varying(10),
    team_secondarycolor character varying(10),
    team_emoji character varying,
    team_slogan character varying,
    active_team boolean DEFAULT false NOT NULL,
    deceased boolean DEFAULT false NOT NULL,
    ur_slug character varying,
    valid_from timestamp without time zone DEFAULT now() NOT NULL,
    valid_until timestamp without time zone,
    hash uuid,
    tempmodifications character varying,
    tempdivision character varying,
    tempdefenserating numeric,
    temprunningrating numeric,
    tempbattingrating numeric,
    temppitchingrating numeric,
    season_id character varying(36),
    wins integer,
    losses integer,
    active boolean,
    location character varying
);

CREATE SEQUENCE delta_data.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE delta_data.teams_id_seq OWNED BY delta_data.teams.id;
ALTER TABLE ONLY delta_data.teams ALTER COLUMN id SET DEFAULT nextval('delta_data.teams_id_seq'::regclass);


--
-- Name: populate_player_heatmaps; Type: PROCEDURE; Schema: delta_data
--

create procedure delta_data.populate_player_heatmaps()
LANGUAGE 'plpgsql'
AS $BODY$
begin
	--For now, doing full truncate/replace rather than track new ones only
	--Because speed + laziness
	TRUNCATE TABLE delta_data.player_heatmaps;
	
	INSERT INTO delta_data.player_heatmaps
	(player_id, current_value, x, y, valid_from, valid_until)

	SELECT player_id, heatmap_value::numeric, 
	(nr-1)/6 as x, mod((nr-1),6) as y, valid_from, valid_until
	FROM delta_data.players, 
	unnest(string_to_array(replace(replace(tempheatmap,'{',''),'}',''),',')) WITH ORDINALITY a(heatmap_value, nr);

end;
$BODY$;

--
-- Name: reset_db; Type: PROCEDURE; Schema: delta_data
--

CREATE OR REPLACE PROCEDURE delta_data.reset_db(
	)
LANGUAGE 'plpgsql'
AS $BODY$
begin
    update delta_data.chron_load_page_tokens set page_token ='AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=', valid_until = '2023-01-08 00:00:00';
    truncate delta_data.players cascade;
	truncate delta_data.player_heatmaps cascade;
    truncate delta_data.teams cascade;
    truncate delta_data.games cascade;
    truncate delta_data.team_roster cascade;
    truncate delta_data.game_events_raw cascade;
end;
$BODY$;

--
-- Start with default page_tokens for all the Chron calls, and the day before δ Eon S1
--
INSERT INTO delta_data.chron_load_page_tokens (object_name, page_token, valid_until)
VALUES
('games','AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=','2023-01-08 00:00:00'),
('game-events','AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=','2023-01-08 00:00:00'),
('players','AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=','2023-01-08 00:00:00'),
('teams','AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=','2023-01-08 00:00:00');