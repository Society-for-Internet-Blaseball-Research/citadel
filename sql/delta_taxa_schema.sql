DROP SCHEMA IF EXISTS delta_taxa;

CREATE SCHEMA delta_taxa;

--
-- TOC entry 252 (class 1259 OID 17370)
-- Name: catch_adjectives; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.catch_adjectives (
    catch_adjective_id integer NOT NULL,
    catch_adjective character varying,
    catch_adjective_category character varying
);

--
-- TOC entry 251 (class 1259 OID 17369)
-- Name: catch_adjectives_catch_adjective_id_seq; Type: SEQUENCE; Schema: delta_taxa; Owner: postgres
--

CREATE SEQUENCE delta_taxa.catch_adjectives_catch_adjective_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 251
-- Name: catch_adjectives_catch_adjective_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_taxa; Owner: postgres
--

ALTER SEQUENCE delta_taxa.catch_adjectives_catch_adjective_id_seq OWNED BY delta_taxa.catch_adjectives.catch_adjective_id;


--
-- TOC entry 250 (class 1259 OID 17363)
-- Name: contact_adjectives; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.contact_adjectives (
    contact_adjective_id integer NOT NULL,
    contact_adjective character varying,
    contact_adjective_category character varying
);

--
-- TOC entry 249 (class 1259 OID 17362)
-- Name: contact_adjectives_contact_adjective_id_seq; Type: SEQUENCE; Schema: delta_taxa; Owner: postgres
--

CREATE SEQUENCE delta_taxa.contact_adjectives_contact_adjective_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 249
-- Name: contact_adjectives_contact_adjective_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_taxa; Owner: postgres
--

ALTER SEQUENCE delta_taxa.contact_adjectives_contact_adjective_id_seq OWNED BY delta_taxa.contact_adjectives.contact_adjective_id;


--
-- TOC entry 244 (class 1259 OID 17341)
-- Name: contact_sounds; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.contact_sounds (
    contact_sound_id integer NOT NULL,
    contact_sound character varying,
    contact_sound_category character varying
);

--
-- TOC entry 243 (class 1259 OID 17340)
-- Name: contact_sounds_contact_sound_id_seq; Type: SEQUENCE; Schema: delta_taxa; Owner: postgres
--

CREATE SEQUENCE delta_taxa.contact_sounds_contact_sound_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 243
-- Name: contact_sounds_contact_sound_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_taxa; Owner: postgres
--

ALTER SEQUENCE delta_taxa.contact_sounds_contact_sound_id_seq OWNED BY delta_taxa.contact_sounds.contact_sound_id;


--
-- TOC entry 246 (class 1259 OID 17349)
-- Name: contact_verbs; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.contact_verbs (
    contact_verb_id integer NOT NULL,
    contact_verb character varying,
    contact_verb_category character varying
);

--
-- TOC entry 245 (class 1259 OID 17348)
-- Name: contact_verbs_contact_verb_id_seq; Type: SEQUENCE; Schema: delta_taxa; Owner: postgres
--

CREATE SEQUENCE delta_taxa.contact_verbs_contact_verb_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 245
-- Name: contact_verbs_contact_verb_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_taxa; Owner: postgres
--

ALTER SEQUENCE delta_taxa.contact_verbs_contact_verb_id_seq OWNED BY delta_taxa.contact_verbs.contact_verb_id;


--
-- TOC entry 248 (class 1259 OID 17356)
-- Name: field_locations; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.field_locations (
    field_location_id integer NOT NULL,
    field_location character varying,
    field_location_category character varying
);

--
-- TOC entry 247 (class 1259 OID 17355)
-- Name: field_locations_field_location_id_seq; Type: SEQUENCE; Schema: delta_taxa; Owner: postgres
--

CREATE SEQUENCE delta_taxa.field_locations_field_location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 247
-- Name: field_locations_field_location_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_taxa; Owner: postgres
--

ALTER SEQUENCE delta_taxa.field_locations_field_location_id_seq OWNED BY delta_taxa.field_locations.field_location_id;


--
-- TOC entry 259 (class 1259 OID 17537)
-- Name: field_positions; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.field_positions (
    field_position_id bigint,
    x text,
    y text,
    position_name character varying
);

