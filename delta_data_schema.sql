-- CREATE delta_data SCHEMA v1.0 
-- Author: Ifhbiff
-- Created: 2023-01-21

DROP SCHEMA IF EXISTS delta_data;

CREATE SCHEMA delta_data;

--
-- TOC entry 256 (class 1259 OID 17405)
-- Name: api_loads_meta; Type: TABLE; Schema: delta_data; Owner: postgres
--

CREATE TABLE delta_data.api_loads_meta (
    id integer NOT NULL,
    load_timestamp timestamp without time zone DEFAULT now(),
    game_timestamp timestamp without time zone,
    team_timestamp timestamp without time zone,
    player_timestamp timestamp without time zone,
    game_events_timestamp timestamp without time zone,
    division_timestamp timestamp without time zone,
    stadium_timestamp timestamp without time zone
);

--
-- TOC entry 255 (class 1259 OID 17404)
-- Name: api_loads_meta_id_seq; Type: SEQUENCE; Schema: delta_data; Owner: postgres
--

CREATE SEQUENCE delta_data.api_loads_meta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 255
-- Name: api_loads_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_data; Owner: postgres
--

ALTER SEQUENCE delta_data.api_loads_meta_id_seq OWNED BY delta_data.api_loads_meta.id;

--
-- TOC entry 230 (class 1259 OID 17263)
-- Name: game_events_abyline; Type: TABLE; Schema: delta_data; Owner: postgres
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

--
-- TOC entry 229 (class 1259 OID 17262)
-- Name: game_events_abyline_id_seq; Type: SEQUENCE; Schema: delta_data; Owner: postgres
--

CREATE SEQUENCE delta_data.game_events_abyline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 229
-- Name: game_events_abyline_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_data; Owner: postgres
--

ALTER SEQUENCE delta_data.game_events_abyline_id_seq OWNED BY delta_data.game_events_abyline.id;

--
-- TOC entry 225 (class 1259 OID 17039)
-- Name: game_events_test_id_seq; Type: SEQUENCE; Schema: delta_data; Owner: postgres
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
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 229
-- Name: game_events_abyline_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_data; Owner: postgres
--

ALTER SEQUENCE delta_data.game_events_raw_id_seq OWNED BY delta_data.game_events_raw.id;

--
-- TOC entry 228 (class 1259 OID 17246)
-- Name: games; Type: TABLE; Schema: delta_data; Owner: postgres
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

--
-- TOC entry 227 (class 1259 OID 17245)
-- Name: games_id_seq; Type: SEQUENCE; Schema: delta_data; Owner: postgres
--

CREATE SEQUENCE delta_data.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 227
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_data; Owner: postgres
--

ALTER SEQUENCE delta_data.games_id_seq OWNED BY delta_data.games.id;


--
-- TOC entry 221 (class 1259 OID 16561)
-- Name: player_heatmaps; Type: TABLE; Schema: delta_data; Owner: postgres
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

--
-- TOC entry 220 (class 1259 OID 16560)
-- Name: player_heatmaps_id_seq; Type: SEQUENCE; Schema: delta_data; Owner: postgres
--

CREATE SEQUENCE delta_data.player_heatmaps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 220
-- Name: player_heatmaps_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_data; Owner: postgres
--

ALTER SEQUENCE delta_data.player_heatmaps_id_seq OWNED BY delta_data.player_heatmaps.id;

--
-- TOC entry 219 (class 1259 OID 16544)
-- Name: players; Type: TABLE; Schema: delta_data; Owner: postgres
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

--
-- TOC entry 218 (class 1259 OID 16543)
-- Name: players_id_seq; Type: SEQUENCE; Schema: delta_data; Owner: postgres
--

CREATE SEQUENCE delta_data.players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 218
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_data; Owner: postgres
--

ALTER SEQUENCE delta_data.players_id_seq OWNED BY delta_data.players.id;