--
-- TOC entry 254 (class 1259 OID 17384)
-- Name: fielding_flavors; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.fielding_flavors (
    fielding_flavor_id integer NOT NULL,
    fielding_flavor character varying,
    fielding_flavor_category character varying
);

--
-- TOC entry 253 (class 1259 OID 17383)
-- Name: fielding_flavors_fielding_flavor_id_seq; Type: SEQUENCE; Schema: delta_taxa; Owner: postgres
--

CREATE SEQUENCE delta_taxa.fielding_flavors_fielding_flavor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 253
-- Name: fielding_flavors_fielding_flavor_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_taxa; Owner: postgres
--

ALTER SEQUENCE delta_taxa.fielding_flavors_fielding_flavor_id_seq OWNED BY delta_taxa.fielding_flavors.fielding_flavor_id;


--
-- TOC entry 236 (class 1259 OID 17313)
-- Name: pitch_adjectives; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.pitch_adjectives (
    pitch_adjective_id integer NOT NULL,
    pitch_adjective character varying,
    pitch_adjective_category character varying
);

--
-- TOC entry 235 (class 1259 OID 17312)
-- Name: pitch_adjectives_pitch_adjective_id_seq; Type: SEQUENCE; Schema: delta_taxa; Owner: postgres
--

CREATE SEQUENCE delta_taxa.pitch_adjectives_pitch_adjective_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 235
-- Name: pitch_adjectives_pitch_adjective_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_taxa; Owner: postgres
--

ALTER SEQUENCE delta_taxa.pitch_adjectives_pitch_adjective_id_seq OWNED BY delta_taxa.pitch_adjectives.pitch_adjective_id;


--
-- TOC entry 238 (class 1259 OID 17320)
-- Name: pitch_ball_flavors; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.pitch_ball_flavors (
    pitch_ball_flavor_id integer NOT NULL,
    pitch_ball_flavor character varying,
    pitch_ball_flavor_category character varying
);

--
-- TOC entry 237 (class 1259 OID 17319)
-- Name: pitch_ball_flavors_pitch_ball_flavor_id_seq; Type: SEQUENCE; Schema: delta_taxa; Owner: postgres
--

CREATE SEQUENCE delta_taxa.pitch_ball_flavors_pitch_ball_flavor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 237
-- Name: pitch_ball_flavors_pitch_ball_flavor_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_taxa; Owner: postgres
--

ALTER SEQUENCE delta_taxa.pitch_ball_flavors_pitch_ball_flavor_id_seq OWNED BY delta_taxa.pitch_ball_flavors.pitch_ball_flavor_id;


--
-- TOC entry 242 (class 1259 OID 17334)
-- Name: pitch_strike_flavors; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.pitch_strike_flavors (
    pitch_strike_flavor_id integer NOT NULL,
    pitch_strike_flavor character varying,
    pitch_strike_flavor_category character varying
);
--
-- TOC entry 241 (class 1259 OID 17333)
-- Name: pitch_strike_flavors_pitch_strike_flavor_id_seq; Type: SEQUENCE; Schema: delta_taxa; Owner: postgres
--

CREATE SEQUENCE delta_taxa.pitch_strike_flavors_pitch_strike_flavor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 241
-- Name: pitch_strike_flavors_pitch_strike_flavor_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_taxa; Owner: postgres
--

ALTER SEQUENCE delta_taxa.pitch_strike_flavors_pitch_strike_flavor_id_seq OWNED BY delta_taxa.pitch_strike_flavors.pitch_strike_flavor_id;


--
-- TOC entry 240 (class 1259 OID 17327)
-- Name: swing_adjectives; Type: TABLE; Schema: delta_taxa; Owner: postgres
--

CREATE TABLE delta_taxa.swing_adjectives (
    swing_adjective_id integer NOT NULL,
    swing_adjective character varying,
    swing_adjective_category character varying
);

--
-- TOC entry 239 (class 1259 OID 17326)
-- Name: swing_adjectives_swing_adjective_id_seq; Type: SEQUENCE; Schema: delta_taxa; Owner: postgres
--

CREATE SEQUENCE delta_taxa.swing_adjectives_swing_adjective_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 239
-- Name: swing_adjectives_swing_adjective_id_seq; Type: SEQUENCE OWNED BY; Schema: delta_taxa; Owner: postgres
--