--
-- TOC entry 258 (class 1259 OID 17460)
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

--
-- TOC entry 257 (class 1259 OID 17459)
-- Name: team_roster_id_seq; Type: SEQUENCE; Schema: delta_data; Owner: postgres
--

CREATE SEQUENCE delta_data.team_roster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 257
-- Name: team_roster_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_data; Owner: postgres
--

ALTER SEQUENCE delta_data.team_roster_id_seq OWNED BY delta_data.team_roster.id;


--
-- TOC entry 223 (class 1259 OID 16570)
-- Name: teams; Type: TABLE; Schema: delta_data; Owner: postgres
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

--
-- TOC entry 222 (class 1259 OID 16569)
-- Name: teams_id_seq; Type: SEQUENCE; Schema: delta_data; Owner: postgres
--

CREATE SEQUENCE delta_data.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 222
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_data; Owner: postgres
--

ALTER SEQUENCE delta_data.teams_id_seq OWNED BY delta_data.teams.id;

--
-- TOC entry 3282 (class 2604 OID 17408)
-- Name: api_loads_meta id; Type: DEFAULT; Schema: delta_data; Owner: postgres
--

ALTER TABLE ONLY delta_data.api_loads_meta ALTER COLUMN id SET DEFAULT nextval('delta_data.api_loads_meta_id_seq'::regclass);


--
-- TOC entry 3281 (class 2604 OID 17266)
-- Name: game_events_abyline id; Type: DEFAULT; Schema: delta_data; Owner: postgres
--

ALTER TABLE ONLY delta_data.game_events_abyline ALTER COLUMN id SET DEFAULT nextval('delta_data.game_events_abyline_id_seq'::regclass);

--
-- TOC entry 3280 (class 2604 OID 17249)
-- Name: games id; Type: DEFAULT; Schema: delta_data; Owner: postgres
--

ALTER TABLE ONLY delta_data.games ALTER COLUMN id SET DEFAULT nextval('delta_data.games_id_seq'::regclass);


--
-- TOC entry 3273 (class 2604 OID 16564)
-- Name: player_heatmaps id; Type: DEFAULT; Schema: delta_data; Owner: postgres
--

ALTER TABLE ONLY delta_data.player_heatmaps ALTER COLUMN id SET DEFAULT nextval('delta_data.player_heatmaps_id_seq'::regclass);


--
-- TOC entry 3266 (class 2604 OID 16547)
-- Name: players id; Type: DEFAULT; Schema: delta_data; Owner: postgres
--

ALTER TABLE ONLY delta_data.players ALTER COLUMN id SET DEFAULT nextval('delta_data.players_id_seq'::regclass);


--
-- TOC entry 3284 (class 2604 OID 17463)
-- Name: team_roster id; Type: DEFAULT; Schema: delta_data; Owner: postgres
--

ALTER TABLE ONLY delta_data.team_roster ALTER COLUMN id SET DEFAULT nextval('delta_data.team_roster_id_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 16573)
-- Name: teams id; Type: DEFAULT; Schema: delta_data; Owner: postgres
--

ALTER TABLE ONLY delta_data.teams ALTER COLUMN id SET DEFAULT nextval('delta_data.teams_id_seq'::regclass);


--
-- TOC entry 3446 (class 0 OID 17405)
-- Dependencies: 256
-- Data for Name: api_loads_meta; Type: TABLE DATA; Schema: delta_data; Owner: postgres
--

--
-- If nothing else, populate the day before Delta Eon in api_loads_meta
-- To get things started
--

INSERT INTO delta_data.api_loads_meta (load_timestamp, game_timestamp, player_timestamp, game_events_timestamp, division_timestamp, stadium_timestamp)
VALUES ('2023-01-08 00:00:00', '2023-01-08 00:00:00', '2023-01-08 00:00:00', '2023-01-08 00:00:00', '2023-01-08 00:00:00', '2023-01-08 00:00:00');