ALTER SEQUENCE delta_taxa.swing_adjectives_swing_adjective_id_seq OWNED BY delta_taxa.swing_adjectives.swing_adjective_id;


--
-- TOC entry 3280 (class 2604 OID 17373)
-- Name: catch_adjectives catch_adjective_id; Type: DEFAULT; Schema: delta_taxa; Owner: postgres
--

ALTER TABLE ONLY delta_taxa.catch_adjectives ALTER COLUMN catch_adjective_id SET DEFAULT nextval('delta_taxa.catch_adjectives_catch_adjective_id_seq'::regclass);


--
-- TOC entry 3279 (class 2604 OID 17366)
-- Name: contact_adjectives contact_adjective_id; Type: DEFAULT; Schema: delta_taxa; Owner: postgres
--

ALTER TABLE ONLY delta_taxa.contact_adjectives ALTER COLUMN contact_adjective_id SET DEFAULT nextval('delta_taxa.contact_adjectives_contact_adjective_id_seq'::regclass);


--
-- TOC entry 3276 (class 2604 OID 17344)
-- Name: contact_sounds contact_sound_id; Type: DEFAULT; Schema: delta_taxa; Owner: postgres
--

ALTER TABLE ONLY delta_taxa.contact_sounds ALTER COLUMN contact_sound_id SET DEFAULT nextval('delta_taxa.contact_sounds_contact_sound_id_seq'::regclass);


--
-- TOC entry 3277 (class 2604 OID 17352)
-- Name: contact_verbs contact_verb_id; Type: DEFAULT; Schema: delta_taxa; Owner: postgres
--

ALTER TABLE ONLY delta_taxa.contact_verbs ALTER COLUMN contact_verb_id SET DEFAULT nextval('delta_taxa.contact_verbs_contact_verb_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 17359)
-- Name: field_locations field_location_id; Type: DEFAULT; Schema: delta_taxa; Owner: postgres
--

ALTER TABLE ONLY delta_taxa.field_locations ALTER COLUMN field_location_id SET DEFAULT nextval('delta_taxa.field_locations_field_location_id_seq'::regclass);


--
-- TOC entry 3281 (class 2604 OID 17387)
-- Name: fielding_flavors fielding_flavor_id; Type: DEFAULT; Schema: delta_taxa; Owner: postgres
--

ALTER TABLE ONLY delta_taxa.fielding_flavors ALTER COLUMN fielding_flavor_id SET DEFAULT nextval('delta_taxa.fielding_flavors_fielding_flavor_id_seq'::regclass);


--
-- TOC entry 3272 (class 2604 OID 17316)
-- Name: pitch_adjectives pitch_adjective_id; Type: DEFAULT; Schema: delta_taxa; Owner: postgres
--

ALTER TABLE ONLY delta_taxa.pitch_adjectives ALTER COLUMN pitch_adjective_id SET DEFAULT nextval('delta_taxa.pitch_adjectives_pitch_adjective_id_seq'::regclass);


--
-- TOC entry 3273 (class 2604 OID 17323)
-- Name: pitch_ball_flavors pitch_ball_flavor_id; Type: DEFAULT; Schema: delta_taxa; Owner: postgres
--

ALTER TABLE ONLY delta_taxa.pitch_ball_flavors ALTER COLUMN pitch_ball_flavor_id SET DEFAULT nextval('delta_taxa.pitch_ball_flavors_pitch_ball_flavor_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 17337)
-- Name: pitch_strike_flavors pitch_strike_flavor_id; Type: DEFAULT; Schema: delta_taxa; Owner: postgres
--

ALTER TABLE ONLY delta_taxa.pitch_strike_flavors ALTER COLUMN pitch_strike_flavor_id SET DEFAULT nextval('delta_taxa.pitch_strike_flavors_pitch_strike_flavor_id_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 17330)
-- Name: swing_adjectives swing_adjective_id; Type: DEFAULT; Schema: delta_taxa; Owner: postgres
--

ALTER TABLE ONLY delta_taxa.swing_adjectives ALTER COLUMN swing_adjective_id SET DEFAULT nextval('delta_taxa.swing_adjectives_swing_adjective_id_seq'::regclass);