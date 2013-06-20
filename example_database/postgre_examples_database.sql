--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: actor_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE actor_actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actor_actor_id_seq OWNER TO root;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actor; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE actor (
    actor_id integer DEFAULT nextval('actor_actor_id_seq'::regclass) NOT NULL,
    fullname character varying(250) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.actor OWNER TO root;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_category_id_seq OWNER TO root;

--
-- Name: category; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE category (
    category_id integer DEFAULT nextval('category_category_id_seq'::regclass) NOT NULL,
    name character varying(25) NOT NULL
);


ALTER TABLE public.category OWNER TO root;

--
-- Name: customers_customernumber_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE customers_customernumber_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_customernumber_seq OWNER TO root;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE customers (
    "customerNumber" integer DEFAULT nextval('customers_customernumber_seq'::regclass) NOT NULL,
    "customerName" character varying(50) NOT NULL,
    "contactLastName" character varying(50) NOT NULL,
    "contactFirstName" character varying(50) NOT NULL,
    phone character varying(50) NOT NULL,
    "addressLine1" character varying(50) NOT NULL,
    "addressLine2" character varying(50),
    city character varying(50) NOT NULL,
    state character varying(50),
    "postalCode" character varying(15),
    country character varying(50) NOT NULL,
    "salesRepEmployeeNumber" integer,
    "creditLimit" double precision
);


ALTER TABLE public.customers OWNER TO root;

--
-- Name: employees_employeenumber_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE employees_employeenumber_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employees_employeenumber_seq OWNER TO root;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE employees (
    "employeeNumber" integer DEFAULT nextval('employees_employeenumber_seq'::regclass) NOT NULL,
    "lastName" character varying(50) NOT NULL,
    "firstName" character varying(50) NOT NULL,
    extension character varying(10) NOT NULL,
    email character varying(100) NOT NULL,
    "officeCode" character varying(10) NOT NULL,
    file_url character varying(250) NOT NULL,
    "jobTitle" character varying(50) NOT NULL
);


ALTER TABLE public.employees OWNER TO root;

--
-- Name: film_film_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE film_film_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.film_film_id_seq OWNER TO root;

--
-- Name: film; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE film (
    film_id integer DEFAULT nextval('film_film_id_seq'::regclass) NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    release_year smallint,
    rental_duration smallint DEFAULT 3 NOT NULL,
    rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
    length integer,
    replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
    rating character varying(5) DEFAULT 'G'::character varying,
    special_features text[],
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT film_rating_check CHECK (((rating)::text = ANY ((ARRAY['G'::character varying, 'PG'::character varying, 'PG-13'::character varying, 'R'::character varying, 'NC-17'::character varying])::text[])))
);


ALTER TABLE public.film OWNER TO root;

--
-- Name: film_actor; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE film_actor (
    actor_id integer NOT NULL,
    film_id integer NOT NULL,
    priority integer NOT NULL
);


ALTER TABLE public.film_actor OWNER TO root;

--
-- Name: film_category; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE film_category (
    film_id integer NOT NULL,
    category_id smallint NOT NULL
);


ALTER TABLE public.film_category OWNER TO root;

--
-- Name: offices_officecode_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE offices_officecode_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offices_officecode_seq OWNER TO root;

--
-- Name: offices; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE offices (
    "officeCode" integer DEFAULT nextval('offices_officecode_seq'::regclass) NOT NULL,
    city character varying(50) NOT NULL,
    phone character varying(50) NOT NULL,
    "addressLine1" character varying(50) NOT NULL,
    "addressLine2" character varying(50),
    state character varying(50),
    country character varying(50) NOT NULL,
    "postalCode" character varying(15) NOT NULL,
    territory character varying(10) NOT NULL
);


ALTER TABLE public.offices OWNER TO root;

--
-- Name: orderdetails; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE orderdetails (
    "orderNumber" integer NOT NULL,
    "productCode" character varying(15) NOT NULL,
    "quantityOrdered" integer NOT NULL,
    "priceEach" double precision NOT NULL,
    "orderLineNumber" smallint NOT NULL
);


ALTER TABLE public.orderdetails OWNER TO root;

--
-- Name: orders_ordernumber_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE orders_ordernumber_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_ordernumber_seq OWNER TO root;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE orders (
    "orderNumber" integer DEFAULT nextval('orders_ordernumber_seq'::regclass) NOT NULL,
    "orderDate" timestamp without time zone NOT NULL,
    "requiredDate" timestamp without time zone NOT NULL,
    "shippedDate" timestamp without time zone,
    status character varying(10) NOT NULL,
    comments text,
    "customerNumber" integer NOT NULL,
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['Cancelled'::character varying, 'Disputed'::character varying, 'In Process'::character varying, 'On Hold'::character varying, 'Resolved'::character varying, 'Shipped'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO root;

--
-- Name: payments; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE payments (
    "customerNumber" integer NOT NULL,
    "checkNumber" character varying(50) NOT NULL,
    "paymentDate" timestamp without time zone NOT NULL,
    amount double precision NOT NULL
);


ALTER TABLE public.payments OWNER TO root;

--
-- Name: productlines; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE productlines (
    "productLine" character varying(50) NOT NULL,
    "textDescription" character varying(4000),
    "htmlDescription" text,
    image bytea
);


ALTER TABLE public.productlines OWNER TO root;

--
-- Name: products; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE products (
    "productCode" character varying(15) NOT NULL,
    "productName" character varying(70) NOT NULL,
    "productLine" character varying(50) NOT NULL,
    "productScale" character varying(10) NOT NULL,
    "productVendor" character varying(50) NOT NULL,
    "productDescription" text NOT NULL,
    "quantityInStock" smallint NOT NULL,
    "buyPrice" double precision NOT NULL,
    "MSRP" double precision NOT NULL
);


ALTER TABLE public.products OWNER TO root;

--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: root
--

COPY actor (actor_id, fullname, last_update) FROM stdin;
1	GUINESS PENELOPE	2011-04-24 19:27:25
2	WAHLBERG NICK	2011-04-24 19:27:25
3	CHASE ED	2011-04-24 19:27:25
4	DAVIS JENNIFER	2011-04-24 19:27:25
5	LOLLOBRIGIDA JOHNNY	2011-04-24 19:27:25
6	NICHOLSON BETTE	2011-04-24 19:27:25
7	MOSTEL GRACE	2011-04-24 19:27:25
8	JOHANSSON MATTHEW	2011-04-24 19:27:25
9	SWANK JOE	2011-04-24 19:27:25
10	GABLE CHRISTIAN	2011-04-24 19:27:25
11	CAGE ZERO	2011-04-24 19:27:25
12	BERRY KARL	2011-04-24 19:27:25
13	WOOD UMA	2011-04-24 19:27:25
14	BERGEN VIVIEN	2011-04-24 19:27:25
15	OLIVIER CUBA	2011-04-24 19:27:25
16	COSTNER FRED	2011-04-24 19:27:25
17	VOIGHT HELEN	2011-04-24 19:27:25
18	TORN DAN	2011-04-24 19:27:25
19	FAWCETT BOB	2011-04-24 19:27:25
20	TRACY LUCILLE	2011-04-24 19:27:25
21	PALTROW KIRSTEN	2011-04-24 19:27:25
22	MARX ELVIS	2011-04-24 19:27:25
23	KILMER SANDRA	2011-04-24 19:27:25
24	STREEP CAMERON	2011-04-24 19:27:25
25	BLOOM KEVIN	2011-04-24 19:27:25
26	CRAWFORD RIP	2011-04-24 19:27:25
27	MCQUEEN JULIA	2011-04-24 19:27:25
28	HOFFMAN WOODY	2011-04-24 19:27:25
29	WAYNE ALEC	2011-04-24 19:27:25
30	PECK SANDRA	2011-04-24 19:27:25
31	SOBIESKI SISSY	2011-04-24 19:27:25
32	HACKMAN TIM	2011-04-24 19:27:25
33	PECK MILLA	2011-04-24 19:27:25
34	OLIVIER AUDREY	2011-04-24 19:27:25
35	DEAN JUDY	2011-04-24 19:27:25
36	DUKAKIS BURT	2011-04-24 19:27:25
37	BOLGER VAL	2011-04-24 19:27:25
38	MCKELLEN TOM	2011-04-24 19:27:25
39	BRODY GOLDIE	2011-04-24 19:27:25
40	CAGE JOHNNY	2011-04-24 19:27:25
41	DEGENERES JODIE	2011-04-24 19:27:25
42	MIRANDA TOM	2011-04-24 19:27:25
43	JOVOVICH KIRK	2011-04-24 19:27:25
44	STALLONE NICK	2011-04-24 19:27:25
45	KILMER REESE	2011-04-24 19:27:25
46	GOLDBERG PARKER	2011-04-24 19:27:25
47	BARRYMORE JULIA	2011-04-24 19:27:25
48	DAY-LEWIS FRANCES	2011-04-24 19:27:25
49	CRONYN ANNE	2011-04-24 19:27:25
50	HOPKINS NATALIE	2011-04-24 19:27:25
51	PHOENIX GARY	2011-04-24 19:27:25
52	HUNT CARMEN	2011-04-24 19:27:25
53	TEMPLE MENA	2011-04-24 19:27:25
54	PINKETT PENELOPE	2011-04-24 19:27:25
55	KILMER FAY	2011-04-24 19:27:25
56	HARRIS DAN	2011-04-24 19:27:25
57	CRUISE JUDE	2011-04-24 19:27:25
58	AKROYD CHRISTIAN	2011-04-24 19:27:25
59	TAUTOU DUSTIN	2011-04-24 19:27:25
60	BERRY HENRY	2011-04-24 19:27:25
61	NEESON CHRISTIAN	2011-04-24 19:27:25
62	NEESON JAYNE	2011-04-24 19:27:25
63	WRAY CAMERON	2011-04-24 19:27:25
64	JOHANSSON RAY	2011-04-24 19:27:25
65	HUDSON ANGELA	2011-04-24 19:27:25
66	TANDY MARY	2011-04-24 19:27:25
67	BAILEY JESSICA	2011-04-24 19:27:25
68	WINSLET RIP	2011-04-24 19:27:25
69	PALTROW KENNETH	2011-04-24 19:27:25
70	MCCONAUGHEY MICHELLE	2011-04-24 19:27:25
71	GRANT ADAM	2011-04-24 19:27:25
72	WILLIAMS SEAN	2011-04-24 19:27:25
73	PENN GARY	2011-04-24 19:27:25
74	KEITEL MILLA	2011-04-24 19:27:25
75	POSEY BURT	2011-04-24 19:27:25
76	ASTAIRE ANGELINA	2011-04-24 19:27:25
77	MCCONAUGHEY CARY	2011-04-24 19:27:25
78	SINATRA GROUCHO	2011-04-24 19:27:25
79	HOFFMAN MAE	2011-04-24 19:27:25
80	CRUZ RALPH	2011-04-24 19:27:25
81	DAMON SCARLETT	2011-04-24 19:27:25
82	JOLIE WOODY	2011-04-24 19:27:25
83	WILLIS BEN	2011-04-24 19:27:25
84	PITT JAMES	2011-04-24 19:27:25
85	ZELLWEGER MINNIE	2011-04-24 19:27:25
86	CHAPLIN GREG	2011-04-24 19:27:25
87	PECK SPENCER	2011-04-24 19:27:25
88	PESCI KENNETH	2011-04-24 19:27:25
89	DENCH CHARLIZE	2011-04-24 19:27:25
90	GUINESS SEAN	2011-04-24 19:27:25
91	BERRY CHRISTOPHER	2011-04-24 19:27:25
92	AKROYD KIRSTEN	2011-04-24 19:27:25
93	PRESLEY ELLEN	2011-04-24 19:27:25
94	TORN KENNETH	2011-04-24 19:27:25
95	WAHLBERG DARYL	2011-04-24 19:27:25
96	WILLIS GENE	2011-04-24 19:27:25
97	HAWKE MEG	2011-04-24 19:27:25
98	BRIDGES CHRIS	2011-04-24 19:27:25
99	MOSTEL JIM	2011-04-24 19:27:25
100	DEPP SPENCER	2011-04-24 19:27:25
101	DAVIS SUSAN	2011-04-24 19:27:25
102	TORN WALTER	2011-04-24 19:27:25
103	LEIGH MATTHEW	2011-04-24 19:27:25
104	CRONYN PENELOPE	2011-04-24 19:27:25
105	CROWE SIDNEY	2011-04-24 19:27:25
106	DUNST GROUCHO	2011-04-24 19:27:25
107	DEGENERES GINA	2011-04-24 19:27:25
108	NOLTE WARREN	2011-04-24 19:27:25
109	DERN SYLVESTER	2011-04-24 19:27:25
110	DAVIS SUSAN	2011-04-24 19:27:25
111	ZELLWEGER CAMERON	2011-04-24 19:27:25
112	BACALL RUSSELL	2011-04-24 19:27:25
113	HOPKINS MORGAN	2011-04-24 19:27:25
114	MCDORMAND MORGAN	2011-04-24 19:27:25
115	BALE HARRISON	2011-04-24 19:27:25
116	STREEP DAN	2011-04-24 19:27:25
117	TRACY RENEE	2011-04-24 19:27:25
118	ALLEN CUBA	2011-04-24 19:27:25
119	JACKMAN WARREN	2011-04-24 19:27:25
120	MONROE PENELOPE	2011-04-24 19:27:25
121	BERGMAN LIZA	2011-04-24 19:27:25
122	NOLTE SALMA	2011-04-24 19:27:25
123	DENCH JULIANNE	2011-04-24 19:27:25
124	BENING SCARLETT	2011-04-24 19:27:25
125	NOLTE ALBERT	2011-04-24 19:27:25
126	TOMEI FRANCES	2011-04-24 19:27:25
127	GARLAND KEVIN	2011-04-24 19:27:25
128	MCQUEEN CATE	2011-04-24 19:27:25
129	CRAWFORD DARYL	2011-04-24 19:27:25
130	KEITEL GRETA	2011-04-24 19:27:25
131	JACKMAN JANE	2011-04-24 19:27:25
132	HOPPER ADAM	2011-04-24 19:27:25
133	PENN RICHARD	2011-04-24 19:27:25
134	HOPKINS GENE	2011-04-24 19:27:25
135	REYNOLDS RITA	2011-04-24 19:27:25
136	MANSFIELD ED	2011-04-24 19:27:25
137	WILLIAMS MORGAN	2011-04-24 19:27:25
138	DEE LUCILLE	2011-04-24 19:27:25
139	GOODING EWAN	2011-04-24 19:27:25
140	HURT WHOOPI	2011-04-24 19:27:25
141	HARRIS CATE	2011-04-24 19:27:25
142	RYDER JADA	2011-04-24 19:27:25
143	DEAN RIVER	2011-04-24 19:27:25
144	WITHERSPOON ANGELA	2011-04-24 19:27:25
145	ALLEN KIM	2011-04-24 19:27:25
146	JOHANSSON ALBERT	2011-04-24 19:27:25
147	WINSLET FAY	2011-04-24 19:27:25
148	DEE EMILY	2011-04-24 19:27:25
149	TEMPLE RUSSELL	2011-04-24 19:27:25
150	NOLTE JAYNE	2011-04-24 19:27:25
151	HESTON GEOFFREY	2011-04-24 19:27:25
152	HARRIS BEN	2011-04-24 19:27:25
153	KILMER MINNIE	2011-04-24 19:27:25
154	GIBSON MERYL	2011-04-24 19:27:25
155	TANDY IAN	2011-04-24 19:27:25
156	WOOD FAY	2011-04-24 19:27:25
157	MALDEN GRETA	2011-04-24 19:27:25
158	BASINGER VIVIEN	2011-04-24 19:27:25
159	BRODY LAURA	2011-04-24 19:27:25
160	DEPP CHRIS	2011-04-24 19:27:25
161	HOPE HARVEY	2011-04-24 19:27:25
162	KILMER OPRAH	2011-04-24 19:27:25
163	WEST CHRISTOPHER	2011-04-24 19:27:25
164	WILLIS HUMPHREY	2011-04-24 19:27:25
165	GARLAND AL	2011-04-24 19:27:25
166	DEGENERES NICK	2011-04-24 19:27:25
167	BULLOCK LAURENCE	2011-04-24 19:27:25
168	WILSON WILL	2011-04-24 19:27:25
169	HOFFMAN KENNETH	2011-04-24 19:27:25
170	HOPPER MENA	2011-04-24 19:27:25
171	PFEIFFER OLYMPIA	2011-04-24 19:27:25
172	WILLIAMS GROUCHO	2011-04-24 19:27:25
173	DREYFUSS ALAN	2011-04-24 19:27:25
174	BENING MICHAEL	2011-04-24 19:27:25
175	HACKMAN WILLIAM	2011-04-24 19:27:25
176	CHASE JON	2011-04-24 19:27:25
177	MCKELLEN GENE	2011-04-24 19:27:25
178	MONROE LISA	2011-04-24 19:27:25
179	GUINESS ED	2011-04-24 19:27:25
180	SILVERSTONE JEFF	2011-04-24 19:27:25
181	CARREY MATTHEW	2011-04-24 19:27:25
182	AKROYD DEBBIE	2011-04-24 19:27:25
183	CLOSE RUSSELL	2011-04-24 19:27:25
184	GARLAND HUMPHREY	2011-04-24 19:27:25
185	BOLGER MICHAEL	2011-04-24 19:27:25
186	ZELLWEGER JULIA	2011-04-24 19:27:25
187	BALL RENEE	2011-04-24 19:27:25
188	DUKAKIS ROCK	2011-04-24 19:27:25
189	BIRCH CUBA	2011-04-24 19:27:25
190	BAILEY AUDREY	2011-04-24 19:27:25
191	GOODING GREGORY	2011-04-24 19:27:25
192	SUVARI JOHN	2011-04-24 19:27:25
193	TEMPLE BURT	2011-04-24 19:27:25
194	ALLEN MERYL	2011-04-24 19:27:25
195	SILVERSTONE JAYNE	2011-04-24 19:27:25
196	WALKEN BELA	2011-04-24 19:27:25
197	WEST REESE	2011-04-24 19:27:25
198	KEITEL MARY	2011-04-24 19:27:25
199	FAWCETT JULIA	2011-04-24 19:27:25
200	TEMPLE THORA	2011-04-24 19:27:25
\.


--
-- Name: actor_actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('actor_actor_id_seq', 201, true);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: root
--

COPY category (category_id, name) FROM stdin;
1	Action
2	Animation
3	Children
4	Classics
5	Comedy
6	Documentary
7	Drama
8	Family
9	Foreign
10	Games
11	Horror
12	Music
13	New
14	Sci-Fi
15	Sports
16	Travel
\.


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('category_category_id_seq', 17, true);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: root
--

COPY customers ("customerNumber", "customerName", "contactLastName", "contactFirstName", phone, "addressLine1", "addressLine2", city, state, "postalCode", country, "salesRepEmployeeNumber", "creditLimit") FROM stdin;
103	Atelier graphique	Schmitt	Carine 	40.32.2555	54, rue Royale	\N	Nantes	\N	44000	France	1370	21000
112	Signal Gift Stores	King	Jean	7025551838	8489 Strong St.	\N	Las Vegas	NV	83030	USA	1166	71800
114	Australian Collectors, Co.	Ferguson	Peter	03 9520 4555	636 St Kilda Road	Level 3	Melbourne	Victoria	3004	Australia	1611	117300
119	La Rochelle Gifts	Labrune	Janine 	40.67.8555	67, rue des Cinquante Otages	\N	Nantes	\N	44000	France	1370	118200
121	Baane Mini Imports	Bergulfsen	Jonas 	07-98 9555	Erling Skakkes gate 78	\N	Stavern	\N	4110	Norway	1504	81700
124	Mini Gifts Distributors Ltd.	Nelson	Susan	4155551450	5677 Strong St.	\N	San Rafael	CA	97562	USA	1165	210500
125	Havel & Zbyszek Co	Piestrzeniewicz	Zbyszek 	(26) 642-7555	ul. Filtrowa 68	\N	Warszawa	\N	01-012	Poland	\N	0
128	Blauer See Auto, Co.	Keitel	Roland	+49 69 66 90 2555	Lyonerstr. 34	\N	Frankfurt	\N	60528	Germany	1504	59700
129	Mini Wheels Co.	Murphy	Julie	6505555787	5557 North Pendale Street	\N	San Francisco	CA	94217	USA	1165	64600
131	Land of Toys Inc.	Lee	Kwai	2125557818	897 Long Airport Avenue	\N	NYC	NY	10022	USA	1323	114900
141	Euro+ Shopping Channel	Freyre	Diego 	(91) 555 94 44	C/ Moralzarzal, 86	\N	Madrid	\N	28034	Spain	1370	227600
144	Volvo Model Replicas, Co	Berglund	Christina 	0921-12 3555	BerguvsvÃ¤gen  8	\N	LuleÃ¥	\N	S-958 22	Sweden	1504	53100
145	Danish Wholesale Imports	Petersen	Jytte 	31 12 3555	VinbÃ¦ltet 34	\N	Kobenhavn	\N	1734	Denmark	1401	83400
146	Saveley & Henriot, Co.	Saveley	Mary 	78.32.5555	2, rue du Commerce	\N	Lyon	\N	69004	France	1337	123900
148	Dragon Souveniers, Ltd.	Natividad	Eric	+65 221 7555	Bronz Sok.	Bronz Apt. 3/6 Tesvikiye	Singapore	\N	079903	Singapore	1621	103800
151	Muscle Machine Inc	Young	Jeff	2125557413	4092 Furth Circle	Suite 400	NYC	NY	10022	USA	1286	138500
157	Diecast Classics Inc.	Leong	Kelvin	2155551555	7586 Pompton St.	\N	Allentown	PA	70267	USA	1216	100600
161	Technics Stores Inc.	Hashimoto	Juri	6505556809	9408 Furth Circle	\N	Burlingame	CA	94217	USA	1165	84600
166	Handji Gifts& Co	Victorino	Wendy	+65 224 1555	106 Linden Road Sandown	2nd Floor	Singapore	\N	069045	Singapore	1612	97900
167	Herkku Gifts	Oeztan	Veysel	+47 2267 3215	Brehmen St. 121	PR 334 Sentrum	Bergen	\N	N 5804	Norway  	1504	96800
168	American Souvenirs Inc	Franco	Keith	2035557845	149 Spinnaker Dr.	Suite 101	New Haven	CT	97823	USA	1286	0
169	Porto Imports Co.	de Castro	Isabel 	(1) 356-5555	Estrada da saÃºde n. 58	\N	Lisboa	\N	1756	Portugal	\N	0
171	Daedalus Designs Imports	RancÃ©	Martine 	20.16.1555	184, chaussÃ©e de Tournai	\N	Lille	\N	59000	France	1370	82900
172	La Corne D'abondance, Co.	Bertrand	Marie	(1) 42.34.2555	265, boulevard Charonne	\N	Paris	\N	75012	France	1337	84300
173	Cambridge Collectables Co.	Tseng	Jerry	6175555555	4658 Baden Av.	\N	Cambridge	MA	51247	USA	1188	43400
175	Gift Depot Inc.	King	Julie	2035552570	25593 South Bay Ln.	\N	Bridgewater	CT	97562	USA	1323	84300
177	Osaka Souveniers Co.	Kentary	Mory	+81 06 6342 5555	1-6-20 Dojima	\N	Kita-ku	Osaka	 530-0003	Japan	1621	81200
181	Vitachrome Inc.	Frick	Michael	2125551500	2678 Kingston Rd.	Suite 101	NYC	NY	10022	USA	1286	76400
186	Toys of Finland, Co.	Karttunen	Matti	90-224 8555	Keskuskatu 45	\N	Helsinki	\N	21240	Finland	1501	96500
187	AV Stores, Co.	Ashworth	Rachel	(171) 555-1555	Fauntleroy Circus	\N	Manchester	\N	EC2 5NT	UK	1501	136800
189	Clover Collections, Co.	Cassidy	Dean	+353 1862 1555	25 Maiden Lane	Floor No. 4	Dublin	\N	2	Ireland	1504	69400
198	Auto-Moto Classics Inc.	Taylor	Leslie	6175558428	16780 Pompton St.	\N	Brickhaven	MA	58339	USA	1216	23000
201	UK Collectables, Ltd.	Devon	Elizabeth	(171) 555-2282	12, Berkeley Gardens Blvd	\N	Liverpool	\N	WX1 6LT	UK	1501	92700
202	Canadian Gift Exchange Network	Tamuri	Yoshi 	(604) 555-3392	1900 Oak St.	\N	Vancouver	BC	V3F 2K1	Canada	1323	90300
204	Online Mini Collectables	Barajas	Miguel	6175557555	7635 Spinnaker Dr.	\N	Brickhaven	MA	58339	USA	1188	68700
205	Toys4GrownUps.com	Young	Julie	6265557265	78934 Hillside Dr.	\N	Pasadena	CA	90003	USA	1166	90700
206	Asian Shopping Network, Co	Walker	Brydey	+612 9411 1555	Suntec Tower Three	8 Temasek	Singapore	\N	038988	Singapore	\N	0
209	Mini Caravy	Citeaux	FrÃ©dÃ©rique 	88.60.1555	24, place KlÃ©ber	\N	Strasbourg	\N	67000	France	1370	53800
211	King Kong Collectables, Co.	Gao	Mike	+852 2251 1555	Bank of China Tower	1 Garden Road	Central Hong Kong	\N	\N	Hong Kong	1621	58600
216	Enaco Distributors	Saavedra	Eduardo 	(93) 203 4555	Rambla de CataluÃ±a, 23	\N	Barcelona	\N	08022	Spain	1702	60300
219	Boards & Toys Co.	Young	Mary	3105552373	4097 Douglas Av.	\N	Glendale	CA	92561	USA	1166	11000
223	NatÃ¼rlich Autos	Kloss	Horst 	0372-555188	TaucherstraÃŸe 10	\N	Cunewalde	\N	01307	Germany	\N	0
227	Heintze Collectables	Ibsen	Palle	86 21 3555	Smagsloget 45	\N	Ã…rhus	\N	8200	Denmark	1401	120800
233	QuÃ©bec Home Shopping Network	FresniÃ¨re	Jean 	(514) 555-8054	43 rue St. Laurent	\N	MontrÃ©al	QuÃ©bec	H1J 1C3	Canada	1286	48700
237	ANG Resellers	Camino	Alejandra 	(91) 745 6555	Gran VÃ­a, 1	\N	Madrid	\N	28001	Spain	\N	0
239	Collectable Mini Designs Co.	Thompson	Valarie	7605558146	361 Furth Circle	\N	San Diego	CA	91217	USA	1166	105000
240	giftsbymail.co.uk	Bennett	Helen 	(198) 555-8888	Garden House	Crowther Way 23	Cowes	Isle of Wight	PO31 7PJ	UK	1501	93900
242	Alpha Cognac	Roulet	Annette 	61.77.6555	1 rue Alsace-Lorraine	\N	Toulouse	\N	31000	France	1370	61100
247	Messner Shopping Network	Messner	Renate 	069-0555984	Magazinweg 7	\N	Frankfurt	\N	60528	Germany	\N	0
249	Amica Models & Co.	Accorti	Paolo 	011-4988555	Via Monte Bianco 34	\N	Torino	\N	10100	Italy	1401	113000
250	Lyon Souveniers	Da Silva	Daniel	+33 1 46 62 7555	27 rue du Colonel Pierre Avia	\N	Paris	\N	75508	France	1337	68100
256	Auto AssociÃ©s & Cie.	Tonini	Daniel 	30.59.8555	67, avenue de l'Europe	\N	Versailles	\N	78000	France	1370	77900
259	Toms SpezialitÃ¤ten, Ltd	Pfalzheim	Henriette 	0221-5554327	Mehrheimerstr. 369	\N	KÃ¶ln	\N	50739	Germany	1504	120400
260	Royal Canadian Collectables, Ltd.	Lincoln	Elizabeth 	(604) 555-4555	23 Tsawassen Blvd.	\N	Tsawassen	BC	T2F 8M4	Canada	1323	89600
273	Franken Gifts, Co	Franken	Peter 	089-0877555	Berliner Platz 43	\N	MÃ¼nchen	\N	80805	Germany	\N	0
276	Anna's Decorations, Ltd	O'Hara	Anna	02 9936 8555	201 Miller Street	Level 15	North Sydney	NSW	2060	Australia	1611	107800
278	Rovelli Gifts	Rovelli	Giovanni 	035-640555	Via Ludovico il Moro 22	\N	Bergamo	\N	24100	Italy	1401	119600
282	Souveniers And Things Co.	Huxley	Adrian	+61 2 9495 8555	Monitor Money Building	815 Pacific Hwy	Chatswood	NSW	2067	Australia	1611	93300
286	Marta's Replicas Co.	Hernandez	Marta	6175558555	39323 Spinnaker Dr.	\N	Cambridge	MA	51247	USA	1216	123700
293	BG&E Collectables	Harrison	Ed	+41 26 425 50 01	Rte des Arsenaux 41 	\N	Fribourg	\N	1700	Switzerland	\N	0
298	Vida Sport, Ltd	Holz	Mihael	0897-034555	Grenzacherweg 237	\N	GenÃ¨ve	\N	1203	Switzerland	1702	141300
299	Norway Gifts By Mail, Co.	Klaeboe	Jan	+47 2212 1555	Drammensveien 126A	PB 211 Sentrum	Oslo	\N	N 0106	Norway  	1504	95100
303	Schuyler Imports	Schuyler	Bradley	+31 20 491 9555	Kingsfordweg 151	\N	Amsterdam	\N	1043 GR	Netherlands	\N	0
307	Der Hund Imports	Andersen	Mel	030-0074555	Obere Str. 57	\N	Berlin	\N	12209	Germany	\N	0
311	Oulu Toy Supplies, Inc.	Koskitalo	Pirkko	981-443655	Torikatu 38	\N	Oulu	\N	90110	Finland	1501	90500
314	Petit Auto	Dewey	Catherine 	(02) 5554 67	Rue Joseph-Bens 532	\N	Bruxelles	\N	B-1180	Belgium	1401	79900
319	Mini Classics	Frick	Steve	9145554562	3758 North Pendale Street	\N	White Plains	NY	24067	USA	1323	102700
320	Mini Creations Ltd.	Huang	Wing	5085559555	4575 Hillside Dr.	\N	New Bedford	MA	50553	USA	1188	94500
321	Corporate Gift Ideas Co.	Brown	Julie	6505551386	7734 Strong St.	\N	San Francisco	CA	94217	USA	1165	105000
323	Down Under Souveniers, Inc	Graham	Mike	+64 9 312 5555	162-164 Grafton Road	Level 2	Auckland  	\N	\N	New Zealand	1612	88000
324	Stylish Desk Decors, Co.	Brown	Ann 	(171) 555-0297	35 King George	\N	London	\N	WX3 6FW	UK	1501	77000
328	Tekni Collectables Inc.	Brown	William	2015559350	7476 Moss Rd.	\N	Newark	NJ	94019	USA	1323	43000
333	Australian Gift Network, Co	Calaghan	Ben	61-7-3844-6555	31 Duncan St. West End	\N	South Brisbane	Queensland	4101	Australia	1611	51600
334	Suominen Souveniers	Suominen	Kalle	+358 9 8045 555	Software Engineering Center	SEC Oy	Espoo	\N	FIN-02271	Finland	1501	98800
335	Cramer SpezialitÃ¤ten, Ltd	Cramer	Philip 	0555-09555	Maubelstr. 90	\N	Brandenburg	\N	14776	Germany	\N	0
339	Classic Gift Ideas, Inc	Cervantes	Francisca	2155554695	782 First Street	\N	Philadelphia	PA	71270	USA	1188	81100
344	CAF Imports	Fernandez	Jesus	+34 913 728 555	Merchants House	27-30 Merchant's Quay	Madrid	\N	28023	Spain	1702	59600
347	Men 'R' US Retailers, Ltd.	Chandler	Brian	2155554369	6047 Douglas Av.	\N	Los Angeles	CA	91003	USA	1166	57700
348	Asian Treasures, Inc.	McKenna	Patricia 	2967 555	8 Johnstown Road	\N	Cork	Co. Cork	\N	Ireland	\N	0
350	Marseille Mini Autos	Lebihan	Laurence 	91.24.4555	12, rue des Bouchers	\N	Marseille	\N	13008	France	1337	65000
353	Reims Collectables	Henriot	Paul 	26.47.1555	59 rue de l'Abbaye	\N	Reims	\N	51100	France	1337	81100
356	SAR Distributors, Co	Kuger	Armand	+27 21 550 3555	1250 Pretorius Street	\N	Hatfield	Pretoria	0028	South Africa	\N	0
357	GiftsForHim.com	MacKinlay	Wales	64-9-3763555	199 Great North Road	\N	Auckland	\N	\N	New Zealand	1612	77700
361	Kommission Auto	Josephs	Karin	0251-555259	Luisenstr. 48	\N	MÃ¼nster	\N	44087	Germany	\N	0
362	Gifts4AllAges.com	Yoshido	Juri	6175559555	8616 Spinnaker Dr.	\N	Boston	MA	51003	USA	1216	41900
363	Online Diecast Creations Co.	Young	Dorothy	6035558647	2304 Long Airport Avenue	\N	Nashua	NH	62005	USA	1216	114200
369	Lisboa Souveniers, Inc	Rodriguez	Lino 	(1) 354-2555	Jardim das rosas n. 32	\N	Lisboa	\N	1675	Portugal	\N	0
376	Precious Collectables	Urs	Braun	0452-076555	Hauptstr. 29	\N	Bern	\N	3012	Switzerland	1702	0
379	Collectables For Less Inc.	Nelson	Allen	6175558555	7825 Douglas Av.	\N	Brickhaven	MA	58339	USA	1188	70700
381	Royale Belge	Cartrain	Pascale 	(071) 23 67 2555	Boulevard Tirou, 255	\N	Charleroi	\N	B-6000	Belgium	1401	23500
382	Salzburg Collectables	Pipps	Georg 	6562-9555	Geislweg 14	\N	Salzburg	\N	5020	Austria	1401	71700
385	Cruz & Sons Co.	Cruz	Arnold	+63 2 555 3587	15 McCallum Street	NatWest Center #13-03	Makati City	\N	1227 MM	Philippines	1621	81500
386	L'ordine Souveniers	Moroni	Maurizio 	0522-556555	Strada Provinciale 124	\N	Reggio Emilia	\N	42100	Italy	1401	121400
398	Tokyo Collectables, Ltd	Shimamura	Akiko	+81 3 3584 0555	2-2-8 Roppongi	\N	Minato-ku	Tokyo	106-0032	Japan	1621	94400
406	Auto Canal+ Petit	Perrier	Dominique	(1) 47.55.6555	25, rue Lauriston	\N	Paris	\N	75016	France	1337	95000
409	Stuttgart Collectable Exchange	MÃ¼ller	Rita 	0711-555361	Adenauerallee 900	\N	Stuttgart	\N	70563	Germany	\N	0
412	Extreme Desk Decorations, Ltd	McRoy	Sarah	04 499 9555	101 Lambton Quay	Level 11	Wellington	\N	\N	New Zealand	1612	86800
415	Bavarian Collectables Imports, Co.	Donnermeyer	Michael	 +49 89 61 08 9555	Hansastr. 15	\N	Munich	\N	80686	Germany	1504	77000
424	Classic Legends Inc.	Hernandez	Maria	2125558493	5905 Pompton St.	Suite 750	NYC	NY	10022	USA	1286	67500
443	Feuer Online Stores, Inc	Feuer	Alexander 	0342-555176	Heerstr. 22	\N	Leipzig	\N	04179	Germany	\N	0
447	Gift Ideas Corp.	Lewis	Dan	2035554407	2440 Pompton St.	\N	Glendale	CT	97561	USA	1323	49700
448	Scandinavian Gift Ideas	Larsson	Martha	0695-34 6555	Ã…kergatan 24	\N	BrÃ¤cke	\N	S-844 67	Sweden	1504	116400
450	The Sharp Gifts Warehouse	Frick	Sue	4085553659	3086 Ingle Ln.	\N	San Jose	CA	94217	USA	1165	77600
452	Mini Auto Werke	Mendel	Roland 	7675-3555	Kirchgasse 6	\N	Graz	\N	8010	Austria	1401	45300
455	Super Scale Inc.	Murphy	Leslie	2035559545	567 North Pendale Street	\N	New Haven	CT	97823	USA	1286	95400
456	Microscale Inc.	Choi	Yu	2125551957	5290 North Pendale Street	Suite 200	NYC	NY	10022	USA	1286	39800
458	Corrida Auto Replicas, Ltd	Sommer	MartÃ­n 	(91) 555 22 82	C/ Araquil, 67	\N	Madrid	\N	28023	Spain	1702	104600
459	Warburg Exchange	Ottlieb	Sven 	0241-039123	Walserweg 21	\N	Aachen	\N	52066	Germany	\N	0
462	FunGiftIdeas.com	Benitez	Violeta	5085552555	1785 First Street	\N	New Bedford	MA	50553	USA	1216	85800
465	Anton Designs, Ltd.	Anton	Carmen	+34 913 728555	c/ Gobelas, 19-1 Urb. La Florida	\N	Madrid	\N	28023	Spain	\N	0
471	Australian Collectables, Ltd	Clenahan	Sean	61-9-3844-6555	7 Allen Street	\N	Glen Waverly	Victoria	3150	Australia	1611	60300
473	Frau da Collezione	Ricotti	Franco	+39 022515555	20093 Cologno Monzese	Alessandro Volta 16	Milan	\N	\N	Italy	1401	34800
475	West Coast Collectables Co.	Thompson	Steve	3105553722	3675 Furth Circle	\N	Burbank	CA	94019	USA	1166	55400
477	Mit VergnÃ¼gen & Co.	Moos	Hanna 	0621-08555	Forsterstr. 57	\N	Mannheim	\N	68306	Germany	\N	0
480	Kremlin Collectables, Co.	Semenov	Alexander 	+7 812 293 0521	2 Pobedy Square	\N	Saint Petersburg	\N	196143	Russia	\N	0
481	Raanan Stores, Inc	Altagar,G M	Raanan	+ 972 9 959 8555	3 Hagalim Blv.	\N	Herzlia	\N	47625	Israel	\N	0
484	Iberia Gift Imports, Corp.	Roel	JosÃ© Pedro 	(95) 555 82 82	C/ Romero, 33	\N	Sevilla	\N	41101	Spain	1702	65700
486	Motor Mint Distributors Inc.	Salazar	Rosa	2155559857	11328 Douglas Av.	\N	Philadelphia	PA	71270	USA	1323	72600
487	Signal Collectibles Ltd.	Taylor	Sue	4155554312	2793 Furth Circle	\N	Brisbane	CA	94217	USA	1165	60300
489	Double Decker Gift Stores, Ltd	Smith	Thomas 	(171) 555-7555	120 Hanover Sq.	\N	London	\N	WA1 1DP	UK	1501	43300
495	Diecast Collectables	Franco	Valarie	6175552555	6251 Ingle Ln.	\N	Boston	MA	51003	USA	1188	85100
496	Kelly's Gift Shop	Snowden	Tony	+64 9 5555500	Arenales 1938 3'A'	\N	Auckland  	\N	\N	New Zealand	1612	110000
\.


--
-- Name: customers_customernumber_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('customers_customernumber_seq', 497, true);


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: root
--

COPY employees ("employeeNumber", "lastName", "firstName", extension, email, "officeCode", file_url, "jobTitle") FROM stdin;
1002	Murphy	Diane	x5800	dmurphy@classicmodelcars.com	1		President
1056	Patterson	Mary	x4611	mpatterso@classicmodelcars.com	1		VP Sales
1076	Firrelli	Jeff	x9273	jfirrelli@classicmodelcars.com	1		VP Marketing
1088	Patterson	William	x4871	wpatterson@classicmodelcars.com	6		Sales Manager (APAC)
1102	Bondur	Gerard	x5408	gbondur@classicmodelcars.com	4	pdftest.pdf	Sale Manager (EMEA)
1143	Bow	Anthony	x5428	abow@classicmodelcars.com	1		Sales Manager (NA)
1165	Jennings	Leslie	x3291	ljennings@classicmodelcars.com	1		Sales Rep
1166	Thompson	Leslie	x4065	lthompson@classicmodelcars.com	1		Sales Rep
1188	Firrelli	Julie	x2173	jfirrelli@classicmodelcars.com	2	test-2.pdf	Sales Rep
1216	Patterson	Steve	x4334	spatterson@classicmodelcars.com	2		Sales Rep
1286	Tseng	Foon Yue	x2248	ftseng@classicmodelcars.com	3		Sales Rep
1323	Vanauf	George	x4102	gvanauf@classicmodelcars.com	3		Sales Rep
1337	Bondur	Loui	x6493	lbondur@classicmodelcars.com	4		Sales Rep
1370	Hernandez	Gerard	x2028	ghernande@classicmodelcars.com	4		Sales Rep
1401	Castillo	Pamela	x2759	pcastillo@classicmodelcars.com	4		Sales Rep
1501	Bott	Larry	x2311	lbott@classicmodelcars.com	7		Sales Rep
1504	Jones	Barry	x102	bjones@classicmodelcars.com	7		Sales Rep
1611	Fixter	Andy	x101	afixter@classicmodelcars.com	6		Sales Rep
1612	Marsh	Peter	x102	pmarsh@classicmodelcars.com	6		Sales Rep
1619	King	Tom	x103	tking@classicmodelcars.com	6		Sales Rep
1621	Nishi	Mami	x101	mnishi@classicmodelcars.com	5		Sales Rep
1625	Kato	Yoshimi	x102	ykato@classicmodelcars.com	5		Sales Rep
1702	Gerard	Martin	x2312	mgerard@classicmodelcars.com	4		Sales Rep
\.


--
-- Name: employees_employeenumber_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('employees_employeenumber_seq', 1703, true);


--
-- Data for Name: film; Type: TABLE DATA; Schema: public; Owner: root
--

COPY film (film_id, title, description, release_year, rental_duration, rental_rate, length, replacement_cost, rating, special_features, last_update) FROM stdin;
1	ACADEMY DINOSAUR	<p>A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies</p>	2006	6	0.99	86	20.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
2	ACE GOLDFINGER	A Astounding Epistle of a Database Administrator And a Explorer who must Find a Car in Ancient China	2006	3	4.99	48	12.99	G	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
3	ADAPTATION HOLES	A Astounding Reflection of a Lumberjack And a Car who must Sink a Lumberjack in A Baloon Factory	2006	7	2.99	50	18.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
4	AFFAIR PREJUDICE	A Fanciful Documentary of a Frisbee And a Lumberjack who must Chase a Monkey in A Shark Tank	2006	5	2.99	117	26.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
5	AFRICAN EGG	A Fast-Paced Documentary of a Pastry Chef And a Dentist who must Pursue a Forensic Psychologist in The Gulf of Mexico	2006	6	2.99	130	22.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
6	AGENT TRUMAN	A Intrepid Panorama of a Robot And a Boy who must Escape a Sumo Wrestler in Ancient China	2006	3	2.99	169	17.99	PG	{"Deleted Scenes"}	2006-02-15 05:03:42
7	AIRPLANE SIERRA	A Touching Saga of a Hunter And a Butler who must Discover a Butler in A Jet Boat	2006	6	4.99	62	28.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
8	AIRPORT POLLOCK	A Epic Tale of a Moose And a Girl who must Confront a Monkey in Ancient India	2006	6	4.99	54	15.99	R	{Trailers}	2006-02-15 05:03:42
9	ALABAMA DEVIL	A Thoughtful Panorama of a Database Administrator And a Mad Scientist who must Outgun a Mad Scientist in A Jet Boat	2006	3	2.99	114	21.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
10	ALADDIN CALENDAR	A Action-Packed Tale of a Man And a Lumberjack who must Reach a Feminist in Ancient China	2006	6	4.99	63	24.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
11	ALAMO VIDEOTAPE	A Boring Epistle of a Butler And a Cat who must Fight a Pastry Chef in A MySQL Convention	2006	6	0.99	126	16.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
12	ALASKA PHANTOM	A Fanciful Saga of a Hunter And a Pastry Chef who must Vanquish a Boy in Australia	2006	6	0.99	136	22.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
13	ALI FOREVER	A Action-Packed Drama of a Dentist And a Crocodile who must Battle a Feminist in The Canadian Rockies	2006	4	4.99	150	21.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
14	ALICE FANTASIA	A Emotional Drama of a A Shark And a Database Administrator who must Vanquish a Pioneer in Soviet Georgia	2006	6	0.99	94	23.99	NC-17	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
15	ALIEN CENTER	A Brilliant Drama of a Cat And a Mad Scientist who must Battle a Feminist in A MySQL Convention	2006	5	2.99	46	10.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
16	ALLEY EVOLUTION	A Fast-Paced Drama of a Robot And a Composer who must Battle a Astronaut in New Orleans	2006	6	2.99	180	23.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
17	ALONE TRIP	A Fast-Paced Character Study of a Composer And a Dog who must Outgun a Boat in An Abandoned Fun House	2006	3	0.99	82	14.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
18	ALTER VICTORY	A Thoughtful Drama of a Composer And a Feminist who must Meet a Secret Agent in The Canadian Rockies	2006	6	0.99	57	27.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
19	AMADEUS HOLY	A Emotional Display of a Pioneer And a Technical Writer who must Battle a Man in A Baloon	2006	6	0.99	113	20.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
20	AMELIE HELLFIGHTERS	A Boring Drama of a Woman And a Squirrel who must Conquer a Student in A Baloon	2006	4	4.99	79	23.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
21	AMERICAN CIRCUS	A Insightful Drama of a Girl And a Astronaut who must Face a Database Administrator in A Shark Tank	2006	3	4.99	129	17.99	R	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
22	AMISTAD MIDSUMMER	A Emotional Character Study of a Dentist And a Crocodile who must Meet a Sumo Wrestler in California	2006	6	2.99	85	10.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
23	ANACONDA CONFESSIONS	A Lacklusture Display of a Dentist And a Dentist who must Fight a Girl in Australia	2006	3	0.99	92	9.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
24	ANALYZE HOOSIERS	A Thoughtful Display of a Explorer And a Pastry Chef who must Overcome a Feminist in The Sahara Desert	2006	6	2.99	181	19.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
25	ANGELS LIFE	A Thoughtful Display of a Woman And a Astronaut who must Battle a Robot in Berlin	2006	3	2.99	74	15.99	G	{Trailers}	2006-02-15 05:03:42
26	ANNIE IDENTITY	A Amazing Panorama of a Pastry Chef And a Boat who must Escape a Woman in An Abandoned Amusement Park	2006	3	0.99	86	15.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
27	ANONYMOUS HUMAN	A Amazing Reflection of a Database Administrator And a Astronaut who must Outrace a Database Administrator in A Shark Tank	2006	7	0.99	179	12.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
28	ANTHEM LUKE	A Touching Panorama of a Waitress And a Woman who must Outrace a Dog in An Abandoned Amusement Park	2006	5	4.99	91	16.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
29	ANTITRUST TOMATOES	A Fateful Yarn of a Womanizer And a Feminist who must Succumb a Database Administrator in Ancient India	2006	5	2.99	168	11.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
30	ANYTHING SAVANNAH	A Epic Story of a Pastry Chef And a Woman who must Chase a Feminist in An Abandoned Fun House	2006	4	2.99	82	27.99	R	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
31	APACHE DIVINE	A Awe-Inspiring Reflection of a Pastry Chef And a Teacher who must Overcome a Sumo Wrestler in A U-Boat	2006	5	4.99	92	16.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
32	APOCALYPSE FLAMINGOS	A Astounding Story of a Dog And a Squirrel who must Defeat a Woman in An Abandoned Amusement Park	2006	6	4.99	119	11.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
33	APOLLO TEEN	A Action-Packed Reflection of a Crocodile And a Explorer who must Find a Sumo Wrestler in An Abandoned Mine Shaft	2006	5	2.99	153	15.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
34	ARABIA DOGMA	A Touching Epistle of a Madman And a Mad Cow who must Defeat a Student in Nigeria	2006	6	0.99	62	29.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
35	ARACHNOPHOBIA ROLLERCOASTER	A Action-Packed Reflection of a Pastry Chef And a Composer who must Discover a Mad Scientist in The First Manned Space Station	2006	4	2.99	147	24.99	PG-13	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
36	ARGONAUTS TOWN	A Emotional Epistle of a Forensic Psychologist And a Butler who must Challenge a Waitress in An Abandoned Mine Shaft	2006	7	0.99	127	12.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
37	ARIZONA BANG	A Brilliant Panorama of a Mad Scientist And a Mad Cow who must Meet a Pioneer in A Monastery	2006	3	2.99	121	28.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
38	ARK RIDGEMONT	A Beautiful Yarn of a Pioneer And a Monkey who must Pursue a Explorer in The Sahara Desert	2006	6	0.99	68	25.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
39	ARMAGEDDON LOST	A Fast-Paced Tale of a Boat And a Teacher who must Succumb a Composer in An Abandoned Mine Shaft	2006	5	0.99	99	10.99	G	{Trailers}	2006-02-15 05:03:42
40	ARMY FLINTSTONES	A Boring Saga of a Database Administrator And a Womanizer who must Battle a Waitress in Nigeria	2006	4	0.99	148	22.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
41	ARSENIC INDEPENDENCE	A Fanciful Documentary of a Mad Cow And a Womanizer who must Find a Dentist in Berlin	2006	4	0.99	137	17.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
42	ARTIST COLDBLOODED	A Stunning Reflection of a Robot And a Moose who must Challenge a Woman in California	2006	5	2.99	170	10.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
43	ATLANTIS CAUSE	A Thrilling Yarn of a Feminist And a Hunter who must Fight a Technical Writer in A Shark Tank	2006	6	2.99	170	15.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
44	ATTACKS HATE	A Fast-Paced Panorama of a Technical Writer And a Mad Scientist who must Find a Feminist in An Abandoned Mine Shaft	2006	5	4.99	113	21.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
45	ATTRACTION NEWTON	A Astounding Panorama of a Composer And a Frisbee who must Reach a Husband in Ancient Japan	2006	5	4.99	83	14.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
46	AUTUMN CROW	A Beautiful Tale of a Dentist And a Mad Cow who must Battle a Moose in The Sahara Desert	2006	3	4.99	108	13.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
47	BABY HALL	A Boring Character Study of a A Shark And a Girl who must Outrace a Feminist in An Abandoned Mine Shaft	2006	5	4.99	153	23.99	NC-17	{Commentaries}	2006-02-15 05:03:42
48	BACKLASH UNDEFEATED	A Stunning Character Study of a Mad Scientist And a Mad Cow who must Kill a Car in A Monastery	2006	3	4.99	118	24.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
49	BADMAN DAWN	A Emotional Panorama of a Pioneer And a Composer who must Escape a Mad Scientist in A Jet Boat	2006	6	2.99	162	22.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
50	BAKED CLEOPATRA	A Stunning Drama of a Forensic Psychologist And a Husband who must Overcome a Waitress in A Monastery	2006	3	2.99	182	20.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
51	BALLOON HOMEWARD	A Insightful Panorama of a Forensic Psychologist And a Mad Cow who must Build a Mad Scientist in The First Manned Space Station	2006	5	2.99	75	10.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
52	BALLROOM MOCKINGBIRD	A Thrilling Documentary of a Composer And a Monkey who must Find a Feminist in California	2006	6	0.99	173	29.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
53	BANG KWAI	A Epic Drama of a Madman And a Cat who must Face a A Shark in An Abandoned Amusement Park	2006	5	2.99	87	25.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
54	BANGER PINOCCHIO	A Awe-Inspiring Drama of a Car And a Pastry Chef who must Chase a Crocodile in The First Manned Space Station	2006	5	0.99	113	15.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
55	BARBARELLA STREETCAR	A Awe-Inspiring Story of a Feminist And a Cat who must Conquer a Dog in A Monastery	2006	6	2.99	65	27.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
56	BAREFOOT MANCHURIAN	A Intrepid Story of a Cat And a Student who must Vanquish a Girl in An Abandoned Amusement Park	2006	6	2.99	129	15.99	G	{Trailers,Commentaries}	2006-02-15 05:03:42
57	BASIC EASY	A Stunning Epistle of a Man And a Husband who must Reach a Mad Scientist in A Jet Boat	2006	4	2.99	90	18.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
58	BEACH HEARTBREAKERS	A Fateful Display of a Womanizer And a Mad Scientist who must Outgun a A Shark in Soviet Georgia	2006	6	2.99	122	16.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
59	BEAR GRACELAND	A Astounding Saga of a Dog And a Boy who must Kill a Teacher in The First Manned Space Station	2006	4	2.99	160	20.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
60	BEAST HUNCHBACK	A Awe-Inspiring Epistle of a Student And a Squirrel who must Defeat a Boy in Ancient China	2006	3	4.99	89	22.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
61	BEAUTY GREASE	A Fast-Paced Display of a Composer And a Moose who must Sink a Robot in An Abandoned Mine Shaft	2006	5	4.99	175	28.99	G	{Trailers,Commentaries}	2006-02-15 05:03:42
62	BED HIGHBALL	A Astounding Panorama of a Lumberjack And a Dog who must Redeem a Woman in An Abandoned Fun House	2006	5	2.99	106	23.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
63	BEDAZZLED MARRIED	A Astounding Character Study of a Madman And a Robot who must Meet a Mad Scientist in An Abandoned Fun House	2006	6	0.99	73	21.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
64	BEETHOVEN EXORCIST	A Epic Display of a Pioneer And a Student who must Challenge a Butler in The Gulf of Mexico	2006	6	0.99	151	26.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
65	BEHAVIOR RUNAWAY	A Unbelieveable Drama of a Student And a Husband who must Outrace a Sumo Wrestler in Berlin	2006	3	4.99	100	20.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
66	BENEATH RUSH	A Astounding Panorama of a Man And a Monkey who must Discover a Man in The First Manned Space Station	2006	6	0.99	53	27.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
67	BERETS AGENT	A Taut Saga of a Crocodile And a Boy who must Overcome a Technical Writer in Ancient China	2006	5	2.99	77	24.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
68	BETRAYED REAR	A Emotional Character Study of a Boat And a Pioneer who must Find a Explorer in A Shark Tank	2006	5	4.99	122	26.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
69	BEVERLY OUTLAW	A Fanciful Documentary of a Womanizer And a Boat who must Defeat a Madman in The First Manned Space Station	2006	3	2.99	85	21.99	R	{Trailers}	2006-02-15 05:03:42
70	BIKINI BORROWERS	A Astounding Drama of a Astronaut And a Cat who must Discover a Woman in The First Manned Space Station	2006	7	4.99	142	26.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
71	BILKO ANONYMOUS	A Emotional Reflection of a Teacher And a Man who must Meet a Cat in The First Manned Space Station	2006	3	4.99	100	25.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
72	BILL OTHERS	A Stunning Saga of a Mad Scientist And a Forensic Psychologist who must Challenge a Squirrel in A MySQL Convention	2006	6	2.99	93	12.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
73	BINGO TALENTED	A Touching Tale of a Girl And a Crocodile who must Discover a Waitress in Nigeria	2006	5	2.99	150	22.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
74	BIRCH ANTITRUST	A Fanciful Panorama of a Husband And a Pioneer who must Outgun a Dog in A Baloon	2006	4	4.99	162	18.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
75	BIRD INDEPENDENCE	A Thrilling Documentary of a Car And a Student who must Sink a Hunter in The Canadian Rockies	2006	6	4.99	163	14.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
76	BIRDCAGE CASPER	A Fast-Paced Saga of a Frisbee And a Astronaut who must Overcome a Feminist in Ancient India	2006	4	0.99	103	23.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
77	BIRDS PERDITION	A Boring Story of a Womanizer And a Pioneer who must Face a Dog in California	2006	5	4.99	61	15.99	G	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
78	BLACKOUT PRIVATE	A Intrepid Yarn of a Pastry Chef And a Mad Scientist who must Challenge a Secret Agent in Ancient Japan	2006	7	2.99	85	12.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
79	BLADE POLISH	A Thoughtful Character Study of a Frisbee And a Pastry Chef who must Fight a Dentist in The First Manned Space Station	2006	5	0.99	114	10.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
80	BLANKET BEVERLY	A Emotional Documentary of a Student And a Girl who must Build a Boat in Nigeria	2006	7	2.99	148	21.99	G	{Trailers}	2006-02-15 05:03:42
81	BLINDNESS GUN	A Touching Drama of a Robot And a Dentist who must Meet a Hunter in A Jet Boat	2006	6	4.99	103	29.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
82	BLOOD ARGONAUTS	A Boring Drama of a Explorer And a Man who must Kill a Lumberjack in A Manhattan Penthouse	2006	3	0.99	71	13.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
83	BLUES INSTINCT	A Insightful Documentary of a Boat And a Composer who must Meet a Forensic Psychologist in An Abandoned Fun House	2006	5	2.99	50	18.99	G	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
84	BOILED DARES	A Awe-Inspiring Story of a Waitress And a Dog who must Discover a Dentist in Ancient Japan	2006	7	4.99	102	13.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
85	BONNIE HOLOCAUST	A Fast-Paced Story of a Crocodile And a Robot who must Find a Moose in Ancient Japan	2006	4	0.99	63	29.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
86	BOOGIE AMELIE	A Lacklusture Character Study of a Husband And a Sumo Wrestler who must Succumb a Technical Writer in The Gulf of Mexico	2006	6	4.99	121	11.99	R	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
87	BOONDOCK BALLROOM	A Fateful Panorama of a Crocodile And a Boy who must Defeat a Monkey in The Gulf of Mexico	2006	7	0.99	76	14.99	NC-17	{"Behind the Scenes"}	2006-02-15 05:03:42
88	BORN SPINAL	A Touching Epistle of a Frisbee And a Husband who must Pursue a Student in Nigeria	2006	7	4.99	179	17.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
89	BORROWERS BEDAZZLED	A Brilliant Epistle of a Teacher And a Sumo Wrestler who must Defeat a Man in An Abandoned Fun House	2006	7	0.99	63	22.99	G	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
90	BOULEVARD MOB	A Fateful Epistle of a Moose And a Monkey who must Confront a Lumberjack in Ancient China	2006	3	0.99	63	11.99	R	{Trailers}	2006-02-15 05:03:42
91	BOUND CHEAPER	A Thrilling Panorama of a Database Administrator And a Astronaut who must Challenge a Lumberjack in A Baloon	2006	5	0.99	98	17.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
92	BOWFINGER GABLES	A Fast-Paced Yarn of a Waitress And a Composer who must Outgun a Dentist in California	2006	7	4.99	72	19.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
93	BRANNIGAN SUNRISE	A Amazing Epistle of a Moose And a Crocodile who must Outrace a Dog in Berlin	2006	4	4.99	121	27.99	PG	{Trailers}	2006-02-15 05:03:42
94	BRAVEHEART HUMAN	A Insightful Story of a Dog And a Pastry Chef who must Battle a Girl in Berlin	2006	7	2.99	176	14.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
95	BREAKFAST GOLDFINGER	A Beautiful Reflection of a Student And a Student who must Fight a Moose in Berlin	2006	5	4.99	123	18.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
96	BREAKING HOME	A Beautiful Display of a Secret Agent And a Monkey who must Battle a Sumo Wrestler in An Abandoned Mine Shaft	2006	4	2.99	169	21.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
97	BRIDE INTRIGUE	A Epic Tale of a Robot And a Monkey who must Vanquish a Man in New Orleans	2006	7	0.99	56	24.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
98	BRIGHT ENCOUNTERS	A Fateful Yarn of a Lumberjack And a Feminist who must Conquer a Student in A Jet Boat	2006	4	4.99	73	12.99	PG-13	{Trailers}	2006-02-15 05:03:42
99	BRINGING HYSTERICAL	A Fateful Saga of a A Shark And a Technical Writer who must Find a Woman in A Jet Boat	2006	7	2.99	136	14.99	PG	{Trailers}	2006-02-15 05:03:42
100	BROOKLYN DESERT	A Beautiful Drama of a Dentist And a Composer who must Battle a Sumo Wrestler in The First Manned Space Station	2006	7	4.99	161	21.99	R	{Commentaries}	2006-02-15 05:03:42
101	BROTHERHOOD BLANKET	A Fateful Character Study of a Butler And a Technical Writer who must Sink a Astronaut in Ancient Japan	2006	3	0.99	73	26.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
102	BUBBLE GROSSE	A Awe-Inspiring Panorama of a Crocodile And a Moose who must Confront a Girl in A Baloon	2006	4	4.99	60	20.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
103	BUCKET BROTHERHOOD	A Amazing Display of a Girl And a Womanizer who must Succumb a Lumberjack in A Baloon Factory	2006	7	4.99	133	27.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
104	BUGSY SONG	A Awe-Inspiring Character Study of a Secret Agent And a Boat who must Find a Squirrel in The First Manned Space Station	2006	4	2.99	119	17.99	G	{Commentaries}	2006-02-15 05:03:42
105	BULL SHAWSHANK	A Fanciful Drama of a Moose And a Squirrel who must Conquer a Pioneer in The Canadian Rockies	2006	6	0.99	125	21.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
106	BULWORTH COMMANDMENTS	A Amazing Display of a Mad Cow And a Pioneer who must Redeem a Sumo Wrestler in The Outback	2006	4	2.99	61	14.99	G	{Trailers}	2006-02-15 05:03:42
107	BUNCH MINDS	A Emotional Story of a Feminist And a Feminist who must Escape a Pastry Chef in A MySQL Convention	2006	4	2.99	63	13.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
108	BUTCH PANTHER	A Lacklusture Yarn of a Feminist And a Database Administrator who must Face a Hunter in New Orleans	2006	6	0.99	67	19.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
109	BUTTERFLY CHOCOLAT	A Fateful Story of a Girl And a Composer who must Conquer a Husband in A Shark Tank	2006	3	0.99	89	17.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
110	CABIN FLASH	A Stunning Epistle of a Boat And a Man who must Challenge a A Shark in A Baloon Factory	2006	4	0.99	53	25.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
111	CADDYSHACK JEDI	A Awe-Inspiring Epistle of a Woman And a Madman who must Fight a Robot in Soviet Georgia	2006	3	0.99	52	17.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
112	CALENDAR GUNFIGHT	A Thrilling Drama of a Frisbee And a Lumberjack who must Sink a Man in Nigeria	2006	4	4.99	120	22.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
113	CALIFORNIA BIRDS	A Thrilling Yarn of a Database Administrator And a Robot who must Battle a Database Administrator in Ancient India	2006	4	4.99	75	19.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
114	CAMELOT VACATION	A Touching Character Study of a Woman And a Waitress who must Battle a Pastry Chef in A MySQL Convention	2006	3	0.99	61	26.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
115	CAMPUS REMEMBER	A Astounding Drama of a Crocodile And a Mad Cow who must Build a Robot in A Jet Boat	2006	5	2.99	167	27.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
116	CANDIDATE PERDITION	A Brilliant Epistle of a Composer And a Database Administrator who must Vanquish a Mad Scientist in The First Manned Space Station	2006	4	2.99	70	10.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
117	CANDLES GRAPES	A Fanciful Character Study of a Monkey And a Explorer who must Build a Astronaut in An Abandoned Fun House	2006	6	4.99	135	15.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
118	CANYON STOCK	A Thoughtful Reflection of a Waitress And a Feminist who must Escape a Squirrel in A Manhattan Penthouse	2006	7	0.99	85	26.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
119	CAPER MOTIONS	A Fateful Saga of a Moose And a Car who must Pursue a Woman in A MySQL Convention	2006	6	0.99	176	22.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
120	CARIBBEAN LIBERTY	A Fanciful Tale of a Pioneer And a Technical Writer who must Outgun a Pioneer in A Shark Tank	2006	3	4.99	92	16.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
121	CAROL TEXAS	A Astounding Character Study of a Composer And a Student who must Overcome a Composer in A Monastery	2006	4	2.99	151	15.99	PG	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
122	CARRIE BUNCH	A Amazing Epistle of a Student And a Astronaut who must Discover a Frisbee in The Canadian Rockies	2006	7	0.99	114	11.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
123	CASABLANCA SUPER	A Amazing Panorama of a Crocodile And a Forensic Psychologist who must Pursue a Secret Agent in The First Manned Space Station	2006	6	4.99	85	22.99	G	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
124	CASPER DRAGONFLY	A Intrepid Documentary of a Boat And a Crocodile who must Chase a Robot in The Sahara Desert	2006	3	4.99	163	16.99	PG-13	{Trailers}	2006-02-15 05:03:42
125	CASSIDY WYOMING	A Intrepid Drama of a Frisbee And a Hunter who must Kill a Secret Agent in New Orleans	2006	5	2.99	61	19.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
126	CASUALTIES ENCINO	A Insightful Yarn of a A Shark And a Pastry Chef who must Face a Boy in A Monastery	2006	3	4.99	179	16.99	G	{Trailers}	2006-02-15 05:03:42
127	CAT CONEHEADS	A Fast-Paced Panorama of a Girl And a A Shark who must Confront a Boy in Ancient India	2006	5	4.99	112	14.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
128	CATCH AMISTAD	A Boring Reflection of a Lumberjack And a Feminist who must Discover a Woman in Nigeria	2006	7	0.99	183	10.99	G	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
129	CAUSE DATE	A Taut Tale of a Explorer And a Pastry Chef who must Conquer a Hunter in A MySQL Convention	2006	3	2.99	179	16.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
130	CELEBRITY HORN	A Amazing Documentary of a Secret Agent And a Astronaut who must Vanquish a Hunter in A Shark Tank	2006	7	0.99	110	24.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
131	CENTER DINOSAUR	A Beautiful Character Study of a Sumo Wrestler And a Dentist who must Find a Dog in California	2006	5	4.99	152	12.99	PG	{"Deleted Scenes"}	2006-02-15 05:03:42
132	CHAINSAW UPTOWN	A Beautiful Documentary of a Boy And a Robot who must Discover a Squirrel in Australia	2006	6	0.99	114	25.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
133	CHAMBER ITALIAN	A Fateful Reflection of a Moose And a Husband who must Overcome a Monkey in Nigeria	2006	7	4.99	117	14.99	NC-17	{Trailers}	2006-02-15 05:03:42
134	CHAMPION FLATLINERS	A Amazing Story of a Mad Cow And a Dog who must Kill a Husband in A Monastery	2006	4	4.99	51	21.99	PG	{Trailers}	2006-02-15 05:03:42
135	CHANCE RESURRECTION	A Astounding Story of a Forensic Psychologist And a Forensic Psychologist who must Overcome a Moose in Ancient China	2006	3	2.99	70	22.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
136	CHAPLIN LICENSE	A Boring Drama of a Dog And a Forensic Psychologist who must Outrace a Explorer in Ancient India	2006	7	2.99	146	26.99	NC-17	{"Behind the Scenes"}	2006-02-15 05:03:42
137	CHARADE DUFFEL	A Action-Packed Display of a Man And a Waitress who must Build a Dog in A MySQL Convention	2006	3	2.99	66	21.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
138	CHARIOTS CONSPIRACY	A Unbelieveable Epistle of a Robot And a Husband who must Chase a Robot in The First Manned Space Station	2006	5	2.99	71	29.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
139	CHASING FIGHT	A Astounding Saga of a Technical Writer And a Butler who must Battle a Butler in A Shark Tank	2006	7	4.99	114	21.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
140	CHEAPER CLYDE	A Emotional Character Study of a Pioneer And a Girl who must Discover a Dog in Ancient Japan	2006	6	0.99	87	23.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
141	CHICAGO NORTH	A Fateful Yarn of a Mad Cow And a Waitress who must Battle a Student in California	2006	6	4.99	185	11.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
142	CHICKEN HELLFIGHTERS	A Emotional Drama of a Dog And a Explorer who must Outrace a Technical Writer in Australia	2006	3	0.99	122	24.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
143	CHILL LUCK	A Lacklusture Epistle of a Boat And a Technical Writer who must Fight a A Shark in The Canadian Rockies	2006	6	0.99	142	17.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
144	CHINATOWN GLADIATOR	A Brilliant Panorama of a Technical Writer And a Lumberjack who must Escape a Butler in Ancient India	2006	7	4.99	61	24.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
145	CHISUM BEHAVIOR	A Epic Documentary of a Sumo Wrestler And a Butler who must Kill a Car in Ancient India	2006	5	4.99	124	25.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
146	CHITTY LOCK	A Boring Epistle of a Boat And a Database Administrator who must Kill a Sumo Wrestler in The First Manned Space Station	2006	6	2.99	107	24.99	G	{Commentaries}	2006-02-15 05:03:42
147	CHOCOLAT HARRY	A Action-Packed Epistle of a Dentist And a Moose who must Meet a Mad Cow in Ancient Japan	2006	5	0.99	101	16.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
148	CHOCOLATE DUCK	A Unbelieveable Story of a Mad Scientist And a Technical Writer who must Discover a Composer in Ancient China	2006	3	2.99	132	13.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
149	CHRISTMAS MOONSHINE	A Action-Packed Epistle of a Feminist And a Astronaut who must Conquer a Boat in A Manhattan Penthouse	2006	7	0.99	150	21.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
150	CIDER DESIRE	A Stunning Character Study of a Composer And a Mad Cow who must Succumb a Cat in Soviet Georgia	2006	7	2.99	101	9.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
151	CINCINATTI WHISPERER	A Brilliant Saga of a Pastry Chef And a Hunter who must Confront a Butler in Berlin	2006	5	4.99	143	26.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
152	CIRCUS YOUTH	A Thoughtful Drama of a Pastry Chef And a Dentist who must Pursue a Girl in A Baloon	2006	5	2.99	90	13.99	PG-13	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
153	CITIZEN SHREK	A Fanciful Character Study of a Technical Writer And a Husband who must Redeem a Robot in The Outback	2006	7	0.99	165	18.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
154	CLASH FREDDY	A Amazing Yarn of a Composer And a Squirrel who must Escape a Astronaut in Australia	2006	6	2.99	81	12.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
155	CLEOPATRA DEVIL	A Fanciful Documentary of a Crocodile And a Technical Writer who must Fight a A Shark in A Baloon	2006	6	0.99	150	26.99	PG-13	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
156	CLERKS ANGELS	A Thrilling Display of a Sumo Wrestler And a Girl who must Confront a Man in A Baloon	2006	3	4.99	164	15.99	G	{Commentaries}	2006-02-15 05:03:42
157	CLOCKWORK PARADISE	A Insightful Documentary of a Technical Writer And a Feminist who must Challenge a Cat in A Baloon	2006	7	0.99	143	29.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
158	CLONES PINOCCHIO	A Amazing Drama of a Car And a Robot who must Pursue a Dentist in New Orleans	2006	6	2.99	124	16.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
159	CLOSER BANG	A Unbelieveable Panorama of a Frisbee And a Hunter who must Vanquish a Monkey in Ancient India	2006	5	4.99	58	12.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
160	CLUB GRAFFITI	A Epic Tale of a Pioneer And a Hunter who must Escape a Girl in A U-Boat	2006	4	0.99	65	12.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
161	CLUE GRAIL	A Taut Tale of a Butler And a Mad Scientist who must Build a Crocodile in Ancient China	2006	6	4.99	70	27.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
162	CLUELESS BUCKET	A Taut Tale of a Car And a Pioneer who must Conquer a Sumo Wrestler in An Abandoned Fun House	2006	4	2.99	95	13.99	R	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
163	CLYDE THEORY	A Beautiful Yarn of a Astronaut And a Frisbee who must Overcome a Explorer in A Jet Boat	2006	4	0.99	139	29.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
164	COAST RAINBOW	A Astounding Documentary of a Mad Cow And a Pioneer who must Challenge a Butler in The Sahara Desert	2006	4	0.99	55	20.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
165	COLDBLOODED DARLING	A Brilliant Panorama of a Dentist And a Moose who must Find a Student in The Gulf of Mexico	2006	7	4.99	70	27.99	G	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
166	COLOR PHILADELPHIA	A Thoughtful Panorama of a Car And a Crocodile who must Sink a Monkey in The Sahara Desert	2006	6	2.99	149	19.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
167	COMA HEAD	A Awe-Inspiring Drama of a Boy And a Frisbee who must Escape a Pastry Chef in California	2006	6	4.99	109	10.99	NC-17	{Commentaries}	2006-02-15 05:03:42
168	COMANCHEROS ENEMY	A Boring Saga of a Lumberjack And a Monkey who must Find a Monkey in The Gulf of Mexico	2006	5	0.99	67	23.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
169	COMFORTS RUSH	A Unbelieveable Panorama of a Pioneer And a Husband who must Meet a Mad Cow in An Abandoned Mine Shaft	2006	3	2.99	76	19.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
170	COMMAND DARLING	A Awe-Inspiring Tale of a Forensic Psychologist And a Woman who must Challenge a Database Administrator in Ancient Japan	2006	5	4.99	120	28.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
171	COMMANDMENTS EXPRESS	A Fanciful Saga of a Student And a Mad Scientist who must Battle a Hunter in An Abandoned Mine Shaft	2006	6	4.99	59	13.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
172	CONEHEADS SMOOCHY	A Touching Story of a Womanizer And a Composer who must Pursue a Husband in Nigeria	2006	7	4.99	112	12.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
173	CONFESSIONS MAGUIRE	A Insightful Story of a Car And a Boy who must Battle a Technical Writer in A Baloon	2006	7	4.99	65	25.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
174	CONFIDENTIAL INTERVIEW	A Stunning Reflection of a Cat And a Woman who must Find a Astronaut in Ancient Japan	2006	6	4.99	180	13.99	NC-17	{Commentaries}	2006-02-15 05:03:42
175	CONFUSED CANDLES	A Stunning Epistle of a Cat And a Forensic Psychologist who must Confront a Pioneer in A Baloon	2006	3	2.99	122	27.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
176	CONGENIALITY QUEST	A Touching Documentary of a Cat And a Pastry Chef who must Find a Lumberjack in A Baloon	2006	6	0.99	87	21.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
177	CONNECTICUT TRAMP	A Unbelieveable Drama of a Crocodile And a Mad Cow who must Reach a Dentist in A Shark Tank	2006	4	4.99	172	20.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
178	CONNECTION MICROCOSMOS	A Fateful Documentary of a Crocodile And a Husband who must Face a Husband in The First Manned Space Station	2006	6	0.99	115	25.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
179	CONQUERER NUTS	A Taut Drama of a Mad Scientist And a Man who must Escape a Pioneer in An Abandoned Mine Shaft	2006	4	4.99	173	14.99	G	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
180	CONSPIRACY SPIRIT	A Awe-Inspiring Story of a Student And a Frisbee who must Conquer a Crocodile in An Abandoned Mine Shaft	2006	4	2.99	184	27.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
181	CONTACT ANONYMOUS	A Insightful Display of a A Shark And a Monkey who must Face a Database Administrator in Ancient India	2006	7	2.99	166	10.99	PG-13	{Commentaries}	2006-02-15 05:03:42
182	CONTROL ANTHEM	A Fateful Documentary of a Robot And a Student who must Battle a Cat in A Monastery	2006	7	4.99	185	9.99	G	{Commentaries}	2006-02-15 05:03:42
183	CONVERSATION DOWNHILL	A Taut Character Study of a Husband And a Waitress who must Sink a Squirrel in A MySQL Convention	2006	4	4.99	112	14.99	R	{Commentaries}	2006-02-15 05:03:42
184	CORE SUIT	A Unbelieveable Tale of a Car And a Explorer who must Confront a Boat in A Manhattan Penthouse	2006	3	2.99	92	24.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
185	COWBOY DOOM	A Astounding Drama of a Boy And a Lumberjack who must Fight a Butler in A Baloon	2006	3	2.99	146	10.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
186	CRAFT OUTFIELD	A Lacklusture Display of a Explorer And a Hunter who must Succumb a Database Administrator in A Baloon Factory	2006	6	0.99	64	17.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
187	CRANES RESERVOIR	A Fanciful Documentary of a Teacher And a Dog who must Outgun a Forensic Psychologist in A Baloon Factory	2006	5	2.99	57	12.99	NC-17	{Commentaries}	2006-02-15 05:03:42
188	CRAZY HOME	A Fanciful Panorama of a Boy And a Woman who must Vanquish a Database Administrator in The Outback	2006	7	2.99	136	24.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
189	CREATURES SHAKESPEARE	A Emotional Drama of a Womanizer And a Squirrel who must Vanquish a Crocodile in Ancient India	2006	3	0.99	139	23.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
190	CREEPERS KANE	A Awe-Inspiring Reflection of a Squirrel And a Boat who must Outrace a Car in A Jet Boat	2006	5	4.99	172	23.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
191	CROOKED FROGMEN	A Unbelieveable Drama of a Hunter And a Database Administrator who must Battle a Crocodile in An Abandoned Amusement Park	2006	6	0.99	143	27.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
192	CROSSING DIVORCE	A Beautiful Documentary of a Dog And a Robot who must Redeem a Womanizer in Berlin	2006	4	4.99	50	19.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
193	CROSSROADS CASUALTIES	A Intrepid Documentary of a Sumo Wrestler And a Astronaut who must Battle a Composer in The Outback	2006	5	2.99	153	20.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
194	CROW GREASE	A Awe-Inspiring Documentary of a Woman And a Husband who must Sink a Database Administrator in The First Manned Space Station	2006	6	0.99	104	22.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
195	CROWDS TELEMARK	A Intrepid Documentary of a Astronaut And a Forensic Psychologist who must Find a Frisbee in An Abandoned Fun House	2006	3	4.99	112	16.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
196	CRUELTY UNFORGIVEN	A Brilliant Tale of a Car And a Moose who must Battle a Dentist in Nigeria	2006	7	0.99	69	29.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
197	CRUSADE HONEY	A Fast-Paced Reflection of a Explorer And a Butler who must Battle a Madman in An Abandoned Amusement Park	2006	4	2.99	112	27.99	R	{Commentaries}	2006-02-15 05:03:42
198	CRYSTAL BREAKING	A Fast-Paced Character Study of a Feminist And a Explorer who must Face a Pastry Chef in Ancient Japan	2006	6	2.99	184	22.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
199	CUPBOARD SINNERS	A Emotional Reflection of a Frisbee And a Boat who must Reach a Pastry Chef in An Abandoned Amusement Park	2006	4	2.99	56	29.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
200	CURTAIN VIDEOTAPE	A Boring Reflection of a Dentist And a Mad Cow who must Chase a Secret Agent in A Shark Tank	2006	7	0.99	133	27.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
201	CYCLONE FAMILY	A Lacklusture Drama of a Student And a Monkey who must Sink a Womanizer in A MySQL Convention	2006	7	2.99	176	18.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
202	DADDY PITTSBURGH	A Epic Story of a A Shark And a Student who must Confront a Explorer in The Gulf of Mexico	2006	5	4.99	161	26.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
203	DAISY MENAGERIE	A Fast-Paced Saga of a Pastry Chef And a Monkey who must Sink a Composer in Ancient India	2006	5	4.99	84	9.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
204	DALMATIONS SWEDEN	A Emotional Epistle of a Moose And a Hunter who must Overcome a Robot in A Manhattan Penthouse	2006	4	0.99	106	25.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
205	DANCES NONE	A Insightful Reflection of a A Shark And a Dog who must Kill a Butler in An Abandoned Amusement Park	2006	3	0.99	58	22.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
206	DANCING FEVER	A Stunning Story of a Explorer And a Forensic Psychologist who must Face a Crocodile in A Shark Tank	2006	6	0.99	144	25.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
207	DANGEROUS UPTOWN	A Unbelieveable Story of a Mad Scientist And a Woman who must Overcome a Dog in California	2006	7	4.99	121	26.99	PG	{Commentaries}	2006-02-15 05:03:42
208	DARES PLUTO	A Fateful Story of a Robot And a Dentist who must Defeat a Astronaut in New Orleans	2006	7	2.99	89	16.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
209	DARKNESS WAR	A Touching Documentary of a Husband And a Hunter who must Escape a Boy in The Sahara Desert	2006	6	2.99	99	24.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
210	DARKO DORADO	A Stunning Reflection of a Frisbee And a Husband who must Redeem a Dog in New Orleans	2006	3	4.99	130	13.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
211	DARLING BREAKING	A Brilliant Documentary of a Astronaut And a Squirrel who must Succumb a Student in The Gulf of Mexico	2006	7	4.99	165	20.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
212	DARN FORRESTER	A Fateful Story of a A Shark And a Explorer who must Succumb a Technical Writer in A Jet Boat	2006	7	4.99	185	14.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
213	DATE SPEED	A Touching Saga of a Composer And a Moose who must Discover a Dentist in A MySQL Convention	2006	4	0.99	104	19.99	R	{Commentaries}	2006-02-15 05:03:42
214	DAUGHTER MADIGAN	A Beautiful Tale of a Hunter And a Mad Scientist who must Confront a Squirrel in The First Manned Space Station	2006	3	4.99	59	13.99	PG-13	{Trailers}	2006-02-15 05:03:42
215	DAWN POND	A Thoughtful Documentary of a Dentist And a Forensic Psychologist who must Defeat a Waitress in Berlin	2006	4	4.99	57	27.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
216	DAY UNFAITHFUL	A Stunning Documentary of a Composer And a Mad Scientist who must Find a Technical Writer in A U-Boat	2006	3	4.99	113	16.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
217	DAZED PUNK	A Action-Packed Story of a Pioneer And a Technical Writer who must Discover a Forensic Psychologist in An Abandoned Amusement Park	2006	6	4.99	120	20.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
218	DECEIVER BETRAYED	A Taut Story of a Moose And a Squirrel who must Build a Husband in Ancient India	2006	7	0.99	122	22.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
219	DEEP CRUSADE	A Amazing Tale of a Crocodile And a Squirrel who must Discover a Composer in Australia	2006	6	4.99	51	20.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
220	DEER VIRGINIAN	A Thoughtful Story of a Mad Cow And a Womanizer who must Overcome a Mad Scientist in Soviet Georgia	2006	7	2.99	106	13.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
221	DELIVERANCE MULHOLLAND	A Astounding Saga of a Monkey And a Moose who must Conquer a Butler in A Shark Tank	2006	4	0.99	100	9.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
222	DESERT POSEIDON	A Brilliant Documentary of a Butler And a Frisbee who must Build a Astronaut in New Orleans	2006	4	4.99	64	27.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
223	DESIRE ALIEN	A Fast-Paced Tale of a Dog And a Forensic Psychologist who must Meet a Astronaut in The First Manned Space Station	2006	7	2.99	76	24.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
224	DESPERATE TRAINSPOTTING	A Epic Yarn of a Forensic Psychologist And a Teacher who must Face a Lumberjack in California	2006	7	4.99	81	29.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
225	DESTINATION JERK	A Beautiful Yarn of a Teacher And a Cat who must Build a Car in A U-Boat	2006	3	0.99	76	19.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
226	DESTINY SATURDAY	A Touching Drama of a Crocodile And a Crocodile who must Conquer a Explorer in Soviet Georgia	2006	4	4.99	56	20.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
227	DETAILS PACKER	A Epic Saga of a Waitress And a Composer who must Face a Boat in A U-Boat	2006	4	4.99	88	17.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
228	DETECTIVE VISION	A Fanciful Documentary of a Pioneer And a Woman who must Redeem a Hunter in Ancient Japan	2006	4	0.99	143	16.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
229	DEVIL DESIRE	A Beautiful Reflection of a Monkey And a Dentist who must Face a Database Administrator in Ancient Japan	2006	6	4.99	87	12.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
230	DIARY PANIC	A Thoughtful Character Study of a Frisbee And a Mad Cow who must Outgun a Man in Ancient India	2006	7	2.99	107	20.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
231	DINOSAUR SECRETARY	A Action-Packed Drama of a Feminist And a Girl who must Reach a Robot in The Canadian Rockies	2006	7	2.99	63	27.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
232	DIRTY ACE	A Action-Packed Character Study of a Forensic Psychologist And a Girl who must Build a Dentist in The Outback	2006	7	2.99	147	29.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
233	DISCIPLE MOTHER	A Touching Reflection of a Mad Scientist And a Boat who must Face a Moose in A Shark Tank	2006	3	0.99	141	17.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
234	DISTURBING SCARFACE	A Lacklusture Display of a Crocodile And a Butler who must Overcome a Monkey in A U-Boat	2006	6	2.99	94	27.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
235	DIVIDE MONSTER	A Intrepid Saga of a Man And a Forensic Psychologist who must Reach a Squirrel in A Monastery	2006	6	2.99	68	13.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
236	DIVINE RESURRECTION	A Boring Character Study of a Man And a Womanizer who must Succumb a Teacher in An Abandoned Amusement Park	2006	4	2.99	100	19.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
237	DIVORCE SHINING	A Unbelieveable Saga of a Crocodile And a Student who must Discover a Cat in Ancient India	2006	3	2.99	47	21.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
238	DOCTOR GRAIL	A Insightful Drama of a Womanizer And a Waitress who must Reach a Forensic Psychologist in The Outback	2006	4	2.99	57	29.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
239	DOGMA FAMILY	A Brilliant Character Study of a Database Administrator And a Monkey who must Succumb a Astronaut in New Orleans	2006	5	4.99	122	16.99	G	{Commentaries}	2006-02-15 05:03:42
240	DOLLS RAGE	A Thrilling Display of a Pioneer And a Frisbee who must Escape a Teacher in The Outback	2006	7	2.99	120	10.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
241	DONNIE ALLEY	A Awe-Inspiring Tale of a Butler And a Frisbee who must Vanquish a Teacher in Ancient Japan	2006	4	0.99	125	20.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
242	DOOM DANCING	A Astounding Panorama of a Car And a Mad Scientist who must Battle a Lumberjack in A MySQL Convention	2006	4	0.99	68	13.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
243	DOORS PRESIDENT	A Awe-Inspiring Display of a Squirrel And a Woman who must Overcome a Boy in The Gulf of Mexico	2006	3	4.99	49	22.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
244	DORADO NOTTING	A Action-Packed Tale of a Sumo Wrestler And a A Shark who must Meet a Frisbee in California	2006	5	4.99	139	26.99	NC-17	{Commentaries}	2006-02-15 05:03:42
245	DOUBLE WRATH	A Thoughtful Yarn of a Womanizer And a Dog who must Challenge a Madman in The Gulf of Mexico	2006	4	0.99	177	28.99	R	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
246	DOUBTFIRE LABYRINTH	A Intrepid Panorama of a Butler And a Composer who must Meet a Mad Cow in The Sahara Desert	2006	5	4.99	154	16.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
247	DOWNHILL ENOUGH	A Emotional Tale of a Pastry Chef And a Forensic Psychologist who must Succumb a Monkey in The Sahara Desert	2006	3	0.99	47	19.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
248	DOZEN LION	A Taut Drama of a Cat And a Girl who must Defeat a Frisbee in The Canadian Rockies	2006	6	4.99	177	20.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
249	DRACULA CRYSTAL	A Thrilling Reflection of a Feminist And a Cat who must Find a Frisbee in An Abandoned Fun House	2006	7	0.99	176	26.99	G	{Commentaries}	2006-02-15 05:03:42
250	DRAGON SQUAD	A Taut Reflection of a Boy And a Waitress who must Outgun a Teacher in Ancient China	2006	4	0.99	170	26.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
251	DRAGONFLY STRANGERS	A Boring Documentary of a Pioneer And a Man who must Vanquish a Man in Nigeria	2006	6	4.99	133	19.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
252	DREAM PICKUP	A Epic Display of a Car And a Composer who must Overcome a Forensic Psychologist in The Gulf of Mexico	2006	6	2.99	135	18.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
253	DRIFTER COMMANDMENTS	A Epic Reflection of a Womanizer And a Squirrel who must Discover a Husband in A Jet Boat	2006	5	4.99	61	18.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
254	DRIVER ANNIE	A Lacklusture Character Study of a Butler And a Car who must Redeem a Boat in An Abandoned Fun House	2006	4	2.99	159	11.99	PG-13	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
255	DRIVING POLISH	A Action-Packed Yarn of a Feminist And a Technical Writer who must Sink a Boat in An Abandoned Mine Shaft	2006	6	4.99	175	21.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
256	DROP WATERFRONT	A Fanciful Documentary of a Husband And a Explorer who must Reach a Madman in Ancient China	2006	6	4.99	178	20.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
257	DRUMLINE CYCLONE	A Insightful Panorama of a Monkey And a Sumo Wrestler who must Outrace a Mad Scientist in The Canadian Rockies	2006	3	0.99	110	14.99	G	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
258	DRUMS DYNAMITE	A Epic Display of a Crocodile And a Crocodile who must Confront a Dog in An Abandoned Amusement Park	2006	6	0.99	96	11.99	PG	{Trailers}	2006-02-15 05:03:42
259	DUCK RACER	A Lacklusture Yarn of a Teacher And a Squirrel who must Overcome a Dog in A Shark Tank	2006	4	2.99	116	15.99	NC-17	{"Behind the Scenes"}	2006-02-15 05:03:42
260	DUDE BLINDNESS	A Stunning Reflection of a Husband And a Lumberjack who must Face a Frisbee in An Abandoned Fun House	2006	3	4.99	132	9.99	G	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
261	DUFFEL APOCALYPSE	A Emotional Display of a Boat And a Explorer who must Challenge a Madman in A MySQL Convention	2006	5	0.99	171	13.99	G	{Commentaries}	2006-02-15 05:03:42
262	DUMBO LUST	A Touching Display of a Feminist And a Dentist who must Conquer a Husband in The Gulf of Mexico	2006	5	0.99	119	17.99	NC-17	{"Behind the Scenes"}	2006-02-15 05:03:42
263	DURHAM PANKY	A Brilliant Panorama of a Girl And a Boy who must Face a Mad Scientist in An Abandoned Mine Shaft	2006	6	4.99	154	14.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
264	DWARFS ALTER	A Emotional Yarn of a Girl And a Dog who must Challenge a Composer in Ancient Japan	2006	6	2.99	101	13.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
265	DYING MAKER	A Intrepid Tale of a Boat And a Monkey who must Kill a Cat in California	2006	5	4.99	168	28.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
266	DYNAMITE TARZAN	A Intrepid Documentary of a Forensic Psychologist And a Mad Scientist who must Face a Explorer in A U-Boat	2006	4	0.99	141	27.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
267	EAGLES PANKY	A Thoughtful Story of a Car And a Boy who must Find a A Shark in The Sahara Desert	2006	4	4.99	140	14.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
268	EARLY HOME	A Amazing Panorama of a Mad Scientist And a Husband who must Meet a Woman in The Outback	2006	6	4.99	96	27.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
269	EARRING INSTINCT	A Stunning Character Study of a Dentist And a Mad Cow who must Find a Teacher in Nigeria	2006	3	0.99	98	22.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
270	EARTH VISION	A Stunning Drama of a Butler And a Madman who must Outrace a Womanizer in Ancient India	2006	7	0.99	85	29.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
271	EASY GLADIATOR	A Fateful Story of a Monkey And a Girl who must Overcome a Pastry Chef in Ancient India	2006	5	4.99	148	12.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
272	EDGE KISSING	A Beautiful Yarn of a Composer And a Mad Cow who must Redeem a Mad Scientist in A Jet Boat	2006	5	4.99	153	9.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
273	EFFECT GLADIATOR	A Beautiful Display of a Pastry Chef And a Pastry Chef who must Outgun a Forensic Psychologist in A Manhattan Penthouse	2006	6	0.99	107	14.99	PG	{Commentaries}	2006-02-15 05:03:42
274	EGG IGBY	A Beautiful Documentary of a Boat And a Sumo Wrestler who must Succumb a Database Administrator in The First Manned Space Station	2006	4	2.99	67	20.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
275	EGYPT TENENBAUMS	A Intrepid Story of a Madman And a Secret Agent who must Outrace a Astronaut in An Abandoned Amusement Park	2006	3	0.99	85	11.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
276	ELEMENT FREDDY	A Awe-Inspiring Reflection of a Waitress And a Squirrel who must Kill a Mad Cow in A Jet Boat	2006	6	4.99	115	28.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
277	ELEPHANT TROJAN	A Beautiful Panorama of a Lumberjack And a Forensic Psychologist who must Overcome a Frisbee in A Baloon	2006	4	4.99	126	24.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
278	ELF MURDER	A Action-Packed Story of a Frisbee And a Woman who must Reach a Girl in An Abandoned Mine Shaft	2006	4	4.99	155	19.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
279	ELIZABETH SHANE	A Lacklusture Display of a Womanizer And a Dog who must Face a Sumo Wrestler in Ancient Japan	2006	7	4.99	152	11.99	NC-17	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
280	EMPIRE MALKOVICH	A Amazing Story of a Feminist And a Cat who must Face a Car in An Abandoned Fun House	2006	7	0.99	177	26.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
281	ENCINO ELF	A Astounding Drama of a Feminist And a Teacher who must Confront a Husband in A Baloon	2006	6	0.99	143	9.99	G	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
282	ENCOUNTERS CURTAIN	A Insightful Epistle of a Pastry Chef And a Womanizer who must Build a Boat in New Orleans	2006	5	0.99	92	20.99	NC-17	{Trailers}	2006-02-15 05:03:42
283	ENDING CROWDS	A Unbelieveable Display of a Dentist And a Madman who must Vanquish a Squirrel in Berlin	2006	6	0.99	85	10.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
284	ENEMY ODDS	A Fanciful Panorama of a Mad Scientist And a Woman who must Pursue a Astronaut in Ancient India	2006	5	4.99	77	23.99	NC-17	{Trailers}	2006-02-15 05:03:42
285	ENGLISH BULWORTH	A Intrepid Epistle of a Pastry Chef And a Pastry Chef who must Pursue a Crocodile in Ancient China	2006	3	0.99	51	18.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
286	ENOUGH RAGING	A Astounding Character Study of a Boat And a Secret Agent who must Find a Mad Cow in The Sahara Desert	2006	7	2.99	158	16.99	NC-17	{Commentaries}	2006-02-15 05:03:42
287	ENTRAPMENT SATISFACTION	A Thoughtful Panorama of a Hunter And a Teacher who must Reach a Mad Cow in A U-Boat	2006	5	0.99	176	19.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
288	ESCAPE METROPOLIS	A Taut Yarn of a Astronaut And a Technical Writer who must Outgun a Boat in New Orleans	2006	7	2.99	167	20.99	R	{Trailers}	2006-02-15 05:03:42
289	EVE RESURRECTION	A Awe-Inspiring Yarn of a Pastry Chef And a Database Administrator who must Challenge a Teacher in A Baloon	2006	5	4.99	66	25.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
290	EVERYONE CRAFT	A Fateful Display of a Waitress And a Dentist who must Reach a Butler in Nigeria	2006	4	0.99	163	29.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
291	EVOLUTION ALTER	A Fanciful Character Study of a Feminist And a Madman who must Find a Explorer in A Baloon Factory	2006	5	0.99	174	10.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
292	EXCITEMENT EVE	A Brilliant Documentary of a Monkey And a Car who must Conquer a Crocodile in A Shark Tank	2006	3	0.99	51	20.99	G	{Commentaries}	2006-02-15 05:03:42
293	EXORCIST STING	A Touching Drama of a Dog And a Sumo Wrestler who must Conquer a Mad Scientist in Berlin	2006	6	2.99	167	17.99	G	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
294	EXPECATIONS NATURAL	A Amazing Drama of a Butler And a Husband who must Reach a A Shark in A U-Boat	2006	5	4.99	138	26.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
295	EXPENDABLE STALLION	A Amazing Character Study of a Mad Cow And a Squirrel who must Discover a Hunter in A U-Boat	2006	3	0.99	97	14.99	PG	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
296	EXPRESS LONELY	A Boring Drama of a Astronaut And a Boat who must Face a Boat in California	2006	5	2.99	178	23.99	R	{Trailers}	2006-02-15 05:03:42
297	EXTRAORDINARY CONQUERER	A Stunning Story of a Dog And a Feminist who must Face a Forensic Psychologist in Berlin	2006	6	2.99	122	29.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
298	EYES DRIVING	A Thrilling Story of a Cat And a Waitress who must Fight a Explorer in The Outback	2006	4	2.99	172	13.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
299	FACTORY DRAGON	A Action-Packed Saga of a Teacher And a Frisbee who must Escape a Lumberjack in The Sahara Desert	2006	4	0.99	144	9.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
300	FALCON VOLUME	A Fateful Saga of a Sumo Wrestler And a Hunter who must Redeem a A Shark in New Orleans	2006	5	4.99	102	21.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
301	FAMILY SWEET	A Epic Documentary of a Teacher And a Boy who must Escape a Woman in Berlin	2006	4	0.99	155	24.99	R	{Trailers}	2006-02-15 05:03:42
302	FANTASIA PARK	A Thoughtful Documentary of a Mad Scientist And a A Shark who must Outrace a Feminist in Australia	2006	5	2.99	131	29.99	G	{Commentaries}	2006-02-15 05:03:42
303	FANTASY TROOPERS	A Touching Saga of a Teacher And a Monkey who must Overcome a Secret Agent in A MySQL Convention	2006	6	0.99	58	27.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
304	FARGO GANDHI	A Thrilling Reflection of a Pastry Chef And a Crocodile who must Reach a Teacher in The Outback	2006	3	2.99	130	28.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
305	FATAL HAUNTED	A Beautiful Drama of a Student And a Secret Agent who must Confront a Dentist in Ancient Japan	2006	6	2.99	91	24.99	PG	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
306	FEATHERS METAL	A Thoughtful Yarn of a Monkey And a Teacher who must Find a Dog in Australia	2006	3	0.99	104	12.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
307	FELLOWSHIP AUTUMN	A Lacklusture Reflection of a Dentist And a Hunter who must Meet a Teacher in A Baloon	2006	6	4.99	77	9.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
308	FERRIS MOTHER	A Touching Display of a Frisbee And a Frisbee who must Kill a Girl in The Gulf of Mexico	2006	3	2.99	142	13.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
309	FEUD FROGMEN	A Brilliant Reflection of a Database Administrator And a Mad Cow who must Chase a Woman in The Canadian Rockies	2006	6	0.99	98	29.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
310	FEVER EMPIRE	A Insightful Panorama of a Cat And a Boat who must Defeat a Boat in The Gulf of Mexico	2006	5	4.99	158	20.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
311	FICTION CHRISTMAS	A Emotional Yarn of a A Shark And a Student who must Battle a Robot in An Abandoned Mine Shaft	2006	4	0.99	72	14.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
312	FIDDLER LOST	A Boring Tale of a Squirrel And a Dog who must Challenge a Madman in The Gulf of Mexico	2006	4	4.99	75	20.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
313	FIDELITY DEVIL	A Awe-Inspiring Drama of a Technical Writer And a Composer who must Reach a Pastry Chef in A U-Boat	2006	5	4.99	118	11.99	G	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
314	FIGHT JAWBREAKER	A Intrepid Panorama of a Womanizer And a Girl who must Escape a Girl in A Manhattan Penthouse	2006	3	0.99	91	13.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
315	FINDING ANACONDA	A Fateful Tale of a Database Administrator And a Girl who must Battle a Squirrel in New Orleans	2006	4	0.99	156	10.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
316	FIRE WOLVES	A Intrepid Documentary of a Frisbee And a Dog who must Outrace a Lumberjack in Nigeria	2006	5	4.99	173	18.99	R	{Trailers}	2006-02-15 05:03:42
317	FIREBALL PHILADELPHIA	A Amazing Yarn of a Dentist And a A Shark who must Vanquish a Madman in An Abandoned Mine Shaft	2006	4	0.99	148	25.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
318	FIREHOUSE VIETNAM	A Awe-Inspiring Character Study of a Boat And a Boy who must Kill a Pastry Chef in The Sahara Desert	2006	7	0.99	103	14.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
319	FISH OPUS	A Touching Display of a Feminist And a Girl who must Confront a Astronaut in Australia	2006	4	2.99	125	22.99	R	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
320	FLAMINGOS CONNECTICUT	A Fast-Paced Reflection of a Composer And a Composer who must Meet a Cat in The Sahara Desert	2006	4	4.99	80	28.99	PG-13	{Trailers}	2006-02-15 05:03:42
321	FLASH WARS	A Astounding Saga of a Moose And a Pastry Chef who must Chase a Student in The Gulf of Mexico	2006	3	4.99	123	21.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
322	FLATLINERS KILLER	A Taut Display of a Secret Agent And a Waitress who must Sink a Robot in An Abandoned Mine Shaft	2006	5	2.99	100	29.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
323	FLIGHT LIES	A Stunning Character Study of a Crocodile And a Pioneer who must Pursue a Teacher in New Orleans	2006	7	4.99	179	22.99	R	{Trailers}	2006-02-15 05:03:42
324	FLINTSTONES HAPPINESS	A Fateful Story of a Husband And a Moose who must Vanquish a Boy in California	2006	3	4.99	148	11.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
325	FLOATS GARDEN	A Action-Packed Epistle of a Robot And a Car who must Chase a Boat in Ancient Japan	2006	6	2.99	145	29.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
326	FLYING HOOK	A Thrilling Display of a Mad Cow And a Dog who must Challenge a Frisbee in Nigeria	2006	6	2.99	69	18.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
327	FOOL MOCKINGBIRD	A Lacklusture Tale of a Crocodile And a Composer who must Defeat a Madman in A U-Boat	2006	3	4.99	158	24.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
328	FOREVER CANDIDATE	A Unbelieveable Panorama of a Technical Writer And a Man who must Pursue a Frisbee in A U-Boat	2006	7	2.99	131	28.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
329	FORREST SONS	A Thrilling Documentary of a Forensic Psychologist And a Butler who must Defeat a Explorer in A Jet Boat	2006	4	2.99	63	15.99	R	{Commentaries}	2006-02-15 05:03:42
330	FORRESTER COMANCHEROS	A Fateful Tale of a Squirrel And a Forensic Psychologist who must Redeem a Man in Nigeria	2006	7	4.99	112	22.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
331	FORWARD TEMPLE	A Astounding Display of a Forensic Psychologist And a Mad Scientist who must Challenge a Girl in New Orleans	2006	6	2.99	90	25.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
332	FRANKENSTEIN STRANGER	A Insightful Character Study of a Feminist And a Pioneer who must Pursue a Pastry Chef in Nigeria	2006	7	0.99	159	16.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
333	FREAKY POCUS	A Fast-Paced Documentary of a Pastry Chef And a Crocodile who must Chase a Squirrel in The Gulf of Mexico	2006	7	2.99	126	16.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
334	FREDDY STORM	A Intrepid Saga of a Man And a Lumberjack who must Vanquish a Husband in The Outback	2006	6	4.99	65	21.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
335	FREEDOM CLEOPATRA	A Emotional Reflection of a Dentist And a Mad Cow who must Face a Squirrel in A Baloon	2006	5	0.99	133	23.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
336	FRENCH HOLIDAY	A Thrilling Epistle of a Dog And a Feminist who must Kill a Madman in Berlin	2006	5	4.99	99	22.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
337	FRIDA SLIPPER	A Fateful Story of a Lumberjack And a Car who must Escape a Boat in An Abandoned Mine Shaft	2006	6	2.99	73	11.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
338	FRISCO FORREST	A Beautiful Documentary of a Woman And a Pioneer who must Pursue a Mad Scientist in A Shark Tank	2006	6	4.99	51	23.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
339	FROGMEN BREAKING	A Unbelieveable Yarn of a Mad Scientist And a Cat who must Chase a Lumberjack in Australia	2006	5	0.99	111	17.99	R	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
340	FRONTIER CABIN	A Emotional Story of a Madman And a Waitress who must Battle a Teacher in An Abandoned Fun House	2006	6	4.99	183	14.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
341	FROST HEAD	A Amazing Reflection of a Lumberjack And a Cat who must Discover a Husband in A MySQL Convention	2006	5	0.99	82	13.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
342	FUGITIVE MAGUIRE	A Taut Epistle of a Feminist And a Sumo Wrestler who must Battle a Crocodile in Australia	2006	7	4.99	83	28.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
343	FULL FLATLINERS	A Beautiful Documentary of a Astronaut And a Moose who must Pursue a Monkey in A Shark Tank	2006	6	2.99	94	14.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
344	FURY MURDER	A Lacklusture Reflection of a Boat And a Forensic Psychologist who must Fight a Waitress in A Monastery	2006	3	0.99	178	28.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
345	GABLES METROPOLIS	A Fateful Display of a Cat And a Pioneer who must Challenge a Pastry Chef in A Baloon Factory	2006	3	0.99	161	17.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
346	GALAXY SWEETHEARTS	A Emotional Reflection of a Womanizer And a Pioneer who must Face a Squirrel in Berlin	2006	4	4.99	128	13.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
347	GAMES BOWFINGER	A Astounding Documentary of a Butler And a Explorer who must Challenge a Butler in A Monastery	2006	7	4.99	119	17.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
348	GANDHI KWAI	A Thoughtful Display of a Mad Scientist And a Secret Agent who must Chase a Boat in Berlin	2006	7	0.99	86	9.99	PG-13	{Trailers}	2006-02-15 05:03:42
349	GANGS PRIDE	A Taut Character Study of a Woman And a A Shark who must Confront a Frisbee in Berlin	2006	4	2.99	185	27.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
350	GARDEN ISLAND	A Unbelieveable Character Study of a Womanizer And a Madman who must Reach a Man in The Outback	2006	3	4.99	80	21.99	G	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
351	GASLIGHT CRUSADE	A Amazing Epistle of a Boy And a Astronaut who must Redeem a Man in The Gulf of Mexico	2006	4	2.99	106	10.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
352	GATHERING CALENDAR	A Intrepid Tale of a Pioneer And a Moose who must Conquer a Frisbee in A MySQL Convention	2006	4	0.99	176	22.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
353	GENTLEMEN STAGE	A Awe-Inspiring Reflection of a Monkey And a Student who must Overcome a Dentist in The First Manned Space Station	2006	6	2.99	125	22.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
354	GHOST GROUNDHOG	A Brilliant Panorama of a Madman And a Composer who must Succumb a Car in Ancient India	2006	6	4.99	85	18.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
355	GHOSTBUSTERS ELF	A Thoughtful Epistle of a Dog And a Feminist who must Chase a Composer in Berlin	2006	7	0.99	101	18.99	R	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
356	GIANT TROOPERS	A Fateful Display of a Feminist And a Monkey who must Vanquish a Monkey in The Canadian Rockies	2006	5	2.99	102	10.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
357	GILBERT PELICAN	A Fateful Tale of a Man And a Feminist who must Conquer a Crocodile in A Manhattan Penthouse	2006	7	0.99	114	13.99	G	{Trailers,Commentaries}	2006-02-15 05:03:42
358	GILMORE BOILED	A Unbelieveable Documentary of a Boat And a Husband who must Succumb a Student in A U-Boat	2006	5	0.99	163	29.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
359	GLADIATOR WESTWARD	A Astounding Reflection of a Squirrel And a Sumo Wrestler who must Sink a Dentist in Ancient Japan	2006	6	4.99	173	20.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
360	GLASS DYING	A Astounding Drama of a Frisbee And a Astronaut who must Fight a Dog in Ancient Japan	2006	4	0.99	103	24.99	G	{Trailers}	2006-02-15 05:03:42
361	GLEAMING JAWBREAKER	A Amazing Display of a Composer And a Forensic Psychologist who must Discover a Car in The Canadian Rockies	2006	5	2.99	89	25.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
362	GLORY TRACY	A Amazing Saga of a Woman And a Womanizer who must Discover a Cat in The First Manned Space Station	2006	7	2.99	115	13.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
363	GO PURPLE	A Fast-Paced Display of a Car And a Database Administrator who must Battle a Woman in A Baloon	2006	3	0.99	54	12.99	R	{Trailers}	2006-02-15 05:03:42
364	GODFATHER DIARY	A Stunning Saga of a Lumberjack And a Squirrel who must Chase a Car in The Outback	2006	3	2.99	73	14.99	NC-17	{Trailers}	2006-02-15 05:03:42
365	GOLD RIVER	A Taut Documentary of a Database Administrator And a Waitress who must Reach a Mad Scientist in A Baloon Factory	2006	4	4.99	154	21.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
366	GOLDFINGER SENSIBILITY	A Insightful Drama of a Mad Scientist And a Hunter who must Defeat a Pastry Chef in New Orleans	2006	3	0.99	93	29.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
367	GOLDMINE TYCOON	A Brilliant Epistle of a Composer And a Frisbee who must Conquer a Husband in The Outback	2006	6	0.99	153	20.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
368	GONE TROUBLE	A Insightful Character Study of a Mad Cow And a Forensic Psychologist who must Conquer a A Shark in A Manhattan Penthouse	2006	7	2.99	84	20.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
369	GOODFELLAS SALUTE	A Unbelieveable Tale of a Dog And a Explorer who must Sink a Mad Cow in A Baloon Factory	2006	4	4.99	56	22.99	PG	{"Deleted Scenes"}	2006-02-15 05:03:42
370	GORGEOUS BINGO	A Action-Packed Display of a Sumo Wrestler And a Car who must Overcome a Waitress in A Baloon Factory	2006	4	2.99	108	26.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
371	GOSFORD DONNIE	A Epic Panorama of a Mad Scientist And a Monkey who must Redeem a Secret Agent in Berlin	2006	5	4.99	129	17.99	G	{Commentaries}	2006-02-15 05:03:42
372	GRACELAND DYNAMITE	A Taut Display of a Cat And a Girl who must Overcome a Database Administrator in New Orleans	2006	5	4.99	140	26.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
373	GRADUATE LORD	A Lacklusture Epistle of a Girl And a A Shark who must Meet a Mad Scientist in Ancient China	2006	7	2.99	156	14.99	G	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
374	GRAFFITI LOVE	A Unbelieveable Epistle of a Sumo Wrestler And a Hunter who must Build a Composer in Berlin	2006	3	0.99	117	29.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
375	GRAIL FRANKENSTEIN	A Unbelieveable Saga of a Teacher And a Monkey who must Fight a Girl in An Abandoned Mine Shaft	2006	4	2.99	85	17.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
376	GRAPES FURY	A Boring Yarn of a Mad Cow And a Sumo Wrestler who must Meet a Robot in Australia	2006	4	0.99	155	20.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
377	GREASE YOUTH	A Emotional Panorama of a Secret Agent And a Waitress who must Escape a Composer in Soviet Georgia	2006	7	0.99	135	20.99	G	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
378	GREATEST NORTH	A Astounding Character Study of a Secret Agent And a Robot who must Build a A Shark in Berlin	2006	5	2.99	93	24.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
379	GREEDY ROOTS	A Amazing Reflection of a A Shark And a Butler who must Chase a Hunter in The Canadian Rockies	2006	7	0.99	166	14.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
380	GREEK EVERYONE	A Stunning Display of a Butler And a Teacher who must Confront a A Shark in The First Manned Space Station	2006	7	2.99	176	11.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
381	GRINCH MASSAGE	A Intrepid Display of a Madman And a Feminist who must Pursue a Pioneer in The First Manned Space Station	2006	7	4.99	150	25.99	R	{Trailers}	2006-02-15 05:03:42
382	GRIT CLOCKWORK	A Thoughtful Display of a Dentist And a Squirrel who must Confront a Lumberjack in A Shark Tank	2006	3	0.99	137	21.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
383	GROOVE FICTION	A Unbelieveable Reflection of a Moose And a A Shark who must Defeat a Lumberjack in An Abandoned Mine Shaft	2006	6	0.99	111	13.99	NC-17	{"Behind the Scenes"}	2006-02-15 05:03:42
384	GROSSE WONDERFUL	A Epic Drama of a Cat And a Explorer who must Redeem a Moose in Australia	2006	5	4.99	49	19.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
385	GROUNDHOG UNCUT	A Brilliant Panorama of a Astronaut And a Technical Writer who must Discover a Butler in A Manhattan Penthouse	2006	6	4.99	139	26.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
386	GUMP DATE	A Intrepid Yarn of a Explorer And a Student who must Kill a Husband in An Abandoned Mine Shaft	2006	3	4.99	53	12.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
387	GUN BONNIE	A Boring Display of a Sumo Wrestler And a Husband who must Build a Waitress in The Gulf of Mexico	2006	7	0.99	100	27.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
388	GUNFIGHT MOON	A Epic Reflection of a Pastry Chef And a Explorer who must Reach a Dentist in The Sahara Desert	2006	5	0.99	70	16.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
389	GUNFIGHTER MUSSOLINI	A Touching Saga of a Robot And a Boy who must Kill a Man in Ancient Japan	2006	3	2.99	127	9.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
390	GUYS FALCON	A Boring Story of a Woman And a Feminist who must Redeem a Squirrel in A U-Boat	2006	4	4.99	84	20.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
391	HALF OUTFIELD	A Epic Epistle of a Database Administrator And a Crocodile who must Face a Madman in A Jet Boat	2006	6	2.99	146	25.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
392	HALL CASSIDY	A Beautiful Panorama of a Pastry Chef And a A Shark who must Battle a Pioneer in Soviet Georgia	2006	5	4.99	51	13.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
393	HALLOWEEN NUTS	A Amazing Panorama of a Forensic Psychologist And a Technical Writer who must Fight a Dentist in A U-Boat	2006	6	2.99	47	19.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
394	HAMLET WISDOM	A Touching Reflection of a Man And a Man who must Sink a Robot in The Outback	2006	7	2.99	146	21.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
395	HANDICAP BOONDOCK	A Beautiful Display of a Pioneer And a Squirrel who must Vanquish a Sumo Wrestler in Soviet Georgia	2006	4	0.99	108	28.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
396	HANGING DEEP	A Action-Packed Yarn of a Boat And a Crocodile who must Build a Monkey in Berlin	2006	5	4.99	62	18.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
397	HANKY OCTOBER	A Boring Epistle of a Database Administrator And a Explorer who must Pursue a Madman in Soviet Georgia	2006	5	2.99	107	26.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
398	HANOVER GALAXY	A Stunning Reflection of a Girl And a Secret Agent who must Succumb a Boy in A MySQL Convention	2006	5	4.99	47	21.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
399	HAPPINESS UNITED	A Action-Packed Panorama of a Husband And a Feminist who must Meet a Forensic Psychologist in Ancient Japan	2006	6	2.99	100	23.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
400	HARDLY ROBBERS	A Emotional Character Study of a Hunter And a Car who must Kill a Woman in Berlin	2006	7	2.99	72	15.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
401	HAROLD FRENCH	A Stunning Saga of a Sumo Wrestler And a Student who must Outrace a Moose in The Sahara Desert	2006	6	0.99	168	10.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
402	HARPER DYING	A Awe-Inspiring Reflection of a Woman And a Cat who must Confront a Feminist in The Sahara Desert	2006	3	0.99	52	15.99	G	{Trailers}	2006-02-15 05:03:42
403	HARRY IDAHO	A Taut Yarn of a Technical Writer And a Feminist who must Outrace a Dog in California	2006	5	4.99	121	18.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
404	HATE HANDICAP	A Intrepid Reflection of a Mad Scientist And a Pioneer who must Overcome a Hunter in The First Manned Space Station	2006	4	0.99	107	26.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
405	HAUNTED ANTITRUST	A Amazing Saga of a Man And a Dentist who must Reach a Technical Writer in Ancient India	2006	6	4.99	76	13.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
406	HAUNTING PIANIST	A Fast-Paced Story of a Database Administrator And a Composer who must Defeat a Squirrel in An Abandoned Amusement Park	2006	5	0.99	181	22.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
407	HAWK CHILL	A Action-Packed Drama of a Mad Scientist And a Composer who must Outgun a Car in Australia	2006	5	0.99	47	12.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
408	HEAD STRANGER	A Thoughtful Saga of a Hunter And a Crocodile who must Confront a Dog in The Gulf of Mexico	2006	4	4.99	69	28.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
409	HEARTBREAKERS BRIGHT	A Awe-Inspiring Documentary of a A Shark And a Dentist who must Outrace a Pastry Chef in The Canadian Rockies	2006	3	4.99	59	9.99	G	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
410	HEAVEN FREEDOM	A Intrepid Story of a Butler And a Car who must Vanquish a Man in New Orleans	2006	7	2.99	48	19.99	PG	{Commentaries}	2006-02-15 05:03:42
411	HEAVENLY GUN	A Beautiful Yarn of a Forensic Psychologist And a Frisbee who must Battle a Moose in A Jet Boat	2006	5	4.99	49	13.99	NC-17	{"Behind the Scenes"}	2006-02-15 05:03:42
412	HEAVYWEIGHTS BEAST	A Unbelieveable Story of a Composer And a Dog who must Overcome a Womanizer in An Abandoned Amusement Park	2006	6	4.99	102	25.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
413	HEDWIG ALTER	A Action-Packed Yarn of a Womanizer And a Lumberjack who must Chase a Sumo Wrestler in A Monastery	2006	7	2.99	169	16.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
414	HELLFIGHTERS SIERRA	A Taut Reflection of a A Shark And a Dentist who must Battle a Boat in Soviet Georgia	2006	3	2.99	75	23.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
415	HIGH ENCINO	A Fateful Saga of a Waitress And a Hunter who must Outrace a Sumo Wrestler in Australia	2006	3	2.99	84	23.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
416	HIGHBALL POTTER	A Action-Packed Saga of a Husband And a Dog who must Redeem a Database Administrator in The Sahara Desert	2006	6	0.99	110	10.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
417	HILLS NEIGHBORS	A Epic Display of a Hunter And a Feminist who must Sink a Car in A U-Boat	2006	5	0.99	93	29.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
418	HOBBIT ALIEN	A Emotional Drama of a Husband And a Girl who must Outgun a Composer in The First Manned Space Station	2006	5	0.99	157	27.99	PG-13	{Commentaries}	2006-02-15 05:03:42
419	HOCUS FRIDA	A Awe-Inspiring Tale of a Girl And a Madman who must Outgun a Student in A Shark Tank	2006	4	2.99	141	19.99	G	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
420	HOLES BRANNIGAN	A Fast-Paced Reflection of a Technical Writer And a Student who must Fight a Boy in The Canadian Rockies	2006	7	4.99	128	27.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
421	HOLIDAY GAMES	A Insightful Reflection of a Waitress And a Madman who must Pursue a Boy in Ancient Japan	2006	7	4.99	78	10.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
422	HOLLOW JEOPARDY	A Beautiful Character Study of a Robot And a Astronaut who must Overcome a Boat in A Monastery	2006	7	4.99	136	25.99	NC-17	{"Behind the Scenes"}	2006-02-15 05:03:42
423	HOLLYWOOD ANONYMOUS	A Fast-Paced Epistle of a Boy And a Explorer who must Escape a Dog in A U-Boat	2006	7	0.99	69	29.99	PG	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
424	HOLOCAUST HIGHBALL	A Awe-Inspiring Yarn of a Composer And a Man who must Find a Robot in Soviet Georgia	2006	6	0.99	149	12.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
425	HOLY TADPOLE	A Action-Packed Display of a Feminist And a Pioneer who must Pursue a Dog in A Baloon Factory	2006	6	0.99	88	20.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
426	HOME PITY	A Touching Panorama of a Man And a Secret Agent who must Challenge a Teacher in A MySQL Convention	2006	7	4.99	185	15.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
427	HOMEWARD CIDER	A Taut Reflection of a Astronaut And a Squirrel who must Fight a Squirrel in A Manhattan Penthouse	2006	5	0.99	103	19.99	R	{Trailers}	2006-02-15 05:03:42
428	HOMICIDE PEACH	A Astounding Documentary of a Hunter And a Boy who must Confront a Boy in A MySQL Convention	2006	6	2.99	141	21.99	PG-13	{Commentaries}	2006-02-15 05:03:42
429	HONEY TIES	A Taut Story of a Waitress And a Crocodile who must Outrace a Lumberjack in A Shark Tank	2006	3	0.99	84	29.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
430	HOOK CHARIOTS	A Insightful Story of a Boy And a Dog who must Redeem a Boy in Australia	2006	7	0.99	49	23.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
431	HOOSIERS BIRDCAGE	A Astounding Display of a Explorer And a Boat who must Vanquish a Car in The First Manned Space Station	2006	3	2.99	176	12.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
432	HOPE TOOTSIE	A Amazing Documentary of a Student And a Sumo Wrestler who must Outgun a A Shark in A Shark Tank	2006	4	2.99	139	22.99	NC-17	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
433	HORN WORKING	A Stunning Display of a Mad Scientist And a Technical Writer who must Succumb a Monkey in A Shark Tank	2006	4	2.99	95	23.99	PG	{Trailers}	2006-02-15 05:03:42
434	HORROR REIGN	A Touching Documentary of a A Shark And a Car who must Build a Husband in Nigeria	2006	3	0.99	139	25.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
435	HOTEL HAPPINESS	A Thrilling Yarn of a Pastry Chef And a A Shark who must Challenge a Mad Scientist in The Outback	2006	6	4.99	181	28.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
436	HOURS RAGE	A Fateful Story of a Explorer And a Feminist who must Meet a Technical Writer in Soviet Georgia	2006	4	0.99	122	14.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
437	HOUSE DYNAMITE	A Taut Story of a Pioneer And a Squirrel who must Battle a Student in Soviet Georgia	2006	7	2.99	109	13.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
438	HUMAN GRAFFITI	A Beautiful Reflection of a Womanizer And a Sumo Wrestler who must Chase a Database Administrator in The Gulf of Mexico	2006	3	2.99	68	22.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
439	HUNCHBACK IMPOSSIBLE	A Touching Yarn of a Frisbee And a Dentist who must Fight a Composer in Ancient Japan	2006	4	4.99	151	28.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
440	HUNGER ROOF	A Unbelieveable Yarn of a Student And a Database Administrator who must Outgun a Husband in An Abandoned Mine Shaft	2006	6	0.99	105	21.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
441	HUNTER ALTER	A Emotional Drama of a Mad Cow And a Boat who must Redeem a Secret Agent in A Shark Tank	2006	5	2.99	125	21.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
442	HUNTING MUSKETEERS	A Thrilling Reflection of a Pioneer And a Dentist who must Outrace a Womanizer in An Abandoned Mine Shaft	2006	6	2.99	65	24.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
443	HURRICANE AFFAIR	A Lacklusture Epistle of a Database Administrator And a Woman who must Meet a Hunter in An Abandoned Mine Shaft	2006	6	2.99	49	11.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
444	HUSTLER PARTY	A Emotional Reflection of a Sumo Wrestler And a Monkey who must Conquer a Robot in The Sahara Desert	2006	3	4.99	83	22.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
445	HYDE DOCTOR	A Fanciful Documentary of a Boy And a Woman who must Redeem a Womanizer in A Jet Boat	2006	5	2.99	100	11.99	G	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
446	HYSTERICAL GRAIL	A Amazing Saga of a Madman And a Dentist who must Build a Car in A Manhattan Penthouse	2006	5	4.99	150	19.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
447	ICE CROSSING	A Fast-Paced Tale of a Butler And a Moose who must Overcome a Pioneer in A Manhattan Penthouse	2006	5	2.99	131	28.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
448	IDAHO LOVE	A Fast-Paced Drama of a Student And a Crocodile who must Meet a Database Administrator in The Outback	2006	3	2.99	172	25.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
449	IDENTITY LOVER	A Boring Tale of a Composer And a Mad Cow who must Defeat a Car in The Outback	2006	4	2.99	119	12.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
450	IDOLS SNATCHERS	A Insightful Drama of a Car And a Composer who must Fight a Man in A Monastery	2006	5	2.99	84	29.99	NC-17	{Trailers}	2006-02-15 05:03:42
451	IGBY MAKER	A Epic Documentary of a Hunter And a Dog who must Outgun a Dog in A Baloon Factory	2006	7	4.99	160	12.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
452	ILLUSION AMELIE	A Emotional Epistle of a Boat And a Mad Scientist who must Outrace a Robot in An Abandoned Mine Shaft	2006	4	0.99	122	15.99	R	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
453	IMAGE PRINCESS	A Lacklusture Panorama of a Secret Agent And a Crocodile who must Discover a Madman in The Canadian Rockies	2006	3	2.99	178	17.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
454	IMPACT ALADDIN	A Epic Character Study of a Frisbee And a Moose who must Outgun a Technical Writer in A Shark Tank	2006	6	0.99	180	20.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
455	IMPOSSIBLE PREJUDICE	A Awe-Inspiring Yarn of a Monkey And a Hunter who must Chase a Teacher in Ancient China	2006	7	4.99	103	11.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
456	INCH JET	A Fateful Saga of a Womanizer And a Student who must Defeat a Butler in A Monastery	2006	6	4.99	167	18.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
457	INDEPENDENCE HOTEL	A Thrilling Tale of a Technical Writer And a Boy who must Face a Pioneer in A Monastery	2006	5	0.99	157	21.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
458	INDIAN LOVE	A Insightful Saga of a Mad Scientist And a Mad Scientist who must Kill a Astronaut in An Abandoned Fun House	2006	4	0.99	135	26.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
459	INFORMER DOUBLE	A Action-Packed Display of a Woman And a Dentist who must Redeem a Forensic Psychologist in The Canadian Rockies	2006	4	4.99	74	23.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
460	INNOCENT USUAL	A Beautiful Drama of a Pioneer And a Crocodile who must Challenge a Student in The Outback	2006	3	4.99	178	26.99	PG-13	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
461	INSECTS STONE	A Epic Display of a Butler And a Dog who must Vanquish a Crocodile in A Manhattan Penthouse	2006	3	0.99	123	14.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
462	INSIDER ARIZONA	A Astounding Saga of a Mad Scientist And a Hunter who must Pursue a Robot in A Baloon Factory	2006	5	2.99	78	17.99	NC-17	{Commentaries}	2006-02-15 05:03:42
463	INSTINCT AIRPORT	A Touching Documentary of a Mad Cow And a Explorer who must Confront a Butler in A Manhattan Penthouse	2006	4	2.99	116	21.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
464	INTENTIONS EMPIRE	A Astounding Epistle of a Cat And a Cat who must Conquer a Mad Cow in A U-Boat	2006	3	2.99	107	13.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
465	INTERVIEW LIAISONS	A Action-Packed Reflection of a Student And a Butler who must Discover a Database Administrator in A Manhattan Penthouse	2006	4	4.99	59	17.99	R	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
466	INTOLERABLE INTENTIONS	A Awe-Inspiring Story of a Monkey And a Pastry Chef who must Succumb a Womanizer in A MySQL Convention	2006	6	4.99	63	20.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
467	INTRIGUE WORST	A Fanciful Character Study of a Explorer And a Mad Scientist who must Vanquish a Squirrel in A Jet Boat	2006	6	0.99	181	10.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
468	INVASION CYCLONE	A Lacklusture Character Study of a Mad Scientist And a Womanizer who must Outrace a Explorer in A Monastery	2006	5	2.99	97	12.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
469	IRON MOON	A Fast-Paced Documentary of a Mad Cow And a Boy who must Pursue a Dentist in A Baloon	2006	7	4.99	46	27.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
470	ISHTAR ROCKETEER	A Astounding Saga of a Dog And a Squirrel who must Conquer a Dog in An Abandoned Fun House	2006	4	4.99	79	24.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
471	ISLAND EXORCIST	A Fanciful Panorama of a Technical Writer And a Boy who must Find a Dentist in An Abandoned Fun House	2006	7	2.99	84	23.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
472	ITALIAN AFRICAN	A Astounding Character Study of a Monkey And a Moose who must Outgun a Cat in A U-Boat	2006	3	4.99	174	24.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
473	JACKET FRISCO	A Insightful Reflection of a Womanizer And a Husband who must Conquer a Pastry Chef in A Baloon	2006	5	2.99	181	16.99	PG-13	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
474	JADE BUNCH	A Insightful Panorama of a Squirrel And a Mad Cow who must Confront a Student in The First Manned Space Station	2006	6	2.99	174	21.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
475	JAPANESE RUN	A Awe-Inspiring Epistle of a Feminist And a Girl who must Sink a Girl in The Outback	2006	6	0.99	135	29.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
476	JASON TRAP	A Thoughtful Tale of a Woman And a A Shark who must Conquer a Dog in A Monastery	2006	5	2.99	130	9.99	NC-17	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
477	JAWBREAKER BROOKLYN	A Stunning Reflection of a Boat And a Pastry Chef who must Succumb a A Shark in A Jet Boat	2006	5	0.99	118	15.99	PG	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
478	JAWS HARRY	A Thrilling Display of a Database Administrator And a Monkey who must Overcome a Dog in An Abandoned Fun House	2006	4	2.99	112	10.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
479	JEDI BENEATH	A Astounding Reflection of a Explorer And a Dentist who must Pursue a Student in Nigeria	2006	7	0.99	128	12.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
480	JEEPERS WEDDING	A Astounding Display of a Composer And a Dog who must Kill a Pastry Chef in Soviet Georgia	2006	3	2.99	84	29.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
481	JEKYLL FROGMEN	A Fanciful Epistle of a Student And a Astronaut who must Kill a Waitress in A Shark Tank	2006	4	2.99	58	22.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
482	JEOPARDY ENCINO	A Boring Panorama of a Man And a Mad Cow who must Face a Explorer in Ancient India	2006	3	0.99	102	12.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
483	JERICHO MULAN	A Amazing Yarn of a Hunter And a Butler who must Defeat a Boy in A Jet Boat	2006	3	2.99	171	29.99	NC-17	{Commentaries}	2006-02-15 05:03:42
484	JERK PAYCHECK	A Touching Character Study of a Pastry Chef And a Database Administrator who must Reach a A Shark in Ancient Japan	2006	3	2.99	172	13.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
485	JERSEY SASSY	A Lacklusture Documentary of a Madman And a Mad Cow who must Find a Feminist in Ancient Japan	2006	6	4.99	60	16.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
486	JET NEIGHBORS	A Amazing Display of a Lumberjack And a Teacher who must Outrace a Woman in A U-Boat	2006	7	4.99	59	14.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
487	JINGLE SAGEBRUSH	A Epic Character Study of a Feminist And a Student who must Meet a Woman in A Baloon	2006	6	4.99	124	29.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
488	JOON NORTHWEST	A Thrilling Panorama of a Technical Writer And a Car who must Discover a Forensic Psychologist in A Shark Tank	2006	3	0.99	105	23.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
489	JUGGLER HARDLY	A Epic Story of a Mad Cow And a Astronaut who must Challenge a Car in California	2006	4	0.99	54	14.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
490	JUMANJI BLADE	A Intrepid Yarn of a Husband And a Womanizer who must Pursue a Mad Scientist in New Orleans	2006	4	2.99	121	13.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
491	JUMPING WRATH	A Touching Epistle of a Monkey And a Feminist who must Discover a Boat in Berlin	2006	4	0.99	74	18.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
492	JUNGLE CLOSER	A Boring Character Study of a Boy And a Woman who must Battle a Astronaut in Australia	2006	6	0.99	134	11.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
493	KANE EXORCIST	A Epic Documentary of a Composer And a Robot who must Overcome a Car in Berlin	2006	5	0.99	92	18.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
494	KARATE MOON	A Astounding Yarn of a Womanizer And a Dog who must Reach a Waitress in A MySQL Convention	2006	4	0.99	120	21.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
495	KENTUCKIAN GIANT	A Stunning Yarn of a Woman And a Frisbee who must Escape a Waitress in A U-Boat	2006	5	2.99	169	10.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
496	KICK SAVANNAH	A Emotional Drama of a Monkey And a Robot who must Defeat a Monkey in New Orleans	2006	3	0.99	179	10.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
497	KILL BROTHERHOOD	A Touching Display of a Hunter And a Secret Agent who must Redeem a Husband in The Outback	2006	4	0.99	54	15.99	G	{Trailers,Commentaries}	2006-02-15 05:03:42
498	KILLER INNOCENT	A Fanciful Character Study of a Student And a Explorer who must Succumb a Composer in An Abandoned Mine Shaft	2006	7	2.99	161	11.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
499	KING EVOLUTION	A Action-Packed Tale of a Boy And a Lumberjack who must Chase a Madman in A Baloon	2006	3	4.99	184	24.99	NC-17	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
500	KISS GLORY	A Lacklusture Reflection of a Girl And a Husband who must Find a Robot in The Canadian Rockies	2006	5	4.99	163	11.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
501	KISSING DOLLS	A Insightful Reflection of a Pioneer And a Teacher who must Build a Composer in The First Manned Space Station	2006	3	4.99	141	9.99	R	{Trailers}	2006-02-15 05:03:42
502	KNOCK WARLOCK	A Unbelieveable Story of a Teacher And a Boat who must Confront a Moose in A Baloon	2006	4	2.99	71	21.99	PG-13	{Trailers}	2006-02-15 05:03:42
503	KRAMER CHOCOLATE	A Amazing Yarn of a Robot And a Pastry Chef who must Redeem a Mad Scientist in The Outback	2006	3	2.99	171	24.99	R	{Trailers}	2006-02-15 05:03:42
504	KWAI HOMEWARD	A Amazing Drama of a Car And a Squirrel who must Pursue a Car in Soviet Georgia	2006	5	0.99	46	25.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
505	LABYRINTH LEAGUE	A Awe-Inspiring Saga of a Composer And a Frisbee who must Succumb a Pioneer in The Sahara Desert	2006	6	2.99	46	24.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
506	LADY STAGE	A Beautiful Character Study of a Woman And a Man who must Pursue a Explorer in A U-Boat	2006	4	4.99	67	14.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
507	LADYBUGS ARMAGEDDON	A Fateful Reflection of a Dog And a Mad Scientist who must Meet a Mad Scientist in New Orleans	2006	4	0.99	113	13.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
508	LAMBS CINCINATTI	A Insightful Story of a Man And a Feminist who must Fight a Composer in Australia	2006	6	4.99	144	18.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
509	LANGUAGE COWBOY	A Epic Yarn of a Cat And a Madman who must Vanquish a Dentist in An Abandoned Amusement Park	2006	5	0.99	78	26.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
510	LAWLESS VISION	A Insightful Yarn of a Boy And a Sumo Wrestler who must Outgun a Car in The Outback	2006	6	4.99	181	29.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
511	LAWRENCE LOVE	A Fanciful Yarn of a Database Administrator And a Mad Cow who must Pursue a Womanizer in Berlin	2006	7	0.99	175	23.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
512	LEAGUE HELLFIGHTERS	A Thoughtful Saga of a A Shark And a Monkey who must Outgun a Student in Ancient China	2006	5	4.99	110	25.99	PG-13	{Trailers}	2006-02-15 05:03:42
513	LEATHERNECKS DWARFS	A Fateful Reflection of a Dog And a Mad Cow who must Outrace a Teacher in An Abandoned Mine Shaft	2006	6	2.99	153	21.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
514	LEBOWSKI SOLDIERS	A Beautiful Epistle of a Secret Agent And a Pioneer who must Chase a Astronaut in Ancient China	2006	6	2.99	69	17.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
515	LEGALLY SECRETARY	A Astounding Tale of a A Shark And a Moose who must Meet a Womanizer in The Sahara Desert	2006	7	4.99	113	14.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
516	LEGEND JEDI	A Awe-Inspiring Epistle of a Pioneer And a Student who must Outgun a Crocodile in The Outback	2006	7	0.99	59	18.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
517	LESSON CLEOPATRA	A Emotional Display of a Man And a Explorer who must Build a Boy in A Manhattan Penthouse	2006	3	0.99	167	28.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
518	LIAISONS SWEET	A Boring Drama of a A Shark And a Explorer who must Redeem a Waitress in The Canadian Rockies	2006	5	4.99	140	15.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
519	LIBERTY MAGNIFICENT	A Boring Drama of a Student And a Cat who must Sink a Technical Writer in A Baloon	2006	3	2.99	138	27.99	G	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
520	LICENSE WEEKEND	A Insightful Story of a Man And a Husband who must Overcome a Madman in A Monastery	2006	7	2.99	91	28.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
521	LIES TREATMENT	A Fast-Paced Character Study of a Dentist And a Moose who must Defeat a Composer in The First Manned Space Station	2006	7	4.99	147	28.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
522	LIFE TWISTED	A Thrilling Reflection of a Teacher And a Composer who must Find a Man in The First Manned Space Station	2006	4	2.99	137	9.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
523	LIGHTS DEER	A Unbelieveable Epistle of a Dog And a Woman who must Confront a Moose in The Gulf of Mexico	2006	7	0.99	174	21.99	R	{Commentaries}	2006-02-15 05:03:42
524	LION UNCUT	A Intrepid Display of a Pastry Chef And a Cat who must Kill a A Shark in Ancient China	2006	6	0.99	50	13.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
525	LOATHING LEGALLY	A Boring Epistle of a Pioneer And a Mad Scientist who must Escape a Frisbee in The Gulf of Mexico	2006	4	0.99	140	29.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
526	LOCK REAR	A Thoughtful Character Study of a Squirrel And a Technical Writer who must Outrace a Student in Ancient Japan	2006	7	2.99	120	10.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
527	LOLA AGENT	A Astounding Tale of a Mad Scientist And a Husband who must Redeem a Database Administrator in Ancient Japan	2006	4	4.99	85	24.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
528	LOLITA WORLD	A Thrilling Drama of a Girl And a Robot who must Redeem a Waitress in An Abandoned Mine Shaft	2006	4	2.99	155	25.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
529	LONELY ELEPHANT	A Intrepid Story of a Student And a Dog who must Challenge a Explorer in Soviet Georgia	2006	3	2.99	67	12.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
530	LORD ARIZONA	A Action-Packed Display of a Frisbee And a Pastry Chef who must Pursue a Crocodile in A Jet Boat	2006	5	2.99	108	27.99	PG-13	{Trailers}	2006-02-15 05:03:42
531	LOSE INCH	A Stunning Reflection of a Student And a Technical Writer who must Battle a Butler in The First Manned Space Station	2006	3	0.99	137	18.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
532	LOSER HUSTLER	A Stunning Drama of a Robot And a Feminist who must Outgun a Butler in Nigeria	2006	5	4.99	80	28.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
533	LOST BIRD	A Emotional Character Study of a Robot And a A Shark who must Defeat a Technical Writer in A Manhattan Penthouse	2006	4	2.99	98	21.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
534	LOUISIANA HARRY	A Lacklusture Drama of a Girl And a Technical Writer who must Redeem a Monkey in A Shark Tank	2006	5	0.99	70	18.99	PG-13	{Trailers}	2006-02-15 05:03:42
535	LOVE SUICIDES	A Brilliant Panorama of a Hunter And a Explorer who must Pursue a Dentist in An Abandoned Fun House	2006	6	0.99	181	21.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
536	LOVELY JINGLE	A Fanciful Yarn of a Crocodile And a Forensic Psychologist who must Discover a Crocodile in The Outback	2006	3	2.99	65	18.99	PG	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
537	LOVER TRUMAN	A Emotional Yarn of a Robot And a Boy who must Outgun a Technical Writer in A U-Boat	2006	3	2.99	75	29.99	G	{Trailers}	2006-02-15 05:03:42
538	LOVERBOY ATTACKS	A Boring Story of a Car And a Butler who must Build a Girl in Soviet Georgia	2006	7	0.99	162	19.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
539	LUCK OPUS	A Boring Display of a Moose And a Squirrel who must Outrace a Teacher in A Shark Tank	2006	7	2.99	152	21.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
540	LUCKY FLYING	A Lacklusture Character Study of a A Shark And a Man who must Find a Forensic Psychologist in A U-Boat	2006	7	2.99	97	10.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
541	LUKE MUMMY	A Taut Character Study of a Boy And a Robot who must Redeem a Mad Scientist in Ancient India	2006	5	2.99	74	21.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
542	LUST LOCK	A Fanciful Panorama of a Hunter And a Dentist who must Meet a Secret Agent in The Sahara Desert	2006	3	2.99	52	28.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
543	MADIGAN DORADO	A Astounding Character Study of a A Shark And a A Shark who must Discover a Crocodile in The Outback	2006	5	4.99	116	20.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
544	MADISON TRAP	A Awe-Inspiring Reflection of a Monkey And a Dentist who must Overcome a Pioneer in A U-Boat	2006	4	2.99	147	11.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
545	MADNESS ATTACKS	A Fanciful Tale of a Squirrel And a Boat who must Defeat a Crocodile in The Gulf of Mexico	2006	4	0.99	178	14.99	PG-13	{Trailers}	2006-02-15 05:03:42
546	MADRE GABLES	A Intrepid Panorama of a Sumo Wrestler And a Forensic Psychologist who must Discover a Moose in The First Manned Space Station	2006	7	2.99	98	27.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
547	MAGIC MALLRATS	A Touching Documentary of a Pastry Chef And a Pastry Chef who must Build a Mad Scientist in California	2006	3	0.99	117	19.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
548	MAGNIFICENT CHITTY	A Insightful Story of a Teacher And a Hunter who must Face a Mad Cow in California	2006	3	2.99	53	27.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
549	MAGNOLIA FORRESTER	A Thoughtful Documentary of a Composer And a Explorer who must Conquer a Dentist in New Orleans	2006	4	0.99	171	28.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
550	MAGUIRE APACHE	A Fast-Paced Reflection of a Waitress And a Hunter who must Defeat a Forensic Psychologist in A Baloon	2006	6	2.99	74	22.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
551	MAIDEN HOME	A Lacklusture Saga of a Moose And a Teacher who must Kill a Forensic Psychologist in A MySQL Convention	2006	3	4.99	138	9.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
552	MAJESTIC FLOATS	A Thrilling Character Study of a Moose And a Student who must Escape a Butler in The First Manned Space Station	2006	5	0.99	130	15.99	PG	{Trailers}	2006-02-15 05:03:42
553	MAKER GABLES	A Stunning Display of a Moose And a Database Administrator who must Pursue a Composer in A Jet Boat	2006	4	0.99	136	12.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
554	MALKOVICH PET	A Intrepid Reflection of a Waitress And a A Shark who must Kill a Squirrel in The Outback	2006	6	2.99	159	22.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
555	MALLRATS UNITED	A Thrilling Yarn of a Waitress And a Dentist who must Find a Hunter in A Monastery	2006	4	0.99	133	25.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
556	MALTESE HOPE	A Fast-Paced Documentary of a Crocodile And a Sumo Wrestler who must Conquer a Explorer in California	2006	6	4.99	127	26.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
557	MANCHURIAN CURTAIN	A Stunning Tale of a Mad Cow And a Boy who must Battle a Boy in Berlin	2006	5	2.99	177	27.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
558	MANNEQUIN WORST	A Astounding Saga of a Mad Cow And a Pastry Chef who must Discover a Husband in Ancient India	2006	3	2.99	71	18.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
559	MARRIED GO	A Fanciful Story of a Womanizer And a Dog who must Face a Forensic Psychologist in The Sahara Desert	2006	7	2.99	114	22.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
560	MARS ROMAN	A Boring Drama of a Car And a Dog who must Succumb a Madman in Soviet Georgia	2006	6	0.99	62	21.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
561	MASK PEACH	A Boring Character Study of a Student And a Robot who must Meet a Woman in California	2006	6	2.99	123	26.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
562	MASKED BUBBLE	A Fanciful Documentary of a Pioneer And a Boat who must Pursue a Pioneer in An Abandoned Mine Shaft	2006	6	0.99	151	12.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
563	MASSACRE USUAL	A Fateful Reflection of a Waitress And a Crocodile who must Challenge a Forensic Psychologist in California	2006	6	4.99	165	16.99	R	{Commentaries}	2006-02-15 05:03:42
564	MASSAGE IMAGE	A Fateful Drama of a Frisbee And a Crocodile who must Vanquish a Dog in The First Manned Space Station	2006	4	2.99	161	11.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
565	MATRIX SNOWMAN	A Action-Packed Saga of a Womanizer And a Woman who must Overcome a Student in California	2006	6	4.99	56	9.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
566	MAUDE MOD	A Beautiful Documentary of a Forensic Psychologist And a Cat who must Reach a Astronaut in Nigeria	2006	6	0.99	72	20.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
567	MEET CHOCOLATE	A Boring Documentary of a Dentist And a Butler who must Confront a Monkey in A MySQL Convention	2006	3	2.99	80	26.99	G	{Trailers}	2006-02-15 05:03:42
568	MEMENTO ZOOLANDER	A Touching Epistle of a Squirrel And a Explorer who must Redeem a Pastry Chef in The Sahara Desert	2006	4	4.99	77	11.99	NC-17	{"Behind the Scenes"}	2006-02-15 05:03:42
569	MENAGERIE RUSHMORE	A Unbelieveable Panorama of a Composer And a Butler who must Overcome a Database Administrator in The First Manned Space Station	2006	7	2.99	147	18.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
570	MERMAID INSECTS	A Lacklusture Drama of a Waitress And a Husband who must Fight a Husband in California	2006	5	4.99	104	20.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
571	METAL ARMAGEDDON	A Thrilling Display of a Lumberjack And a Crocodile who must Meet a Monkey in A Baloon Factory	2006	6	2.99	161	26.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
572	METROPOLIS COMA	A Emotional Saga of a Database Administrator And a Pastry Chef who must Confront a Teacher in A Baloon Factory	2006	4	2.99	64	9.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
573	MICROCOSMOS PARADISE	A Touching Character Study of a Boat And a Student who must Sink a A Shark in Nigeria	2006	6	2.99	105	22.99	PG-13	{Commentaries}	2006-02-15 05:03:42
574	MIDNIGHT WESTWARD	A Taut Reflection of a Husband And a A Shark who must Redeem a Pastry Chef in A Monastery	2006	3	0.99	86	19.99	G	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
575	MIDSUMMER GROUNDHOG	A Fateful Panorama of a Moose And a Dog who must Chase a Crocodile in Ancient Japan	2006	3	4.99	48	27.99	G	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
576	MIGHTY LUCK	A Astounding Epistle of a Mad Scientist And a Pioneer who must Escape a Database Administrator in A MySQL Convention	2006	7	2.99	122	13.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
577	MILE MULAN	A Lacklusture Epistle of a Cat And a Husband who must Confront a Boy in A MySQL Convention	2006	4	0.99	64	10.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
578	MILLION ACE	A Brilliant Documentary of a Womanizer And a Squirrel who must Find a Technical Writer in The Sahara Desert	2006	4	4.99	142	16.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
579	MINDS TRUMAN	A Taut Yarn of a Mad Scientist And a Crocodile who must Outgun a Database Administrator in A Monastery	2006	3	4.99	149	22.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
580	MINE TITANS	A Amazing Yarn of a Robot And a Womanizer who must Discover a Forensic Psychologist in Berlin	2006	3	4.99	166	12.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
581	MINORITY KISS	A Insightful Display of a Lumberjack And a Sumo Wrestler who must Meet a Man in The Outback	2006	4	0.99	59	16.99	G	{Trailers}	2006-02-15 05:03:42
582	MIRACLE VIRTUAL	A Touching Epistle of a Butler And a Boy who must Find a Mad Scientist in The Sahara Desert	2006	3	2.99	162	19.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
583	MISSION ZOOLANDER	A Intrepid Story of a Sumo Wrestler And a Teacher who must Meet a A Shark in An Abandoned Fun House	2006	3	4.99	164	26.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
584	MIXED DOORS	A Taut Drama of a Womanizer And a Lumberjack who must Succumb a Pioneer in Ancient India	2006	6	2.99	180	26.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
585	MOB DUFFEL	A Unbelieveable Documentary of a Frisbee And a Boat who must Meet a Boy in The Canadian Rockies	2006	4	0.99	105	25.99	G	{Trailers}	2006-02-15 05:03:42
586	MOCKINGBIRD HOLLYWOOD	A Thoughtful Panorama of a Man And a Car who must Sink a Composer in Berlin	2006	4	0.99	60	27.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
587	MOD SECRETARY	A Boring Documentary of a Mad Cow And a Cat who must Build a Lumberjack in New Orleans	2006	6	4.99	77	20.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
588	MODEL FISH	A Beautiful Panorama of a Boat And a Crocodile who must Outrace a Dog in Australia	2006	4	4.99	175	11.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
589	MODERN DORADO	A Awe-Inspiring Story of a Butler And a Sumo Wrestler who must Redeem a Boy in New Orleans	2006	3	0.99	74	20.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
590	MONEY HAROLD	A Touching Tale of a Explorer And a Boat who must Defeat a Robot in Australia	2006	3	2.99	135	17.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
591	MONSOON CAUSE	A Astounding Tale of a Crocodile And a Car who must Outrace a Squirrel in A U-Boat	2006	6	4.99	182	20.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
592	MONSTER SPARTACUS	A Fast-Paced Story of a Waitress And a Cat who must Fight a Girl in Australia	2006	6	2.99	107	28.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
593	MONTEREY LABYRINTH	A Awe-Inspiring Drama of a Monkey And a Composer who must Escape a Feminist in A U-Boat	2006	6	0.99	158	13.99	G	{Trailers,Commentaries}	2006-02-15 05:03:42
594	MONTEZUMA COMMAND	A Thrilling Reflection of a Waitress And a Butler who must Battle a Butler in A Jet Boat	2006	6	0.99	126	22.99	NC-17	{Trailers}	2006-02-15 05:03:42
595	MOON BUNCH	A Beautiful Tale of a Astronaut And a Mad Cow who must Challenge a Cat in A Baloon Factory	2006	7	0.99	83	20.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
596	MOONSHINE CABIN	A Thoughtful Display of a Astronaut And a Feminist who must Chase a Frisbee in A Jet Boat	2006	4	4.99	171	25.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
597	MOONWALKER FOOL	A Epic Drama of a Feminist And a Pioneer who must Sink a Composer in New Orleans	2006	5	4.99	184	12.99	G	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
598	MOSQUITO ARMAGEDDON	A Thoughtful Character Study of a Waitress And a Feminist who must Build a Teacher in Ancient Japan	2006	6	0.99	57	22.99	G	{Trailers}	2006-02-15 05:03:42
599	MOTHER OLEANDER	A Boring Tale of a Husband And a Boy who must Fight a Squirrel in Ancient China	2006	3	0.99	103	20.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
600	MOTIONS DETAILS	A Awe-Inspiring Reflection of a Dog And a Student who must Kill a Car in An Abandoned Fun House	2006	5	0.99	166	16.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
601	MOULIN WAKE	A Astounding Story of a Forensic Psychologist And a Cat who must Battle a Teacher in An Abandoned Mine Shaft	2006	4	0.99	79	20.99	PG-13	{Trailers}	2006-02-15 05:03:42
602	MOURNING PURPLE	A Lacklusture Display of a Waitress And a Lumberjack who must Chase a Pioneer in New Orleans	2006	5	0.99	146	14.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
603	MOVIE SHAKESPEARE	A Insightful Display of a Database Administrator And a Student who must Build a Hunter in Berlin	2006	6	4.99	53	27.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
604	MULAN MOON	A Emotional Saga of a Womanizer And a Pioneer who must Overcome a Dentist in A Baloon	2006	4	0.99	160	10.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
605	MULHOLLAND BEAST	A Awe-Inspiring Display of a Husband And a Squirrel who must Battle a Sumo Wrestler in A Jet Boat	2006	7	2.99	157	13.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
606	MUMMY CREATURES	A Fateful Character Study of a Crocodile And a Monkey who must Meet a Dentist in Australia	2006	3	0.99	160	15.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
607	MUPPET MILE	A Lacklusture Story of a Madman And a Teacher who must Kill a Frisbee in The Gulf of Mexico	2006	5	4.99	50	18.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
608	MURDER ANTITRUST	A Brilliant Yarn of a Car And a Database Administrator who must Escape a Boy in A MySQL Convention	2006	6	2.99	166	11.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
609	MUSCLE BRIGHT	A Stunning Panorama of a Sumo Wrestler And a Husband who must Redeem a Madman in Ancient India	2006	7	2.99	185	23.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
610	MUSIC BOONDOCK	A Thrilling Tale of a Butler And a Astronaut who must Battle a Explorer in The First Manned Space Station	2006	7	0.99	129	17.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
611	MUSKETEERS WAIT	A Touching Yarn of a Student And a Moose who must Fight a Mad Cow in Australia	2006	7	4.99	73	17.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
612	MUSSOLINI SPOILERS	A Thrilling Display of a Boat And a Monkey who must Meet a Composer in Ancient China	2006	6	2.99	180	10.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
613	MYSTIC TRUMAN	A Epic Yarn of a Teacher And a Hunter who must Outgun a Explorer in Soviet Georgia	2006	5	0.99	92	19.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
614	NAME DETECTIVE	A Touching Saga of a Sumo Wrestler And a Cat who must Pursue a Mad Scientist in Nigeria	2006	5	4.99	178	11.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
615	NASH CHOCOLAT	A Epic Reflection of a Monkey And a Mad Cow who must Kill a Forensic Psychologist in An Abandoned Mine Shaft	2006	6	2.99	180	21.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
616	NATIONAL STORY	A Taut Epistle of a Mad Scientist And a Girl who must Escape a Monkey in California	2006	4	2.99	92	19.99	NC-17	{Trailers}	2006-02-15 05:03:42
617	NATURAL STOCK	A Fast-Paced Story of a Sumo Wrestler And a Girl who must Defeat a Car in A Baloon Factory	2006	4	0.99	50	24.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
618	NECKLACE OUTBREAK	A Astounding Epistle of a Database Administrator And a Mad Scientist who must Pursue a Cat in California	2006	3	0.99	132	21.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
619	NEIGHBORS CHARADE	A Fanciful Reflection of a Crocodile And a Astronaut who must Outrace a Feminist in An Abandoned Amusement Park	2006	3	0.99	161	20.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
620	NEMO CAMPUS	A Lacklusture Reflection of a Monkey And a Squirrel who must Outrace a Womanizer in A Manhattan Penthouse	2006	5	2.99	131	23.99	NC-17	{Trailers}	2006-02-15 05:03:42
621	NETWORK PEAK	A Unbelieveable Reflection of a Butler And a Boat who must Outgun a Mad Scientist in California	2006	5	2.99	75	23.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
622	NEWSIES STORY	A Action-Packed Character Study of a Dog And a Lumberjack who must Outrace a Moose in The Gulf of Mexico	2006	4	0.99	159	25.99	G	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
623	NEWTON LABYRINTH	A Intrepid Character Study of a Moose And a Waitress who must Find a A Shark in Ancient India	2006	4	0.99	75	9.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
624	NIGHTMARE CHILL	A Brilliant Display of a Robot And a Butler who must Fight a Waitress in An Abandoned Mine Shaft	2006	3	4.99	149	25.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
625	NONE SPIKING	A Boring Reflection of a Secret Agent And a Astronaut who must Face a Composer in A Manhattan Penthouse	2006	3	0.99	83	18.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
626	NOON PAPI	A Unbelieveable Character Study of a Mad Scientist And a Astronaut who must Find a Pioneer in A Manhattan Penthouse	2006	5	2.99	57	12.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
627	NORTH TEQUILA	A Beautiful Character Study of a Mad Cow And a Robot who must Reach a Womanizer in New Orleans	2006	4	4.99	67	9.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
628	NORTHWEST POLISH	A Boring Character Study of a Boy And a A Shark who must Outrace a Womanizer in The Outback	2006	5	2.99	172	24.99	PG	{Trailers}	2006-02-15 05:03:42
629	NOTORIOUS REUNION	A Amazing Epistle of a Woman And a Squirrel who must Fight a Hunter in A Baloon	2006	7	0.99	128	9.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
630	NOTTING SPEAKEASY	A Thoughtful Display of a Butler And a Womanizer who must Find a Waitress in The Canadian Rockies	2006	7	0.99	48	19.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
631	NOVOCAINE FLIGHT	A Fanciful Display of a Student And a Teacher who must Outgun a Crocodile in Nigeria	2006	4	0.99	64	11.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
632	NUTS TIES	A Thoughtful Drama of a Explorer And a Womanizer who must Meet a Teacher in California	2006	5	4.99	145	10.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
633	OCTOBER SUBMARINE	A Taut Epistle of a Monkey And a Boy who must Confront a Husband in A Jet Boat	2006	6	4.99	54	10.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
634	ODDS BOOGIE	A Thrilling Yarn of a Feminist And a Madman who must Battle a Hunter in Berlin	2006	6	0.99	48	14.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
635	OKLAHOMA JUMANJI	A Thoughtful Drama of a Dentist And a Womanizer who must Meet a Husband in The Sahara Desert	2006	7	0.99	58	15.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
636	OLEANDER CLUE	A Boring Story of a Teacher And a Monkey who must Succumb a Forensic Psychologist in A Jet Boat	2006	5	0.99	161	12.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
637	OPEN AFRICAN	A Lacklusture Drama of a Secret Agent And a Explorer who must Discover a Car in A U-Boat	2006	7	4.99	131	16.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
638	OPERATION OPERATION	A Intrepid Character Study of a Man And a Frisbee who must Overcome a Madman in Ancient China	2006	7	2.99	156	23.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
639	OPPOSITE NECKLACE	A Fateful Epistle of a Crocodile And a Moose who must Kill a Explorer in Nigeria	2006	7	4.99	92	9.99	PG	{"Deleted Scenes"}	2006-02-15 05:03:42
640	OPUS ICE	A Fast-Paced Drama of a Hunter And a Boy who must Discover a Feminist in The Sahara Desert	2006	5	4.99	102	21.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
641	ORANGE GRAPES	A Astounding Documentary of a Butler And a Womanizer who must Face a Dog in A U-Boat	2006	4	0.99	76	21.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
642	ORDER BETRAYED	A Amazing Saga of a Dog And a A Shark who must Challenge a Cat in The Sahara Desert	2006	7	2.99	120	13.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
643	ORIENT CLOSER	A Astounding Epistle of a Technical Writer And a Teacher who must Fight a Squirrel in The Sahara Desert	2006	3	2.99	118	22.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
644	OSCAR GOLD	A Insightful Tale of a Database Administrator And a Dog who must Face a Madman in Soviet Georgia	2006	7	2.99	115	29.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
645	OTHERS SOUP	A Lacklusture Documentary of a Mad Cow And a Madman who must Sink a Moose in The Gulf of Mexico	2006	7	2.99	118	18.99	PG	{"Deleted Scenes"}	2006-02-15 05:03:42
646	OUTBREAK DIVINE	A Unbelieveable Yarn of a Database Administrator And a Woman who must Succumb a A Shark in A U-Boat	2006	6	0.99	169	12.99	NC-17	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
647	OUTFIELD MASSACRE	A Thoughtful Drama of a Husband And a Secret Agent who must Pursue a Database Administrator in Ancient India	2006	4	0.99	129	18.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
648	OUTLAW HANKY	A Thoughtful Story of a Astronaut And a Composer who must Conquer a Dog in The Sahara Desert	2006	7	4.99	148	17.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
649	OZ LIAISONS	A Epic Yarn of a Mad Scientist And a Cat who must Confront a Womanizer in A Baloon Factory	2006	4	2.99	85	14.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
650	PACIFIC AMISTAD	A Thrilling Yarn of a Dog And a Moose who must Kill a Pastry Chef in A Manhattan Penthouse	2006	3	0.99	144	27.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
651	PACKER MADIGAN	A Epic Display of a Sumo Wrestler And a Forensic Psychologist who must Build a Woman in An Abandoned Amusement Park	2006	3	0.99	84	20.99	PG-13	{Trailers}	2006-02-15 05:03:42
652	PAJAMA JAWBREAKER	A Emotional Drama of a Boy And a Technical Writer who must Redeem a Sumo Wrestler in California	2006	3	0.99	126	14.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
653	PANIC CLUB	A Fanciful Display of a Teacher And a Crocodile who must Succumb a Girl in A Baloon	2006	3	4.99	102	15.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
654	PANKY SUBMARINE	A Touching Documentary of a Dentist And a Sumo Wrestler who must Overcome a Boy in The Gulf of Mexico	2006	4	4.99	93	19.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
655	PANTHER REDS	A Brilliant Panorama of a Moose And a Man who must Reach a Teacher in The Gulf of Mexico	2006	5	4.99	109	22.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
656	PAPI NECKLACE	A Fanciful Display of a Car And a Monkey who must Escape a Squirrel in Ancient Japan	2006	3	0.99	128	9.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
657	PARADISE SABRINA	A Intrepid Yarn of a Car And a Moose who must Outrace a Crocodile in A Manhattan Penthouse	2006	5	2.99	48	12.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
658	PARIS WEEKEND	A Intrepid Story of a Squirrel And a Crocodile who must Defeat a Monkey in The Outback	2006	7	2.99	121	19.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
659	PARK CITIZEN	A Taut Epistle of a Sumo Wrestler And a Girl who must Face a Husband in Ancient Japan	2006	3	4.99	109	14.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
660	PARTY KNOCK	A Fateful Display of a Technical Writer And a Butler who must Battle a Sumo Wrestler in An Abandoned Mine Shaft	2006	7	2.99	107	11.99	PG	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
661	PAST SUICIDES	A Intrepid Tale of a Madman And a Astronaut who must Challenge a Hunter in A Monastery	2006	5	4.99	157	17.99	PG-13	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
662	PATHS CONTROL	A Astounding Documentary of a Butler And a Cat who must Find a Frisbee in Ancient China	2006	3	4.99	118	9.99	PG	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
663	PATIENT SISTER	A Emotional Epistle of a Squirrel And a Robot who must Confront a Lumberjack in Soviet Georgia	2006	7	0.99	99	29.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
664	PATRIOT ROMAN	A Taut Saga of a Robot And a Database Administrator who must Challenge a Astronaut in California	2006	6	2.99	65	12.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
665	PATTON INTERVIEW	A Thrilling Documentary of a Composer And a Secret Agent who must Succumb a Cat in Berlin	2006	4	2.99	175	22.99	PG	{Commentaries}	2006-02-15 05:03:42
666	PAYCHECK WAIT	A Awe-Inspiring Reflection of a Boy And a Man who must Discover a Moose in The Sahara Desert	2006	4	4.99	145	27.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
667	PEACH INNOCENT	A Action-Packed Drama of a Monkey And a Dentist who must Chase a Butler in Berlin	2006	3	2.99	160	20.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
668	PEAK FOREVER	A Insightful Reflection of a Boat And a Secret Agent who must Vanquish a Astronaut in An Abandoned Mine Shaft	2006	7	4.99	80	25.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
669	PEARL DESTINY	A Lacklusture Yarn of a Astronaut And a Pastry Chef who must Sink a Dog in A U-Boat	2006	3	2.99	74	10.99	NC-17	{Trailers}	2006-02-15 05:03:42
670	PELICAN COMFORTS	A Epic Documentary of a Boy And a Monkey who must Pursue a Astronaut in Berlin	2006	4	4.99	48	17.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
671	PERDITION FARGO	A Fast-Paced Story of a Car And a Cat who must Outgun a Hunter in Berlin	2006	7	4.99	99	27.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
672	PERFECT GROOVE	A Thrilling Yarn of a Dog And a Dog who must Build a Husband in A Baloon	2006	7	2.99	82	17.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
673	PERSONAL LADYBUGS	A Epic Saga of a Hunter And a Technical Writer who must Conquer a Cat in Ancient Japan	2006	3	0.99	118	19.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
674	PET HAUNTING	A Unbelieveable Reflection of a Explorer And a Boat who must Conquer a Woman in California	2006	3	0.99	99	11.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
675	PHANTOM GLORY	A Beautiful Documentary of a Astronaut And a Crocodile who must Discover a Madman in A Monastery	2006	6	2.99	60	17.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
676	PHILADELPHIA WIFE	A Taut Yarn of a Hunter And a Astronaut who must Conquer a Database Administrator in The Sahara Desert	2006	7	4.99	137	16.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
677	PIANIST OUTFIELD	A Intrepid Story of a Boy And a Technical Writer who must Pursue a Lumberjack in A Monastery	2006	6	0.99	136	25.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
678	PICKUP DRIVING	A Touching Documentary of a Husband And a Boat who must Meet a Pastry Chef in A Baloon Factory	2006	3	2.99	77	23.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
679	PILOT HOOSIERS	A Awe-Inspiring Reflection of a Crocodile And a Sumo Wrestler who must Meet a Forensic Psychologist in An Abandoned Mine Shaft	2006	6	2.99	50	17.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
680	PINOCCHIO SIMON	A Action-Packed Reflection of a Mad Scientist And a A Shark who must Find a Feminist in California	2006	4	4.99	103	21.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
681	PIRATES ROXANNE	A Stunning Drama of a Woman And a Lumberjack who must Overcome a A Shark in The Canadian Rockies	2006	4	0.99	100	20.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
682	PITTSBURGH HUNCHBACK	A Thrilling Epistle of a Boy And a Boat who must Find a Student in Soviet Georgia	2006	4	4.99	134	17.99	PG-13	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
683	PITY BOUND	A Boring Panorama of a Feminist And a Moose who must Defeat a Database Administrator in Nigeria	2006	5	4.99	60	19.99	NC-17	{Commentaries}	2006-02-15 05:03:42
684	PIZZA JUMANJI	A Epic Saga of a Cat And a Squirrel who must Outgun a Robot in A U-Boat	2006	4	2.99	173	11.99	NC-17	{Commentaries}	2006-02-15 05:03:42
685	PLATOON INSTINCT	A Thrilling Panorama of a Man And a Woman who must Reach a Woman in Australia	2006	6	4.99	132	10.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
686	PLUTO OLEANDER	A Action-Packed Reflection of a Car And a Moose who must Outgun a Car in A Shark Tank	2006	5	4.99	84	9.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
687	POCUS PULP	A Intrepid Yarn of a Frisbee And a Dog who must Build a Astronaut in A Baloon Factory	2006	6	0.99	138	15.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
688	POLISH BROOKLYN	A Boring Character Study of a Database Administrator And a Lumberjack who must Reach a Madman in The Outback	2006	6	0.99	61	12.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
689	POLLOCK DELIVERANCE	A Intrepid Story of a Madman And a Frisbee who must Outgun a Boat in The Sahara Desert	2006	5	2.99	137	14.99	PG	{Commentaries}	2006-02-15 05:03:42
690	POND SEATTLE	A Stunning Drama of a Teacher And a Boat who must Battle a Feminist in Ancient China	2006	7	2.99	185	25.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
691	POSEIDON FOREVER	A Thoughtful Epistle of a Womanizer And a Monkey who must Vanquish a Dentist in A Monastery	2006	6	4.99	159	29.99	PG-13	{Commentaries}	2006-02-15 05:03:42
692	POTLUCK MIXED	A Beautiful Story of a Dog And a Technical Writer who must Outgun a Student in A Baloon	2006	3	2.99	179	10.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
693	POTTER CONNECTICUT	A Thrilling Epistle of a Frisbee And a Cat who must Fight a Technical Writer in Berlin	2006	5	2.99	115	16.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
694	PREJUDICE OLEANDER	A Epic Saga of a Boy And a Dentist who must Outrace a Madman in A U-Boat	2006	6	4.99	98	15.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
695	PRESIDENT BANG	A Fateful Panorama of a Technical Writer And a Moose who must Battle a Robot in Soviet Georgia	2006	6	4.99	144	12.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
696	PRIDE ALAMO	A Thoughtful Drama of a A Shark And a Forensic Psychologist who must Vanquish a Student in Ancient India	2006	6	0.99	114	20.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
697	PRIMARY GLASS	A Fateful Documentary of a Pastry Chef And a Butler who must Build a Dog in The Canadian Rockies	2006	7	0.99	53	16.99	G	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
698	PRINCESS GIANT	A Thrilling Yarn of a Pastry Chef And a Monkey who must Battle a Monkey in A Shark Tank	2006	3	2.99	71	29.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
699	PRIVATE DROP	A Stunning Story of a Technical Writer And a Hunter who must Succumb a Secret Agent in A Baloon	2006	7	4.99	106	26.99	PG	{Trailers}	2006-02-15 05:03:42
700	PRIX UNDEFEATED	A Stunning Saga of a Mad Scientist And a Boat who must Overcome a Dentist in Ancient China	2006	4	2.99	115	13.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
701	PSYCHO SHRUNK	A Amazing Panorama of a Crocodile And a Explorer who must Fight a Husband in Nigeria	2006	5	2.99	155	11.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
702	PULP BEVERLY	A Unbelieveable Display of a Dog And a Crocodile who must Outrace a Man in Nigeria	2006	4	2.99	89	12.99	G	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
703	PUNK DIVORCE	A Fast-Paced Tale of a Pastry Chef And a Boat who must Face a Frisbee in The Canadian Rockies	2006	6	4.99	100	18.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
704	PURE RUNNER	A Thoughtful Documentary of a Student And a Madman who must Challenge a Squirrel in A Manhattan Penthouse	2006	3	2.99	121	25.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
705	PURPLE MOVIE	A Boring Display of a Pastry Chef And a Sumo Wrestler who must Discover a Frisbee in An Abandoned Amusement Park	2006	4	2.99	88	9.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
706	QUEEN LUKE	A Astounding Story of a Girl And a Boy who must Challenge a Composer in New Orleans	2006	5	4.99	163	22.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
707	QUEST MUSSOLINI	A Fateful Drama of a Husband And a Sumo Wrestler who must Battle a Pastry Chef in A Baloon Factory	2006	5	2.99	177	29.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
708	QUILLS BULL	A Thoughtful Story of a Pioneer And a Woman who must Reach a Moose in Australia	2006	4	4.99	112	19.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
709	RACER EGG	A Emotional Display of a Monkey And a Waitress who must Reach a Secret Agent in California	2006	7	2.99	147	19.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
710	RAGE GAMES	A Fast-Paced Saga of a Astronaut And a Secret Agent who must Escape a Hunter in An Abandoned Amusement Park	2006	4	4.99	120	18.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
711	RAGING AIRPLANE	A Astounding Display of a Secret Agent And a Technical Writer who must Escape a Mad Scientist in A Jet Boat	2006	4	4.99	154	18.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
712	RAIDERS ANTITRUST	A Amazing Drama of a Teacher And a Feminist who must Meet a Woman in The First Manned Space Station	2006	4	0.99	82	11.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
713	RAINBOW SHOCK	A Action-Packed Story of a Hunter And a Boy who must Discover a Lumberjack in Ancient India	2006	3	4.99	74	14.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
714	RANDOM GO	A Fateful Drama of a Frisbee And a Student who must Confront a Cat in A Shark Tank	2006	6	2.99	73	29.99	NC-17	{Trailers}	2006-02-15 05:03:42
715	RANGE MOONWALKER	A Insightful Documentary of a Hunter And a Dentist who must Confront a Crocodile in A Baloon	2006	3	4.99	147	25.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
716	REAP UNFAITHFUL	A Thrilling Epistle of a Composer And a Sumo Wrestler who must Challenge a Mad Cow in A MySQL Convention	2006	6	2.99	136	26.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
717	REAR TRADING	A Awe-Inspiring Reflection of a Forensic Psychologist And a Secret Agent who must Succumb a Pastry Chef in Soviet Georgia	2006	6	0.99	97	23.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
718	REBEL AIRPORT	A Intrepid Yarn of a Database Administrator And a Boat who must Outrace a Husband in Ancient India	2006	7	0.99	73	24.99	G	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
719	RECORDS ZORRO	A Amazing Drama of a Mad Scientist And a Composer who must Build a Husband in The Outback	2006	7	4.99	182	11.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
720	REDEMPTION COMFORTS	A Emotional Documentary of a Dentist And a Woman who must Battle a Mad Scientist in Ancient China	2006	3	2.99	179	20.99	NC-17	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
721	REDS POCUS	A Lacklusture Yarn of a Sumo Wrestler And a Squirrel who must Redeem a Monkey in Soviet Georgia	2006	7	4.99	182	23.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
722	REEF SALUTE	A Action-Packed Saga of a Teacher And a Lumberjack who must Battle a Dentist in A Baloon	2006	5	0.99	123	26.99	NC-17	{"Behind the Scenes"}	2006-02-15 05:03:42
723	REIGN GENTLEMEN	A Emotional Yarn of a Composer And a Man who must Escape a Butler in The Gulf of Mexico	2006	3	2.99	82	29.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
724	REMEMBER DIARY	A Insightful Tale of a Technical Writer And a Waitress who must Conquer a Monkey in Ancient India	2006	5	2.99	110	15.99	R	{Trailers,Commentaries}	2006-02-15 05:03:42
725	REQUIEM TYCOON	A Unbelieveable Character Study of a Cat And a Database Administrator who must Pursue a Teacher in A Monastery	2006	6	4.99	167	25.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
726	RESERVOIR ADAPTATION	A Intrepid Drama of a Teacher And a Moose who must Kill a Car in California	2006	7	2.99	61	29.99	PG-13	{Commentaries}	2006-02-15 05:03:42
727	RESURRECTION SILVERADO	A Epic Yarn of a Robot And a Explorer who must Challenge a Girl in A MySQL Convention	2006	6	0.99	117	12.99	PG	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
728	REUNION WITCHES	A Unbelieveable Documentary of a Database Administrator And a Frisbee who must Redeem a Mad Scientist in A Baloon Factory	2006	3	0.99	63	26.99	R	{Commentaries}	2006-02-15 05:03:42
729	RIDER CADDYSHACK	A Taut Reflection of a Monkey And a Womanizer who must Chase a Moose in Nigeria	2006	5	2.99	177	28.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
730	RIDGEMONT SUBMARINE	A Unbelieveable Drama of a Waitress And a Composer who must Sink a Mad Cow in Ancient Japan	2006	3	0.99	46	28.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
731	RIGHT CRANES	A Fateful Character Study of a Boat And a Cat who must Find a Database Administrator in A Jet Boat	2006	7	4.99	153	29.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
732	RINGS HEARTBREAKERS	A Amazing Yarn of a Sumo Wrestler And a Boat who must Conquer a Waitress in New Orleans	2006	5	0.99	58	17.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
733	RIVER OUTLAW	A Thrilling Character Study of a Squirrel And a Lumberjack who must Face a Hunter in A MySQL Convention	2006	4	0.99	149	29.99	PG-13	{Commentaries}	2006-02-15 05:03:42
734	ROAD ROXANNE	A Boring Character Study of a Waitress And a Astronaut who must Fight a Crocodile in Ancient Japan	2006	4	4.99	158	12.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
735	ROBBERS JOON	A Thoughtful Story of a Mad Scientist And a Waitress who must Confront a Forensic Psychologist in Soviet Georgia	2006	7	2.99	102	26.99	PG-13	{Commentaries}	2006-02-15 05:03:42
736	ROBBERY BRIGHT	A Taut Reflection of a Robot And a Squirrel who must Fight a Boat in Ancient Japan	2006	4	0.99	134	21.99	R	{Trailers}	2006-02-15 05:03:42
737	ROCK INSTINCT	A Astounding Character Study of a Robot And a Moose who must Overcome a Astronaut in Ancient India	2006	4	0.99	102	28.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
738	ROCKETEER MOTHER	A Awe-Inspiring Character Study of a Robot And a Sumo Wrestler who must Discover a Womanizer in A Shark Tank	2006	3	0.99	178	27.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
739	ROCKY WAR	A Fast-Paced Display of a Squirrel And a Explorer who must Outgun a Mad Scientist in Nigeria	2006	4	4.99	145	17.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
740	ROLLERCOASTER BRINGING	A Beautiful Drama of a Robot And a Lumberjack who must Discover a Technical Writer in A Shark Tank	2006	5	2.99	153	13.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
741	ROMAN PUNK	A Thoughtful Panorama of a Mad Cow And a Student who must Battle a Forensic Psychologist in Berlin	2006	7	0.99	81	28.99	NC-17	{Trailers}	2006-02-15 05:03:42
742	ROOF CHAMPION	A Lacklusture Reflection of a Car And a Explorer who must Find a Monkey in A Baloon	2006	7	0.99	101	25.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
743	ROOM ROMAN	A Awe-Inspiring Panorama of a Composer And a Secret Agent who must Sink a Composer in A Shark Tank	2006	7	0.99	60	27.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
744	ROOTS REMEMBER	A Brilliant Drama of a Mad Cow And a Hunter who must Escape a Hunter in Berlin	2006	4	0.99	89	23.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
745	ROSES TREASURE	A Astounding Panorama of a Monkey And a Secret Agent who must Defeat a Woman in The First Manned Space Station	2006	5	4.99	162	23.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
746	ROUGE SQUAD	A Awe-Inspiring Drama of a Astronaut And a Frisbee who must Conquer a Mad Scientist in Australia	2006	3	0.99	118	10.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
747	ROXANNE REBEL	A Astounding Story of a Pastry Chef And a Database Administrator who must Fight a Man in The Outback	2006	5	0.99	171	9.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
748	RUGRATS SHAKESPEARE	A Touching Saga of a Crocodile And a Crocodile who must Discover a Technical Writer in Nigeria	2006	4	0.99	109	16.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
749	RULES HUMAN	A Beautiful Epistle of a Astronaut And a Student who must Confront a Monkey in An Abandoned Fun House	2006	6	4.99	153	19.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
750	RUN PACIFIC	A Touching Tale of a Cat And a Pastry Chef who must Conquer a Pastry Chef in A MySQL Convention	2006	3	0.99	145	25.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
751	RUNAWAY TENENBAUMS	A Thoughtful Documentary of a Boat And a Man who must Meet a Boat in An Abandoned Fun House	2006	6	0.99	181	17.99	NC-17	{Commentaries}	2006-02-15 05:03:42
752	RUNNER MADIGAN	A Thoughtful Documentary of a Crocodile And a Robot who must Outrace a Womanizer in The Outback	2006	6	0.99	101	27.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
753	RUSH GOODFELLAS	A Emotional Display of a Man And a Dentist who must Challenge a Squirrel in Australia	2006	3	0.99	48	20.99	PG	{"Deleted Scenes"}	2006-02-15 05:03:42
754	RUSHMORE MERMAID	A Boring Story of a Woman And a Moose who must Reach a Husband in A Shark Tank	2006	6	2.99	150	17.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
755	SABRINA MIDNIGHT	A Emotional Story of a Squirrel And a Crocodile who must Succumb a Husband in The Sahara Desert	2006	5	4.99	99	11.99	PG	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
756	SADDLE ANTITRUST	A Stunning Epistle of a Feminist And a A Shark who must Battle a Woman in An Abandoned Fun House	2006	7	2.99	80	10.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
757	SAGEBRUSH CLUELESS	A Insightful Story of a Lumberjack And a Hunter who must Kill a Boy in Ancient Japan	2006	4	2.99	106	28.99	G	{Trailers}	2006-02-15 05:03:42
758	SAINTS BRIDE	A Fateful Tale of a Technical Writer And a Composer who must Pursue a Explorer in The Gulf of Mexico	2006	5	2.99	125	11.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
759	SALUTE APOLLO	A Awe-Inspiring Character Study of a Boy And a Feminist who must Sink a Crocodile in Ancient China	2006	4	2.99	73	29.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
760	SAMURAI LION	A Fast-Paced Story of a Pioneer And a Astronaut who must Reach a Boat in A Baloon	2006	5	2.99	110	21.99	G	{Commentaries}	2006-02-15 05:03:42
761	SANTA PARIS	A Emotional Documentary of a Moose And a Car who must Redeem a Mad Cow in A Baloon Factory	2006	7	2.99	154	23.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
762	SASSY PACKER	A Fast-Paced Documentary of a Dog And a Teacher who must Find a Moose in A Manhattan Penthouse	2006	6	0.99	154	29.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
763	SATISFACTION CONFIDENTIAL	A Lacklusture Yarn of a Dentist And a Butler who must Meet a Secret Agent in Ancient China	2006	3	4.99	75	26.99	G	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
764	SATURDAY LAMBS	A Thoughtful Reflection of a Mad Scientist And a Moose who must Kill a Husband in A Baloon	2006	3	4.99	150	28.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
765	SATURN NAME	A Fateful Epistle of a Butler And a Boy who must Redeem a Teacher in Berlin	2006	7	4.99	182	18.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
766	SAVANNAH TOWN	A Awe-Inspiring Tale of a Astronaut And a Database Administrator who must Chase a Secret Agent in The Gulf of Mexico	2006	5	0.99	84	25.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
767	SCALAWAG DUCK	A Fateful Reflection of a Car And a Teacher who must Confront a Waitress in A Monastery	2006	6	4.99	183	13.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
768	SCARFACE BANG	A Emotional Yarn of a Teacher And a Girl who must Find a Teacher in A Baloon Factory	2006	3	4.99	102	11.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
769	SCHOOL JACKET	A Intrepid Yarn of a Monkey And a Boy who must Fight a Composer in A Manhattan Penthouse	2006	5	4.99	151	21.99	PG-13	{Trailers}	2006-02-15 05:03:42
770	SCISSORHANDS SLUMS	A Awe-Inspiring Drama of a Girl And a Technical Writer who must Meet a Feminist in The Canadian Rockies	2006	5	2.99	147	13.99	G	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
771	SCORPION APOLLO	A Awe-Inspiring Documentary of a Technical Writer And a Husband who must Meet a Monkey in An Abandoned Fun House	2006	3	4.99	137	23.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
772	SEA VIRGIN	A Fast-Paced Documentary of a Technical Writer And a Pastry Chef who must Escape a Moose in A U-Boat	2006	4	2.99	80	24.99	PG	{"Deleted Scenes"}	2006-02-15 05:03:42
773	SEABISCUIT PUNK	A Insightful Saga of a Man And a Forensic Psychologist who must Discover a Mad Cow in A MySQL Convention	2006	6	2.99	112	28.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
774	SEARCHERS WAIT	A Fast-Paced Tale of a Car And a Mad Scientist who must Kill a Womanizer in Ancient Japan	2006	3	2.99	182	22.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
775	SEATTLE EXPECATIONS	A Insightful Reflection of a Crocodile And a Sumo Wrestler who must Meet a Technical Writer in The Sahara Desert	2006	4	4.99	110	18.99	PG-13	{Trailers}	2006-02-15 05:03:42
776	SECRET GROUNDHOG	A Astounding Story of a Cat And a Database Administrator who must Build a Technical Writer in New Orleans	2006	6	4.99	90	11.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
777	SECRETARY ROUGE	A Action-Packed Panorama of a Mad Cow And a Composer who must Discover a Robot in A Baloon Factory	2006	5	4.99	158	10.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
778	SECRETS PARADISE	A Fateful Saga of a Cat And a Frisbee who must Kill a Girl in A Manhattan Penthouse	2006	3	4.99	109	24.99	G	{Trailers,Commentaries}	2006-02-15 05:03:42
779	SENSE GREEK	A Taut Saga of a Lumberjack And a Pastry Chef who must Escape a Sumo Wrestler in An Abandoned Fun House	2006	4	4.99	54	23.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
780	SENSIBILITY REAR	A Emotional Tale of a Robot And a Sumo Wrestler who must Redeem a Pastry Chef in A Baloon Factory	2006	7	4.99	98	15.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
781	SEVEN SWARM	A Unbelieveable Character Study of a Dog And a Mad Cow who must Kill a Monkey in Berlin	2006	4	4.99	127	15.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
782	SHAKESPEARE SADDLE	A Fast-Paced Panorama of a Lumberjack And a Database Administrator who must Defeat a Madman in A MySQL Convention	2006	6	2.99	60	26.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
783	SHANE DARKNESS	A Action-Packed Saga of a Moose And a Lumberjack who must Find a Woman in Berlin	2006	5	2.99	93	22.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
784	SHANGHAI TYCOON	A Fast-Paced Character Study of a Crocodile And a Lumberjack who must Build a Husband in An Abandoned Fun House	2006	7	2.99	47	20.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
785	SHAWSHANK BUBBLE	A Lacklusture Story of a Moose And a Monkey who must Confront a Butler in An Abandoned Amusement Park	2006	6	4.99	80	20.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
786	SHEPHERD MIDSUMMER	A Thoughtful Drama of a Robot And a Womanizer who must Kill a Lumberjack in A Baloon	2006	7	0.99	113	14.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
787	SHINING ROSES	A Awe-Inspiring Character Study of a Astronaut And a Forensic Psychologist who must Challenge a Madman in Ancient India	2006	4	0.99	125	12.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
788	SHIP WONDERLAND	A Thrilling Saga of a Monkey And a Frisbee who must Escape a Explorer in The Outback	2006	5	2.99	104	15.99	R	{Commentaries}	2006-02-15 05:03:42
789	SHOCK CABIN	A Fateful Tale of a Mad Cow And a Crocodile who must Meet a Husband in New Orleans	2006	7	2.99	79	15.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
790	SHOOTIST SUPERFLY	A Fast-Paced Story of a Crocodile And a A Shark who must Sink a Pioneer in Berlin	2006	6	0.99	67	22.99	PG-13	{Trailers}	2006-02-15 05:03:42
791	SHOW LORD	A Fanciful Saga of a Student And a Girl who must Find a Butler in Ancient Japan	2006	3	4.99	167	24.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
792	SHREK LICENSE	A Fateful Yarn of a Secret Agent And a Feminist who must Find a Feminist in A Jet Boat	2006	7	2.99	154	15.99	PG-13	{Commentaries}	2006-02-15 05:03:42
793	SHRUNK DIVINE	A Fateful Character Study of a Waitress And a Technical Writer who must Battle a Hunter in A Baloon	2006	6	2.99	139	14.99	R	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
794	SIDE ARK	A Stunning Panorama of a Crocodile And a Womanizer who must Meet a Feminist in The Canadian Rockies	2006	5	0.99	52	28.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
795	SIEGE MADRE	A Boring Tale of a Frisbee And a Crocodile who must Vanquish a Moose in An Abandoned Mine Shaft	2006	7	0.99	111	23.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
796	SIERRA DIVIDE	A Emotional Character Study of a Frisbee And a Mad Scientist who must Build a Madman in California	2006	3	0.99	135	12.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
797	SILENCE KANE	A Emotional Drama of a Sumo Wrestler And a Dentist who must Confront a Sumo Wrestler in A Baloon	2006	7	0.99	67	23.99	R	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
798	SILVERADO GOLDFINGER	A Stunning Epistle of a Sumo Wrestler And a Man who must Challenge a Waitress in Ancient India	2006	4	4.99	74	11.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
799	SIMON NORTH	A Thrilling Documentary of a Technical Writer And a A Shark who must Face a Pioneer in A Shark Tank	2006	3	0.99	51	26.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
800	SINNERS ATLANTIS	A Epic Display of a Dog And a Boat who must Succumb a Mad Scientist in An Abandoned Mine Shaft	2006	7	2.99	126	19.99	PG-13	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
801	SISTER FREDDY	A Stunning Saga of a Butler And a Woman who must Pursue a Explorer in Australia	2006	5	4.99	152	19.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
802	SKY MIRACLE	A Epic Drama of a Mad Scientist And a Explorer who must Succumb a Waitress in An Abandoned Fun House	2006	7	2.99	132	15.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
803	SLACKER LIAISONS	A Fast-Paced Tale of a A Shark And a Student who must Meet a Crocodile in Ancient China	2006	7	4.99	179	29.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
804	SLEEPING SUSPECTS	A Stunning Reflection of a Sumo Wrestler And a Explorer who must Sink a Frisbee in A MySQL Convention	2006	7	4.99	129	13.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
805	SLEEPLESS MONSOON	A Amazing Saga of a Moose And a Pastry Chef who must Escape a Butler in Australia	2006	5	4.99	64	12.99	G	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
806	SLEEPY JAPANESE	A Emotional Epistle of a Moose And a Composer who must Fight a Technical Writer in The Outback	2006	4	2.99	137	25.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
807	SLEUTH ORIENT	A Fateful Character Study of a Husband And a Dog who must Find a Feminist in Ancient India	2006	4	0.99	87	25.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
808	SLING LUKE	A Intrepid Character Study of a Robot And a Monkey who must Reach a Secret Agent in An Abandoned Amusement Park	2006	5	0.99	84	10.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
809	SLIPPER FIDELITY	A Taut Reflection of a Secret Agent And a Man who must Redeem a Explorer in A MySQL Convention	2006	5	0.99	156	14.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
810	SLUMS DUCK	A Amazing Character Study of a Teacher And a Database Administrator who must Defeat a Waitress in A Jet Boat	2006	5	0.99	147	21.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
811	SMILE EARRING	A Intrepid Drama of a Teacher And a Butler who must Build a Pastry Chef in Berlin	2006	4	2.99	60	29.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
812	SMOKING BARBARELLA	A Lacklusture Saga of a Mad Cow And a Mad Scientist who must Sink a Cat in A MySQL Convention	2006	7	0.99	50	13.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
813	SMOOCHY CONTROL	A Thrilling Documentary of a Husband And a Feminist who must Face a Mad Scientist in Ancient China	2006	7	0.99	184	18.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
814	SNATCH SLIPPER	A Insightful Panorama of a Woman And a Feminist who must Defeat a Forensic Psychologist in Berlin	2006	6	4.99	110	15.99	PG	{Commentaries}	2006-02-15 05:03:42
815	SNATCHERS MONTEZUMA	A Boring Epistle of a Sumo Wrestler And a Woman who must Escape a Man in The Canadian Rockies	2006	4	2.99	74	14.99	PG-13	{Commentaries}	2006-02-15 05:03:42
816	SNOWMAN ROLLERCOASTER	A Fateful Display of a Lumberjack And a Girl who must Succumb a Mad Cow in A Manhattan Penthouse	2006	3	0.99	62	27.99	G	{Trailers}	2006-02-15 05:03:42
817	SOLDIERS EVOLUTION	A Lacklusture Panorama of a A Shark And a Pioneer who must Confront a Student in The First Manned Space Station	2006	7	4.99	185	27.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
818	SOMETHING DUCK	A Boring Character Study of a Car And a Husband who must Outgun a Frisbee in The First Manned Space Station	2006	4	4.99	180	17.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
819	SONG HEDWIG	A Amazing Documentary of a Man And a Husband who must Confront a Squirrel in A MySQL Convention	2006	3	0.99	165	29.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
820	SONS INTERVIEW	A Taut Character Study of a Explorer And a Mad Cow who must Battle a Hunter in Ancient China	2006	3	2.99	184	11.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
821	SORORITY QUEEN	A Fast-Paced Display of a Squirrel And a Composer who must Fight a Forensic Psychologist in A Jet Boat	2006	6	0.99	184	17.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
822	SOUP WISDOM	A Fast-Paced Display of a Robot And a Butler who must Defeat a Butler in A MySQL Convention	2006	6	0.99	169	12.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
823	SOUTH WAIT	A Amazing Documentary of a Car And a Robot who must Escape a Lumberjack in An Abandoned Amusement Park	2006	4	2.99	143	21.99	R	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
824	SPARTACUS CHEAPER	A Thrilling Panorama of a Pastry Chef And a Secret Agent who must Overcome a Student in A Manhattan Penthouse	2006	4	4.99	52	19.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
825	SPEAKEASY DATE	A Lacklusture Drama of a Forensic Psychologist And a Car who must Redeem a Man in A Manhattan Penthouse	2006	6	2.99	165	22.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
826	SPEED SUIT	A Brilliant Display of a Frisbee And a Mad Scientist who must Succumb a Robot in Ancient China	2006	7	4.99	124	19.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
827	SPICE SORORITY	A Fateful Display of a Pioneer And a Hunter who must Defeat a Husband in An Abandoned Mine Shaft	2006	5	4.99	141	22.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
828	SPIKING ELEMENT	A Lacklusture Epistle of a Dentist And a Technical Writer who must Find a Dog in A Monastery	2006	7	2.99	79	12.99	G	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
829	SPINAL ROCKY	A Lacklusture Epistle of a Sumo Wrestler And a Squirrel who must Defeat a Explorer in California	2006	7	2.99	138	12.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
830	SPIRIT FLINTSTONES	A Brilliant Yarn of a Cat And a Car who must Confront a Explorer in Ancient Japan	2006	7	0.99	149	23.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
831	SPIRITED CASUALTIES	A Taut Story of a Waitress And a Man who must Face a Car in A Baloon Factory	2006	5	0.99	138	20.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
832	SPLASH GUMP	A Taut Saga of a Crocodile And a Boat who must Conquer a Hunter in A Shark Tank	2006	5	0.99	175	16.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
833	SPLENDOR PATTON	A Taut Story of a Dog And a Explorer who must Find a Astronaut in Berlin	2006	5	0.99	134	20.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
834	SPOILERS HELLFIGHTERS	A Fanciful Story of a Technical Writer And a Squirrel who must Defeat a Dog in The Gulf of Mexico	2006	4	0.99	151	26.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
835	SPY MILE	A Thrilling Documentary of a Feminist And a Feminist who must Confront a Feminist in A Baloon	2006	6	2.99	112	13.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
836	SQUAD FISH	A Fast-Paced Display of a Pastry Chef And a Dog who must Kill a Teacher in Berlin	2006	3	2.99	136	14.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
837	STAGE WORLD	A Lacklusture Panorama of a Woman And a Frisbee who must Chase a Crocodile in A Jet Boat	2006	4	2.99	85	19.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
838	STAGECOACH ARMAGEDDON	A Touching Display of a Pioneer And a Butler who must Chase a Car in California	2006	5	4.99	112	25.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
839	STALLION SUNDANCE	A Fast-Paced Tale of a Car And a Dog who must Outgun a A Shark in Australia	2006	5	0.99	130	23.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
840	STAMPEDE DISTURBING	A Unbelieveable Tale of a Woman And a Lumberjack who must Fight a Frisbee in A U-Boat	2006	5	0.99	75	26.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
841	STAR OPERATION	A Insightful Character Study of a Girl And a Car who must Pursue a Mad Cow in A Shark Tank	2006	5	2.99	181	9.99	PG	{Commentaries}	2006-02-15 05:03:42
842	STATE WASTELAND	A Beautiful Display of a Cat And a Pastry Chef who must Outrace a Mad Cow in A Jet Boat	2006	4	2.99	113	13.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
843	STEEL SANTA	A Fast-Paced Yarn of a Composer And a Frisbee who must Face a Moose in Nigeria	2006	4	4.99	143	15.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
844	STEERS ARMAGEDDON	A Stunning Character Study of a Car And a Girl who must Succumb a Car in A MySQL Convention	2006	6	4.99	140	16.99	PG	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
845	STEPMOM DREAM	A Touching Epistle of a Crocodile And a Teacher who must Build a Forensic Psychologist in A MySQL Convention	2006	7	4.99	48	9.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
846	STING PERSONAL	A Fanciful Drama of a Frisbee And a Dog who must Fight a Madman in A Jet Boat	2006	3	4.99	93	9.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
847	STOCK GLASS	A Boring Epistle of a Crocodile And a Lumberjack who must Outgun a Moose in Ancient China	2006	7	2.99	160	10.99	PG	{Commentaries}	2006-02-15 05:03:42
848	STONE FIRE	A Intrepid Drama of a Astronaut And a Crocodile who must Find a Boat in Soviet Georgia	2006	3	0.99	94	19.99	G	{Trailers}	2006-02-15 05:03:42
849	STORM HAPPINESS	A Insightful Drama of a Feminist And a A Shark who must Vanquish a Boat in A Shark Tank	2006	6	0.99	57	28.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
850	STORY SIDE	A Lacklusture Saga of a Boy And a Cat who must Sink a Dentist in An Abandoned Mine Shaft	2006	7	0.99	163	27.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
851	STRAIGHT HOURS	A Boring Panorama of a Secret Agent And a Girl who must Sink a Waitress in The Outback	2006	3	0.99	151	19.99	R	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
852	STRANGELOVE DESIRE	A Awe-Inspiring Panorama of a Lumberjack And a Waitress who must Defeat a Crocodile in An Abandoned Amusement Park	2006	4	0.99	103	27.99	NC-17	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
853	STRANGER STRANGERS	A Awe-Inspiring Yarn of a Womanizer And a Explorer who must Fight a Woman in The First Manned Space Station	2006	3	4.99	139	12.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
854	STRANGERS GRAFFITI	A Brilliant Character Study of a Secret Agent And a Man who must Find a Cat in The Gulf of Mexico	2006	4	4.99	119	22.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
855	STREAK RIDGEMONT	A Astounding Character Study of a Hunter And a Waitress who must Sink a Man in New Orleans	2006	7	0.99	132	28.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
856	STREETCAR INTENTIONS	A Insightful Character Study of a Waitress And a Crocodile who must Sink a Waitress in The Gulf of Mexico	2006	5	4.99	73	11.99	R	{Commentaries}	2006-02-15 05:03:42
857	STRICTLY SCARFACE	A Touching Reflection of a Crocodile And a Dog who must Chase a Hunter in An Abandoned Fun House	2006	3	2.99	144	24.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
858	SUBMARINE BED	A Amazing Display of a Car And a Monkey who must Fight a Teacher in Soviet Georgia	2006	5	4.99	127	21.99	R	{Trailers}	2006-02-15 05:03:42
859	SUGAR WONKA	A Touching Story of a Dentist And a Database Administrator who must Conquer a Astronaut in An Abandoned Amusement Park	2006	3	4.99	114	20.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
860	SUICIDES SILENCE	A Emotional Character Study of a Car And a Girl who must Face a Composer in A U-Boat	2006	4	4.99	93	13.99	G	{"Deleted Scenes"}	2006-02-15 05:03:42
861	SUIT WALLS	A Touching Panorama of a Lumberjack And a Frisbee who must Build a Dog in Australia	2006	3	4.99	111	12.99	R	{Commentaries}	2006-02-15 05:03:42
862	SUMMER SCARFACE	A Emotional Panorama of a Lumberjack And a Hunter who must Meet a Girl in A Shark Tank	2006	5	0.99	53	25.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
863	SUN CONFESSIONS	A Beautiful Display of a Mad Cow And a Dog who must Redeem a Waitress in An Abandoned Amusement Park	2006	5	0.99	141	9.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
864	SUNDANCE INVASION	A Epic Drama of a Lumberjack And a Explorer who must Confront a Hunter in A Baloon Factory	2006	5	0.99	92	21.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
865	SUNRISE LEAGUE	A Beautiful Epistle of a Madman And a Butler who must Face a Crocodile in A Manhattan Penthouse	2006	3	4.99	135	19.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
866	SUNSET RACER	A Awe-Inspiring Reflection of a Astronaut And a A Shark who must Defeat a Forensic Psychologist in California	2006	6	0.99	48	28.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
867	SUPER WYOMING	A Action-Packed Saga of a Pastry Chef And a Explorer who must Discover a A Shark in The Outback	2006	5	4.99	58	10.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
868	SUPERFLY TRIP	A Beautiful Saga of a Lumberjack And a Teacher who must Build a Technical Writer in An Abandoned Fun House	2006	5	0.99	114	27.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
869	SUSPECTS QUILLS	A Emotional Epistle of a Pioneer And a Crocodile who must Battle a Man in A Manhattan Penthouse	2006	4	2.99	47	22.99	PG	{Trailers}	2006-02-15 05:03:42
870	SWARM GOLD	A Insightful Panorama of a Crocodile And a Boat who must Conquer a Sumo Wrestler in A MySQL Convention	2006	4	0.99	123	12.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
871	SWEDEN SHINING	A Taut Documentary of a Car And a Robot who must Conquer a Boy in The Canadian Rockies	2006	6	4.99	176	19.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
872	SWEET BROTHERHOOD	A Unbelieveable Epistle of a Sumo Wrestler And a Hunter who must Chase a Forensic Psychologist in A Baloon	2006	3	2.99	185	27.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
873	SWEETHEARTS SUSPECTS	A Brilliant Character Study of a Frisbee And a Sumo Wrestler who must Confront a Woman in The Gulf of Mexico	2006	3	0.99	108	13.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
874	TADPOLE PARK	A Beautiful Tale of a Frisbee And a Moose who must Vanquish a Dog in An Abandoned Amusement Park	2006	6	2.99	155	13.99	PG	{Trailers,Commentaries}	2006-02-15 05:03:42
875	TALENTED HOMICIDE	A Lacklusture Panorama of a Dentist And a Forensic Psychologist who must Outrace a Pioneer in A U-Boat	2006	6	0.99	173	9.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
876	TARZAN VIDEOTAPE	A Fast-Paced Display of a Lumberjack And a Mad Scientist who must Succumb a Sumo Wrestler in The Sahara Desert	2006	3	2.99	91	11.99	PG-13	{Trailers}	2006-02-15 05:03:42
877	TAXI KICK	A Amazing Epistle of a Girl And a Woman who must Outrace a Waitress in Soviet Georgia	2006	4	0.99	64	23.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
878	TEEN APOLLO	A Awe-Inspiring Drama of a Dog And a Man who must Escape a Robot in A Shark Tank	2006	3	4.99	74	25.99	G	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
879	TELEGRAPH VOYAGE	A Fateful Yarn of a Husband And a Dog who must Battle a Waitress in A Jet Boat	2006	3	4.99	148	20.99	PG	{Commentaries}	2006-02-15 05:03:42
880	TELEMARK HEARTBREAKERS	A Action-Packed Panorama of a Technical Writer And a Man who must Build a Forensic Psychologist in A Manhattan Penthouse	2006	6	2.99	152	9.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
881	TEMPLE ATTRACTION	A Action-Packed Saga of a Forensic Psychologist And a Woman who must Battle a Womanizer in Soviet Georgia	2006	5	4.99	71	13.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
882	TENENBAUMS COMMAND	A Taut Display of a Pioneer And a Man who must Reach a Girl in The Gulf of Mexico	2006	4	0.99	99	24.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
883	TEQUILA PAST	A Action-Packed Panorama of a Mad Scientist And a Robot who must Challenge a Student in Nigeria	2006	6	4.99	53	17.99	PG	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
884	TERMINATOR CLUB	A Touching Story of a Crocodile And a Girl who must Sink a Man in The Gulf of Mexico	2006	5	4.99	88	11.99	R	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
885	TEXAS WATCH	A Awe-Inspiring Yarn of a Student And a Teacher who must Fight a Teacher in An Abandoned Amusement Park	2006	7	0.99	179	22.99	NC-17	{Trailers}	2006-02-15 05:03:42
886	THEORY MERMAID	A Fateful Yarn of a Composer And a Monkey who must Vanquish a Womanizer in The First Manned Space Station	2006	5	0.99	184	9.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
887	THIEF PELICAN	A Touching Documentary of a Madman And a Mad Scientist who must Outrace a Feminist in An Abandoned Mine Shaft	2006	5	4.99	135	28.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
888	THIN SAGEBRUSH	A Emotional Drama of a Husband And a Lumberjack who must Build a Cat in Ancient India	2006	5	4.99	53	9.99	PG-13	{"Behind the Scenes"}	2006-02-15 05:03:42
889	TIES HUNGER	A Insightful Saga of a Astronaut And a Explorer who must Pursue a Mad Scientist in A U-Boat	2006	3	4.99	111	28.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
890	TIGHTS DAWN	A Thrilling Epistle of a Boat And a Secret Agent who must Face a Boy in A Baloon	2006	5	0.99	172	14.99	R	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
891	TIMBERLAND SKY	A Boring Display of a Man And a Dog who must Redeem a Girl in A U-Boat	2006	3	0.99	69	13.99	G	{Commentaries}	2006-02-15 05:03:42
892	TITANIC BOONDOCK	A Brilliant Reflection of a Feminist And a Dog who must Fight a Boy in A Baloon Factory	2006	3	4.99	104	18.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
893	TITANS JERK	A Unbelieveable Panorama of a Feminist And a Sumo Wrestler who must Challenge a Technical Writer in Ancient China	2006	4	4.99	91	11.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
894	TOMATOES HELLFIGHTERS	A Thoughtful Epistle of a Madman And a Astronaut who must Overcome a Monkey in A Shark Tank	2006	6	0.99	68	23.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
895	TOMORROW HUSTLER	A Thoughtful Story of a Moose And a Husband who must Face a Secret Agent in The Sahara Desert	2006	3	2.99	142	21.99	R	{Commentaries}	2006-02-15 05:03:42
896	TOOTSIE PILOT	A Awe-Inspiring Documentary of a Womanizer And a Pastry Chef who must Kill a Lumberjack in Berlin	2006	3	0.99	157	10.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
897	TORQUE BOUND	A Emotional Display of a Crocodile And a Husband who must Reach a Man in Ancient Japan	2006	3	4.99	179	27.99	G	{Trailers,Commentaries}	2006-02-15 05:03:42
898	TOURIST PELICAN	A Boring Story of a Butler And a Astronaut who must Outrace a Pioneer in Australia	2006	4	4.99	152	18.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
899	TOWERS HURRICANE	A Fateful Display of a Monkey And a Car who must Sink a Husband in A MySQL Convention	2006	7	0.99	144	14.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
900	TOWN ARK	A Awe-Inspiring Documentary of a Moose And a Madman who must Meet a Dog in An Abandoned Mine Shaft	2006	6	2.99	136	17.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
901	TRACY CIDER	A Touching Reflection of a Database Administrator And a Madman who must Build a Lumberjack in Nigeria	2006	3	0.99	142	29.99	G	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
902	TRADING PINOCCHIO	A Emotional Character Study of a Student And a Explorer who must Discover a Frisbee in The First Manned Space Station	2006	6	4.99	170	22.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
903	TRAFFIC HOBBIT	A Amazing Epistle of a Squirrel And a Lumberjack who must Succumb a Database Administrator in A U-Boat	2006	5	4.99	139	13.99	G	{Trailers,Commentaries}	2006-02-15 05:03:42
904	TRAIN BUNCH	A Thrilling Character Study of a Robot And a Squirrel who must Face a Dog in Ancient India	2006	3	4.99	71	26.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
905	TRAINSPOTTING STRANGERS	A Fast-Paced Drama of a Pioneer And a Mad Cow who must Challenge a Madman in Ancient Japan	2006	7	4.99	132	10.99	PG-13	{Trailers}	2006-02-15 05:03:42
906	TRAMP OTHERS	A Brilliant Display of a Composer And a Cat who must Succumb a A Shark in Ancient India	2006	4	0.99	171	27.99	PG	{"Deleted Scenes"}	2006-02-15 05:03:42
907	TRANSLATION SUMMER	A Touching Reflection of a Man And a Monkey who must Pursue a Womanizer in A MySQL Convention	2006	4	0.99	168	10.99	PG-13	{Trailers}	2006-02-15 05:03:42
908	TRAP GUYS	A Unbelieveable Story of a Boy And a Mad Cow who must Challenge a Database Administrator in The Sahara Desert	2006	3	4.99	110	11.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
909	TREASURE COMMAND	A Emotional Saga of a Car And a Madman who must Discover a Pioneer in California	2006	3	0.99	102	28.99	PG-13	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
910	TREATMENT JEKYLL	A Boring Story of a Teacher And a Student who must Outgun a Cat in An Abandoned Mine Shaft	2006	3	0.99	87	19.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
911	TRIP NEWTON	A Fanciful Character Study of a Lumberjack And a Car who must Discover a Cat in An Abandoned Amusement Park	2006	7	4.99	64	14.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
912	TROJAN TOMORROW	A Astounding Panorama of a Husband And a Sumo Wrestler who must Pursue a Boat in Ancient India	2006	3	2.99	52	9.99	PG	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
913	TROOPERS METAL	A Fanciful Drama of a Monkey And a Feminist who must Sink a Man in Berlin	2006	3	0.99	115	20.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
914	TROUBLE DATE	A Lacklusture Panorama of a Forensic Psychologist And a Woman who must Kill a Explorer in Ancient Japan	2006	6	2.99	61	13.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
915	TRUMAN CRAZY	A Thrilling Epistle of a Moose And a Boy who must Meet a Database Administrator in A Monastery	2006	7	4.99	92	9.99	G	{Trailers,Commentaries}	2006-02-15 05:03:42
916	TURN STAR	A Stunning Tale of a Man And a Monkey who must Chase a Student in New Orleans	2006	3	2.99	80	10.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
917	TUXEDO MILE	A Boring Drama of a Man And a Forensic Psychologist who must Face a Frisbee in Ancient India	2006	3	2.99	152	24.99	R	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
918	TWISTED PIRATES	A Touching Display of a Frisbee And a Boat who must Kill a Girl in A MySQL Convention	2006	4	4.99	152	23.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
919	TYCOON GATHERING	A Emotional Display of a Husband And a A Shark who must Succumb a Madman in A Manhattan Penthouse	2006	3	4.99	82	17.99	G	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
920	UNBREAKABLE KARATE	A Amazing Character Study of a Robot And a Student who must Chase a Robot in Australia	2006	3	0.99	62	16.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
921	UNCUT SUICIDES	A Intrepid Yarn of a Explorer And a Pastry Chef who must Pursue a Mad Cow in A U-Boat	2006	7	2.99	172	29.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
922	UNDEFEATED DALMATIONS	A Unbelieveable Display of a Crocodile And a Feminist who must Overcome a Moose in An Abandoned Amusement Park	2006	7	4.99	107	22.99	PG-13	{Commentaries}	2006-02-15 05:03:42
923	UNFAITHFUL KILL	A Taut Documentary of a Waitress And a Mad Scientist who must Battle a Technical Writer in New Orleans	2006	7	2.99	78	12.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
924	UNFORGIVEN ZOOLANDER	A Taut Epistle of a Monkey And a Sumo Wrestler who must Vanquish a A Shark in A Baloon Factory	2006	7	0.99	129	15.99	PG	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
925	UNITED PILOT	A Fast-Paced Reflection of a Cat And a Mad Cow who must Fight a Car in The Sahara Desert	2006	3	0.99	164	27.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
926	UNTOUCHABLES SUNRISE	A Amazing Documentary of a Woman And a Astronaut who must Outrace a Teacher in An Abandoned Fun House	2006	5	2.99	120	11.99	NC-17	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
927	UPRISING UPTOWN	A Fanciful Reflection of a Boy And a Butler who must Pursue a Woman in Berlin	2006	6	2.99	174	16.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
928	UPTOWN YOUNG	A Fateful Documentary of a Dog And a Hunter who must Pursue a Teacher in An Abandoned Amusement Park	2006	5	2.99	84	16.99	PG	{Commentaries}	2006-02-15 05:03:42
929	USUAL UNTOUCHABLES	A Touching Display of a Explorer And a Lumberjack who must Fight a Forensic Psychologist in A Shark Tank	2006	5	4.99	128	21.99	PG-13	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
930	VACATION BOONDOCK	A Fanciful Character Study of a Secret Agent And a Mad Scientist who must Reach a Teacher in Australia	2006	4	2.99	145	23.99	R	{Commentaries}	2006-02-15 05:03:42
931	VALENTINE VANISHING	A Thrilling Display of a Husband And a Butler who must Reach a Pastry Chef in California	2006	7	0.99	48	9.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
932	VALLEY PACKER	A Astounding Documentary of a Astronaut And a Boy who must Outrace a Sumo Wrestler in Berlin	2006	3	0.99	73	21.99	G	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
933	VAMPIRE WHALE	A Epic Story of a Lumberjack And a Monkey who must Confront a Pioneer in A MySQL Convention	2006	4	4.99	126	11.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
934	VANILLA DAY	A Fast-Paced Saga of a Girl And a Forensic Psychologist who must Redeem a Girl in Nigeria	2006	7	4.99	122	20.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
935	VANISHED GARDEN	A Intrepid Character Study of a Squirrel And a A Shark who must Kill a Lumberjack in California	2006	5	0.99	142	17.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
936	VANISHING ROCKY	A Brilliant Reflection of a Man And a Woman who must Conquer a Pioneer in A MySQL Convention	2006	3	2.99	123	21.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
937	VARSITY TRIP	A Action-Packed Character Study of a Astronaut And a Explorer who must Reach a Monkey in A MySQL Convention	2006	7	2.99	85	14.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
938	VELVET TERMINATOR	A Lacklusture Tale of a Pastry Chef And a Technical Writer who must Confront a Crocodile in An Abandoned Amusement Park	2006	3	4.99	173	14.99	R	{"Behind the Scenes"}	2006-02-15 05:03:42
939	VERTIGO NORTHWEST	A Unbelieveable Display of a Mad Scientist And a Mad Scientist who must Outgun a Mad Cow in Ancient Japan	2006	4	2.99	90	17.99	R	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
940	VICTORY ACADEMY	A Insightful Epistle of a Mad Scientist And a Explorer who must Challenge a Cat in The Sahara Desert	2006	6	0.99	64	19.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
941	VIDEOTAPE ARSENIC	A Lacklusture Display of a Girl And a Astronaut who must Succumb a Student in Australia	2006	4	4.99	145	10.99	NC-17	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
942	VIETNAM SMOOCHY	A Lacklusture Display of a Butler And a Man who must Sink a Explorer in Soviet Georgia	2006	7	0.99	174	27.99	PG-13	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
943	VILLAIN DESPERATE	A Boring Yarn of a Pioneer And a Feminist who must Redeem a Cat in An Abandoned Amusement Park	2006	4	4.99	76	27.99	PG-13	{Trailers,Commentaries}	2006-02-15 05:03:42
944	VIRGIN DAISY	A Awe-Inspiring Documentary of a Robot And a Mad Scientist who must Reach a Database Administrator in A Shark Tank	2006	6	4.99	179	29.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
945	VIRGINIAN PLUTO	A Emotional Panorama of a Dentist And a Crocodile who must Meet a Boy in Berlin	2006	5	0.99	164	22.99	R	{"Deleted Scenes"}	2006-02-15 05:03:42
946	VIRTUAL SPOILERS	A Fateful Tale of a Database Administrator And a Squirrel who must Discover a Student in Soviet Georgia	2006	3	4.99	144	14.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
947	VISION TORQUE	A Thoughtful Documentary of a Dog And a Man who must Sink a Man in A Shark Tank	2006	5	0.99	59	16.99	PG-13	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
948	VOICE PEACH	A Amazing Panorama of a Pioneer And a Student who must Overcome a Mad Scientist in A Manhattan Penthouse	2006	6	0.99	139	22.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
949	VOLCANO TEXAS	A Awe-Inspiring Yarn of a Hunter And a Feminist who must Challenge a Dentist in The Outback	2006	6	0.99	157	27.99	NC-17	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
950	VOLUME HOUSE	A Boring Tale of a Dog And a Woman who must Meet a Dentist in California	2006	7	4.99	132	12.99	PG	{Commentaries}	2006-02-15 05:03:42
951	VOYAGE LEGALLY	A Epic Tale of a Squirrel And a Hunter who must Conquer a Boy in An Abandoned Mine Shaft	2006	6	0.99	78	28.99	PG-13	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
952	WAGON JAWS	A Intrepid Drama of a Moose And a Boat who must Kill a Explorer in A Manhattan Penthouse	2006	7	2.99	152	17.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
953	WAIT CIDER	A Intrepid Epistle of a Woman And a Forensic Psychologist who must Succumb a Astronaut in A Manhattan Penthouse	2006	3	0.99	112	9.99	PG-13	{Trailers}	2006-02-15 05:03:42
954	WAKE JAWS	A Beautiful Saga of a Feminist And a Composer who must Challenge a Moose in Berlin	2006	7	4.99	73	18.99	G	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
955	WALLS ARTIST	A Insightful Panorama of a Teacher And a Teacher who must Overcome a Mad Cow in An Abandoned Fun House	2006	7	4.99	135	19.99	PG	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
956	WANDA CHAMBER	A Insightful Drama of a A Shark And a Pioneer who must Find a Womanizer in The Outback	2006	7	4.99	107	23.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
957	WAR NOTTING	A Boring Drama of a Teacher And a Sumo Wrestler who must Challenge a Secret Agent in The Canadian Rockies	2006	7	4.99	80	26.99	G	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
958	WARDROBE PHANTOM	A Action-Packed Display of a Mad Cow And a Astronaut who must Kill a Car in Ancient India	2006	6	2.99	178	19.99	G	{Trailers,Commentaries}	2006-02-15 05:03:42
959	WARLOCK WEREWOLF	A Astounding Yarn of a Pioneer And a Crocodile who must Defeat a A Shark in The Outback	2006	6	2.99	83	10.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
960	WARS PLUTO	A Taut Reflection of a Teacher And a Database Administrator who must Chase a Madman in The Sahara Desert	2006	5	2.99	128	15.99	G	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
961	WASH HEAVENLY	A Awe-Inspiring Reflection of a Cat And a Pioneer who must Escape a Hunter in Ancient China	2006	7	4.99	161	22.99	R	{Commentaries}	2006-02-15 05:03:42
962	WASTELAND DIVINE	A Fanciful Story of a Database Administrator And a Womanizer who must Fight a Database Administrator in Ancient China	2006	7	2.99	85	18.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
963	WATCH TRACY	A Fast-Paced Yarn of a Dog And a Frisbee who must Conquer a Hunter in Nigeria	2006	5	0.99	78	12.99	PG	{Trailers,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
964	WATERFRONT DELIVERANCE	A Unbelieveable Documentary of a Dentist And a Technical Writer who must Build a Womanizer in Nigeria	2006	4	4.99	61	17.99	G	{"Behind the Scenes"}	2006-02-15 05:03:42
965	WATERSHIP FRONTIER	A Emotional Yarn of a Boat And a Crocodile who must Meet a Moose in Soviet Georgia	2006	6	0.99	112	28.99	G	{Commentaries}	2006-02-15 05:03:42
966	WEDDING APOLLO	A Action-Packed Tale of a Student And a Waitress who must Conquer a Lumberjack in An Abandoned Mine Shaft	2006	3	0.99	70	14.99	PG	{Trailers}	2006-02-15 05:03:42
967	WEEKEND PERSONAL	A Fast-Paced Documentary of a Car And a Butler who must Find a Frisbee in A Jet Boat	2006	5	2.99	134	26.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
968	WEREWOLF LOLA	A Fanciful Story of a Man And a Sumo Wrestler who must Outrace a Student in A Monastery	2006	6	4.99	79	19.99	G	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
969	WEST LION	A Intrepid Drama of a Butler And a Lumberjack who must Challenge a Database Administrator in A Manhattan Penthouse	2006	4	4.99	159	29.99	G	{Trailers}	2006-02-15 05:03:42
970	WESTWARD SEABISCUIT	A Lacklusture Tale of a Butler And a Husband who must Face a Boy in Ancient China	2006	7	0.99	52	11.99	NC-17	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
971	WHALE BIKINI	A Intrepid Story of a Pastry Chef And a Database Administrator who must Kill a Feminist in A MySQL Convention	2006	4	4.99	109	11.99	PG-13	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
972	WHISPERER GIANT	A Intrepid Story of a Dentist And a Hunter who must Confront a Monkey in Ancient Japan	2006	4	4.99	59	24.99	PG-13	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
973	WIFE TURN	A Awe-Inspiring Epistle of a Teacher And a Feminist who must Confront a Pioneer in Ancient Japan	2006	3	4.99	183	27.99	NC-17	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
974	WILD APOLLO	A Beautiful Story of a Monkey And a Sumo Wrestler who must Conquer a A Shark in A MySQL Convention	2006	4	0.99	181	24.99	R	{Trailers,Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
975	WILLOW TRACY	A Brilliant Panorama of a Boat And a Astronaut who must Challenge a Teacher in A Manhattan Penthouse	2006	6	2.99	137	22.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
976	WIND PHANTOM	A Touching Saga of a Madman And a Forensic Psychologist who must Build a Sumo Wrestler in An Abandoned Mine Shaft	2006	6	0.99	111	12.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
977	WINDOW SIDE	A Astounding Character Study of a Womanizer And a Hunter who must Escape a Robot in A Monastery	2006	3	2.99	85	25.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
978	WISDOM WORKER	A Unbelieveable Saga of a Forensic Psychologist And a Student who must Face a Squirrel in The First Manned Space Station	2006	3	0.99	98	12.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
979	WITCHES PANIC	A Awe-Inspiring Drama of a Secret Agent And a Hunter who must Fight a Moose in Nigeria	2006	6	4.99	100	10.99	NC-17	{Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
980	WIZARD COLDBLOODED	A Lacklusture Display of a Robot And a Girl who must Defeat a Sumo Wrestler in A MySQL Convention	2006	4	4.99	75	12.99	PG	{Commentaries,"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
981	WOLVES DESIRE	A Fast-Paced Drama of a Squirrel And a Robot who must Succumb a Technical Writer in A Manhattan Penthouse	2006	7	0.99	55	13.99	NC-17	{"Behind the Scenes"}	2006-02-15 05:03:42
982	WOMEN DORADO	A Insightful Documentary of a Waitress And a Butler who must Vanquish a Composer in Australia	2006	4	0.99	126	23.99	R	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
983	WON DARES	A Unbelieveable Documentary of a Teacher And a Monkey who must Defeat a Explorer in A U-Boat	2006	7	2.99	105	18.99	PG	{"Behind the Scenes"}	2006-02-15 05:03:42
984	WONDERFUL DROP	A Boring Panorama of a Woman And a Madman who must Overcome a Butler in A U-Boat	2006	3	2.99	126	20.99	NC-17	{Commentaries}	2006-02-15 05:03:42
985	WONDERLAND CHRISTMAS	A Awe-Inspiring Character Study of a Waitress And a Car who must Pursue a Mad Scientist in The First Manned Space Station	2006	4	4.99	111	19.99	PG	{Commentaries}	2006-02-15 05:03:42
986	WONKA SEA	A Brilliant Saga of a Boat And a Mad Scientist who must Meet a Moose in Ancient India	2006	6	2.99	85	24.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
987	WORDS HUNTER	A Action-Packed Reflection of a Composer And a Mad Scientist who must Face a Pioneer in A MySQL Convention	2006	3	2.99	116	13.99	PG	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
988	WORKER TARZAN	A Action-Packed Yarn of a Secret Agent And a Technical Writer who must Battle a Sumo Wrestler in The First Manned Space Station	2006	7	2.99	139	26.99	R	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
989	WORKING MICROCOSMOS	A Stunning Epistle of a Dentist And a Dog who must Kill a Madman in Ancient China	2006	4	4.99	74	22.99	R	{Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
990	WORLD LEATHERNECKS	A Unbelieveable Tale of a Pioneer And a Astronaut who must Overcome a Robot in An Abandoned Amusement Park	2006	3	0.99	171	13.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
991	WORST BANGER	A Thrilling Drama of a Madman And a Dentist who must Conquer a Boy in The Outback	2006	4	2.99	185	26.99	PG	{"Deleted Scenes","Behind the Scenes"}	2006-02-15 05:03:42
992	WRATH MILE	A Intrepid Reflection of a Technical Writer And a Hunter who must Defeat a Sumo Wrestler in A Monastery	2006	5	0.99	176	17.99	NC-17	{Trailers,Commentaries}	2006-02-15 05:03:42
993	WRONG BEHAVIOR	A Emotional Saga of a Crocodile And a Sumo Wrestler who must Discover a Mad Cow in New Orleans	2006	6	2.99	178	10.99	PG-13	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
994	WYOMING STORM	A Awe-Inspiring Panorama of a Robot And a Boat who must Overcome a Feminist in A U-Boat	2006	6	4.99	100	29.99	PG-13	{"Deleted Scenes"}	2006-02-15 05:03:42
995	YENTL IDAHO	A Amazing Display of a Robot And a Astronaut who must Fight a Womanizer in Berlin	2006	5	4.99	86	11.99	R	{Trailers,Commentaries,"Deleted Scenes"}	2006-02-15 05:03:42
996	YOUNG LANGUAGE	A Unbelieveable Yarn of a Boat And a Database Administrator who must Meet a Boy in The First Manned Space Station	2006	6	0.99	183	9.99	G	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
997	YOUTH KICK	A Touching Drama of a Teacher And a Cat who must Challenge a Technical Writer in A U-Boat	2006	4	0.99	179	14.99	NC-17	{Trailers,"Behind the Scenes"}	2006-02-15 05:03:42
998	ZHIVAGO CORE	A Fateful Yarn of a Composer And a Man who must Face a Boy in The Canadian Rockies	2006	6	0.99	105	10.99	NC-17	{"Deleted Scenes"}	2006-02-15 05:03:42
999	ZOOLANDER FICTION	A Fateful Reflection of a Waitress And a Boat who must Discover a Sumo Wrestler in Ancient China	2006	5	2.99	101	28.99	R	{Trailers,"Deleted Scenes"}	2006-02-15 05:03:42
1000	ZORRO ARK	A Intrepid Panorama of a Mad Scientist And a Boy who must Redeem a Boy in A Monastery	2006	3	4.99	50	18.99	NC-17	{Trailers,Commentaries,"Behind the Scenes"}	2006-02-15 05:03:42
\.


--
-- Data for Name: film_actor; Type: TABLE DATA; Schema: public; Owner: root
--

COPY film_actor (actor_id, film_id, priority) FROM stdin;
1	1	0
1	23	0
1	25	0
1	106	0
1	140	0
1	166	0
1	277	0
1	361	0
1	438	0
1	499	0
1	506	0
1	509	0
1	605	0
1	635	0
1	749	0
1	832	0
1	939	0
1	970	0
1	980	0
2	3	0
2	31	0
2	47	0
2	105	0
2	132	0
2	145	0
2	226	0
2	249	0
2	314	0
2	321	0
2	357	0
2	369	0
2	399	0
2	458	0
2	481	0
2	485	0
2	518	0
2	540	0
2	550	0
2	555	0
2	561	0
2	742	0
2	754	0
2	811	0
2	958	0
3	17	0
3	40	0
3	42	0
3	87	0
3	111	0
3	185	0
3	289	0
3	329	0
3	336	0
3	341	0
3	393	0
3	441	0
3	453	0
3	480	0
3	539	0
3	618	0
3	685	0
3	827	0
3	966	0
3	967	0
3	971	0
3	996	0
4	23	0
4	25	0
4	56	0
4	62	0
4	79	0
4	87	0
4	355	0
4	379	0
4	398	0
4	463	0
4	490	0
4	616	0
4	635	0
4	691	0
4	712	0
4	714	0
4	721	0
4	798	0
4	832	0
4	858	0
4	909	0
4	924	0
5	19	0
5	54	0
5	85	0
5	146	0
5	171	0
5	172	0
5	202	0
5	203	0
5	286	0
5	288	0
5	316	0
5	340	0
5	369	0
5	375	0
5	383	0
5	392	0
5	411	0
5	503	0
5	535	0
5	571	0
5	650	0
5	665	0
5	687	0
5	730	0
5	732	0
5	811	0
5	817	0
5	841	0
5	865	0
6	29	0
6	53	0
6	60	0
6	70	0
6	112	0
6	164	0
6	165	0
6	193	0
6	256	0
6	451	0
6	503	0
6	509	0
6	517	0
6	519	0
6	605	0
6	692	0
6	826	0
6	892	0
6	902	0
6	994	0
7	25	0
7	27	0
7	35	0
7	67	0
7	96	0
7	170	0
7	173	0
7	217	0
7	218	0
7	225	0
7	292	0
7	351	0
7	414	0
7	463	0
7	554	0
7	618	0
7	633	0
7	637	0
7	691	0
7	758	0
7	766	0
7	770	0
7	805	0
7	806	0
7	846	0
7	900	0
7	901	0
7	910	0
7	957	0
7	959	0
8	47	0
8	115	0
8	158	0
8	179	0
8	195	0
8	205	0
8	255	0
8	263	0
8	321	0
8	396	0
8	458	0
8	523	0
8	532	0
8	554	0
8	752	0
8	769	0
8	771	0
8	859	0
8	895	0
8	936	0
9	30	0
9	74	0
9	147	0
9	148	0
9	191	0
9	200	0
9	204	0
9	434	0
9	510	0
9	514	0
9	552	0
9	650	0
9	671	0
9	697	0
9	722	0
9	752	0
9	811	0
9	815	0
9	865	0
9	873	0
9	889	0
9	903	0
9	926	0
9	964	0
9	974	0
10	1	8
10	9	0
10	191	0
10	236	0
10	251	0
10	366	0
10	477	0
10	480	0
10	522	0
10	530	0
10	587	0
10	694	0
10	703	0
10	716	0
10	782	0
10	914	0
10	929	0
10	930	0
10	964	0
10	966	0
10	980	0
10	983	0
11	118	0
11	205	0
11	281	0
11	283	0
11	348	0
11	364	0
11	395	0
11	429	0
11	433	0
11	453	0
11	485	0
11	532	0
11	567	0
11	587	0
11	597	0
11	636	0
11	709	0
11	850	0
11	854	0
11	888	0
11	896	0
11	928	0
11	938	0
11	969	0
11	988	0
12	16	0
12	17	0
12	34	0
12	37	0
12	91	0
12	92	0
12	107	0
12	155	0
12	177	0
12	208	0
12	213	0
12	216	0
12	243	0
12	344	0
12	400	0
12	416	0
12	420	0
12	457	0
12	513	0
12	540	0
12	593	0
12	631	0
12	635	0
12	672	0
12	716	0
12	728	0
12	812	0
12	838	0
12	871	0
12	880	0
12	945	0
13	17	0
13	29	0
13	45	0
13	87	0
13	110	0
13	144	0
13	154	0
13	162	0
13	203	0
13	254	0
13	337	0
13	346	0
13	381	0
13	385	0
13	427	0
13	456	0
13	513	0
13	515	0
13	522	0
13	524	0
13	528	0
13	571	0
13	588	0
13	597	0
13	600	0
13	718	0
13	729	0
13	816	0
13	817	0
13	832	0
13	833	0
13	843	0
13	897	0
13	966	0
13	998	0
14	154	0
14	187	0
14	232	0
14	241	0
14	253	0
14	255	0
14	258	0
14	284	0
14	292	0
14	370	0
14	415	0
14	417	0
14	418	0
14	454	0
14	472	0
14	475	0
14	495	0
14	536	0
14	537	0
14	612	0
14	688	0
14	759	0
14	764	0
14	847	0
14	856	0
14	890	0
14	908	0
14	919	0
14	948	0
14	970	0
15	31	0
15	89	0
15	91	0
15	108	0
15	125	0
15	236	0
15	275	0
15	280	0
15	326	0
15	342	0
15	414	0
15	445	0
15	500	0
15	502	0
15	541	0
15	553	0
15	594	0
15	626	0
15	635	0
15	745	0
15	783	0
15	795	0
15	817	0
15	886	0
15	924	0
15	949	0
15	968	0
15	985	0
16	80	0
16	87	0
16	101	0
16	121	0
16	155	0
16	177	0
16	218	0
16	221	0
16	267	0
16	269	0
16	271	0
16	280	0
16	287	0
16	345	0
16	438	0
16	453	0
16	455	0
16	456	0
16	503	0
16	548	0
16	582	0
16	583	0
16	717	0
16	758	0
16	779	0
16	886	0
16	967	0
17	96	0
17	119	0
17	124	0
17	127	0
17	154	0
17	199	0
17	201	0
17	236	0
17	280	0
17	310	0
17	313	0
17	378	0
17	457	0
17	469	0
17	478	0
17	500	0
17	515	0
17	521	0
17	573	0
17	603	0
17	606	0
17	734	0
17	770	0
17	794	0
17	800	0
17	853	0
17	873	0
17	874	0
17	880	0
17	948	0
17	957	0
17	959	0
18	44	0
18	84	0
18	144	0
18	172	0
18	268	0
18	279	0
18	280	0
18	321	0
18	386	0
18	460	0
18	462	0
18	484	0
18	536	0
18	561	0
18	612	0
18	717	0
18	808	0
18	842	0
18	863	0
18	883	0
18	917	0
18	944	0
19	2	0
19	3	0
19	144	0
19	152	0
19	182	0
19	208	0
19	212	0
19	217	0
19	266	0
19	404	0
19	428	0
19	473	0
19	490	0
19	510	0
19	513	0
19	644	0
19	670	0
19	673	0
19	711	0
19	750	0
19	752	0
19	756	0
19	771	0
19	785	0
19	877	0
20	1	7
20	54	0
20	63	0
20	140	0
20	146	0
20	165	0
20	231	0
20	243	0
20	269	0
20	274	0
20	348	0
20	366	0
20	445	0
20	478	0
20	492	0
20	499	0
20	527	0
20	531	0
20	538	0
20	589	0
20	643	0
20	652	0
20	663	0
20	714	0
20	717	0
20	757	0
20	784	0
20	863	0
20	962	0
20	977	0
21	6	0
21	87	0
21	88	0
21	142	0
21	159	0
21	179	0
21	253	0
21	281	0
21	321	0
21	398	0
21	426	0
21	429	0
21	497	0
21	507	0
21	530	0
21	680	0
21	686	0
21	700	0
21	702	0
21	733	0
21	734	0
21	798	0
21	804	0
21	887	0
21	893	0
21	920	0
21	983	0
22	9	0
22	23	0
22	56	0
22	89	0
22	111	0
22	146	0
22	291	0
22	294	0
22	349	0
22	369	0
22	418	0
22	430	0
22	483	0
22	491	0
22	495	0
22	536	0
22	600	0
22	634	0
22	648	0
22	688	0
22	731	0
22	742	0
22	775	0
22	802	0
22	912	0
22	964	0
23	6	0
23	42	0
23	78	0
23	105	0
23	116	0
23	117	0
23	125	0
23	212	0
23	226	0
23	235	0
23	254	0
23	367	0
23	370	0
23	414	0
23	419	0
23	435	0
23	449	0
23	491	0
23	536	0
23	549	0
23	636	0
23	649	0
23	673	0
23	691	0
23	766	0
23	782	0
23	804	0
23	820	0
23	826	0
23	833	0
23	842	0
23	853	0
23	855	0
23	856	0
23	935	0
23	981	0
23	997	0
24	3	0
24	83	0
24	112	0
24	126	0
24	148	0
24	164	0
24	178	0
24	194	0
24	199	0
24	242	0
24	256	0
24	277	0
24	335	0
24	405	0
24	463	0
24	515	0
24	585	0
24	603	0
24	653	0
24	704	0
24	781	0
24	829	0
24	832	0
24	969	0
25	21	0
25	86	0
25	153	0
25	179	0
25	204	0
25	213	0
25	226	0
25	245	0
25	311	0
25	404	0
25	411	0
25	420	0
25	538	0
25	564	0
25	583	0
25	606	0
25	688	0
25	697	0
25	755	0
25	871	0
25	914	0
26	9	0
26	21	0
26	34	0
26	90	0
26	93	0
26	103	0
26	147	0
26	186	0
26	201	0
26	225	0
26	241	0
26	327	0
26	329	0
26	340	0
26	345	0
26	390	0
26	392	0
26	529	0
26	544	0
26	564	0
26	635	0
26	644	0
26	682	0
26	688	0
26	715	0
26	732	0
26	758	0
26	764	0
26	795	0
26	821	0
26	885	0
26	904	0
26	906	0
27	19	0
27	34	0
27	85	0
27	150	0
27	172	0
27	273	0
27	334	0
27	347	0
27	359	0
27	398	0
27	415	0
27	462	0
27	477	0
27	500	0
27	503	0
27	540	0
27	586	0
27	593	0
27	637	0
27	679	0
27	682	0
27	695	0
27	771	0
27	805	0
27	830	0
27	854	0
27	873	0
27	880	0
27	889	0
27	904	0
27	967	0
27	986	0
27	996	0
28	14	0
28	43	0
28	58	0
28	74	0
28	96	0
28	107	0
28	259	0
28	263	0
28	287	0
28	358	0
28	502	0
28	508	0
28	532	0
28	551	0
28	574	0
28	597	0
28	619	0
28	625	0
28	652	0
28	679	0
28	743	0
28	790	0
28	793	0
28	816	0
28	827	0
28	835	0
28	879	0
28	908	0
28	953	0
28	973	0
28	994	0
29	10	0
29	79	0
29	105	0
29	110	0
29	131	0
29	133	0
29	172	0
29	226	0
29	273	0
29	282	0
29	296	0
29	311	0
29	335	0
29	342	0
29	436	0
29	444	0
29	449	0
29	462	0
29	482	0
29	488	0
29	519	0
29	547	0
29	590	0
29	646	0
29	723	0
29	812	0
29	862	0
29	928	0
29	944	0
30	1	6
30	53	0
30	64	0
30	69	0
30	77	0
30	87	0
30	260	0
30	262	0
30	286	0
30	292	0
30	301	0
30	318	0
30	321	0
30	357	0
30	565	0
30	732	0
30	797	0
30	838	0
30	945	0
31	88	0
31	146	0
31	163	0
31	164	0
31	188	0
31	299	0
31	308	0
31	368	0
31	380	0
31	431	0
31	585	0
31	637	0
31	700	0
31	739	0
31	793	0
31	802	0
31	880	0
31	978	0
32	65	0
32	84	0
32	103	0
32	112	0
32	136	0
32	197	0
32	199	0
32	219	0
32	309	0
32	312	0
32	401	0
32	427	0
32	431	0
32	523	0
32	567	0
32	585	0
32	606	0
32	651	0
32	667	0
32	669	0
32	815	0
32	928	0
32	980	0
33	56	0
33	112	0
33	135	0
33	154	0
33	214	0
33	252	0
33	305	0
33	306	0
33	473	0
33	489	0
33	574	0
33	618	0
33	667	0
33	694	0
33	712	0
33	735	0
33	737	0
33	754	0
33	775	0
33	878	0
33	881	0
33	965	0
33	972	0
33	993	0
34	43	0
34	90	0
34	119	0
34	125	0
34	172	0
34	182	0
34	244	0
34	336	0
34	389	0
34	393	0
34	438	0
34	493	0
34	502	0
34	525	0
34	668	0
34	720	0
34	779	0
34	788	0
34	794	0
34	836	0
34	846	0
34	853	0
34	929	0
34	950	0
34	971	0
35	10	0
35	35	0
35	52	0
35	201	0
35	256	0
35	389	0
35	589	0
35	612	0
35	615	0
35	707	0
35	732	0
35	738	0
35	748	0
35	817	0
35	914	0
36	15	0
36	81	0
36	171	0
36	231	0
36	245	0
36	283	0
36	380	0
36	381	0
36	387	0
36	390	0
36	410	0
36	426	0
36	427	0
36	453	0
36	466	0
36	484	0
36	493	0
36	499	0
36	569	0
36	590	0
36	600	0
36	714	0
36	715	0
36	716	0
36	731	0
36	875	0
36	915	0
36	931	0
36	956	0
37	10	0
37	12	0
37	19	0
37	118	0
37	119	0
37	122	0
37	146	0
37	204	0
37	253	0
37	260	0
37	277	0
37	317	0
37	467	0
37	477	0
37	485	0
37	508	0
37	529	0
37	553	0
37	555	0
37	572	0
37	588	0
37	662	0
37	663	0
37	694	0
37	697	0
37	785	0
37	839	0
37	840	0
37	853	0
37	900	0
37	925	0
37	963	0
37	966	0
37	989	0
37	997	0
38	24	0
38	111	0
38	160	0
38	176	0
38	223	0
38	241	0
38	274	0
38	335	0
38	338	0
38	353	0
38	448	0
38	450	0
38	458	0
38	501	0
38	516	0
38	547	0
38	583	0
38	618	0
38	619	0
38	705	0
38	793	0
38	827	0
38	839	0
38	853	0
38	876	0
39	71	0
39	73	0
39	168	0
39	203	0
39	222	0
39	290	0
39	293	0
39	320	0
39	415	0
39	425	0
39	431	0
39	456	0
39	476	0
39	559	0
39	587	0
39	598	0
39	606	0
39	648	0
39	683	0
39	689	0
39	696	0
39	700	0
39	703	0
39	736	0
39	772	0
39	815	0
39	831	0
39	920	0
40	1	5
40	11	0
40	34	0
40	107	0
40	128	0
40	163	0
40	177	0
40	223	0
40	233	0
40	326	0
40	374	0
40	394	0
40	396	0
40	463	0
40	466	0
40	494	0
40	521	0
40	723	0
40	737	0
40	744	0
40	747	0
40	754	0
40	799	0
40	835	0
40	868	0
40	869	0
40	887	0
40	933	0
40	938	0
41	4	0
41	60	0
41	69	0
41	86	0
41	100	0
41	150	0
41	159	0
41	194	0
41	203	0
41	212	0
41	230	0
41	249	0
41	252	0
41	305	0
41	336	0
41	383	0
41	544	0
41	596	0
41	657	0
41	674	0
41	678	0
41	721	0
41	724	0
41	779	0
41	784	0
41	799	0
41	894	0
41	912	0
41	942	0
42	24	0
42	139	0
42	309	0
42	320	0
42	333	0
42	500	0
42	502	0
42	505	0
42	527	0
42	535	0
42	546	0
42	568	0
42	648	0
42	665	0
42	673	0
42	687	0
42	713	0
42	738	0
42	798	0
42	861	0
42	865	0
42	867	0
42	876	0
42	890	0
42	907	0
42	922	0
42	932	0
43	19	0
43	42	0
43	56	0
43	89	0
43	105	0
43	147	0
43	161	0
43	180	0
43	239	0
43	276	0
43	330	0
43	344	0
43	359	0
43	377	0
43	410	0
43	462	0
43	533	0
43	598	0
43	605	0
43	608	0
43	621	0
43	753	0
43	827	0
43	833	0
43	917	0
43	958	0
44	58	0
44	84	0
44	88	0
44	94	0
44	109	0
44	176	0
44	242	0
44	273	0
44	322	0
44	420	0
44	434	0
44	490	0
44	591	0
44	598	0
44	604	0
44	699	0
44	751	0
44	784	0
44	825	0
44	854	0
44	875	0
44	878	0
44	883	0
44	896	0
44	902	0
44	937	0
44	944	0
44	952	0
44	982	0
44	998	0
45	18	0
45	65	0
45	66	0
45	115	0
45	117	0
45	164	0
45	187	0
45	198	0
45	219	0
45	330	0
45	407	0
45	416	0
45	463	0
45	467	0
45	484	0
45	502	0
45	503	0
45	508	0
45	537	0
45	680	0
45	714	0
45	767	0
45	778	0
45	797	0
45	810	0
45	895	0
45	900	0
45	901	0
45	920	0
45	925	0
45	975	0
45	978	0
46	38	0
46	51	0
46	174	0
46	254	0
46	296	0
46	319	0
46	407	0
46	448	0
46	456	0
46	463	0
46	478	0
46	538	0
46	540	0
46	567	0
46	731	0
46	766	0
46	768	0
46	820	0
46	829	0
46	830	0
46	836	0
46	889	0
46	980	0
46	991	0
47	25	0
47	36	0
47	53	0
47	67	0
47	172	0
47	233	0
47	273	0
47	351	0
47	385	0
47	484	0
47	508	0
47	576	0
47	670	0
47	734	0
47	737	0
47	770	0
47	777	0
47	787	0
47	790	0
47	913	0
47	923	0
47	924	0
47	944	0
47	973	0
48	99	0
48	101	0
48	134	0
48	150	0
48	164	0
48	211	0
48	245	0
48	267	0
48	287	0
48	295	0
48	312	0
48	315	0
48	345	0
48	349	0
48	428	0
48	506	0
48	545	0
48	559	0
48	570	0
48	599	0
48	645	0
48	705	0
48	757	0
48	792	0
48	922	0
48	926	0
49	31	0
49	151	0
49	195	0
49	207	0
49	250	0
49	282	0
49	348	0
49	391	0
49	400	0
49	407	0
49	423	0
49	433	0
49	469	0
49	506	0
49	542	0
49	558	0
49	579	0
49	595	0
49	662	0
49	709	0
49	716	0
49	725	0
49	729	0
49	811	0
49	927	0
49	977	0
49	980	0
50	111	0
50	178	0
50	243	0
50	248	0
50	274	0
50	288	0
50	303	0
50	306	0
50	327	0
50	372	0
50	401	0
50	417	0
50	420	0
50	437	0
50	476	0
50	504	0
50	520	0
50	552	0
50	591	0
50	621	0
50	632	0
50	645	0
50	672	0
50	717	0
50	732	0
50	795	0
50	829	0
50	840	0
50	897	0
50	918	0
50	924	0
50	957	0
51	5	0
51	63	0
51	103	0
51	112	0
51	121	0
51	153	0
51	395	0
51	408	0
51	420	0
51	461	0
51	490	0
51	525	0
51	627	0
51	678	0
51	733	0
51	734	0
51	737	0
51	750	0
51	847	0
51	891	0
51	895	0
51	940	0
51	974	0
51	990	0
51	993	0
52	20	0
52	92	0
52	96	0
52	108	0
52	203	0
52	249	0
52	341	0
52	376	0
52	388	0
52	407	0
52	424	0
52	474	0
52	515	0
52	517	0
52	584	0
52	596	0
52	664	0
52	675	0
52	689	0
52	714	0
52	812	0
52	878	0
52	879	0
52	915	0
52	951	0
52	999	0
53	1	4
53	9	0
53	51	0
53	58	0
53	109	0
53	122	0
53	126	0
53	181	0
53	256	0
53	268	0
53	285	0
53	307	0
53	358	0
53	386	0
53	447	0
53	465	0
53	490	0
53	492	0
53	508	0
53	518	0
53	573	0
53	576	0
53	577	0
53	697	0
53	725	0
53	727	0
53	937	0
53	947	0
53	961	0
53	980	0
54	84	0
54	129	0
54	150	0
54	184	0
54	285	0
54	292	0
54	301	0
54	348	0
54	489	0
54	510	0
54	524	0
54	546	0
54	600	0
54	636	0
54	649	0
54	658	0
54	754	0
54	764	0
54	842	0
54	858	0
54	861	0
54	913	0
54	970	0
54	988	0
54	990	0
55	8	0
55	27	0
55	75	0
55	197	0
55	307	0
55	320	0
55	340	0
55	403	0
55	485	0
55	486	0
55	603	0
55	612	0
55	620	0
55	709	0
55	776	0
55	790	0
55	815	0
55	827	0
55	930	0
55	963	0
56	63	0
56	87	0
56	226	0
56	236	0
56	298	0
56	307	0
56	354	0
56	383	0
56	417	0
56	421	0
56	457	0
56	462	0
56	474	0
56	521	0
56	593	0
56	728	0
56	750	0
56	769	0
56	781	0
56	795	0
56	844	0
56	851	0
56	862	0
56	868	0
56	892	0
56	893	0
56	936	0
56	965	0
57	16	0
57	34	0
57	101	0
57	114	0
57	122	0
57	134	0
57	144	0
57	153	0
57	192	0
57	213	0
57	258	0
57	267	0
57	317	0
57	340	0
57	393	0
57	437	0
57	447	0
57	502	0
57	592	0
57	605	0
57	637	0
57	685	0
57	707	0
57	714	0
57	717	0
57	737	0
57	767	0
57	852	0
57	891	0
57	918	0
58	48	0
58	68	0
58	119	0
58	128	0
58	135	0
58	175	0
58	199	0
58	235	0
58	242	0
58	243	0
58	254	0
58	306	0
58	316	0
58	417	0
58	426	0
58	460	0
58	477	0
58	541	0
58	549	0
58	551	0
58	553	0
58	578	0
58	602	0
58	632	0
58	635	0
58	638	0
58	698	0
58	726	0
58	755	0
58	800	0
58	856	0
58	858	0
59	5	0
59	46	0
59	54	0
59	72	0
59	88	0
59	121	0
59	129	0
59	130	0
59	183	0
59	210	0
59	241	0
59	295	0
59	418	0
59	572	0
59	644	0
59	650	0
59	689	0
59	694	0
59	702	0
59	713	0
59	749	0
59	772	0
59	853	0
59	862	0
59	943	0
59	946	0
59	984	0
60	31	0
60	85	0
60	133	0
60	142	0
60	177	0
60	179	0
60	186	0
60	222	0
60	235	0
60	239	0
60	253	0
60	262	0
60	297	0
60	299	0
60	334	0
60	376	0
60	423	0
60	436	0
60	493	0
60	534	0
60	551	0
60	658	0
60	665	0
60	679	0
60	754	0
60	771	0
60	783	0
60	784	0
60	805	0
60	830	0
60	835	0
60	928	0
60	952	0
60	971	0
60	986	0
61	235	0
61	237	0
61	307	0
61	362	0
61	372	0
61	374	0
61	423	0
61	433	0
61	508	0
61	518	0
61	519	0
61	535	0
61	537	0
61	585	0
61	639	0
61	648	0
61	649	0
61	703	0
61	752	0
61	766	0
61	767	0
61	780	0
61	831	0
61	832	0
61	990	0
62	6	0
62	42	0
62	54	0
62	100	0
62	101	0
62	129	0
62	198	0
62	211	0
62	231	0
62	272	0
62	295	0
62	337	0
62	375	0
62	385	0
62	393	0
62	398	0
62	406	0
62	413	0
62	428	0
62	445	0
62	457	0
62	465	0
62	688	0
62	707	0
62	719	0
62	951	0
62	981	0
62	988	0
62	990	0
63	73	0
63	134	0
63	167	0
63	208	0
63	225	0
63	248	0
63	249	0
63	278	0
63	392	0
63	517	0
63	633	0
63	763	0
63	781	0
63	809	0
63	893	0
63	932	0
63	944	0
63	945	0
63	981	0
64	3	0
64	10	0
64	37	0
64	87	0
64	88	0
64	124	0
64	197	0
64	280	0
64	291	0
64	307	0
64	335	0
64	345	0
64	448	0
64	469	0
64	471	0
64	506	0
64	543	0
64	557	0
64	569	0
64	572	0
64	597	0
64	616	0
64	646	0
64	694	0
64	832	0
64	852	0
64	860	0
64	921	0
64	925	0
64	980	0
65	39	0
65	46	0
65	97	0
65	106	0
65	117	0
65	125	0
65	158	0
65	276	0
65	305	0
65	338	0
65	347	0
65	371	0
65	398	0
65	471	0
65	475	0
65	476	0
65	491	0
65	496	0
65	516	0
65	517	0
65	541	0
65	556	0
65	571	0
65	577	0
65	615	0
65	658	0
65	683	0
65	694	0
65	714	0
65	735	0
65	852	0
65	938	0
65	951	0
65	965	0
66	55	0
66	143	0
66	207	0
66	226	0
66	229	0
66	230	0
66	283	0
66	300	0
66	342	0
66	350	0
66	361	0
66	376	0
66	424	0
66	434	0
66	553	0
66	608	0
66	676	0
66	697	0
66	706	0
66	725	0
66	769	0
66	793	0
66	829	0
66	871	0
66	909	0
66	915	0
66	928	0
66	951	0
66	957	0
66	960	0
66	999	0
67	24	0
67	57	0
67	67	0
67	144	0
67	242	0
67	244	0
67	256	0
67	408	0
67	477	0
67	496	0
67	512	0
67	576	0
67	601	0
67	725	0
67	726	0
67	731	0
67	766	0
67	861	0
67	870	0
67	915	0
67	945	0
67	972	0
67	981	0
68	9	0
68	45	0
68	133	0
68	161	0
68	205	0
68	213	0
68	215	0
68	255	0
68	296	0
68	315	0
68	325	0
68	331	0
68	347	0
68	357	0
68	378	0
68	380	0
68	386	0
68	396	0
68	435	0
68	497	0
68	607	0
68	654	0
68	665	0
68	671	0
68	706	0
68	747	0
68	834	0
68	839	0
68	840	0
68	971	0
69	15	0
69	88	0
69	111	0
69	202	0
69	236	0
69	292	0
69	300	0
69	306	0
69	374	0
69	396	0
69	452	0
69	466	0
69	529	0
69	612	0
69	720	0
69	722	0
69	761	0
69	791	0
69	864	0
69	877	0
69	914	0
70	50	0
70	53	0
70	92	0
70	202	0
70	227	0
70	249	0
70	290	0
70	304	0
70	343	0
70	414	0
70	453	0
70	466	0
70	504	0
70	584	0
70	628	0
70	654	0
70	725	0
70	823	0
70	834	0
70	856	0
70	869	0
70	953	0
70	964	0
71	26	0
71	52	0
71	233	0
71	317	0
71	359	0
71	362	0
71	385	0
71	399	0
71	450	0
71	532	0
71	560	0
71	574	0
71	638	0
71	773	0
71	833	0
71	874	0
71	918	0
71	956	0
72	34	0
72	144	0
72	237	0
72	249	0
72	286	0
72	296	0
72	325	0
72	331	0
72	405	0
72	450	0
72	550	0
72	609	0
72	623	0
72	636	0
72	640	0
72	665	0
72	718	0
72	743	0
72	757	0
72	773	0
72	854	0
72	865	0
72	938	0
72	956	0
72	964	0
72	969	0
73	36	0
73	45	0
73	51	0
73	77	0
73	148	0
73	245	0
73	275	0
73	322	0
73	374	0
73	379	0
73	467	0
73	548	0
73	561	0
73	562	0
73	565	0
73	627	0
73	666	0
73	667	0
73	707	0
73	748	0
73	772	0
73	823	0
73	936	0
73	946	0
73	950	0
73	998	0
74	28	0
74	44	0
74	117	0
74	185	0
74	192	0
74	203	0
74	263	0
74	321	0
74	415	0
74	484	0
74	503	0
74	537	0
74	543	0
74	617	0
74	626	0
74	637	0
74	663	0
74	704	0
74	720	0
74	747	0
74	780	0
74	804	0
74	834	0
74	836	0
74	848	0
74	872	0
74	902	0
74	956	0
75	12	0
75	34	0
75	143	0
75	170	0
75	222	0
75	301	0
75	347	0
75	372	0
75	436	0
75	445	0
75	446	0
75	492	0
75	498	0
75	508	0
75	541	0
75	547	0
75	579	0
75	645	0
75	667	0
75	744	0
75	764	0
75	780	0
75	870	0
75	920	0
76	60	0
76	66	0
76	68	0
76	95	0
76	122	0
76	187	0
76	223	0
76	234	0
76	251	0
76	348	0
76	444	0
76	464	0
76	474	0
76	498	0
76	568	0
76	604	0
76	606	0
76	642	0
76	648	0
76	650	0
76	709	0
76	760	0
76	765	0
76	781	0
76	850	0
76	862	0
76	866	0
76	870	0
76	912	0
76	935	0
76	958	0
77	13	0
77	22	0
77	40	0
77	73	0
77	78	0
77	153	0
77	224	0
77	240	0
77	245	0
77	261	0
77	343	0
77	442	0
77	458	0
77	538	0
77	566	0
77	612	0
77	635	0
77	694	0
77	749	0
77	938	0
77	943	0
77	963	0
77	969	0
77	993	0
78	86	0
78	239	0
78	260	0
78	261	0
78	265	0
78	301	0
78	387	0
78	393	0
78	428	0
78	457	0
78	505	0
78	520	0
78	530	0
78	549	0
78	552	0
78	599	0
78	670	0
78	674	0
78	689	0
78	762	0
78	767	0
78	811	0
78	852	0
78	880	0
78	963	0
78	968	0
79	32	0
79	33	0
79	40	0
79	141	0
79	205	0
79	230	0
79	242	0
79	262	0
79	267	0
79	269	0
79	299	0
79	367	0
79	428	0
79	430	0
79	473	0
79	607	0
79	628	0
79	634	0
79	646	0
79	727	0
79	750	0
79	753	0
79	769	0
79	776	0
79	788	0
79	840	0
79	853	0
79	916	0
80	69	0
80	118	0
80	124	0
80	175	0
80	207	0
80	212	0
80	260	0
80	262	0
80	280	0
80	341	0
80	342	0
80	343	0
80	362	0
80	436	0
80	475	0
80	553	0
80	619	0
80	622	0
80	680	0
80	687	0
80	688	0
80	709	0
80	788	0
80	807	0
80	858	0
80	888	0
80	941	0
80	979	0
81	4	0
81	11	0
81	59	0
81	89	0
81	178	0
81	186	0
81	194	0
81	215	0
81	219	0
81	232	0
81	260	0
81	267	0
81	268	0
81	304	0
81	332	0
81	389	0
81	398	0
81	453	0
81	458	0
81	465	0
81	505	0
81	508	0
81	527	0
81	545	0
81	564	0
81	578	0
81	579	0
81	613	0
81	619	0
81	643	0
81	692	0
81	710	0
81	729	0
81	761	0
81	827	0
81	910	0
82	17	0
82	33	0
82	104	0
82	143	0
82	188	0
82	242	0
82	247	0
82	290	0
82	306	0
82	316	0
82	344	0
82	453	0
82	468	0
82	480	0
82	497	0
82	503	0
82	527	0
82	551	0
82	561	0
82	750	0
82	787	0
82	802	0
82	838	0
82	839	0
82	870	0
82	877	0
82	893	0
82	911	0
82	954	0
82	978	0
82	985	0
83	49	0
83	52	0
83	58	0
83	110	0
83	120	0
83	121	0
83	135	0
83	165	0
83	217	0
83	247	0
83	249	0
83	263	0
83	268	0
83	279	0
83	281	0
83	339	0
83	340	0
83	369	0
83	412	0
83	519	0
83	529	0
83	615	0
83	631	0
83	655	0
83	672	0
83	686	0
83	719	0
83	764	0
83	777	0
83	784	0
83	833	0
83	873	0
83	932	0
84	19	0
84	39	0
84	46	0
84	175	0
84	238	0
84	281	0
84	290	0
84	312	0
84	317	0
84	413	0
84	414	0
84	460	0
84	479	0
84	491	0
84	529	0
84	540	0
84	566	0
84	574	0
84	589	0
84	616	0
84	646	0
84	703	0
84	729	0
84	764	0
84	782	0
84	809	0
84	830	0
84	843	0
84	887	0
84	975	0
84	996	0
85	2	0
85	14	0
85	72	0
85	85	0
85	92	0
85	148	0
85	216	0
85	290	0
85	296	0
85	297	0
85	337	0
85	383	0
85	421	0
85	446	0
85	461	0
85	475	0
85	478	0
85	522	0
85	543	0
85	558	0
85	591	0
85	630	0
85	678	0
85	711	0
85	761	0
85	812	0
85	869	0
85	875	0
85	895	0
85	957	0
85	960	0
86	137	0
86	163	0
86	196	0
86	216	0
86	249	0
86	303	0
86	331	0
86	364	0
86	391	0
86	432	0
86	482	0
86	486	0
86	519	0
86	520	0
86	548	0
86	623	0
86	631	0
86	636	0
86	752	0
86	760	0
86	808	0
86	857	0
86	878	0
86	893	0
86	905	0
86	923	0
86	929	0
87	48	0
87	157	0
87	161	0
87	199	0
87	207	0
87	250	0
87	253	0
87	312	0
87	421	0
87	570	0
87	599	0
87	606	0
87	654	0
87	679	0
87	706	0
87	718	0
87	721	0
87	830	0
87	870	0
87	952	0
87	961	0
88	4	0
88	76	0
88	87	0
88	128	0
88	170	0
88	193	0
88	234	0
88	304	0
88	602	0
88	620	0
88	668	0
88	717	0
88	785	0
88	819	0
88	839	0
88	881	0
88	908	0
88	929	0
88	940	0
88	968	0
89	47	0
89	103	0
89	117	0
89	162	0
89	182	0
89	187	0
89	212	0
89	254	0
89	266	0
89	306	0
89	342	0
89	406	0
89	410	0
89	446	0
89	473	0
89	488	0
89	529	0
89	542	0
89	564	0
89	697	0
89	833	0
89	864	0
89	970	0
89	976	0
90	2	0
90	11	0
90	100	0
90	197	0
90	212	0
90	262	0
90	303	0
90	330	0
90	363	0
90	374	0
90	384	0
90	385	0
90	391	0
90	406	0
90	433	0
90	442	0
90	451	0
90	520	0
90	529	0
90	542	0
90	586	0
90	633	0
90	663	0
90	676	0
90	771	0
90	817	0
90	838	0
90	855	0
90	858	0
90	868	0
90	880	0
90	901	0
90	925	0
91	13	0
91	25	0
91	48	0
91	176	0
91	181	0
91	190	0
91	335	0
91	416	0
91	447	0
91	480	0
91	493	0
91	509	0
91	511	0
91	608	0
91	807	0
91	829	0
91	849	0
91	859	0
91	941	0
91	982	0
92	90	0
92	94	0
92	103	0
92	104	0
92	123	0
92	137	0
92	207	0
92	229	0
92	338	0
92	381	0
92	436	0
92	443	0
92	453	0
92	470	0
92	505	0
92	512	0
92	543	0
92	545	0
92	547	0
92	553	0
92	564	0
92	568	0
92	618	0
92	662	0
92	686	0
92	699	0
92	712	0
92	728	0
92	802	0
92	825	0
92	838	0
92	889	0
92	929	0
92	991	0
93	71	0
93	120	0
93	124	0
93	280	0
93	325	0
93	339	0
93	427	0
93	445	0
93	453	0
93	473	0
93	573	0
93	621	0
93	644	0
93	678	0
93	680	0
93	699	0
93	744	0
93	768	0
93	777	0
93	835	0
93	856	0
93	874	0
93	909	0
93	916	0
93	982	0
94	13	0
94	60	0
94	76	0
94	122	0
94	153	0
94	193	0
94	206	0
94	228	0
94	270	0
94	275	0
94	320	0
94	322	0
94	337	0
94	354	0
94	402	0
94	428	0
94	457	0
94	473	0
94	475	0
94	512	0
94	517	0
94	521	0
94	533	0
94	540	0
94	548	0
94	551	0
94	712	0
94	713	0
94	724	0
94	775	0
94	788	0
94	950	0
94	989	0
95	22	0
95	35	0
95	47	0
95	52	0
95	65	0
95	74	0
95	126	0
95	207	0
95	245	0
95	294	0
95	301	0
95	312	0
95	329	0
95	353	0
95	375	0
95	420	0
95	424	0
95	431	0
95	498	0
95	522	0
95	546	0
95	551	0
95	619	0
95	627	0
95	690	0
95	748	0
95	813	0
95	828	0
95	855	0
95	903	0
95	923	0
96	8	0
96	36	0
96	40	0
96	54	0
96	58	0
96	66	0
96	134	0
96	209	0
96	244	0
96	320	0
96	430	0
96	452	0
96	486	0
96	572	0
96	590	0
96	661	0
96	778	0
96	832	0
96	846	0
96	874	0
96	945	0
96	968	0
96	987	0
97	143	0
97	177	0
97	188	0
97	197	0
97	256	0
97	312	0
97	342	0
97	348	0
97	358	0
97	370	0
97	437	0
97	446	0
97	466	0
97	518	0
97	553	0
97	561	0
97	641	0
97	656	0
97	728	0
97	755	0
97	757	0
97	826	0
97	862	0
97	930	0
97	933	0
97	947	0
97	951	0
98	66	0
98	72	0
98	81	0
98	87	0
98	107	0
98	120	0
98	183	0
98	194	0
98	212	0
98	297	0
98	607	0
98	634	0
98	686	0
98	705	0
98	710	0
98	721	0
98	725	0
98	734	0
98	738	0
98	765	0
98	782	0
98	824	0
98	829	0
98	912	0
98	955	0
98	985	0
98	990	0
99	7	0
99	27	0
99	84	0
99	250	0
99	322	0
99	325	0
99	381	0
99	414	0
99	475	0
99	490	0
99	512	0
99	540	0
99	572	0
99	600	0
99	618	0
99	620	0
99	622	0
99	636	0
99	672	0
99	726	0
99	741	0
99	796	0
99	835	0
99	967	0
99	978	0
99	982	0
100	17	0
100	118	0
100	250	0
100	411	0
100	414	0
100	513	0
100	563	0
100	642	0
100	714	0
100	718	0
100	759	0
100	779	0
100	815	0
100	846	0
100	850	0
100	872	0
100	877	0
100	909	0
100	919	0
100	944	0
100	967	0
100	979	0
100	991	0
100	992	0
101	60	0
101	66	0
101	85	0
101	146	0
101	189	0
101	250	0
101	255	0
101	263	0
101	275	0
101	289	0
101	491	0
101	494	0
101	511	0
101	568	0
101	608	0
101	617	0
101	655	0
101	662	0
101	700	0
101	702	0
101	758	0
101	774	0
101	787	0
101	828	0
101	841	0
101	928	0
101	932	0
101	936	0
101	941	0
101	978	0
101	980	0
101	984	0
101	988	0
102	20	0
102	34	0
102	53	0
102	123	0
102	124	0
102	194	0
102	200	0
102	205	0
102	268	0
102	326	0
102	329	0
102	334	0
102	351	0
102	418	0
102	431	0
102	446	0
102	485	0
102	508	0
102	517	0
102	521	0
102	526	0
102	529	0
102	544	0
102	600	0
102	605	0
102	606	0
102	624	0
102	631	0
102	712	0
102	728	0
102	744	0
102	796	0
102	802	0
102	810	0
102	828	0
102	837	0
102	845	0
102	852	0
102	958	0
102	979	0
102	980	0
103	5	0
103	118	0
103	130	0
103	197	0
103	199	0
103	206	0
103	215	0
103	221	0
103	271	0
103	285	0
103	315	0
103	318	0
103	333	0
103	347	0
103	356	0
103	360	0
103	378	0
103	437	0
103	585	0
103	609	0
103	639	0
103	643	0
103	692	0
103	735	0
103	822	0
103	895	0
103	903	0
103	912	0
103	942	0
103	956	0
104	19	0
104	39	0
104	40	0
104	59	0
104	70	0
104	136	0
104	156	0
104	184	0
104	198	0
104	233	0
104	259	0
104	287	0
104	309	0
104	313	0
104	394	0
104	401	0
104	463	0
104	506	0
104	516	0
104	583	0
104	600	0
104	607	0
104	657	0
104	677	0
104	739	0
104	892	0
104	904	0
104	926	0
104	945	0
104	984	0
104	999	0
105	12	0
105	15	0
105	21	0
105	29	0
105	42	0
105	116	0
105	158	0
105	239	0
105	280	0
105	283	0
105	315	0
105	333	0
105	372	0
105	377	0
105	530	0
105	558	0
105	561	0
105	606	0
105	649	0
105	686	0
105	750	0
105	795	0
105	831	0
105	835	0
105	858	0
105	864	0
105	893	0
105	906	0
105	910	0
105	915	0
105	954	0
105	990	0
105	993	0
105	994	0
106	44	0
106	83	0
106	108	0
106	126	0
106	136	0
106	166	0
106	189	0
106	194	0
106	204	0
106	229	0
106	241	0
106	345	0
106	365	0
106	399	0
106	439	0
106	457	0
106	469	0
106	500	0
106	505	0
106	559	0
106	566	0
106	585	0
106	639	0
106	654	0
106	659	0
106	675	0
106	687	0
106	752	0
106	763	0
106	780	0
106	858	0
106	866	0
106	881	0
106	894	0
106	934	0
107	62	0
107	112	0
107	133	0
107	136	0
107	138	0
107	162	0
107	165	0
107	172	0
107	209	0
107	220	0
107	239	0
107	277	0
107	292	0
107	338	0
107	348	0
107	369	0
107	388	0
107	392	0
107	409	0
107	430	0
107	445	0
107	454	0
107	458	0
107	467	0
107	520	0
107	534	0
107	548	0
107	571	0
107	574	0
107	603	0
107	606	0
107	637	0
107	774	0
107	781	0
107	796	0
107	831	0
107	849	0
107	859	0
107	879	0
107	905	0
107	973	0
107	977	0
108	1	3
108	6	0
108	9	0
108	137	0
108	208	0
108	219	0
108	242	0
108	278	0
108	302	0
108	350	0
108	378	0
108	379	0
108	495	0
108	507	0
108	517	0
108	561	0
108	567	0
108	648	0
108	652	0
108	655	0
108	673	0
108	693	0
108	696	0
108	702	0
108	721	0
108	733	0
108	741	0
108	744	0
108	887	0
108	892	0
108	894	0
108	920	0
108	958	0
108	966	0
109	12	0
109	48	0
109	77	0
109	157	0
109	174	0
109	190	0
109	243	0
109	281	0
109	393	0
109	463	0
109	622	0
109	657	0
109	694	0
109	700	0
109	732	0
109	753	0
109	785	0
109	786	0
109	863	0
109	885	0
109	955	0
109	967	0
110	8	0
110	27	0
110	62	0
110	120	0
110	126	0
110	156	0
110	292	0
110	343	0
110	360	0
110	369	0
110	435	0
110	513	0
110	525	0
110	539	0
110	545	0
110	625	0
110	650	0
110	801	0
110	912	0
110	961	0
110	987	0
111	61	0
111	78	0
111	98	0
111	162	0
111	179	0
111	194	0
111	325	0
111	359	0
111	382	0
111	403	0
111	407	0
111	414	0
111	474	0
111	489	0
111	508	0
111	555	0
111	603	0
111	608	0
111	643	0
111	669	0
111	679	0
111	680	0
111	699	0
111	731	0
111	732	0
111	737	0
111	744	0
111	777	0
111	847	0
111	894	0
111	919	0
111	962	0
111	973	0
112	34	0
112	37	0
112	151	0
112	173	0
112	188	0
112	231	0
112	312	0
112	322	0
112	443	0
112	450	0
112	565	0
112	603	0
112	606	0
112	654	0
112	666	0
112	700	0
112	728	0
112	772	0
112	796	0
112	817	0
112	829	0
112	856	0
112	865	0
112	869	0
112	988	0
113	35	0
113	84	0
113	116	0
113	181	0
113	218	0
113	249	0
113	258	0
113	292	0
113	322	0
113	353	0
113	403	0
113	525	0
113	642	0
113	656	0
113	674	0
113	680	0
113	700	0
113	719	0
113	723	0
113	726	0
113	732	0
113	748	0
113	838	0
113	890	0
113	921	0
113	969	0
113	981	0
114	13	0
114	68	0
114	90	0
114	162	0
114	188	0
114	194	0
114	210	0
114	237	0
114	254	0
114	305	0
114	339	0
114	420	0
114	425	0
114	452	0
114	538	0
114	619	0
114	757	0
114	807	0
114	827	0
114	841	0
114	861	0
114	866	0
114	913	0
114	961	0
114	993	0
115	49	0
115	52	0
115	245	0
115	246	0
115	277	0
115	302	0
115	379	0
115	383	0
115	391	0
115	428	0
115	506	0
115	531	0
115	607	0
115	615	0
115	661	0
115	671	0
115	686	0
115	703	0
115	714	0
115	740	0
115	754	0
115	846	0
115	887	0
115	952	0
115	955	0
115	966	0
115	985	0
115	994	0
116	36	0
116	48	0
116	88	0
116	90	0
116	105	0
116	128	0
116	336	0
116	338	0
116	384	0
116	412	0
116	420	0
116	451	0
116	481	0
116	492	0
116	584	0
116	606	0
116	622	0
116	647	0
116	653	0
116	742	0
116	784	0
116	844	0
116	939	0
116	956	0
117	10	0
117	15	0
117	42	0
117	167	0
117	178	0
117	190	0
117	197	0
117	224	0
117	246	0
117	273	0
117	298	0
117	316	0
117	337	0
117	395	0
117	423	0
117	432	0
117	459	0
117	468	0
117	550	0
117	578	0
117	707	0
117	710	0
117	738	0
117	739	0
117	778	0
117	783	0
117	785	0
117	797	0
117	812	0
117	831	0
117	864	0
117	887	0
117	926	0
118	35	0
118	39	0
118	41	0
118	49	0
118	55	0
118	136	0
118	141	0
118	151	0
118	311	0
118	384	0
118	399	0
118	499	0
118	517	0
118	553	0
118	558	0
118	572	0
118	641	0
118	656	0
118	695	0
118	735	0
118	788	0
118	852	0
118	938	0
118	957	0
118	969	0
119	21	0
119	49	0
119	64	0
119	87	0
119	143	0
119	171	0
119	172	0
119	173	0
119	381	0
119	394	0
119	412	0
119	418	0
119	454	0
119	509	0
119	521	0
119	567	0
119	570	0
119	592	0
119	614	0
119	636	0
119	649	0
119	693	0
119	738	0
119	751	0
119	782	0
119	786	0
119	788	0
119	802	0
119	858	0
119	868	0
119	900	0
119	939	0
120	57	0
120	63	0
120	144	0
120	149	0
120	208	0
120	231	0
120	238	0
120	255	0
120	414	0
120	424	0
120	489	0
120	513	0
120	590	0
120	641	0
120	642	0
120	659	0
120	682	0
120	691	0
120	715	0
120	717	0
120	722	0
120	746	0
120	830	0
120	894	0
120	898	0
120	911	0
120	994	0
121	141	0
121	154	0
121	161	0
121	170	0
121	186	0
121	198	0
121	220	0
121	222	0
121	284	0
121	297	0
121	338	0
121	353	0
121	449	0
121	479	0
121	517	0
121	633	0
121	654	0
121	658	0
121	666	0
121	771	0
121	780	0
121	847	0
121	884	0
121	885	0
121	966	0
122	22	0
122	29	0
122	76	0
122	83	0
122	157	0
122	158	0
122	166	0
122	227	0
122	238	0
122	300	0
122	307	0
122	363	0
122	470	0
122	489	0
122	491	0
122	542	0
122	620	0
122	649	0
122	654	0
122	673	0
122	718	0
122	795	0
122	957	0
122	961	0
122	998	0
123	3	0
123	43	0
123	67	0
123	105	0
123	148	0
123	151	0
123	185	0
123	223	0
123	234	0
123	245	0
123	246	0
123	266	0
123	286	0
123	429	0
123	442	0
123	446	0
123	479	0
123	480	0
123	494	0
123	503	0
123	530	0
123	576	0
123	577	0
123	589	0
123	593	0
123	725	0
123	730	0
123	786	0
123	860	0
123	892	0
123	926	0
123	988	0
124	22	0
124	64	0
124	106	0
124	113	0
124	190	0
124	246	0
124	260	0
124	263	0
124	289	0
124	306	0
124	312	0
124	322	0
124	343	0
124	449	0
124	468	0
124	539	0
124	601	0
124	726	0
124	742	0
124	775	0
124	785	0
124	814	0
124	858	0
124	882	0
124	987	0
124	997	0
125	62	0
125	98	0
125	100	0
125	114	0
125	175	0
125	188	0
125	204	0
125	238	0
125	250	0
125	324	0
125	338	0
125	361	0
125	367	0
125	395	0
125	414	0
125	428	0
125	429	0
125	450	0
125	497	0
125	557	0
125	568	0
125	584	0
125	602	0
125	623	0
125	664	0
125	683	0
125	710	0
125	877	0
125	908	0
125	949	0
125	965	0
126	21	0
126	34	0
126	43	0
126	58	0
126	85	0
126	96	0
126	193	0
126	194	0
126	199	0
126	256	0
126	263	0
126	288	0
126	317	0
126	347	0
126	369	0
126	370	0
126	419	0
126	468	0
126	469	0
126	545	0
126	685	0
126	836	0
126	860	0
127	36	0
127	47	0
127	48	0
127	79	0
127	119	0
127	141	0
127	157	0
127	202	0
127	286	0
127	333	0
127	354	0
127	366	0
127	382	0
127	388	0
127	411	0
127	459	0
127	553	0
127	573	0
127	613	0
127	617	0
127	641	0
127	710	0
127	727	0
127	749	0
127	763	0
127	771	0
127	791	0
127	819	0
127	839	0
127	846	0
127	911	0
127	953	0
127	970	0
128	26	0
128	82	0
128	119	0
128	168	0
128	212	0
128	238	0
128	299	0
128	312	0
128	326	0
128	336	0
128	345	0
128	407	0
128	462	0
128	485	0
128	516	0
128	564	0
128	614	0
128	650	0
128	665	0
128	671	0
128	693	0
128	696	0
128	759	0
128	774	0
128	814	0
128	899	0
128	912	0
128	944	0
128	949	0
128	965	0
129	56	0
129	89	0
129	101	0
129	166	0
129	202	0
129	230	0
129	247	0
129	249	0
129	348	0
129	367	0
129	391	0
129	418	0
129	431	0
129	452	0
129	471	0
129	520	0
129	597	0
129	602	0
129	640	0
129	669	0
129	684	0
129	705	0
129	805	0
129	826	0
129	834	0
129	857	0
129	910	0
129	920	0
129	938	0
129	962	0
130	9	0
130	26	0
130	37	0
130	43	0
130	49	0
130	57	0
130	107	0
130	112	0
130	208	0
130	326	0
130	375	0
130	416	0
130	431	0
130	452	0
130	453	0
130	478	0
130	507	0
130	525	0
130	549	0
130	592	0
130	702	0
130	725	0
130	764	0
130	809	0
130	869	0
130	930	0
130	981	0
131	48	0
131	66	0
131	94	0
131	120	0
131	147	0
131	206	0
131	320	0
131	383	0
131	432	0
131	436	0
131	450	0
131	479	0
131	494	0
131	515	0
131	539	0
131	590	0
131	647	0
131	693	0
131	713	0
131	770	0
131	798	0
131	809	0
131	875	0
131	881	0
131	921	0
132	81	0
132	82	0
132	133	0
132	156	0
132	162	0
132	311	0
132	345	0
132	377	0
132	410	0
132	538	0
132	562	0
132	586	0
132	626	0
132	637	0
132	698	0
132	756	0
132	806	0
132	897	0
132	899	0
132	904	0
132	930	0
132	987	0
133	7	0
133	51	0
133	133	0
133	172	0
133	210	0
133	270	0
133	280	0
133	286	0
133	338	0
133	342	0
133	351	0
133	368	0
133	385	0
133	390	0
133	397	0
133	410	0
133	452	0
133	463	0
133	514	0
133	588	0
133	594	0
133	635	0
133	652	0
133	727	0
133	806	0
133	868	0
133	882	0
133	894	0
133	933	0
133	952	0
134	132	0
134	145	0
134	161	0
134	219	0
134	243	0
134	250	0
134	278	0
134	341	0
134	386	0
134	413	0
134	558	0
134	588	0
134	624	0
134	655	0
134	683	0
134	690	0
134	861	0
134	896	0
134	897	0
134	915	0
134	927	0
134	936	0
135	35	0
135	41	0
135	65	0
135	88	0
135	170	0
135	269	0
135	320	0
135	353	0
135	357	0
135	364	0
135	455	0
135	458	0
135	484	0
135	541	0
135	553	0
135	616	0
135	628	0
135	719	0
135	814	0
135	905	0
136	20	0
136	25	0
136	33	0
136	56	0
136	61	0
136	193	0
136	214	0
136	229	0
136	243	0
136	256	0
136	262	0
136	271	0
136	288	0
136	300	0
136	364	0
136	401	0
136	414	0
136	420	0
136	474	0
136	485	0
136	542	0
136	552	0
136	620	0
136	649	0
136	686	0
136	781	0
136	806	0
136	808	0
136	818	0
136	842	0
136	933	0
136	993	0
137	6	0
137	14	0
137	56	0
137	96	0
137	160	0
137	224	0
137	249	0
137	254	0
137	263	0
137	268	0
137	304	0
137	390	0
137	410	0
137	433	0
137	446	0
137	489	0
137	530	0
137	564	0
137	603	0
137	610	0
137	688	0
137	703	0
137	745	0
137	758	0
137	832	0
137	841	0
137	917	0
138	8	0
138	52	0
138	61	0
138	125	0
138	157	0
138	214	0
138	258	0
138	376	0
138	403	0
138	446	0
138	453	0
138	508	0
138	553	0
138	561	0
138	583	0
138	627	0
138	639	0
138	695	0
138	747	0
138	879	0
138	885	0
138	923	0
138	970	0
138	989	0
139	20	0
139	35	0
139	57	0
139	74	0
139	90	0
139	107	0
139	155	0
139	170	0
139	181	0
139	200	0
139	229	0
139	233	0
139	261	0
139	262	0
139	266	0
139	282	0
139	284	0
139	373	0
139	447	0
139	489	0
139	529	0
139	540	0
139	570	0
139	602	0
139	605	0
139	636	0
139	691	0
139	706	0
139	719	0
139	744	0
139	746	0
139	862	0
139	892	0
140	27	0
140	77	0
140	112	0
140	135	0
140	185	0
140	258	0
140	370	0
140	373	0
140	498	0
140	509	0
140	576	0
140	587	0
140	599	0
140	608	0
140	647	0
140	665	0
140	670	0
140	693	0
140	702	0
140	729	0
140	730	0
140	731	0
140	736	0
140	742	0
140	778	0
140	820	0
140	830	0
140	835	0
140	857	0
140	923	0
140	934	0
140	999	0
141	43	0
141	67	0
141	188	0
141	191	0
141	207	0
141	223	0
141	341	0
141	358	0
141	380	0
141	395	0
141	467	0
141	491	0
141	589	0
141	607	0
141	673	0
141	740	0
141	752	0
141	768	0
141	772	0
141	787	0
141	821	0
141	829	0
141	840	0
141	849	0
141	862	0
141	863	0
141	909	0
141	992	0
142	10	0
142	18	0
142	107	0
142	139	0
142	186	0
142	199	0
142	248	0
142	328	0
142	350	0
142	371	0
142	470	0
142	481	0
142	494	0
142	501	0
142	504	0
142	540	0
142	554	0
142	575	0
142	608	0
142	710	0
142	712	0
142	735	0
142	759	0
142	794	0
142	842	0
142	859	0
142	863	0
142	875	0
142	906	0
142	914	0
142	999	0
143	47	0
143	79	0
143	141	0
143	175	0
143	232	0
143	239	0
143	316	0
143	339	0
143	361	0
143	386	0
143	404	0
143	457	0
143	485	0
143	497	0
143	560	0
143	576	0
143	603	0
143	613	0
143	659	0
143	660	0
143	680	0
143	687	0
143	690	0
143	706	0
143	792	0
143	821	0
143	830	0
143	872	0
143	878	0
143	906	0
143	958	0
144	18	0
144	67	0
144	79	0
144	90	0
144	99	0
144	105	0
144	123	0
144	125	0
144	127	0
144	130	0
144	135	0
144	164	0
144	184	0
144	216	0
144	228	0
144	260	0
144	272	0
144	291	0
144	293	0
144	312	0
144	393	0
144	396	0
144	473	0
144	504	0
144	540	0
144	599	0
144	668	0
144	702	0
144	753	0
144	762	0
144	776	0
144	785	0
144	845	0
144	894	0
144	953	0
145	39	0
145	109	0
145	120	0
145	154	0
145	155	0
145	243	0
145	293	0
145	402	0
145	409	0
145	457	0
145	475	0
145	487	0
145	494	0
145	527	0
145	592	0
145	625	0
145	629	0
145	641	0
145	661	0
145	664	0
145	692	0
145	713	0
145	726	0
145	748	0
145	822	0
145	893	0
145	923	0
145	953	0
146	12	0
146	16	0
146	33	0
146	117	0
146	177	0
146	191	0
146	197	0
146	207	0
146	218	0
146	278	0
146	296	0
146	314	0
146	320	0
146	372	0
146	384	0
146	402	0
146	410	0
146	427	0
146	429	0
146	512	0
146	514	0
146	571	0
146	591	0
146	720	0
146	731	0
146	734	0
146	871	0
146	909	0
146	922	0
146	945	0
146	955	0
146	966	0
146	969	0
147	4	0
147	85	0
147	131	0
147	139	0
147	145	0
147	178	0
147	251	0
147	254	0
147	295	0
147	298	0
147	305	0
147	310	0
147	318	0
147	333	0
147	341	0
147	351	0
147	394	0
147	402	0
147	405	0
147	410	0
147	431	0
147	443	0
147	508	0
147	554	0
147	563	0
147	649	0
147	688	0
147	708	0
147	864	0
147	957	0
147	987	0
148	27	0
148	57	0
148	133	0
148	149	0
148	226	0
148	342	0
148	368	0
148	422	0
148	468	0
148	633	0
148	718	0
148	768	0
148	772	0
148	792	0
149	53	0
149	72	0
149	95	0
149	118	0
149	139	0
149	146	0
149	153	0
149	159	0
149	169	0
149	178	0
149	188	0
149	193	0
149	339	0
149	354	0
149	362	0
149	365	0
149	458	0
149	631	0
149	670	0
149	685	0
149	761	0
149	782	0
149	810	0
149	811	0
149	899	0
149	905	0
149	913	0
149	921	0
149	947	0
149	949	0
149	992	0
150	23	0
150	63	0
150	75	0
150	94	0
150	105	0
150	168	0
150	190	0
150	206	0
150	233	0
150	270	0
150	285	0
150	306	0
150	386	0
150	433	0
150	446	0
150	447	0
150	468	0
150	508	0
150	542	0
150	551	0
150	629	0
150	647	0
150	672	0
150	697	0
150	728	0
150	777	0
150	854	0
150	873	0
150	880	0
150	887	0
150	889	0
150	892	0
150	953	0
150	962	0
151	131	0
151	144	0
151	167	0
151	170	0
151	217	0
151	232	0
151	342	0
151	367	0
151	370	0
151	382	0
151	451	0
151	463	0
151	482	0
151	501	0
151	527	0
151	539	0
151	570	0
151	574	0
151	634	0
151	658	0
151	665	0
151	703	0
151	880	0
151	892	0
151	895	0
151	989	0
152	59	0
152	153	0
152	217	0
152	248	0
152	318	0
152	332	0
152	475	0
152	476	0
152	578	0
152	607	0
152	611	0
152	615	0
152	674	0
152	680	0
152	729	0
152	768	0
152	821	0
152	846	0
152	891	0
152	898	0
152	927	0
152	964	0
152	968	0
153	47	0
153	64	0
153	136	0
153	180	0
153	203	0
153	231	0
153	444	0
153	476	0
153	480	0
153	486	0
153	536	0
153	627	0
153	732	0
153	756	0
153	766	0
153	817	0
153	847	0
153	919	0
153	938	0
153	988	0
154	27	0
154	111	0
154	141	0
154	158	0
154	169	0
154	170	0
154	193	0
154	208	0
154	274	0
154	276	0
154	282	0
154	299	0
154	314	0
154	396	0
154	399	0
154	421	0
154	440	0
154	467	0
154	474	0
154	489	0
154	588	0
154	602	0
154	680	0
154	698	0
154	802	0
154	842	0
154	954	0
154	988	0
155	20	0
155	67	0
155	128	0
155	153	0
155	220	0
155	249	0
155	303	0
155	312	0
155	359	0
155	361	0
155	383	0
155	387	0
155	407	0
155	427	0
155	459	0
155	513	0
155	584	0
155	590	0
155	630	0
155	688	0
155	757	0
155	768	0
155	785	0
155	849	0
155	885	0
155	890	0
155	941	0
155	966	0
155	987	0
155	997	0
155	1000	0
156	53	0
156	155	0
156	198	0
156	244	0
156	262	0
156	263	0
156	285	0
156	297	0
156	301	0
156	349	0
156	379	0
156	448	0
156	462	0
156	467	0
156	504	0
156	518	0
156	593	0
156	646	0
156	705	0
156	754	0
156	775	0
156	844	0
157	10	0
157	24	0
157	34	0
157	122	0
157	159	0
157	183	0
157	210	0
157	217	0
157	291	0
157	303	0
157	321	0
157	326	0
157	353	0
157	400	0
157	406	0
157	431	0
157	496	0
157	535	0
157	573	0
157	574	0
157	604	0
157	616	0
157	642	0
157	661	0
157	696	0
157	713	0
157	802	0
157	835	0
157	874	0
157	913	0
157	967	0
157	973	0
158	32	0
158	47	0
158	64	0
158	66	0
158	102	0
158	121	0
158	177	0
158	178	0
158	188	0
158	215	0
158	241	0
158	293	0
158	437	0
158	473	0
158	483	0
158	532	0
158	555	0
158	581	0
158	601	0
158	616	0
158	626	0
158	637	0
158	799	0
158	812	0
158	824	0
158	830	0
158	840	0
158	869	0
158	879	0
158	880	0
158	894	0
158	896	0
158	967	0
158	968	0
158	990	0
159	20	0
159	82	0
159	127	0
159	187	0
159	206	0
159	208	0
159	223	0
159	248	0
159	342	0
159	343	0
159	344	0
159	364	0
159	418	0
159	549	0
159	561	0
159	600	0
159	674	0
159	680	0
159	784	0
159	789	0
159	800	0
159	802	0
159	818	0
159	876	0
159	907	0
159	978	0
160	2	0
160	17	0
160	43	0
160	242	0
160	267	0
160	275	0
160	368	0
160	455	0
160	469	0
160	484	0
160	579	0
160	660	0
160	755	0
160	767	0
160	769	0
160	794	0
160	826	0
160	883	0
160	950	0
160	954	0
161	43	0
161	58	0
161	89	0
161	90	0
161	120	0
161	188	0
161	247	0
161	269	0
161	281	0
161	340	0
161	353	0
161	401	0
161	414	0
161	425	0
161	469	0
161	526	0
161	588	0
161	644	0
161	653	0
161	655	0
161	669	0
161	684	0
161	714	0
161	749	0
161	807	0
161	825	0
161	850	0
161	880	0
161	920	0
161	921	0
161	924	0
161	927	0
162	1	2
162	4	0
162	7	0
162	18	0
162	28	0
162	32	0
162	33	0
162	41	0
162	85	0
162	121	0
162	164	0
162	274	0
162	279	0
162	409	0
162	410	0
162	415	0
162	500	0
162	574	0
162	612	0
162	636	0
162	659	0
162	786	0
162	844	0
162	909	0
162	968	0
163	30	0
163	45	0
163	166	0
163	180	0
163	239	0
163	283	0
163	303	0
163	304	0
163	307	0
163	394	0
163	409	0
163	434	0
163	444	0
163	522	0
163	719	0
163	785	0
163	833	0
163	881	0
163	891	0
163	947	0
163	996	0
164	15	0
164	23	0
164	148	0
164	169	0
164	252	0
164	324	0
164	347	0
164	367	0
164	431	0
164	448	0
164	469	0
164	545	0
164	610	0
164	613	0
164	673	0
164	681	0
164	698	0
164	801	0
164	820	0
164	832	0
164	834	0
164	851	0
164	884	0
164	908	0
164	957	0
164	984	0
165	72	0
165	95	0
165	146	0
165	204	0
165	253	0
165	286	0
165	360	0
165	375	0
165	395	0
165	421	0
165	437	0
165	473	0
165	607	0
165	644	0
165	659	0
165	693	0
165	737	0
165	779	0
165	798	0
165	807	0
165	809	0
165	832	0
165	833	0
165	947	0
165	948	0
165	962	0
166	25	0
166	38	0
166	55	0
166	61	0
166	68	0
166	86	0
166	146	0
166	255	0
166	297	0
166	306	0
166	326	0
166	361	0
166	366	0
166	426	0
166	580	0
166	622	0
166	674	0
166	714	0
166	788	0
166	867	0
166	944	0
166	1000	0
167	17	0
167	25	0
167	63	0
167	72	0
167	107	0
167	120	0
167	191	0
167	294	0
167	319	0
167	339	0
167	341	0
167	496	0
167	554	0
167	626	0
167	628	0
167	672	0
167	692	0
167	717	0
167	734	0
167	794	0
167	800	0
167	802	0
167	856	0
167	864	0
167	882	0
167	923	0
168	32	0
168	56	0
168	92	0
168	115	0
168	188	0
168	196	0
168	208	0
168	237	0
168	241	0
168	255	0
168	305	0
168	336	0
168	387	0
168	433	0
168	438	0
168	519	0
168	602	0
168	619	0
168	626	0
168	652	0
168	678	0
168	685	0
168	804	0
168	807	0
168	826	0
168	841	0
168	886	0
168	889	0
168	892	0
168	927	0
168	959	0
169	6	0
169	78	0
169	93	0
169	246	0
169	248	0
169	289	0
169	301	0
169	326	0
169	349	0
169	372	0
169	398	0
169	434	0
169	505	0
169	564	0
169	571	0
169	634	0
169	642	0
169	673	0
169	694	0
169	727	0
169	778	0
169	815	0
169	847	0
169	849	0
169	894	0
169	897	0
169	954	0
169	992	0
169	998	0
170	7	0
170	15	0
170	27	0
170	33	0
170	102	0
170	139	0
170	180	0
170	184	0
170	212	0
170	299	0
170	322	0
170	358	0
170	416	0
170	508	0
170	537	0
170	705	0
170	758	0
170	764	0
170	868	0
170	877	0
170	886	0
170	925	0
170	993	0
170	996	0
171	49	0
171	146	0
171	166	0
171	181	0
171	219	0
171	273	0
171	296	0
171	318	0
171	342	0
171	397	0
171	447	0
171	450	0
171	466	0
171	549	0
171	560	0
171	566	0
171	608	0
171	625	0
171	645	0
171	701	0
171	761	0
171	779	0
171	849	0
171	872	0
171	892	0
171	898	0
171	903	0
171	953	0
172	57	0
172	100	0
172	148	0
172	215	0
172	302	0
172	345	0
172	368	0
172	385	0
172	423	0
172	487	0
172	493	0
172	529	0
172	538	0
172	567	0
172	609	0
172	639	0
172	649	0
172	661	0
172	667	0
172	710	0
172	744	0
172	758	0
172	771	0
172	833	0
172	959	0
173	49	0
173	55	0
173	74	0
173	80	0
173	106	0
173	154	0
173	162	0
173	188	0
173	235	0
173	313	0
173	379	0
173	405	0
173	491	0
173	496	0
173	529	0
173	550	0
173	564	0
173	571	0
173	592	0
173	688	0
173	753	0
173	757	0
173	852	0
173	857	0
173	921	0
173	928	0
173	933	0
174	11	0
174	61	0
174	168	0
174	298	0
174	352	0
174	442	0
174	451	0
174	496	0
174	610	0
174	618	0
174	622	0
174	659	0
174	677	0
174	705	0
174	722	0
174	780	0
174	797	0
174	809	0
174	827	0
174	830	0
174	852	0
174	853	0
174	879	0
174	982	0
175	9	0
175	29	0
175	67	0
175	129	0
175	155	0
175	190	0
175	191	0
175	362	0
175	405	0
175	424	0
175	439	0
175	442	0
175	483	0
175	591	0
175	596	0
175	616	0
175	719	0
175	729	0
175	772	0
175	778	0
175	828	0
175	842	0
175	890	0
175	908	0
175	977	0
175	978	0
175	998	0
176	13	0
176	73	0
176	89	0
176	150	0
176	162	0
176	238	0
176	252	0
176	303	0
176	320	0
176	401	0
176	417	0
176	441	0
176	458	0
176	461	0
176	517	0
176	521	0
176	543	0
176	573	0
176	699	0
176	726	0
176	740	0
176	746	0
176	758	0
176	802	0
176	827	0
176	839	0
176	859	0
176	872	0
176	946	0
177	12	0
177	39	0
177	52	0
177	55	0
177	86	0
177	175	0
177	188	0
177	235	0
177	237	0
177	289	0
177	363	0
177	401	0
177	433	0
177	458	0
177	522	0
177	543	0
177	563	0
177	649	0
177	683	0
177	684	0
177	726	0
177	751	0
177	763	0
177	764	0
177	827	0
177	910	0
177	956	0
178	30	0
178	34	0
178	109	0
178	146	0
178	160	0
178	164	0
178	194	0
178	197	0
178	273	0
178	311	0
178	397	0
178	483	0
178	517	0
178	537	0
178	587	0
178	708	0
178	733	0
178	744	0
178	762	0
178	930	0
178	974	0
178	983	0
178	1000	0
179	24	0
179	27	0
179	65	0
179	85	0
179	109	0
179	131	0
179	159	0
179	193	0
179	250	0
179	291	0
179	353	0
179	415	0
179	463	0
179	468	0
179	489	0
179	566	0
179	588	0
179	650	0
179	698	0
179	732	0
179	737	0
179	769	0
179	811	0
179	817	0
179	852	0
179	924	0
179	931	0
179	960	0
179	976	0
180	12	0
180	33	0
180	144	0
180	195	0
180	258	0
180	441	0
180	506	0
180	561	0
180	609	0
180	622	0
180	628	0
180	657	0
180	724	0
180	729	0
180	732	0
180	777	0
180	809	0
180	811	0
180	820	0
180	824	0
180	847	0
180	869	0
180	874	0
180	955	0
180	963	0
181	5	0
181	40	0
181	74	0
181	78	0
181	83	0
181	152	0
181	195	0
181	233	0
181	286	0
181	301	0
181	311	0
181	381	0
181	387	0
181	403	0
181	409	0
181	420	0
181	437	0
181	456	0
181	507	0
181	522	0
181	539	0
181	542	0
181	546	0
181	579	0
181	596	0
181	604	0
181	609	0
181	625	0
181	744	0
181	816	0
181	836	0
181	868	0
181	870	0
181	874	0
181	892	0
181	907	0
181	911	0
181	921	0
181	991	0
182	33	0
182	160	0
182	301	0
182	324	0
182	346	0
182	362	0
182	391	0
182	413	0
182	421	0
182	437	0
182	590	0
182	639	0
182	668	0
182	677	0
182	679	0
182	695	0
182	714	0
182	720	0
182	819	0
182	828	0
182	845	0
182	864	0
182	940	0
182	990	0
183	32	0
183	40	0
183	71	0
183	113	0
183	313	0
183	388	0
183	389	0
183	390	0
183	495	0
183	520	0
183	576	0
183	636	0
183	715	0
183	850	0
183	862	0
183	914	0
183	941	0
183	949	0
183	983	0
184	35	0
184	87	0
184	146	0
184	169	0
184	221	0
184	336	0
184	371	0
184	452	0
184	486	0
184	492	0
184	500	0
184	574	0
184	580	0
184	597	0
184	615	0
184	640	0
184	642	0
184	650	0
184	661	0
184	684	0
184	745	0
184	772	0
184	787	0
184	867	0
184	959	0
184	966	0
184	967	0
184	969	0
184	985	0
185	7	0
185	95	0
185	138	0
185	265	0
185	286	0
185	360	0
185	411	0
185	427	0
185	437	0
185	448	0
185	494	0
185	510	0
185	518	0
185	554	0
185	560	0
185	571	0
185	584	0
185	631	0
185	665	0
185	694	0
185	730	0
185	761	0
185	818	0
185	845	0
185	880	0
185	882	0
185	919	0
185	920	0
185	965	0
185	973	0
186	95	0
186	187	0
186	208	0
186	228	0
186	237	0
186	422	0
186	482	0
186	508	0
186	552	0
186	579	0
186	637	0
186	648	0
186	654	0
186	729	0
186	983	0
186	994	0
187	17	0
187	25	0
187	29	0
187	51	0
187	73	0
187	76	0
187	98	0
187	110	0
187	127	0
187	168	0
187	222	0
187	224	0
187	297	0
187	354	0
187	379	0
187	417	0
187	435	0
187	441	0
187	474	0
187	499	0
187	538	0
187	548	0
187	561	0
187	617	0
187	625	0
187	664	0
187	671	0
187	768	0
187	779	0
187	906	0
187	914	0
187	923	0
187	976	0
188	1	1
188	10	0
188	14	0
188	51	0
188	102	0
188	111	0
188	146	0
188	206	0
188	223	0
188	289	0
188	311	0
188	322	0
188	338	0
188	396	0
188	412	0
188	506	0
188	517	0
188	529	0
188	566	0
188	593	0
188	606	0
188	662	0
188	770	0
188	773	0
188	774	0
188	815	0
188	849	0
188	925	0
188	988	0
188	989	0
189	43	0
189	82	0
189	171	0
189	266	0
189	272	0
189	315	0
189	378	0
189	492	0
189	509	0
189	512	0
189	519	0
189	533	0
189	548	0
189	560	0
189	628	0
189	734	0
189	748	0
189	788	0
189	820	0
189	853	0
189	882	0
189	896	0
189	899	0
189	940	0
190	38	0
190	54	0
190	62	0
190	87	0
190	173	0
190	234	0
190	253	0
190	278	0
190	310	0
190	374	0
190	411	0
190	426	0
190	472	0
190	549	0
190	562	0
190	606	0
190	623	0
190	679	0
190	682	0
190	693	0
190	695	0
190	705	0
190	708	0
190	802	0
190	806	0
190	874	0
190	959	0
191	16	0
191	39	0
191	84	0
191	185	0
191	219	0
191	293	0
191	296	0
191	378	0
191	410	0
191	420	0
191	461	0
191	544	0
191	551	0
191	596	0
191	638	0
191	668	0
191	692	0
191	775	0
191	801	0
191	819	0
191	827	0
191	830	0
191	834	0
191	849	0
191	858	0
191	914	0
191	958	0
191	969	0
191	971	0
191	993	0
192	16	0
192	69	0
192	117	0
192	155	0
192	166	0
192	179	0
192	214	0
192	361	0
192	367	0
192	426	0
192	465	0
192	470	0
192	475	0
192	485	0
192	541	0
192	578	0
192	592	0
192	614	0
192	618	0
192	622	0
192	674	0
192	677	0
192	680	0
192	682	0
192	708	0
192	711	0
192	747	0
192	763	0
192	819	0
193	44	0
193	80	0
193	103	0
193	109	0
193	119	0
193	141	0
193	164	0
193	291	0
193	352	0
193	358	0
193	376	0
193	412	0
193	462	0
193	689	0
193	709	0
193	745	0
193	807	0
193	828	0
193	834	0
193	851	0
193	937	0
193	953	0
193	960	0
194	9	0
194	42	0
194	67	0
194	86	0
194	88	0
194	98	0
194	135	0
194	161	0
194	163	0
194	215	0
194	232	0
194	352	0
194	415	0
194	486	0
194	498	0
194	531	0
194	719	0
194	738	0
194	786	0
194	872	0
194	938	0
194	940	0
195	129	0
195	130	0
195	141	0
195	144	0
195	298	0
195	359	0
195	361	0
195	392	0
195	403	0
195	494	0
195	520	0
195	534	0
195	560	0
195	592	0
195	649	0
195	658	0
195	673	0
195	677	0
195	706	0
195	738	0
195	769	0
195	781	0
195	794	0
195	813	0
195	869	0
195	885	0
195	962	0
196	64	0
196	122	0
196	156	0
196	169	0
196	276	0
196	284	0
196	303	0
196	324	0
196	423	0
196	473	0
196	484	0
196	515	0
196	524	0
196	541	0
196	560	0
196	575	0
196	576	0
196	587	0
196	615	0
196	635	0
196	684	0
196	795	0
196	815	0
196	833	0
196	837	0
196	906	0
196	908	0
196	919	0
196	939	0
196	972	0
197	6	0
197	29	0
197	63	0
197	123	0
197	129	0
197	147	0
197	164	0
197	189	0
197	243	0
197	249	0
197	258	0
197	364	0
197	369	0
197	370	0
197	418	0
197	522	0
197	531	0
197	554	0
197	598	0
197	628	0
197	691	0
197	724	0
197	746	0
197	752	0
197	758	0
197	769	0
197	815	0
197	916	0
197	950	0
197	967	0
197	974	0
197	979	0
197	995	0
198	1	9
198	109	0
198	125	0
198	186	0
198	262	0
198	264	0
198	303	0
198	309	0
198	311	0
198	329	0
198	347	0
198	379	0
198	395	0
198	406	0
198	450	0
198	464	0
198	482	0
198	499	0
198	536	0
198	541	0
198	545	0
198	555	0
198	568	0
198	570	0
198	588	0
198	597	0
198	628	0
198	745	0
198	758	0
198	796	0
198	806	0
198	817	0
198	843	0
198	858	0
198	871	0
198	886	0
198	892	0
198	924	0
198	952	0
198	997	0
199	67	0
199	84	0
199	145	0
199	159	0
199	216	0
199	432	0
199	541	0
199	604	0
199	640	0
199	689	0
199	730	0
199	784	0
199	785	0
199	886	0
199	953	0
200	5	0
200	49	0
200	80	0
200	116	0
200	121	0
200	149	0
200	346	0
200	419	0
200	462	0
200	465	0
200	474	0
200	537	0
200	538	0
200	544	0
200	714	0
200	879	0
200	912	0
200	945	0
200	958	0
200	993	0
\.


--
-- Data for Name: film_category; Type: TABLE DATA; Schema: public; Owner: root
--

COPY film_category (film_id, category_id) FROM stdin;
1	6
2	11
3	6
4	11
5	8
6	9
7	5
8	11
9	11
10	15
11	9
12	12
13	11
14	4
15	9
16	9
17	12
18	2
19	1
20	12
21	1
22	13
23	2
24	11
25	13
26	14
27	15
28	5
29	1
30	11
31	8
32	13
33	7
34	11
35	11
36	2
37	4
38	1
39	14
40	6
41	16
42	15
43	8
44	14
45	13
46	10
47	9
48	3
49	14
50	8
51	12
52	9
53	8
54	12
55	14
56	1
57	16
58	6
59	3
60	4
61	7
62	6
63	8
64	7
65	11
66	3
67	1
68	3
69	14
70	2
71	8
72	6
73	14
74	12
75	16
76	12
77	13
78	2
79	7
80	8
81	14
82	8
83	8
84	16
85	6
86	12
87	16
88	16
89	2
90	13
91	4
92	11
93	13
94	8
95	13
96	13
97	1
98	7
99	5
100	9
101	6
102	15
103	16
104	9
105	1
106	10
107	7
108	13
109	13
110	3
111	1
112	9
113	15
114	14
115	1
116	4
117	10
118	2
119	5
120	15
121	2
122	11
123	16
124	3
125	16
126	1
127	5
128	9
129	6
130	1
131	4
132	14
133	12
134	2
135	15
136	13
137	14
138	14
139	8
140	14
141	10
142	6
143	7
144	13
145	8
146	7
147	8
148	9
149	3
150	6
151	14
152	3
153	14
154	2
155	13
156	6
157	3
158	12
159	5
160	2
161	12
162	1
163	13
164	6
165	14
166	4
167	16
168	3
169	16
170	9
171	11
172	7
173	7
174	12
175	8
176	15
177	14
178	5
179	7
180	4
181	16
182	5
183	8
184	4
185	9
186	7
187	15
188	5
189	10
190	4
191	3
192	9
193	2
194	1
195	14
196	4
197	15
198	9
199	6
200	10
201	9
202	5
203	14
204	7
205	1
206	6
207	9
208	2
209	7
210	1
211	10
212	1
213	8
214	3
215	10
216	13
217	10
218	7
219	6
220	12
221	6
222	11
223	2
224	16
225	7
226	13
227	10
228	4
229	1
230	7
231	8
232	10
233	16
234	14
235	14
236	10
237	15
238	3
239	2
240	14
241	2
242	5
243	2
244	12
245	2
246	9
247	5
248	6
249	4
250	1
251	13
252	1
253	1
254	15
255	12
256	15
257	16
258	11
259	2
260	15
261	6
262	8
263	15
264	10
265	5
266	4
267	13
268	2
269	8
270	13
271	1
272	7
273	8
274	6
275	11
276	5
277	11
278	12
279	15
280	3
281	10
282	7
283	13
284	12
285	14
286	16
287	1
288	16
289	13
290	9
291	15
292	1
293	15
294	16
295	6
296	14
297	4
298	14
299	16
300	2
301	11
302	10
303	1
304	3
305	13
306	10
307	16
308	5
309	8
310	10
311	9
312	14
313	11
314	2
315	8
316	10
317	5
318	1
319	14
320	13
321	13
322	15
323	15
324	5
325	2
326	2
327	1
328	3
329	1
330	2
331	10
332	5
333	12
334	11
335	5
336	6
337	9
338	14
339	16
340	13
341	4
342	16
343	3
344	3
345	8
346	4
347	16
348	8
349	2
350	14
351	11
352	10
353	9
354	3
355	2
356	3
357	4
358	4
359	8
360	1
361	15
362	10
363	12
364	13
365	5
366	7
367	14
368	7
369	14
370	3
371	1
372	15
373	3
374	14
375	1
376	9
377	8
378	12
379	7
380	9
381	10
382	10
383	15
384	12
385	5
386	16
387	10
388	5
389	15
390	14
391	8
392	3
393	6
394	14
395	1
396	7
397	14
398	12
399	9
400	6
401	7
402	2
403	7
404	5
405	16
406	10
407	6
408	10
409	3
410	5
411	12
412	6
413	5
414	9
415	11
416	9
417	1
418	7
419	8
420	15
421	9
422	14
423	3
424	3
425	4
426	12
427	6
428	8
429	15
430	2
431	9
432	4
433	2
434	16
435	9
436	13
437	8
438	10
439	7
440	9
441	6
442	8
443	5
444	5
445	4
446	15
447	10
448	13
449	14
450	3
451	16
452	9
453	15
454	12
455	9
456	2
457	6
458	8
459	9
460	9
461	2
462	12
463	15
464	2
465	13
466	6
467	9
468	3
469	4
470	2
471	4
472	16
473	7
474	15
475	11
476	8
477	12
478	5
479	8
480	4
481	13
482	4
483	10
484	4
485	3
486	9
487	4
488	15
489	2
490	13
491	3
492	13
493	9
494	11
495	11
496	16
497	6
498	8
499	8
500	9
501	1
502	5
503	15
504	7
505	3
506	11
507	10
508	10
509	3
510	2
511	1
512	4
513	16
514	7
515	3
516	12
517	15
518	16
519	15
520	14
521	7
522	5
523	4
524	5
525	4
526	16
527	11
528	8
529	5
530	1
531	9
532	15
533	9
534	8
535	11
536	4
537	4
538	13
539	7
540	12
541	2
542	1
543	16
544	6
545	9
546	10
547	3
548	4
549	1
550	8
551	13
552	6
553	3
554	4
555	5
556	10
557	8
558	13
559	14
560	10
561	13
562	12
563	10
564	2
565	9
566	9
567	9
568	5
569	2
570	15
571	6
572	14
573	3
574	1
575	6
576	6
577	15
578	4
579	1
580	13
581	12
582	2
583	2
584	9
585	7
586	1
587	6
588	3
589	6
590	13
591	10
592	12
593	11
594	1
595	9
596	10
597	10
598	15
599	15
600	11
601	16
602	14
603	8
604	5
605	9
606	15
607	9
608	3
609	16
610	8
611	4
612	15
613	5
614	10
615	2
616	6
617	8
618	7
619	15
620	14
621	8
622	6
623	9
624	10
625	14
626	3
627	6
628	15
629	6
630	7
631	15
632	13
633	4
634	8
635	13
636	12
637	14
638	5
639	8
640	9
641	9
642	16
643	7
644	2
645	16
646	10
647	12
648	16
649	2
650	6
651	2
652	4
653	11
654	10
655	14
656	16
657	5
658	11
659	1
660	5
661	9
662	7
663	4
664	1
665	11
666	7
667	15
668	15
669	9
670	6
671	15
672	5
673	12
674	9
675	13
676	15
677	13
678	15
679	8
680	5
681	15
682	8
683	7
684	10
685	13
686	13
687	6
688	3
689	9
690	2
691	15
692	2
693	2
694	4
695	8
696	2
697	1
698	6
699	10
700	8
701	10
702	11
703	2
704	5
705	9
706	7
707	1
708	6
709	7
710	8
711	14
712	6
713	6
714	14
715	8
716	11
717	1
718	12
719	15
720	13
721	12
722	11
723	14
724	8
725	4
726	9
727	8
728	7
729	15
730	13
731	4
732	1
733	15
734	6
735	3
736	8
737	11
738	9
739	7
740	11
741	12
742	10
743	2
744	4
745	15
746	10
747	10
748	1
749	11
750	13
751	13
752	12
753	8
754	5
755	3
756	5
757	6
758	7
759	13
760	13
761	3
762	10
763	15
764	15
765	5
766	7
767	12
768	3
769	9
770	9
771	7
772	7
773	15
774	5
775	7
776	6
777	15
778	8
779	15
780	8
781	10
782	15
783	16
784	16
785	16
786	3
787	16
788	6
789	9
790	7
791	6
792	9
793	1
794	1
795	8
796	15
797	12
798	14
799	11
800	11
801	3
802	1
803	7
804	11
805	2
806	13
807	10
808	4
809	15
810	8
811	16
812	6
813	15
814	5
815	4
816	2
817	14
818	7
819	12
820	2
821	9
822	8
823	1
824	8
825	1
826	16
827	7
828	4
829	8
830	11
831	14
832	8
833	3
834	6
835	10
836	15
837	5
838	1
839	14
840	10
841	15
842	10
843	4
844	15
845	9
846	13
847	13
848	16
849	2
850	1
851	15
852	3
853	3
854	11
855	6
856	11
857	5
858	5
859	2
860	14
861	10
862	4
863	14
864	3
865	2
866	8
867	8
868	16
869	1
870	11
871	5
872	16
873	3
874	4
875	15
876	11
877	12
878	16
879	12
880	2
881	11
882	7
883	3
884	12
885	11
886	2
887	2
888	6
889	3
890	15
891	4
892	2
893	14
894	16
895	4
896	3
897	7
898	15
899	4
900	9
901	2
902	15
903	16
904	11
905	5
906	5
907	7
908	9
909	11
910	7
911	1
912	14
913	13
914	16
915	1
916	2
917	15
918	3
919	10
920	13
921	12
922	11
923	7
924	14
925	6
926	6
927	1
928	3
929	9
930	14
931	16
932	5
933	13
934	10
935	13
936	12
937	13
938	5
939	5
940	15
941	10
942	7
943	6
944	7
945	6
946	8
947	9
948	13
949	10
950	4
951	4
952	6
953	2
954	13
955	3
956	10
957	9
958	7
959	3
960	6
961	9
962	4
963	2
964	1
965	11
966	6
967	14
968	1
969	7
970	4
971	9
972	14
973	6
974	13
975	8
976	10
977	16
978	5
979	7
980	12
981	16
982	1
983	12
984	9
985	14
986	2
987	12
988	16
989	16
990	11
991	1
992	6
993	3
994	13
995	11
996	6
997	12
998	11
999	3
1000	5
1005	2
1005	3
1005	1
1007	1
1009	1
1010	1
1011	1
1012	1
1013	1
1018	3
1018	5
1025	1
1	1
1021	1
1021	3
1023	1
1	6
2	11
3	6
4	11
5	8
6	9
7	5
8	11
9	11
10	15
11	9
12	12
13	11
14	4
15	9
16	9
17	12
18	2
19	1
20	12
21	1
22	13
23	2
24	11
25	13
26	14
27	15
28	5
29	1
30	11
31	8
32	13
33	7
34	11
35	11
36	2
37	4
38	1
39	14
40	6
41	16
42	15
43	8
44	14
45	13
46	10
47	9
48	3
49	14
50	8
51	12
52	9
53	8
54	12
55	14
56	1
57	16
58	6
59	3
60	4
61	7
62	6
63	8
64	7
65	11
66	3
67	1
68	3
69	14
70	2
71	8
72	6
73	14
74	12
75	16
76	12
77	13
78	2
79	7
80	8
81	14
82	8
83	8
84	16
85	6
86	12
87	16
88	16
89	2
90	13
91	4
92	11
93	13
94	8
95	13
96	13
97	1
98	7
99	5
100	9
101	6
102	15
103	16
104	9
105	1
106	10
107	7
108	13
109	13
110	3
111	1
112	9
113	15
114	14
115	1
116	4
117	10
118	2
119	5
120	15
121	2
122	11
123	16
124	3
125	16
126	1
127	5
128	9
129	6
130	1
131	4
132	14
133	12
134	2
135	15
136	13
137	14
138	14
139	8
140	14
141	10
142	6
143	7
144	13
145	8
146	7
147	8
148	9
149	3
150	6
151	14
152	3
153	14
154	2
155	13
156	6
157	3
158	12
159	5
160	2
161	12
162	1
163	13
164	6
165	14
166	4
167	16
168	3
169	16
170	9
171	11
172	7
173	7
174	12
175	8
176	15
177	14
178	5
179	7
180	4
181	16
182	5
183	8
184	4
185	9
186	7
187	15
188	5
189	10
190	4
191	3
192	9
193	2
194	1
195	14
196	4
197	15
198	9
199	6
200	10
201	9
202	5
203	14
204	7
205	1
206	6
207	9
208	2
209	7
210	1
211	10
212	1
213	8
214	3
215	10
216	13
217	10
218	7
219	6
220	12
221	6
222	11
223	2
224	16
225	7
226	13
227	10
228	4
229	1
230	7
231	8
232	10
233	16
234	14
235	14
236	10
237	15
238	3
239	2
240	14
241	2
242	5
243	2
244	12
245	2
246	9
247	5
248	6
249	4
250	1
251	13
252	1
253	1
254	15
255	12
256	15
257	16
258	11
259	2
260	15
261	6
262	8
263	15
264	10
265	5
266	4
267	13
268	2
269	8
270	13
271	1
272	7
273	8
274	6
275	11
276	5
277	11
278	12
279	15
280	3
281	10
282	7
283	13
284	12
285	14
286	16
287	1
288	16
289	13
290	9
291	15
292	1
293	15
294	16
295	6
296	14
297	4
298	14
299	16
300	2
301	11
302	10
303	1
304	3
305	13
306	10
307	16
308	5
309	8
310	10
311	9
312	14
313	11
314	2
315	8
316	10
317	5
318	1
319	14
320	13
321	13
322	15
323	15
324	5
325	2
326	2
327	1
328	3
329	1
330	2
331	10
332	5
333	12
334	11
335	5
336	6
337	9
338	14
339	16
340	13
341	4
342	16
343	3
344	3
345	8
346	4
347	16
348	8
349	2
350	14
351	11
352	10
353	9
354	3
355	2
356	3
357	4
358	4
359	8
360	1
361	15
362	10
363	12
364	13
365	5
366	7
367	14
368	7
369	14
370	3
371	1
372	15
373	3
374	14
375	1
376	9
377	8
378	12
379	7
380	9
381	10
382	10
383	15
384	12
385	5
386	16
387	10
388	5
389	15
390	14
391	8
392	3
393	6
394	14
395	1
396	7
397	14
398	12
399	9
400	6
401	7
402	2
403	7
404	5
405	16
406	10
407	6
408	10
409	3
410	5
411	12
412	6
413	5
414	9
415	11
416	9
417	1
418	7
419	8
420	15
421	9
422	14
423	3
424	3
425	4
426	12
427	6
428	8
429	15
430	2
431	9
432	4
433	2
434	16
435	9
436	13
437	8
438	10
439	7
440	9
441	6
442	8
443	5
444	5
445	4
446	15
447	10
448	13
449	14
450	3
451	16
452	9
453	15
454	12
455	9
456	2
457	6
458	8
459	9
460	9
461	2
462	12
463	15
464	2
465	13
466	6
467	9
468	3
469	4
470	2
471	4
472	16
473	7
474	15
475	11
476	8
477	12
478	5
479	8
480	4
481	13
482	4
483	10
484	4
485	3
486	9
487	4
488	15
489	2
490	13
491	3
492	13
493	9
494	11
495	11
496	16
497	6
498	8
499	8
500	9
501	1
502	5
503	15
504	7
505	3
506	11
507	10
508	10
509	3
510	2
511	1
512	4
513	16
514	7
515	3
516	12
517	15
518	16
519	15
520	14
521	7
522	5
523	4
524	5
525	4
526	16
527	11
528	8
529	5
530	1
531	9
532	15
533	9
534	8
535	11
536	4
537	4
538	13
539	7
540	12
541	2
542	1
543	16
544	6
545	9
546	10
547	3
548	4
549	1
550	8
551	13
552	6
553	3
554	4
555	5
556	10
557	8
558	13
559	14
560	10
561	13
562	12
563	10
564	2
565	9
566	9
567	9
568	5
569	2
570	15
571	6
572	14
573	3
574	1
575	6
576	6
577	15
578	4
579	1
580	13
581	12
582	2
583	2
584	9
585	7
586	1
587	6
588	3
589	6
590	13
591	10
592	12
593	11
594	1
595	9
596	10
597	10
598	15
599	15
600	11
601	16
602	14
603	8
604	5
605	9
606	15
607	9
608	3
609	16
610	8
611	4
612	15
613	5
614	10
615	2
616	6
617	8
618	7
619	15
620	14
621	8
622	6
623	9
624	10
625	14
626	3
627	6
628	15
629	6
630	7
631	15
632	13
633	4
634	8
635	13
636	12
637	14
638	5
639	8
640	9
641	9
642	16
643	7
644	2
645	16
646	10
647	12
648	16
649	2
650	6
651	2
652	4
653	11
654	10
655	14
656	16
657	5
658	11
659	1
660	5
661	9
662	7
663	4
664	1
665	11
666	7
667	15
668	15
669	9
670	6
671	15
672	5
673	12
674	9
675	13
676	15
677	13
678	15
679	8
680	5
681	15
682	8
683	7
684	10
685	13
686	13
687	6
688	3
689	9
690	2
691	15
692	2
693	2
694	4
695	8
696	2
697	1
698	6
699	10
700	8
701	10
702	11
703	2
704	5
705	9
706	7
707	1
708	6
709	7
710	8
711	14
712	6
713	6
714	14
715	8
716	11
717	1
718	12
719	15
720	13
721	12
722	11
723	14
724	8
725	4
726	9
727	8
728	7
729	15
730	13
731	4
732	1
733	15
734	6
735	3
736	8
737	11
738	9
739	7
740	11
741	12
742	10
743	2
744	4
745	15
746	10
747	10
748	1
749	11
750	13
751	13
752	12
753	8
754	5
755	3
756	5
757	6
758	7
759	13
760	13
761	3
762	10
763	15
764	15
765	5
766	7
767	12
768	3
769	9
770	9
771	7
772	7
773	15
774	5
775	7
776	6
777	15
778	8
779	15
780	8
781	10
782	15
783	16
784	16
785	16
786	3
787	16
788	6
789	9
790	7
791	6
792	9
793	1
794	1
795	8
796	15
797	12
798	14
799	11
800	11
801	3
802	1
803	7
804	11
805	2
806	13
807	10
808	4
809	15
810	8
811	16
812	6
813	15
814	5
815	4
816	2
817	14
818	7
819	12
820	2
821	9
822	8
823	1
824	8
825	1
826	16
827	7
828	4
829	8
830	11
831	14
832	8
833	3
834	6
835	10
836	15
837	5
838	1
839	14
840	10
841	15
842	10
843	4
844	15
845	9
846	13
847	13
848	16
849	2
850	1
851	15
852	3
853	3
854	11
855	6
856	11
857	5
858	5
859	2
860	14
861	10
862	4
863	14
864	3
865	2
866	8
867	8
868	16
869	1
870	11
871	5
872	16
873	3
874	4
875	15
876	11
877	12
878	16
879	12
880	2
881	11
882	7
883	3
884	12
885	11
886	2
887	2
888	6
889	3
890	15
891	4
892	2
893	14
894	16
895	4
896	3
897	7
898	15
899	4
900	9
901	2
902	15
903	16
904	11
905	5
906	5
907	7
908	9
909	11
910	7
911	1
912	14
913	13
914	16
915	1
916	2
917	15
918	3
919	10
920	13
921	12
922	11
923	7
924	14
925	6
926	6
927	1
928	3
929	9
930	14
931	16
932	5
933	13
934	10
935	13
936	12
937	13
938	5
939	5
940	15
941	10
942	7
943	6
944	7
945	6
946	8
947	9
948	13
949	10
950	4
951	4
952	6
953	2
954	13
955	3
956	10
957	9
958	7
959	3
960	6
961	9
962	4
963	2
964	1
965	11
966	6
967	14
968	1
969	7
970	4
971	9
972	14
973	6
974	13
975	8
976	10
977	16
978	5
979	7
980	12
981	16
982	1
983	12
984	9
985	14
986	2
987	12
988	16
989	16
990	11
991	1
992	6
993	3
994	13
995	11
996	6
997	12
998	11
999	3
1000	5
\.


--
-- Name: film_film_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('film_film_id_seq', 1001, true);


--
-- Data for Name: offices; Type: TABLE DATA; Schema: public; Owner: root
--

COPY offices ("officeCode", city, phone, "addressLine1", "addressLine2", state, country, "postalCode", territory) FROM stdin;
1	San Francisco	+1 650 219 4782	100 Market Street	Suite 300	CA	USA	94080	NA
2	Boston	+1 215 837 0825	1550 Court Place	Suite 102	MA	USA	02107	NA
3	NYC	+1 212 555 3000	523 East 53rd Street	apt. 5A	NY	USA	10022	NA
4	Paris	+33 14 723 4404	43 Rue Jouffroy D			France	75017	EMEA
5	Tokyo	+81 33 224 5000	4-1 Kioicho	\N	Chiyoda-Ku	Japan	102-8578	Japan
6	Sydney	+61 2 9264 2451	5-11 Wentworth Avenue	Floor #2	\N	Australia	NSW 2010	APAC
7	London	+44 20 7877 2041	25 Old Broad Street	Level 7	\N	UK	EC2N 1HN	EMEA
\.


--
-- Name: offices_officecode_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('offices_officecode_seq', 8, true);


--
-- Data for Name: orderdetails; Type: TABLE DATA; Schema: public; Owner: root
--

COPY orderdetails ("orderNumber", "productCode", "quantityOrdered", "priceEach", "orderLineNumber") FROM stdin;
10100	S18_1749	30	136	3
10100	S18_2248	50	55.0900000000000034	2
10100	S18_4409	22	75.4599999999999937	4
10100	S24_3969	49	35.2899999999999991	1
10101	S18_2325	25	108.060000000000002	4
10101	S18_2795	26	167.060000000000002	1
10101	S24_1937	45	32.5300000000000011	3
10101	S24_2022	46	44.3500000000000014	2
10102	S18_1342	39	95.5499999999999972	2
10102	S18_1367	41	43.1300000000000026	1
10103	S10_1949	26	214.300000000000011	11
10103	S10_4962	42	119.670000000000002	4
10103	S12_1666	27	121.640000000000001	8
10103	S18_1097	35	94.5	10
10103	S18_2432	22	58.3400000000000034	2
10103	S18_2949	27	92.1899999999999977	12
10103	S18_2957	35	61.8400000000000034	14
10103	S18_3136	25	86.9200000000000017	13
10103	S18_3320	46	86.3100000000000023	16
10103	S18_4600	36	98.0699999999999932	5
10103	S18_4668	41	40.75	9
10103	S24_2300	36	107.340000000000003	1
10103	S24_4258	25	88.6200000000000045	15
10103	S32_1268	31	92.4599999999999937	3
10103	S32_3522	45	63.3500000000000014	7
10103	S700_2824	42	94.0699999999999932	6
10104	S12_3148	34	131.439999999999998	1
10104	S12_4473	41	111.390000000000001	9
10104	S18_2238	24	135.900000000000006	8
10104	S18_2319	29	122.730000000000004	12
10104	S18_3232	23	165.949999999999989	13
10104	S18_4027	38	119.200000000000003	3
10104	S24_1444	35	52.0200000000000031	6
10104	S24_2840	44	30.4100000000000001	10
10104	S24_4048	26	106.450000000000003	5
10104	S32_2509	35	51.9500000000000028	11
10104	S32_3207	49	56.5499999999999972	4
10104	S50_1392	33	114.590000000000003	7
10104	S50_1514	32	53.3100000000000023	2
10105	S10_4757	50	127.840000000000003	2
10105	S12_1108	41	205.719999999999999	15
10105	S12_3891	29	141.879999999999995	14
10105	S18_3140	22	136.590000000000003	11
10105	S18_3259	38	87.730000000000004	13
10105	S18_4522	41	75.480000000000004	10
10105	S24_2011	43	117.969999999999999	9
10105	S24_3151	44	73.4599999999999937	4
10105	S24_3816	50	75.4699999999999989	1
10105	S700_1138	41	54	5
10105	S700_1938	29	86.6099999999999994	12
10105	S700_2610	31	60.7199999999999989	3
10105	S700_3505	39	92.1599999999999966	6
10105	S700_3962	22	99.3100000000000023	7
10105	S72_3212	25	44.7700000000000031	8
10106	S18_1662	36	134.039999999999992	12
10106	S18_2581	34	81.0999999999999943	2
10106	S18_3029	41	80.8599999999999994	18
10106	S18_3856	41	94.2199999999999989	17
10106	S24_1785	28	107.230000000000004	4
10106	S24_2841	49	65.769999999999996	13
10106	S24_3420	31	55.8900000000000006	14
10106	S24_3949	50	55.9600000000000009	11
10106	S24_4278	26	71	3
10106	S32_4289	33	65.3499999999999943	5
10106	S50_1341	39	35.7800000000000011	6
10106	S700_1691	31	91.3400000000000034	7
10106	S700_2047	30	85.0900000000000034	16
10106	S700_2466	34	99.7199999999999989	9
10106	S700_2834	32	113.900000000000006	1
10106	S700_3167	44	76	8
10106	S700_4002	48	70.3299999999999983	10
10106	S72_1253	48	43.7000000000000028	15
10107	S10_1678	30	81.3499999999999943	2
10107	S10_2016	39	105.859999999999999	5
10107	S10_4698	27	172.360000000000014	4
10107	S12_2823	21	122	1
10107	S18_2625	29	52.7000000000000028	6
10107	S24_1578	25	96.9200000000000017	3
10107	S24_2000	38	73.1200000000000045	7
10107	S32_1374	20	88.9000000000000057	8
10108	S12_1099	33	165.379999999999995	6
10108	S12_3380	45	96.2999999999999972	4
10108	S12_3990	39	75.8100000000000023	7
10108	S12_4675	36	107.099999999999994	3
10108	S18_1889	38	67.7600000000000051	2
10108	S18_3278	26	73.1700000000000017	9
10108	S18_3482	29	132.289999999999992	8
10108	S18_3782	43	52.8400000000000034	12
10108	S18_4721	44	139.870000000000005	11
10108	S24_2360	35	64.4099999999999966	15
10108	S24_3371	30	60.009999999999998	5
10108	S24_3856	40	132	1
10108	S24_4620	31	67.0999999999999943	10
10108	S32_2206	27	36.2100000000000009	13
10108	S32_4485	31	87.7600000000000051	16
10108	S50_4713	34	74.8499999999999943	14
10109	S18_1129	26	117.480000000000004	4
10109	S18_1984	38	137.97999999999999	3
10109	S18_2870	26	126.719999999999999	1
10109	S18_3232	46	160.870000000000005	5
10109	S18_3685	47	125.739999999999995	2
10109	S24_2972	29	32.1000000000000014	6
10110	S18_1589	37	118.219999999999999	16
10110	S18_1749	42	153	7
10110	S18_2248	32	51.4600000000000009	6
10110	S18_2325	33	115.689999999999998	4
10110	S18_2795	31	163.689999999999998	1
10110	S18_4409	28	81.9099999999999966	8
10110	S18_4933	42	62	9
10110	S24_1046	36	72.019999999999996	13
10110	S24_1628	29	43.2700000000000031	15
10110	S24_1937	20	28.879999999999999	3
10110	S24_2022	39	40.7700000000000031	2
10110	S24_2766	43	82.6899999999999977	11
10110	S24_2887	46	112.739999999999995	10
10110	S24_3191	27	80.4699999999999989	12
10110	S24_3432	37	96.3700000000000045	14
10110	S24_3969	48	35.2899999999999991	5
10111	S18_1342	33	87.3299999999999983	6
10111	S18_1367	48	48.5200000000000031	5
10111	S18_2957	28	53.0900000000000034	2
10111	S18_3136	43	94.25	1
10111	S18_3320	39	91.269999999999996	4
10111	S24_4258	26	85.7000000000000028	3
10112	S10_1949	29	197.159999999999997	1
10112	S18_2949	23	85.0999999999999943	2
10113	S12_1666	21	121.640000000000001	2
10113	S18_1097	49	101.5	4
10113	S18_4668	50	43.2700000000000031	3
10113	S32_3522	23	58.8200000000000003	1
10114	S10_4962	31	128.530000000000001	8
10114	S18_2319	39	106.780000000000001	3
10114	S18_2432	45	53.4799999999999969	6
10114	S18_3232	48	169.340000000000003	4
10114	S18_4600	41	105.340000000000003	9
10114	S24_2300	21	102.230000000000004	5
10114	S24_2840	24	28.6400000000000006	1
10114	S32_1268	32	88.6099999999999994	7
10114	S32_2509	28	43.8299999999999983	2
10114	S700_2824	42	82.9399999999999977	10
10115	S12_4473	46	111.390000000000001	5
10115	S18_2238	46	140.810000000000002	4
10115	S24_1444	47	56.6400000000000006	2
10115	S24_4048	44	106.450000000000003	1
10115	S50_1392	27	100.700000000000003	3
10116	S32_3207	27	60.2800000000000011	1
10117	S12_1108	33	195.330000000000013	9
10117	S12_3148	43	148.060000000000002	10
10117	S12_3891	39	173.02000000000001	8
10117	S18_3140	26	121.569999999999993	5
10117	S18_3259	21	81.6800000000000068	7
10117	S18_4027	22	122.079999999999998	12
10117	S18_4522	23	73.730000000000004	4
10117	S24_2011	41	119.200000000000003	3
10117	S50_1514	21	55.6499999999999986	11
10117	S700_1938	38	75.3499999999999943	6
10117	S700_3962	45	89.3799999999999955	1
10117	S72_3212	50	52.4200000000000017	2
10118	S700_3505	36	86.1500000000000057	1
10119	S10_4757	46	112.879999999999995	11
10119	S18_1662	43	151.379999999999995	3
10119	S18_3029	21	74.8400000000000034	9
10119	S18_3856	27	95.2800000000000011	8
10119	S24_2841	41	64.4000000000000057	4
10119	S24_3151	35	72.5799999999999983	13
10119	S24_3420	20	63.1199999999999974	5
10119	S24_3816	35	82.1800000000000068	10
10119	S24_3949	28	62.1000000000000014	2
10119	S700_1138	25	57.3400000000000034	14
10119	S700_2047	29	74.230000000000004	7
10119	S700_2610	38	67.2199999999999989	12
10119	S700_4002	26	63.6700000000000017	1
10119	S72_1253	28	40.2199999999999989	6
10120	S10_2016	29	118.939999999999998	3
10120	S10_4698	46	158.800000000000011	2
10120	S18_2581	29	82.7900000000000063	8
10120	S18_2625	46	57.5399999999999991	4
10120	S24_1578	35	110.450000000000003	1
10120	S24_1785	39	93.0100000000000051	10
10120	S24_2000	34	72.3599999999999994	5
10120	S24_4278	29	71.730000000000004	9
10120	S32_1374	22	94.9000000000000057	6
10120	S32_4289	29	68.7900000000000063	11
10120	S50_1341	49	41.4600000000000009	12
10120	S700_1691	47	91.3400000000000034	13
10120	S700_2466	24	81.769999999999996	15
10120	S700_2834	24	106.790000000000006	7
10120	S700_3167	43	72	14
10121	S10_1678	34	86.1299999999999955	5
10121	S12_2823	50	126.519999999999996	4
10121	S24_2360	32	58.1799999999999997	2
10121	S32_4485	25	95.9300000000000068	3
10121	S50_4713	44	72.4099999999999966	1
10122	S12_1099	42	155.659999999999997	10
10122	S12_3380	37	113.920000000000002	8
10122	S12_3990	32	65.4399999999999977	11
10122	S12_4675	20	104.799999999999997	7
10122	S18_1129	34	114.650000000000006	2
10122	S18_1889	43	62.3699999999999974	6
10122	S18_1984	31	113.799999999999997	1
10122	S18_3232	25	137.169999999999987	3
10122	S18_3278	21	69.1500000000000057	13
10122	S18_3482	21	133.759999999999991	12
10122	S18_3782	35	59.0600000000000023	16
10122	S18_4721	28	145.819999999999993	15
10122	S24_2972	39	34.740000000000002	4
10122	S24_3371	34	50.8200000000000003	9
10122	S24_3856	43	136.219999999999999	5
10122	S24_4620	29	67.0999999999999943	14
10122	S32_2206	31	33.7899999999999991	17
10123	S18_1589	26	120.709999999999994	2
10123	S18_2870	46	114.840000000000003	3
10123	S18_3685	34	117.260000000000005	4
10123	S24_1628	50	43.2700000000000031	1
10124	S18_1749	21	153	6
10124	S18_2248	42	58.1199999999999974	5
10124	S18_2325	42	111.870000000000005	3
10124	S18_4409	36	75.4599999999999937	7
10124	S18_4933	23	66.2800000000000011	8
10124	S24_1046	22	62.4699999999999989	12
10124	S24_1937	45	30.5300000000000011	2
10124	S24_2022	22	36.2899999999999991	1
10124	S24_2766	32	74.5100000000000051	10
10124	S24_2887	25	93.9500000000000028	9
10124	S24_3191	49	76.1899999999999977	11
10124	S24_3432	43	101.730000000000004	13
10124	S24_3969	46	36.1099999999999994	4
10125	S18_1342	32	89.3799999999999955	1
10125	S18_2795	34	138.379999999999995	2
10126	S10_1949	38	205.72999999999999	11
10126	S10_4962	22	122.620000000000005	4
10126	S12_1666	21	135.300000000000011	8
10126	S18_1097	38	116.670000000000002	10
10126	S18_1367	42	51.2100000000000009	17
10126	S18_2432	43	51.0499999999999972	2
10126	S18_2949	31	93.2099999999999937	12
10126	S18_2957	46	61.8400000000000034	14
10126	S18_3136	30	93.2000000000000028	13
10126	S18_3320	38	94.25	16
10126	S18_4600	50	102.920000000000002	5
10126	S18_4668	43	47.2899999999999991	9
10126	S24_2300	27	122.680000000000007	1
10126	S24_4258	34	83.7600000000000051	15
10126	S32_1268	43	82.8299999999999983	3
10126	S32_3522	26	62.0499999999999972	7
10126	S700_2824	45	97.0999999999999943	6
10127	S12_1108	46	193.25	2
10127	S12_3148	46	140.5	3
10127	S12_3891	42	169.560000000000002	1
10127	S12_4473	24	100.730000000000004	11
10127	S18_2238	45	140.810000000000002	10
10127	S18_2319	45	114.140000000000001	14
10127	S18_3232	22	149.02000000000001	15
10127	S18_4027	25	126.390000000000001	5
10127	S24_1444	20	50.8599999999999994	8
10127	S24_2840	39	34.2999999999999972	12
10127	S24_4048	20	107.629999999999995	7
10127	S32_2509	45	46.5300000000000011	13
10127	S32_3207	29	60.8999999999999986	6
10127	S50_1392	46	111.120000000000005	9
10127	S50_1514	46	55.6499999999999986	4
10128	S18_3140	41	120.200000000000003	2
10128	S18_3259	41	80.6700000000000017	4
10128	S18_4522	43	77.2399999999999949	1
10128	S700_1938	32	72.75	3
10129	S10_4757	33	123.760000000000005	2
10129	S24_2011	45	113.060000000000002	9
10129	S24_3151	41	81.4300000000000068	4
10129	S24_3816	50	76.3100000000000023	1
10129	S700_1138	31	58.6700000000000017	5
10129	S700_2610	45	72.2800000000000011	3
10129	S700_3505	42	90.1500000000000057	6
10129	S700_3962	30	94.3400000000000034	7
10129	S72_3212	32	44.2299999999999969	8
10130	S18_3029	40	68.8199999999999932	2
10130	S18_3856	33	99.519999999999996	1
10131	S18_1662	21	141.919999999999987	4
10131	S24_2841	35	60.9699999999999989	5
10131	S24_3420	29	52.6000000000000014	6
10131	S24_3949	50	54.5900000000000034	3
10131	S700_2047	22	76.9399999999999977	8
10131	S700_2466	40	86.7600000000000051	1
10131	S700_4002	26	63.6700000000000017	2
10131	S72_1253	21	40.2199999999999989	7
10132	S700_3167	36	80	1
10133	S18_2581	49	80.2600000000000051	3
10133	S24_1785	41	109.420000000000002	5
10133	S24_4278	46	61.5799999999999983	4
10133	S32_1374	23	80.9099999999999966	1
10133	S32_4289	49	67.4099999999999966	6
10133	S50_1341	27	37.0900000000000034	7
10133	S700_1691	24	76.730000000000004	8
10133	S700_2834	27	115.090000000000003	2
10134	S10_1678	41	90.9200000000000017	2
10134	S10_2016	27	116.560000000000002	5
10134	S10_4698	31	187.849999999999994	4
10134	S12_2823	20	131.039999999999992	1
10134	S18_2625	30	51.4799999999999969	6
10134	S24_1578	35	94.6700000000000017	3
10134	S24_2000	43	75.4099999999999966	7
10135	S12_1099	42	173.169999999999987	7
10135	S12_3380	48	110.390000000000001	5
10135	S12_3990	24	72.6200000000000045	8
10135	S12_4675	29	103.640000000000001	4
10135	S18_1889	48	66.9899999999999949	3
10135	S18_3278	45	65.9399999999999977	10
10135	S18_3482	42	139.639999999999986	9
10135	S18_3782	45	49.740000000000002	13
10135	S18_4721	31	133.919999999999987	12
10135	S24_2360	29	67.1800000000000068	16
10135	S24_2972	20	34.3599999999999994	1
10135	S24_3371	27	52.0499999999999972	6
10135	S24_3856	47	139.030000000000001	2
10135	S24_4620	23	76.7999999999999972	11
10135	S32_2206	33	38.6199999999999974	14
10135	S32_4485	30	91.8499999999999943	17
10135	S50_4713	44	78.9200000000000017	15
10136	S18_1129	25	117.480000000000004	2
10136	S18_1984	36	120.909999999999997	1
10136	S18_3232	41	169.340000000000003	3
10137	S18_1589	44	115.730000000000004	2
10137	S18_2870	37	110.879999999999995	3
10137	S18_3685	31	118.680000000000007	4
10137	S24_1628	26	40.25	1
10138	S18_1749	33	149.599999999999994	6
10138	S18_2248	22	51.4600000000000009	5
10138	S18_2325	38	114.420000000000002	3
10138	S18_4409	47	79.1500000000000057	7
10138	S18_4933	23	64.8599999999999994	8
10138	S24_1046	45	59.5300000000000011	12
10138	S24_1937	22	33.1899999999999977	2
10138	S24_2022	33	38.5300000000000011	1
10138	S24_2766	28	73.5999999999999943	10
10138	S24_2887	30	96.2999999999999972	9
10138	S24_3191	49	77.0499999999999972	11
10138	S24_3432	21	99.5799999999999983	13
10138	S24_3969	29	32.8200000000000003	4
10139	S18_1342	31	89.3799999999999955	7
10139	S18_1367	49	52.8299999999999983	6
10139	S18_2795	41	151.879999999999995	8
10139	S18_2949	46	91.1800000000000068	1
10139	S18_2957	20	52.4699999999999989	3
10139	S18_3136	20	101.579999999999998	2
10139	S18_3320	30	81.3499999999999943	5
10139	S24_4258	29	93.4899999999999949	4
10140	S10_1949	37	186.439999999999998	11
10140	S10_4962	26	131.490000000000009	4
10140	S12_1666	38	118.900000000000006	8
10140	S18_1097	32	95.6700000000000017	10
10140	S18_2432	46	51.0499999999999972	2
10140	S18_4600	40	100.5	5
10140	S18_4668	29	40.25	9
10140	S24_2300	47	118.840000000000003	1
10140	S32_1268	26	87.6400000000000006	3
10140	S32_3522	28	62.0499999999999972	7
10140	S700_2824	36	101.150000000000006	6
10141	S12_4473	21	114.950000000000003	5
10141	S18_2238	39	160.460000000000008	4
10141	S18_2319	47	103.090000000000003	8
10141	S18_3232	34	143.939999999999998	9
10141	S24_1444	20	50.8599999999999994	2
10141	S24_2840	21	32.1799999999999997	6
10141	S24_4048	40	104.090000000000003	1
10141	S32_2509	24	53.0300000000000011	7
10141	S50_1392	44	94.9200000000000017	3
10142	S12_1108	33	166.240000000000009	12
10142	S12_3148	33	140.5	13
10142	S12_3891	46	167.830000000000013	11
10142	S18_3140	47	129.759999999999991	8
10142	S18_3259	22	95.7999999999999972	10
10142	S18_4027	24	122.079999999999998	15
10142	S18_4522	24	79.8700000000000045	7
10142	S24_2011	33	114.290000000000006	6
10142	S24_3151	49	74.3499999999999943	1
10142	S32_3207	42	60.8999999999999986	16
10142	S50_1514	42	56.240000000000002	14
10142	S700_1138	41	55.3400000000000034	2
10142	S700_1938	43	77.0799999999999983	9
10142	S700_3505	21	92.1599999999999966	3
10142	S700_3962	38	91.3700000000000045	4
10142	S72_3212	39	46.9600000000000009	5
10143	S10_4757	49	133.280000000000001	15
10143	S18_1662	32	126.150000000000006	7
10143	S18_3029	46	70.5400000000000063	13
10143	S18_3856	34	99.519999999999996	12
10143	S24_2841	27	63.7100000000000009	8
10143	S24_3420	33	59.8299999999999983	9
10143	S24_3816	23	74.6400000000000006	14
10143	S24_3949	28	55.9600000000000009	6
10143	S50_1341	34	34.9099999999999966	1
10143	S700_1691	36	86.769999999999996	2
10143	S700_2047	26	87.7999999999999972	11
10143	S700_2466	26	79.7800000000000011	4
10143	S700_2610	31	69.3900000000000006	16
10143	S700_3167	28	70.4000000000000057	3
10143	S700_4002	34	65.1500000000000057	5
10143	S72_1253	37	49.6599999999999966	10
10144	S32_4289	20	56.4099999999999966	1
10145	S10_1678	45	76.5600000000000023	6
10145	S10_2016	37	104.670000000000002	9
10145	S10_4698	33	154.930000000000007	8
10145	S12_2823	49	146.099999999999994	5
10145	S18_2581	30	71.8100000000000023	14
10145	S18_2625	30	52.7000000000000028	10
10145	S24_1578	43	103.680000000000007	7
10145	S24_1785	40	87.5400000000000063	16
10145	S24_2000	47	63.9799999999999969	11
10145	S24_2360	27	56.1000000000000014	3
10145	S24_4278	33	71.730000000000004	15
10145	S32_1374	33	99.8900000000000006	12
10145	S32_2206	31	39.4299999999999997	1
10145	S32_4485	27	95.9300000000000068	4
10145	S50_4713	38	73.2199999999999989	2
10145	S700_2834	20	113.900000000000006	13
10146	S18_3782	47	60.2999999999999972	2
10146	S18_4721	29	130.939999999999998	1
10147	S12_1099	48	161.490000000000009	7
10147	S12_3380	31	110.390000000000001	5
10147	S12_3990	21	74.2099999999999937	8
10147	S12_4675	33	97.8900000000000006	4
10147	S18_1889	26	70.8400000000000034	3
10147	S18_3278	36	74.7800000000000011	10
10147	S18_3482	37	129.349999999999994	9
10147	S24_2972	25	33.2299999999999969	1
10147	S24_3371	30	48.9799999999999969	6
10147	S24_3856	23	123.579999999999998	2
10147	S24_4620	31	72.7600000000000051	11
10148	S18_1129	23	114.650000000000006	13
10148	S18_1589	47	108.260000000000005	9
10148	S18_1984	25	136.560000000000002	12
10148	S18_2870	27	113.519999999999996	10
10148	S18_3232	32	143.939999999999998	14
10148	S18_3685	28	135.629999999999995	11
10148	S18_4409	34	83.75	1
10148	S18_4933	29	66.2800000000000011	2
10148	S24_1046	25	65.4099999999999966	6
10148	S24_1628	47	46.2899999999999991	8
10148	S24_2766	21	77.2399999999999949	4
10148	S24_2887	34	115.090000000000003	3
10148	S24_3191	31	71.9099999999999966	5
10148	S24_3432	27	96.3700000000000045	7
10149	S18_1342	50	87.3299999999999983	4
10149	S18_1367	30	48.5200000000000031	3
10149	S18_1749	34	156.400000000000006	11
10149	S18_2248	24	50.8500000000000014	10
10149	S18_2325	33	125.859999999999999	8
10149	S18_2795	23	167.060000000000002	5
10149	S18_3320	42	89.2900000000000063	2
10149	S24_1937	36	31.1999999999999993	7
10149	S24_2022	49	39.8699999999999974	6
10149	S24_3969	26	38.5700000000000003	9
10149	S24_4258	20	90.5699999999999932	1
10150	S10_1949	45	182.159999999999997	8
10150	S10_4962	20	121.150000000000006	1
10150	S12_1666	30	135.300000000000011	5
10150	S18_1097	34	95.6700000000000017	7
10150	S18_2949	47	93.2099999999999937	9
10150	S18_2957	30	56.2100000000000009	11
10150	S18_3136	26	97.3900000000000006	10
10150	S18_4600	49	111.390000000000001	2
10150	S18_4668	30	47.2899999999999991	6
10150	S32_3522	49	62.0499999999999972	4
10150	S700_2824	20	95.0799999999999983	3
10151	S12_4473	24	114.950000000000003	3
10151	S18_2238	43	152.27000000000001	2
10151	S18_2319	49	106.780000000000001	6
10151	S18_2432	39	58.3400000000000034	9
10151	S18_3232	21	167.650000000000006	7
10151	S24_2300	42	109.900000000000006	8
10151	S24_2840	30	29.3500000000000014	4
10151	S32_1268	27	84.75	10
10151	S32_2509	41	43.2899999999999991	5
10151	S50_1392	26	108.810000000000002	1
10152	S18_4027	35	117.769999999999996	1
10152	S24_1444	25	49.1300000000000026	4
10152	S24_4048	23	112.370000000000005	3
10152	S32_3207	33	57.1700000000000017	2
10153	S12_1108	20	201.569999999999993	11
10153	S12_3148	42	128.419999999999987	12
10153	S12_3891	49	155.719999999999999	10
10153	S18_3140	31	125.659999999999997	7
10153	S18_3259	29	82.6899999999999977	9
10153	S18_4522	22	82.5	6
10153	S24_2011	40	111.829999999999998	5
10153	S50_1514	31	53.3100000000000023	13
10153	S700_1138	43	58	1
10153	S700_1938	31	80.5499999999999972	8
10153	S700_3505	50	87.1500000000000057	2
10153	S700_3962	20	85.4099999999999966	3
10153	S72_3212	50	51.8699999999999974	4
10154	S24_3151	31	75.230000000000004	2
10154	S700_2610	36	59.2700000000000031	1
10155	S10_4757	32	129.199999999999989	13
10155	S18_1662	38	138.77000000000001	5
10155	S18_3029	44	83.4399999999999977	11
10155	S18_3856	29	105.870000000000005	10
10155	S24_2841	23	62.3400000000000034	6
10155	S24_3420	34	56.5499999999999972	7
10155	S24_3816	37	76.3100000000000023	12
10155	S24_3949	44	58.6899999999999977	4
10155	S700_2047	32	89.6099999999999994	9
10155	S700_2466	20	87.75	2
10155	S700_3167	43	76.7999999999999972	1
10155	S700_4002	44	70.3299999999999983	3
10155	S72_1253	34	49.1599999999999966	8
10156	S50_1341	20	43.6400000000000006	1
10156	S700_1691	48	77.6400000000000006	2
10157	S18_2581	33	69.269999999999996	3
10157	S24_1785	40	89.7199999999999989	5
10157	S24_4278	33	66.6500000000000057	4
10157	S32_1374	34	83.9099999999999966	1
10157	S32_4289	28	56.4099999999999966	6
10157	S700_2834	48	109.159999999999997	2
10158	S24_2000	22	67.7900000000000063	1
10159	S10_1678	49	81.3499999999999943	14
10159	S10_2016	37	101.099999999999994	17
10159	S10_4698	22	170.419999999999987	16
10159	S12_1099	41	188.72999999999999	2
10159	S12_2823	38	131.039999999999992	13
10159	S12_3990	24	67.0300000000000011	3
10159	S18_2625	42	51.4799999999999969	18
10159	S18_3278	21	66.7399999999999949	5
10159	S18_3482	25	129.349999999999994	4
10159	S18_3782	21	54.7100000000000009	8
10159	S18_4721	32	142.849999999999994	7
10159	S24_1578	44	100.299999999999997	15
10159	S24_2360	27	67.1800000000000068	11
10159	S24_3371	50	49.6000000000000014	1
10159	S24_4620	23	80.8400000000000034	6
10159	S32_2206	35	39.4299999999999997	9
10159	S32_4485	23	86.7399999999999949	12
10159	S50_4713	31	78.1099999999999994	10
10160	S12_3380	46	96.2999999999999972	6
10160	S12_4675	50	93.2800000000000011	5
10160	S18_1889	38	70.8400000000000034	4
10160	S18_3232	20	140.550000000000011	1
10160	S24_2972	42	30.5899999999999999	2
10160	S24_3856	35	130.599999999999994	3
10161	S18_1129	28	121.719999999999999	12
10161	S18_1589	43	102.040000000000006	8
10161	S18_1984	48	139.409999999999997	11
10161	S18_2870	23	125.400000000000006	9
10161	S18_3685	36	132.800000000000011	10
10161	S18_4933	25	62.7199999999999989	1
10161	S24_1046	37	73.4899999999999949	5
10161	S24_1628	23	47.2899999999999991	7
10161	S24_2766	20	82.6899999999999977	3
10161	S24_2887	25	108.040000000000006	2
10161	S24_3191	20	72.769999999999996	4
10161	S24_3432	30	94.230000000000004	6
10162	S18_1342	48	87.3299999999999983	2
10162	S18_1367	45	45.2800000000000011	1
10162	S18_1749	29	141.099999999999994	9
10162	S18_2248	27	53.2800000000000011	8
10162	S18_2325	38	113.150000000000006	6
10162	S18_2795	48	156.939999999999998	3
10162	S18_4409	39	86.5100000000000051	10
10162	S24_1937	37	27.5500000000000007	5
10162	S24_2022	43	38.9799999999999969	4
10162	S24_3969	37	32.8200000000000003	7
10163	S10_1949	21	212.159999999999997	1
10163	S18_2949	31	101.310000000000002	2
10163	S18_2957	48	59.9600000000000009	4
10163	S18_3136	40	101.579999999999998	3
10163	S18_3320	43	80.3599999999999994	6
10163	S24_4258	42	96.4200000000000017	5
10164	S10_4962	21	143.310000000000002	2
10164	S12_1666	49	121.640000000000001	6
10164	S18_1097	36	103.840000000000003	8
10164	S18_4600	45	107.760000000000005	3
10164	S18_4668	25	46.2899999999999991	7
10164	S32_1268	24	91.4899999999999949	1
10164	S32_3522	49	57.5300000000000011	5
10164	S700_2824	39	86.9899999999999949	4
10165	S12_1108	44	168.319999999999993	3
10165	S12_3148	34	123.890000000000001	4
10165	S12_3891	27	152.259999999999991	2
10165	S12_4473	48	109.019999999999996	12
10165	S18_2238	29	134.259999999999991	11
10165	S18_2319	46	120.280000000000001	15
10165	S18_2432	31	60.7700000000000031	18
10165	S18_3232	47	154.099999999999994	16
10165	S18_3259	50	84.7099999999999937	1
10165	S18_4027	28	123.510000000000005	6
10165	S24_1444	25	46.8200000000000003	9
10165	S24_2300	32	117.569999999999993	17
10165	S24_2840	27	31.120000000000001	13
10165	S24_4048	24	106.450000000000003	8
10165	S32_2509	48	50.8599999999999994	14
10165	S32_3207	44	55.2999999999999972	7
10165	S50_1392	48	106.489999999999995	10
10165	S50_1514	38	49.2100000000000009	5
10166	S18_3140	43	136.590000000000003	2
10166	S18_4522	26	72.8499999999999943	1
10166	S700_1938	29	76.2199999999999989	3
10167	S10_4757	44	123.760000000000005	9
10167	S18_1662	43	141.919999999999987	1
10167	S18_3029	46	69.6800000000000068	7
10167	S18_3856	34	84.7000000000000028	6
10167	S24_2011	33	110.599999999999994	16
10167	S24_2841	21	54.8100000000000023	2
10167	S24_3151	20	77	11
10167	S24_3420	32	64.4399999999999977	3
10167	S24_3816	29	73.7999999999999972	8
10167	S700_1138	43	66	12
10167	S700_2047	29	87.7999999999999972	5
10167	S700_2610	46	62.1599999999999966	10
10167	S700_3505	24	85.1400000000000006	13
10167	S700_3962	28	83.4200000000000017	14
10167	S72_1253	40	42.7100000000000009	4
10167	S72_3212	38	43.6799999999999997	15
10168	S10_1678	36	94.7399999999999949	1
10168	S10_2016	27	97.5300000000000011	4
10168	S10_4698	20	160.740000000000009	3
10168	S18_2581	21	75.1899999999999977	9
10168	S18_2625	46	49.0600000000000023	5
10168	S24_1578	50	103.680000000000007	2
10168	S24_1785	49	93.0100000000000051	11
10168	S24_2000	29	72.3599999999999994	6
10168	S24_3949	27	57.3200000000000003	18
10168	S24_4278	48	68.0999999999999943	10
10168	S32_1374	28	89.9000000000000057	7
10168	S32_4289	31	57.7800000000000011	12
10168	S50_1341	48	39.7100000000000009	13
10168	S700_1691	28	91.3400000000000034	14
10168	S700_2466	31	87.75	16
10168	S700_2834	36	94.9200000000000017	8
10168	S700_3167	48	72	15
10168	S700_4002	39	67.3700000000000045	17
10169	S12_1099	30	163.439999999999998	2
10169	S12_2823	35	126.519999999999996	13
10169	S12_3990	36	71.8199999999999932	3
10169	S18_3278	32	65.1299999999999955	5
10169	S18_3482	36	136.699999999999989	4
10169	S18_3782	38	52.8400000000000034	8
10169	S18_4721	33	120.530000000000001	7
10169	S24_2360	38	66.4899999999999949	11
10169	S24_3371	34	53.2700000000000031	1
10169	S24_4620	24	77.6099999999999994	6
10169	S32_2206	26	37.009999999999998	9
10169	S32_4485	34	83.6800000000000068	12
10169	S50_4713	48	75.6599999999999966	10
10170	S12_3380	47	116.269999999999996	4
10170	S12_4675	41	93.2800000000000011	3
10170	S18_1889	20	70.0699999999999932	2
10170	S24_3856	34	130.599999999999994	1
10171	S18_1129	35	134.460000000000008	2
10171	S18_1984	35	128.030000000000001	1
10171	S18_3232	39	165.949999999999989	3
10171	S24_2972	36	34.740000000000002	4
10172	S18_1589	42	109.510000000000005	6
10172	S18_2870	39	117.480000000000004	7
10172	S18_3685	48	139.870000000000005	8
10172	S24_1046	32	61	3
10172	S24_1628	34	43.2700000000000031	5
10172	S24_2766	22	79.9699999999999989	1
10172	S24_3191	24	77.9099999999999966	2
10172	S24_3432	22	87.8100000000000023	4
10173	S18_1342	43	101.709999999999994	6
10173	S18_1367	48	51.75	5
10173	S18_1749	24	168.300000000000011	13
10173	S18_2248	26	55.0900000000000034	12
10173	S18_2325	31	127.129999999999995	10
10173	S18_2795	22	140.060000000000002	7
10173	S18_2957	28	56.8400000000000034	2
10173	S18_3136	31	86.9200000000000017	1
10173	S18_3320	29	90.2800000000000011	4
10173	S18_4409	21	77.3100000000000023	14
10173	S18_4933	39	58.4399999999999977	15
10173	S24_1937	31	29.870000000000001	9
10173	S24_2022	27	39.4200000000000017	8
10173	S24_2887	23	98.6500000000000057	16
10173	S24_3969	35	35.7000000000000028	11
10173	S24_4258	22	93.4899999999999949	3
10174	S10_1949	34	207.870000000000005	4
10174	S12_1666	43	113.439999999999998	1
10174	S18_1097	48	108.5	3
10174	S18_2949	46	100.299999999999997	5
10174	S18_4668	49	44.2700000000000031	2
10175	S10_4962	33	119.670000000000002	9
10175	S12_4473	26	109.019999999999996	1
10175	S18_2319	48	101.870000000000005	4
10175	S18_2432	41	59.5499999999999972	7
10175	S18_3232	29	150.710000000000008	5
10175	S18_4600	47	102.920000000000002	10
10175	S24_2300	28	121.400000000000006	6
10175	S24_2840	37	32.1799999999999997	2
10175	S32_1268	22	89.5699999999999932	8
10175	S32_2509	50	50.8599999999999994	3
10175	S32_3522	29	56.240000000000002	12
10175	S700_2824	42	80.9200000000000017	11
10176	S12_1108	33	166.240000000000009	2
10176	S12_3148	47	145.039999999999992	3
10176	S12_3891	50	160.909999999999997	1
10176	S18_2238	20	139.169999999999987	10
10176	S18_4027	36	140.75	5
10176	S24_1444	27	55.490000000000002	8
10176	S24_4048	29	101.719999999999999	7
10176	S32_3207	22	62.1400000000000006	6
10176	S50_1392	23	109.959999999999994	9
10176	S50_1514	38	52.1400000000000006	4
10177	S18_3140	23	113.370000000000005	9
10177	S18_3259	29	92.769999999999996	11
10177	S18_4522	35	82.5	8
10177	S24_2011	50	115.519999999999996	7
10177	S24_3151	45	79.6599999999999966	2
10177	S700_1138	24	58.6700000000000017	3
10177	S700_1938	31	77.9500000000000028	10
10177	S700_2610	32	64.3299999999999983	1
10177	S700_3505	44	88.1500000000000057	4
10177	S700_3962	24	83.4200000000000017	5
10177	S72_3212	40	52.9600000000000009	6
10178	S10_4757	24	131.919999999999987	12
10178	S18_1662	42	127.730000000000004	4
10178	S18_3029	41	70.5400000000000063	10
10178	S18_3856	48	104.810000000000002	9
10178	S24_2841	34	67.8199999999999932	5
10178	S24_3420	27	65.75	6
10178	S24_3816	21	68.769999999999996	11
10178	S24_3949	30	64.1500000000000057	3
10178	S700_2047	34	86.9000000000000057	8
10178	S700_2466	22	91.7399999999999949	1
10178	S700_4002	45	68.1099999999999994	2
10178	S72_1253	45	41.7100000000000009	7
10179	S18_2581	24	82.7900000000000063	3
10179	S24_1785	47	105.040000000000006	5
10179	S24_4278	27	66.6500000000000057	4
10179	S32_1374	45	86.9000000000000057	1
10179	S32_4289	24	63.9699999999999989	6
10179	S50_1341	34	43.2000000000000028	7
10179	S700_1691	23	75.8100000000000023	8
10179	S700_2834	25	98.480000000000004	2
10179	S700_3167	39	80	9
10180	S10_1678	29	76.5600000000000023	9
10180	S10_2016	42	99.9099999999999966	12
10180	S10_4698	41	164.610000000000014	11
10180	S12_2823	40	131.039999999999992	8
10180	S18_2625	25	48.4600000000000009	13
10180	S18_3782	21	59.0600000000000023	3
10180	S18_4721	44	147.310000000000002	2
10180	S24_1578	48	98.0499999999999972	10
10180	S24_2000	28	61.7000000000000028	14
10180	S24_2360	35	60.9500000000000028	6
10180	S24_4620	28	68.7099999999999937	1
10180	S32_2206	34	33.3900000000000006	4
10180	S32_4485	22	102.049999999999997	7
10180	S50_4713	21	74.8499999999999943	5
10181	S12_1099	27	155.659999999999997	14
10181	S12_3380	28	113.920000000000002	12
10181	S12_3990	20	67.0300000000000011	15
10181	S12_4675	36	107.099999999999994	11
10181	S18_1129	44	124.560000000000002	6
10181	S18_1589	42	124.439999999999998	2
10181	S18_1889	22	74.6899999999999977	10
10181	S18_1984	21	129.449999999999989	5
10181	S18_2870	27	130.680000000000007	3
10181	S18_3232	45	147.330000000000013	7
10181	S18_3278	30	73.1700000000000017	17
10181	S18_3482	22	120.530000000000001	16
10181	S18_3685	39	137.039999999999992	4
10181	S24_1628	34	45.2800000000000011	1
10181	S24_2972	37	32.8500000000000014	8
10181	S24_3371	23	54.490000000000002	13
10181	S24_3856	25	122.170000000000002	9
10182	S18_1342	25	83.2199999999999989	3
10182	S18_1367	32	44.2100000000000009	2
10182	S18_1749	44	159.800000000000011	10
10182	S18_2248	38	54.490000000000002	9
10182	S18_2325	20	105.519999999999996	7
10182	S18_2795	21	135	4
10182	S18_3320	33	86.3100000000000023	1
10182	S18_4409	36	88.3499999999999943	11
10182	S18_4933	44	61.2899999999999991	12
10182	S24_1046	47	63.2000000000000028	16
10182	S24_1937	39	31.8599999999999994	6
10182	S24_2022	31	39.8699999999999974	5
10182	S24_2766	36	87.2399999999999949	14
10182	S24_2887	20	116.269999999999996	13
10182	S24_3191	33	73.6200000000000045	15
10182	S24_3432	49	95.2999999999999972	17
10182	S24_3969	23	34.8800000000000026	8
10183	S10_1949	23	180.009999999999991	8
10183	S10_4962	28	127.060000000000002	1
10183	S12_1666	41	114.799999999999997	5
10183	S18_1097	21	108.5	7
10183	S18_2949	37	91.1800000000000068	9
10183	S18_2957	39	51.2199999999999989	11
10183	S18_3136	22	90.0600000000000023	10
10183	S18_4600	21	118.659999999999997	2
10183	S18_4668	40	42.259999999999998	6
10183	S24_4258	47	81.8100000000000023	12
10183	S32_3522	49	52.3599999999999994	4
10183	S700_2824	23	85.980000000000004	3
10184	S12_4473	37	105.469999999999999	6
10184	S18_2238	46	145.719999999999999	5
10184	S18_2319	46	119.049999999999997	9
10184	S18_2432	44	60.7700000000000031	12
10184	S18_3232	28	165.949999999999989	10
10184	S24_1444	31	57.2199999999999989	3
10184	S24_2300	24	117.569999999999993	11
10184	S24_2840	42	30.0599999999999987	7
10184	S24_4048	49	114.730000000000004	2
10184	S32_1268	46	84.75	13
10184	S32_2509	33	52.490000000000002	8
10184	S32_3207	48	59.0300000000000011	1
10184	S50_1392	45	92.5999999999999943	4
10185	S12_1108	21	195.330000000000013	13
10185	S12_3148	33	146.550000000000011	14
10185	S12_3891	43	147.069999999999993	12
10185	S18_3140	28	124.299999999999997	9
10185	S18_3259	49	94.7900000000000063	11
10185	S18_4027	39	127.819999999999993	16
10185	S18_4522	47	87.769999999999996	8
10185	S24_2011	30	105.689999999999998	7
10185	S24_3151	33	83.2000000000000028	2
10185	S50_1514	20	46.8599999999999994	15
10185	S700_1138	21	64.6700000000000017	3
10185	S700_1938	30	79.6800000000000068	10
10185	S700_2610	39	61.4399999999999977	1
10185	S700_3505	37	99.1700000000000017	4
10185	S700_3962	22	93.3499999999999943	5
10185	S72_3212	28	47.5	6
10186	S10_4757	26	108.799999999999997	9
10186	S18_1662	32	137.189999999999998	1
10186	S18_3029	32	73.1200000000000045	7
10186	S18_3856	46	98.4599999999999937	6
10186	S24_2841	22	60.2899999999999991	2
10186	S24_3420	21	59.8299999999999983	3
10186	S24_3816	36	68.769999999999996	8
10186	S700_2047	24	80.5600000000000023	5
10186	S72_1253	28	42.7100000000000009	4
10187	S18_2581	45	70.1200000000000045	1
10187	S24_1785	46	96.2900000000000063	3
10187	S24_3949	43	55.9600000000000009	10
10187	S24_4278	33	64.480000000000004	2
10187	S32_4289	31	61.2199999999999989	4
10187	S50_1341	41	39.7100000000000009	5
10187	S700_1691	34	84.9500000000000028	6
10187	S700_2466	44	95.730000000000004	8
10187	S700_3167	34	72	7
10187	S700_4002	44	70.3299999999999983	9
10188	S10_1678	48	95.7000000000000028	1
10188	S10_2016	38	111.799999999999997	4
10188	S10_4698	45	182.039999999999992	3
10188	S18_2625	32	52.0900000000000034	5
10188	S24_1578	25	95.7999999999999972	2
10188	S24_2000	40	61.7000000000000028	6
10188	S32_1374	44	81.9099999999999966	7
10188	S700_2834	29	96.1099999999999994	8
10189	S12_2823	28	138.569999999999993	1
10190	S24_2360	42	58.8699999999999974	3
10190	S32_2206	46	38.6199999999999974	1
10190	S32_4485	42	89.7999999999999972	4
10190	S50_4713	40	67.5300000000000011	2
10191	S12_1099	21	155.659999999999997	3
10191	S12_3380	40	104.519999999999996	1
10191	S12_3990	30	70.2199999999999989	4
10191	S18_3278	36	75.5900000000000034	6
10191	S18_3482	23	119.060000000000002	5
10191	S18_3782	43	60.9299999999999997	9
10191	S18_4721	32	136.900000000000006	8
10191	S24_3371	48	53.2700000000000031	2
10191	S24_4620	44	77.6099999999999994	7
10192	S12_4675	27	99.0400000000000063	16
10192	S18_1129	22	140.120000000000005	11
10192	S18_1589	29	100.799999999999997	7
10192	S18_1889	45	70.8400000000000034	15
10192	S18_1984	47	128.030000000000001	10
10192	S18_2870	38	110.879999999999995	8
10192	S18_3232	26	137.169999999999987	12
10192	S18_3685	45	125.739999999999995	9
10192	S24_1046	37	72.019999999999996	4
10192	S24_1628	47	49.2999999999999972	6
10192	S24_2766	46	86.3299999999999983	2
10192	S24_2887	23	112.739999999999995	1
10192	S24_2972	30	33.2299999999999969	13
10192	S24_3191	32	69.3400000000000034	3
10192	S24_3432	46	93.1599999999999966	5
10192	S24_3856	45	112.340000000000003	14
10193	S18_1342	28	92.4699999999999989	7
10193	S18_1367	46	46.3599999999999994	6
10193	S18_1749	21	153	14
10193	S18_2248	42	60.5399999999999991	13
10193	S18_2325	44	115.689999999999998	11
10193	S18_2795	22	143.439999999999998	8
10193	S18_2949	28	87.1299999999999955	1
10193	S18_2957	24	53.0900000000000034	3
10193	S18_3136	23	97.3900000000000006	2
10193	S18_3320	32	79.3700000000000045	5
10193	S18_4409	24	92.0300000000000011	15
10193	S18_4933	25	66.2800000000000011	16
10193	S24_1937	26	32.1899999999999977	10
10193	S24_2022	20	44.7999999999999972	9
10193	S24_3969	22	38.1599999999999966	12
10193	S24_4258	20	92.519999999999996	4
10194	S10_1949	42	203.590000000000003	11
10194	S10_4962	26	134.439999999999998	4
10194	S12_1666	38	124.370000000000005	8
10194	S18_1097	21	103.840000000000003	10
10194	S18_2432	45	51.0499999999999972	2
10194	S18_4600	32	113.819999999999993	5
10194	S18_4668	41	47.7899999999999991	9
10194	S24_2300	49	112.459999999999994	1
10194	S32_1268	37	77.0499999999999972	3
10194	S32_3522	39	61.4099999999999966	7
10194	S700_2824	26	80.9200000000000017	6
10195	S12_4473	49	118.5	6
10195	S18_2238	27	139.169999999999987	5
10195	S18_2319	35	112.909999999999997	9
10195	S18_3232	50	150.710000000000008	10
10195	S24_1444	44	54.3299999999999983	3
10195	S24_2840	32	31.8200000000000003	7
10195	S24_4048	34	95.8100000000000023	2
10195	S32_2509	32	51.9500000000000028	8
10195	S32_3207	33	59.0300000000000011	1
10195	S50_1392	49	97.230000000000004	4
10196	S12_1108	47	203.639999999999986	5
10196	S12_3148	24	151.080000000000013	6
10196	S12_3891	38	147.069999999999993	4
10196	S18_3140	49	127.030000000000001	1
10196	S18_3259	35	81.6800000000000068	3
10196	S18_4027	27	126.390000000000001	8
10196	S50_1514	46	56.8200000000000003	7
10196	S700_1938	50	84.8799999999999955	2
10197	S10_4757	45	118.319999999999993	6
10197	S18_3029	46	83.4399999999999977	4
10197	S18_3856	22	85.75	3
10197	S18_4522	50	78.9899999999999949	14
10197	S24_2011	41	109.370000000000005	13
10197	S24_3151	47	83.2000000000000028	8
10197	S24_3816	22	67.9300000000000068	5
10197	S700_1138	23	60	9
10197	S700_2047	24	78.75	2
10197	S700_2610	50	66.5	7
10197	S700_3505	27	100.170000000000002	10
10197	S700_3962	35	88.3900000000000006	11
10197	S72_1253	29	39.7299999999999969	1
10197	S72_3212	42	48.5900000000000034	12
10198	S18_1662	42	149.810000000000002	4
10198	S24_2841	48	60.9699999999999989	5
10198	S24_3420	27	61.8100000000000023	6
10198	S24_3949	43	65.5100000000000051	3
10198	S700_2466	42	94.730000000000004	1
10198	S700_4002	40	74.0300000000000011	2
10199	S50_1341	29	37.9699999999999989	1
10199	S700_1691	48	81.2900000000000063	2
10199	S700_3167	38	70.4000000000000057	3
10200	S18_2581	28	74.3400000000000034	3
10200	S24_1785	33	99.5699999999999932	5
10200	S24_4278	39	70.2800000000000011	4
10200	S32_1374	35	80.9099999999999966	1
10200	S32_4289	27	65.3499999999999943	6
10200	S700_2834	39	115.090000000000003	2
10201	S10_1678	22	82.2999999999999972	2
10201	S10_2016	24	116.560000000000002	5
10201	S10_4698	49	191.719999999999999	4
10201	S12_2823	25	126.519999999999996	1
10201	S18_2625	30	48.4600000000000009	6
10201	S24_1578	39	93.5400000000000063	3
10201	S24_2000	25	66.269999999999996	7
10202	S18_3782	30	55.3299999999999983	3
10202	S18_4721	43	124.989999999999995	2
10202	S24_2360	50	56.1000000000000014	6
10202	S24_4620	50	75.1800000000000068	1
10202	S32_2206	27	33.3900000000000006	4
10202	S32_4485	31	81.6400000000000006	7
10202	S50_4713	40	79.730000000000004	5
10203	S12_1099	20	161.490000000000009	8
10203	S12_3380	20	111.569999999999993	6
10203	S12_3990	44	63.8400000000000034	9
10203	S12_4675	47	115.159999999999997	5
10203	S18_1889	45	73.1500000000000057	4
10203	S18_3232	48	157.490000000000009	1
10203	S18_3278	33	66.7399999999999949	11
10203	S18_3482	32	127.879999999999995	10
10203	S24_2972	21	33.2299999999999969	2
10203	S24_3371	34	56.9399999999999977	7
10203	S24_3856	47	140.430000000000007	3
10204	S18_1129	42	114.650000000000006	17
10204	S18_1589	40	113.239999999999995	13
10204	S18_1749	33	153	4
10204	S18_1984	38	133.719999999999999	16
10204	S18_2248	23	59.3299999999999983	3
10204	S18_2325	26	119.5	1
10204	S18_2870	27	106.920000000000002	14
10204	S18_3685	35	132.800000000000011	15
10204	S18_4409	29	83.75	5
10204	S18_4933	45	69.8400000000000034	6
10204	S24_1046	20	69.8199999999999932	10
10204	S24_1628	45	46.7899999999999991	12
10204	S24_2766	47	79.0600000000000023	8
10204	S24_2887	42	112.739999999999995	7
10204	S24_3191	40	84.75	9
10204	S24_3432	48	104.939999999999998	11
10204	S24_3969	39	34.8800000000000026	2
10205	S18_1342	36	98.6299999999999955	2
10205	S18_1367	48	45.8200000000000003	1
10205	S18_2795	40	138.379999999999995	3
10205	S24_1937	32	27.879999999999999	5
10205	S24_2022	24	36.740000000000002	4
10206	S10_1949	47	203.590000000000003	6
10206	S12_1666	28	109.340000000000003	3
10206	S18_1097	34	115.5	5
10206	S18_2949	37	98.269999999999996	7
10206	S18_2957	28	51.8400000000000034	9
10206	S18_3136	30	102.629999999999995	8
10206	S18_3320	28	99.2099999999999937	11
10206	S18_4668	21	45.7800000000000011	4
10206	S24_4258	33	95.4399999999999977	10
10206	S32_3522	36	54.9399999999999977	2
10206	S700_2824	33	89.0100000000000051	1
10207	S10_4962	31	125.579999999999998	15
10207	S12_4473	34	95.9899999999999949	7
10207	S18_2238	44	140.810000000000002	6
10207	S18_2319	43	109.230000000000004	10
10207	S18_2432	37	60.7700000000000031	13
10207	S18_3232	25	140.550000000000011	11
10207	S18_4027	40	143.620000000000005	1
10207	S18_4600	47	119.870000000000005	16
10207	S24_1444	49	57.7999999999999972	4
10207	S24_2300	46	127.790000000000006	12
10207	S24_2840	42	30.7600000000000016	8
10207	S24_4048	28	108.819999999999993	3
10207	S32_1268	49	84.75	14
10207	S32_2509	27	51.9500000000000028	9
10207	S32_3207	45	55.2999999999999972	2
10207	S50_1392	28	106.489999999999995	5
10208	S12_1108	46	176.629999999999995	13
10208	S12_3148	26	128.419999999999987	14
10208	S12_3891	20	152.259999999999991	12
10208	S18_3140	24	117.469999999999999	9
10208	S18_3259	48	96.8100000000000023	11
10208	S18_4522	45	72.8499999999999943	8
10208	S24_2011	35	122.890000000000001	7
10208	S24_3151	20	80.5400000000000063	2
10208	S50_1514	30	57.990000000000002	15
10208	S700_1138	38	56.6700000000000017	3
10208	S700_1938	40	73.6200000000000045	10
10208	S700_2610	46	63.6099999999999994	1
10208	S700_3505	37	95.1599999999999966	4
10208	S700_3962	33	95.3400000000000034	5
10208	S72_3212	42	48.0499999999999972	6
10209	S10_4757	39	129.199999999999989	8
10209	S18_3029	28	82.5799999999999983	6
10209	S18_3856	20	97.4000000000000057	5
10209	S24_2841	43	66.4500000000000028	1
10209	S24_3420	36	56.5499999999999972	2
10209	S24_3816	22	79.6700000000000017	7
10209	S700_2047	33	90.519999999999996	4
10209	S72_1253	48	44.2000000000000028	3
10210	S10_2016	23	112.989999999999995	2
10210	S10_4698	34	189.789999999999992	1
10210	S18_1662	31	141.919999999999987	17
10210	S18_2581	50	68.4300000000000068	7
10210	S18_2625	40	51.4799999999999969	3
10210	S24_1785	27	100.670000000000002	9
10210	S24_2000	30	63.2199999999999989	4
10210	S24_3949	29	56.6400000000000006	16
10210	S24_4278	40	68.0999999999999943	8
10210	S32_1374	46	84.9099999999999966	5
10210	S32_4289	39	57.1000000000000014	10
10210	S50_1341	43	43.2000000000000028	11
10210	S700_1691	21	87.6899999999999977	12
10210	S700_2466	26	93.7399999999999949	14
10210	S700_2834	25	98.480000000000004	6
10210	S700_3167	31	64	13
10210	S700_4002	42	60.7000000000000028	15
10211	S10_1678	41	90.9200000000000017	14
10211	S12_1099	41	171.219999999999999	2
10211	S12_2823	36	126.519999999999996	13
10211	S12_3990	28	79.7999999999999972	3
10211	S18_3278	35	73.1700000000000017	5
10211	S18_3482	28	138.169999999999987	4
10211	S18_3782	46	60.2999999999999972	8
10211	S18_4721	41	148.800000000000011	7
10211	S24_1578	25	109.319999999999993	15
10211	S24_2360	21	62.3299999999999983	11
10211	S24_3371	48	52.6599999999999966	1
10211	S24_4620	22	80.8400000000000034	6
10211	S32_2206	41	39.8299999999999983	9
10211	S32_4485	37	94.9099999999999966	12
10211	S50_4713	40	70.7800000000000011	10
10212	S12_3380	39	99.8199999999999932	16
10212	S12_4675	33	110.549999999999997	15
10212	S18_1129	29	117.480000000000004	10
10212	S18_1589	38	105.769999999999996	6
10212	S18_1889	20	64.6800000000000068	14
10212	S18_1984	41	133.719999999999999	9
10212	S18_2870	40	117.480000000000004	7
10212	S18_3232	40	155.789999999999992	11
10212	S18_3685	45	115.849999999999994	8
10212	S24_1046	41	61.7299999999999969	3
10212	S24_1628	45	43.2700000000000031	5
10212	S24_2766	45	81.7800000000000011	1
10212	S24_2972	34	37.3800000000000026	12
10212	S24_3191	27	77.9099999999999966	2
10212	S24_3432	46	100.659999999999997	4
10212	S24_3856	49	117.959999999999994	13
10213	S18_4409	38	84.6700000000000017	1
10213	S18_4933	25	58.4399999999999977	2
10213	S24_2887	27	97.480000000000004	3
10214	S18_1749	30	166.599999999999994	7
10214	S18_2248	21	53.2800000000000011	6
10214	S18_2325	27	125.859999999999999	4
10214	S18_2795	50	167.060000000000002	1
10214	S24_1937	20	32.1899999999999977	3
10214	S24_2022	49	39.8699999999999974	2
10214	S24_3969	44	38.5700000000000003	5
10215	S10_1949	35	205.72999999999999	3
10215	S18_1097	46	100.340000000000003	2
10215	S18_1342	27	92.4699999999999989	10
10215	S18_1367	33	53.9099999999999966	9
10215	S18_2949	49	97.2600000000000051	4
10215	S18_2957	31	56.2100000000000009	6
10215	S18_3136	49	89.0100000000000051	5
10215	S18_3320	41	84.3299999999999983	8
10215	S18_4668	46	42.759999999999998	1
10215	S24_4258	39	94.4699999999999989	7
10216	S12_1666	43	133.939999999999998	1
10217	S10_4962	48	132.969999999999999	4
10217	S18_2432	35	58.3400000000000034	2
10217	S18_4600	38	118.659999999999997	5
10217	S24_2300	28	103.510000000000005	1
10217	S32_1268	21	78.9699999999999989	3
10217	S32_3522	39	56.240000000000002	7
10217	S700_2824	31	90.019999999999996	6
10218	S18_2319	22	110.459999999999994	1
10218	S18_3232	34	152.409999999999997	2
10219	S12_4473	48	94.7999999999999972	2
10219	S18_2238	43	132.620000000000005	1
10219	S24_2840	21	31.120000000000001	3
10219	S32_2509	35	47.6199999999999974	4
10220	S12_1108	32	189.099999999999994	2
10220	S12_3148	30	151.080000000000013	3
10220	S12_3891	27	166.099999999999994	1
10220	S18_4027	50	126.390000000000001	5
10220	S24_1444	26	48.5499999999999972	8
10220	S24_4048	37	101.719999999999999	7
10220	S32_3207	20	49.7100000000000009	6
10220	S50_1392	37	92.5999999999999943	9
10220	S50_1514	30	56.8200000000000003	4
10221	S18_3140	33	133.860000000000014	3
10221	S18_3259	23	89.75	5
10221	S18_4522	39	84.2600000000000051	2
10221	S24_2011	49	113.060000000000002	1
10221	S700_1938	23	69.2900000000000063	4
10222	S10_4757	49	133.280000000000001	12
10222	S18_1662	49	137.189999999999998	4
10222	S18_3029	49	79.1400000000000006	10
10222	S18_3856	45	88.9300000000000068	9
10222	S24_2841	32	56.8599999999999994	5
10222	S24_3151	47	74.3499999999999943	14
10222	S24_3420	43	61.1499999999999986	6
10222	S24_3816	46	77.9899999999999949	11
10222	S24_3949	48	55.2700000000000031	3
10222	S700_1138	31	58.6700000000000017	15
10222	S700_2047	26	80.5600000000000023	8
10222	S700_2466	37	90.75	1
10222	S700_2610	36	69.3900000000000006	13
10222	S700_3505	38	84.1400000000000006	16
10222	S700_3962	31	81.4300000000000068	17
10222	S700_4002	43	66.6299999999999955	2
10222	S72_1253	31	45.1899999999999977	7
10222	S72_3212	36	48.5900000000000034	18
10223	S10_1678	37	80.3900000000000006	1
10223	S10_2016	47	110.609999999999999	4
10223	S10_4698	49	189.789999999999992	3
10223	S18_2581	47	67.5799999999999983	9
10223	S18_2625	28	58.75	5
10223	S24_1578	32	104.810000000000002	2
10223	S24_1785	34	87.5400000000000063	11
10223	S24_2000	38	60.9399999999999977	6
10223	S24_4278	23	68.0999999999999943	10
10223	S32_1374	21	90.9000000000000057	7
10223	S32_4289	20	66.730000000000004	12
10223	S50_1341	41	41.0200000000000031	13
10223	S700_1691	25	84.0300000000000011	14
10223	S700_2834	29	113.900000000000006	8
10223	S700_3167	26	79.2000000000000028	15
10224	S12_2823	43	141.580000000000013	6
10224	S18_3782	38	57.2000000000000028	1
10224	S24_2360	37	60.259999999999998	4
10224	S32_2206	43	37.009999999999998	2
10224	S32_4485	30	94.9099999999999966	5
10224	S50_4713	50	81.3599999999999994	3
10225	S12_1099	27	157.599999999999994	9
10225	S12_3380	25	101	7
10225	S12_3990	37	64.6400000000000006	10
10225	S12_4675	21	100.189999999999998	6
10225	S18_1129	32	116.060000000000002	1
10225	S18_1889	47	71.6099999999999994	5
10225	S18_3232	43	162.569999999999993	2
10225	S18_3278	37	69.9599999999999937	12
10225	S18_3482	27	119.060000000000002	11
10225	S18_4721	35	135.409999999999997	14
10225	S24_2972	42	34.740000000000002	3
10225	S24_3371	24	51.4299999999999997	8
10225	S24_3856	40	130.599999999999994	4
10225	S24_4620	46	77.6099999999999994	13
10226	S18_1589	38	108.260000000000005	4
10226	S18_1984	24	129.449999999999989	7
10226	S18_2870	24	125.400000000000006	5
10226	S18_3685	46	122.909999999999997	6
10226	S24_1046	21	65.4099999999999966	1
10226	S24_1628	36	47.7899999999999991	3
10226	S24_3432	48	95.2999999999999972	2
10227	S18_1342	25	85.269999999999996	3
10227	S18_1367	31	50.1400000000000006	2
10227	S18_1749	26	136	10
10227	S18_2248	28	59.9299999999999997	9
10227	S18_2325	46	118.230000000000004	7
10227	S18_2795	29	146.810000000000002	4
10227	S18_3320	33	99.2099999999999937	1
10227	S18_4409	34	87.4300000000000068	11
10227	S18_4933	37	70.5600000000000023	12
10227	S24_1937	42	27.2199999999999989	6
10227	S24_2022	24	39.4200000000000017	5
10227	S24_2766	47	84.5100000000000051	14
10227	S24_2887	33	102.170000000000002	13
10227	S24_3191	40	78.7600000000000051	15
10227	S24_3969	27	34.8800000000000026	8
10228	S10_1949	29	214.300000000000011	2
10228	S18_1097	32	100.340000000000003	1
10228	S18_2949	24	101.310000000000002	3
10228	S18_2957	45	57.4600000000000009	5
10228	S18_3136	31	100.530000000000001	4
10228	S24_4258	33	84.730000000000004	6
10229	S10_4962	50	138.879999999999995	9
10229	S12_1666	25	110.700000000000003	13
10229	S12_4473	36	95.9899999999999949	1
10229	S18_2319	26	104.319999999999993	4
10229	S18_2432	28	53.4799999999999969	7
10229	S18_3232	22	157.490000000000009	5
10229	S18_4600	41	119.870000000000005	10
10229	S18_4668	39	43.7700000000000031	14
10229	S24_2300	48	115.010000000000005	6
10229	S24_2840	33	34.6499999999999986	2
10229	S32_1268	25	78.9699999999999989	8
10229	S32_2509	23	49.7800000000000011	3
10229	S32_3522	30	52.3599999999999994	12
10229	S700_2824	50	91.0400000000000063	11
10230	S12_3148	43	128.419999999999987	1
10230	S18_2238	49	153.909999999999997	8
10230	S18_4027	42	142.180000000000007	3
10230	S24_1444	36	47.3999999999999986	6
10230	S24_4048	45	99.3599999999999994	5
10230	S32_3207	46	59.0300000000000011	4
10230	S50_1392	34	100.700000000000003	7
10230	S50_1514	43	57.4099999999999966	2
10231	S12_1108	42	193.25	2
10231	S12_3891	49	147.069999999999993	1
10232	S18_3140	22	133.860000000000014	6
10232	S18_3259	48	97.8100000000000023	8
10232	S18_4522	23	78.1200000000000045	5
10232	S24_2011	46	113.060000000000002	4
10232	S700_1938	26	84.8799999999999955	7
10232	S700_3505	48	86.1500000000000057	1
10232	S700_3962	35	81.4300000000000068	2
10232	S72_3212	24	48.5900000000000034	3
10233	S24_3151	40	70.8100000000000023	2
10233	S700_1138	36	66	3
10233	S700_2610	29	67.9399999999999977	1
10234	S10_4757	48	118.319999999999993	9
10234	S18_1662	50	146.650000000000006	1
10234	S18_3029	48	84.2999999999999972	7
10234	S18_3856	39	85.75	6
10234	S24_2841	44	67.1400000000000006	2
10234	S24_3420	25	65.0900000000000034	3
10234	S24_3816	31	78.8299999999999983	8
10234	S700_2047	29	83.2800000000000011	5
10234	S72_1253	40	45.6899999999999977	4
10235	S18_2581	24	81.9500000000000028	3
10235	S24_1785	23	89.7199999999999989	5
10235	S24_3949	33	55.2700000000000031	12
10235	S24_4278	40	63.0300000000000011	4
10235	S32_1374	41	90.9000000000000057	1
10235	S32_4289	34	66.730000000000004	6
10235	S50_1341	41	37.0900000000000034	7
10235	S700_1691	25	88.5999999999999943	8
10235	S700_2466	38	92.7399999999999949	10
10235	S700_2834	25	116.280000000000001	2
10235	S700_3167	32	73.5999999999999943	9
10235	S700_4002	34	70.3299999999999983	11
10236	S10_2016	22	105.859999999999999	1
10236	S18_2625	23	52.7000000000000028	2
10236	S24_2000	36	65.5100000000000051	3
10237	S10_1678	23	91.8700000000000045	7
10237	S10_4698	39	158.800000000000011	9
10237	S12_2823	32	129.530000000000001	6
10237	S18_3782	26	49.740000000000002	1
10237	S24_1578	20	109.319999999999993	8
10237	S24_2360	26	62.3299999999999983	4
10237	S32_2206	26	35	2
10237	S32_4485	27	94.9099999999999966	5
10237	S50_4713	20	78.9200000000000017	3
10238	S12_1099	28	161.490000000000009	3
10238	S12_3380	29	104.519999999999996	1
10238	S12_3990	20	73.4200000000000017	4
10238	S18_3278	41	68.3499999999999943	6
10238	S18_3482	49	144.050000000000011	5
10238	S18_4721	44	120.530000000000001	8
10238	S24_3371	47	53.8800000000000026	2
10238	S24_4620	22	67.9099999999999966	7
10239	S12_4675	21	100.189999999999998	5
10239	S18_1889	46	70.0699999999999932	4
10239	S18_3232	47	135.469999999999999	1
10239	S24_2972	20	32.4699999999999989	2
10239	S24_3856	29	133.409999999999997	3
10240	S18_1129	41	125.969999999999999	3
10240	S18_1984	37	136.560000000000002	2
10240	S18_3685	37	134.219999999999999	1
10241	S18_1589	21	119.459999999999994	11
10241	S18_1749	41	153	2
10241	S18_2248	33	55.7000000000000028	1
10241	S18_2870	44	126.719999999999999	12
10241	S18_4409	42	77.3100000000000023	3
10241	S18_4933	30	62.7199999999999989	4
10241	S24_1046	22	72.019999999999996	8
10241	S24_1628	21	47.2899999999999991	10
10241	S24_2766	47	89.0499999999999972	6
10241	S24_2887	28	117.439999999999998	5
10241	S24_3191	26	69.3400000000000034	7
10241	S24_3432	27	107.079999999999998	9
10242	S24_3969	46	36.5200000000000031	1
10243	S18_2325	47	111.870000000000005	2
10243	S24_1937	33	30.870000000000001	1
10244	S18_1342	40	99.6599999999999966	7
10244	S18_1367	20	48.5200000000000031	6
10244	S18_2795	43	141.75	8
10244	S18_2949	30	87.1299999999999955	1
10244	S18_2957	24	54.9600000000000009	3
10244	S18_3136	29	85.8700000000000045	2
10244	S18_3320	36	87.2999999999999972	5
10244	S24_2022	39	42.1099999999999994	9
10244	S24_4258	40	97.3900000000000006	4
10245	S10_1949	34	195.009999999999991	9
10245	S10_4962	28	147.740000000000009	2
10245	S12_1666	38	120.269999999999996	6
10245	S18_1097	29	114.340000000000003	8
10245	S18_4600	21	111.390000000000001	3
10245	S18_4668	45	48.7999999999999972	7
10245	S32_1268	37	81.8599999999999994	1
10245	S32_3522	44	54.9399999999999977	5
10245	S700_2824	44	81.9300000000000068	4
10246	S12_4473	46	99.5400000000000063	5
10246	S18_2238	40	144.080000000000013	4
10246	S18_2319	22	100.640000000000001	8
10246	S18_2432	30	57.7299999999999969	11
10246	S18_3232	36	145.629999999999995	9
10246	S24_1444	44	46.240000000000002	2
10246	S24_2300	29	118.840000000000003	10
10246	S24_2840	49	34.6499999999999986	6
10246	S24_4048	46	100.540000000000006	1
10246	S32_2509	35	45.4500000000000028	7
10246	S50_1392	22	113.439999999999998	3
10247	S12_1108	44	195.330000000000013	2
10247	S12_3148	25	140.5	3
10247	S12_3891	27	167.830000000000013	1
10247	S18_4027	48	143.620000000000005	5
10247	S32_3207	40	58.4099999999999966	6
10247	S50_1514	49	51.5499999999999972	4
10248	S10_4757	20	126.480000000000004	3
10248	S18_3029	21	80.8599999999999994	1
10248	S18_3140	32	133.860000000000014	12
10248	S18_3259	42	95.7999999999999972	14
10248	S18_4522	42	87.769999999999996	11
10248	S24_2011	48	122.890000000000001	10
10248	S24_3151	30	85.8499999999999943	5
10248	S24_3816	23	83.019999999999996	2
10248	S700_1138	36	66	6
10248	S700_1938	40	81.4099999999999966	13
10248	S700_2610	32	69.3900000000000006	4
10248	S700_3505	30	84.1400000000000006	7
10248	S700_3962	35	92.3599999999999994	8
10248	S72_3212	23	53.509999999999998	9
10249	S18_3856	46	88.9300000000000068	5
10249	S24_2841	20	54.8100000000000023	1
10249	S24_3420	25	65.75	2
10249	S700_2047	40	85.9899999999999949	4
10249	S72_1253	32	49.1599999999999966	3
10250	S18_1662	45	148.22999999999999	14
10250	S18_2581	27	84.480000000000004	4
10250	S24_1785	31	95.2000000000000028	6
10250	S24_2000	32	63.2199999999999989	1
10250	S24_3949	40	61.4200000000000017	13
10250	S24_4278	37	72.4500000000000028	5
10250	S32_1374	31	99.8900000000000006	2
10250	S32_4289	50	62.6000000000000014	7
10250	S50_1341	36	36.6599999999999966	8
10250	S700_1691	31	91.3400000000000034	9
10250	S700_2466	35	90.75	11
10250	S700_2834	44	98.480000000000004	3
10250	S700_3167	44	76	10
10250	S700_4002	38	65.8900000000000006	12
10251	S10_1678	59	93.7900000000000063	2
10251	S10_2016	44	115.370000000000005	5
10251	S10_4698	43	172.360000000000014	4
10251	S12_2823	46	129.530000000000001	1
10251	S18_2625	44	58.1499999999999986	6
10251	S24_1578	50	91.2900000000000063	3
10252	S18_3278	20	74.7800000000000011	2
10252	S18_3482	41	145.52000000000001	1
10252	S18_3782	31	50.3599999999999994	5
10252	S18_4721	26	127.969999999999999	4
10252	S24_2360	47	63.0300000000000011	8
10252	S24_4620	38	69.519999999999996	3
10252	S32_2206	36	36.2100000000000009	6
10252	S32_4485	25	93.8900000000000006	9
10252	S50_4713	48	72.4099999999999966	7
10253	S12_1099	24	157.599999999999994	13
10253	S12_3380	22	102.170000000000002	11
10253	S12_3990	25	67.0300000000000011	14
10253	S12_4675	41	109.400000000000006	10
10253	S18_1129	26	130.219999999999999	5
10253	S18_1589	24	103.290000000000006	1
10253	S18_1889	23	67.7600000000000051	9
10253	S18_1984	33	130.870000000000005	4
10253	S18_2870	37	114.840000000000003	2
10253	S18_3232	40	145.629999999999995	6
10253	S18_3685	31	139.870000000000005	3
10253	S24_2972	40	34.740000000000002	7
10253	S24_3371	24	50.8200000000000003	12
10253	S24_3856	39	115.150000000000006	8
10254	S18_1749	49	137.699999999999989	5
10254	S18_2248	36	55.0900000000000034	4
10254	S18_2325	41	102.980000000000004	2
10254	S18_4409	34	80.9899999999999949	6
10254	S18_4933	30	59.8699999999999974	7
10254	S24_1046	34	66.8799999999999955	11
10254	S24_1628	32	43.2700000000000031	13
10254	S24_1937	38	28.879999999999999	1
10254	S24_2766	31	85.4200000000000017	9
10254	S24_2887	33	111.569999999999993	8
10254	S24_3191	42	69.3400000000000034	10
10254	S24_3432	49	101.730000000000004	12
10254	S24_3969	20	39.7999999999999972	3
10255	S18_2795	24	135	1
10255	S24_2022	37	37.6300000000000026	2
10256	S18_1342	34	93.4899999999999949	2
10256	S18_1367	29	52.8299999999999983	1
10257	S18_2949	50	92.1899999999999977	1
10257	S18_2957	49	59.3400000000000034	3
10257	S18_3136	37	83.7800000000000011	2
10257	S18_3320	26	91.269999999999996	5
10257	S24_4258	46	81.8100000000000023	4
10258	S10_1949	32	177.870000000000005	6
10258	S12_1666	41	133.939999999999998	3
10258	S18_1097	41	113.170000000000002	5
10258	S18_4668	21	49.8100000000000023	4
10258	S32_3522	20	62.7000000000000028	2
10258	S700_2824	45	86.9899999999999949	1
10259	S10_4962	26	121.150000000000006	12
10259	S12_4473	46	117.319999999999993	4
10259	S18_2238	30	134.259999999999991	3
10259	S18_2319	34	120.280000000000001	7
10259	S18_2432	30	59.5499999999999972	10
10259	S18_3232	27	152.409999999999997	8
10259	S18_4600	41	107.760000000000005	13
10259	S24_1444	28	46.8200000000000003	1
10259	S24_2300	47	121.400000000000006	9
10259	S24_2840	31	31.4699999999999989	5
10259	S32_1268	45	95.3499999999999943	11
10259	S32_2509	40	45.990000000000002	6
10259	S50_1392	29	105.329999999999998	2
10260	S12_1108	46	180.789999999999992	5
10260	S12_3148	30	140.5	6
10260	S12_3891	44	169.560000000000002	4
10260	S18_3140	32	121.569999999999993	1
10260	S18_3259	29	92.769999999999996	3
10260	S18_4027	23	137.879999999999995	8
10260	S24_4048	23	117.099999999999994	10
10260	S32_3207	27	55.2999999999999972	9
10260	S50_1514	21	56.240000000000002	7
10260	S700_1938	33	80.5499999999999972	2
10261	S10_4757	27	116.959999999999994	1
10261	S18_4522	20	80.75	9
10261	S24_2011	36	105.689999999999998	8
10261	S24_3151	22	79.6599999999999966	3
10261	S700_1138	34	64	4
10261	S700_2610	44	58.5499999999999972	2
10261	S700_3505	25	89.1500000000000057	5
10261	S700_3962	50	88.3900000000000006	6
10261	S72_3212	29	43.6799999999999997	7
10262	S18_1662	49	157.689999999999998	9
10262	S18_3029	32	81.7199999999999989	15
10262	S18_3856	34	85.75	14
10262	S24_1785	34	98.480000000000004	1
10262	S24_2841	24	63.7100000000000009	10
10262	S24_3420	46	65.75	11
10262	S24_3816	49	82.1800000000000068	16
10262	S24_3949	48	58.6899999999999977	8
10262	S32_4289	40	63.9699999999999989	2
10262	S50_1341	49	35.7800000000000011	3
10262	S700_1691	40	87.6899999999999977	4
10262	S700_2047	44	83.2800000000000011	13
10262	S700_2466	33	81.769999999999996	6
10262	S700_3167	27	64.7999999999999972	5
10262	S700_4002	35	64.4099999999999966	7
10262	S72_1253	21	41.7100000000000009	12
10263	S10_1678	34	89	2
10263	S10_2016	40	107.049999999999997	5
10263	S10_4698	41	193.659999999999997	4
10263	S12_2823	48	123.510000000000005	1
10263	S18_2581	33	67.5799999999999983	10
10263	S18_2625	34	50.2700000000000031	6
10263	S24_1578	42	109.319999999999993	3
10263	S24_2000	37	67.0300000000000011	7
10263	S24_4278	24	59.4099999999999966	11
10263	S32_1374	31	93.9000000000000057	8
10263	S700_2834	47	117.459999999999994	9
10264	S18_3782	48	58.4399999999999977	3
10264	S18_4721	20	124.989999999999995	2
10264	S24_2360	37	61.6400000000000006	6
10264	S24_4620	47	75.1800000000000068	1
10264	S32_2206	20	39.0200000000000031	4
10264	S32_4485	34	100.010000000000005	7
10264	S50_4713	47	67.5300000000000011	5
10265	S18_3278	45	74.7800000000000011	2
10265	S18_3482	49	123.469999999999999	1
10266	S12_1099	44	188.72999999999999	14
10266	S12_3380	22	110.390000000000001	12
10266	S12_3990	35	67.8299999999999983	15
10266	S12_4675	40	112.859999999999999	11
10266	S18_1129	21	131.629999999999995	6
10266	S18_1589	36	99.5499999999999972	2
10266	S18_1889	33	77	10
10266	S18_1984	49	139.409999999999997	5
10266	S18_2870	20	113.519999999999996	3
10266	S18_3232	29	137.169999999999987	7
10266	S18_3685	33	127.150000000000006	4
10266	S24_1628	28	40.25	1
10266	S24_2972	34	35.1199999999999974	8
10266	S24_3371	47	56.3299999999999983	13
10266	S24_3856	24	119.370000000000005	9
10267	S18_4933	36	71.269999999999996	1
10267	S24_1046	40	72.019999999999996	5
10267	S24_2766	38	76.3299999999999983	3
10267	S24_2887	43	93.9500000000000028	2
10267	S24_3191	44	83.9000000000000057	4
10267	S24_3432	43	98.5100000000000051	6
10268	S18_1342	49	93.4899999999999949	3
10268	S18_1367	26	45.8200000000000003	2
10268	S18_1749	34	164.900000000000006	10
10268	S18_2248	31	60.5399999999999991	9
10268	S18_2325	50	124.590000000000003	7
10268	S18_2795	35	148.5	4
10268	S18_3320	39	96.230000000000004	1
10268	S18_4409	35	84.6700000000000017	11
10268	S24_1937	33	31.8599999999999994	6
10268	S24_2022	40	36.2899999999999991	5
10268	S24_3969	30	37.75	8
10269	S18_2957	32	57.4600000000000009	1
10269	S24_4258	48	95.4399999999999977	2
10270	S10_1949	21	171.439999999999998	9
10270	S10_4962	32	124.099999999999994	2
10270	S12_1666	28	135.300000000000011	6
10270	S18_1097	43	94.5	8
10270	S18_2949	31	81.0499999999999972	10
10270	S18_3136	38	85.8700000000000045	11
10270	S18_4600	38	107.760000000000005	3
10270	S18_4668	44	40.25	7
10270	S32_1268	32	93.4200000000000017	1
10270	S32_3522	21	52.3599999999999994	5
10270	S700_2824	46	101.150000000000006	4
10271	S12_4473	31	99.5400000000000063	5
10271	S18_2238	50	147.360000000000014	4
10271	S18_2319	50	121.5	8
10271	S18_2432	25	59.5499999999999972	11
10271	S18_3232	20	169.340000000000003	9
10271	S24_1444	45	49.7100000000000009	2
10271	S24_2300	43	122.680000000000007	10
10271	S24_2840	38	28.6400000000000006	6
10271	S24_4048	22	110	1
10271	S32_2509	35	51.9500000000000028	7
10271	S50_1392	34	93.7600000000000051	3
10272	S12_1108	35	187.02000000000001	2
10272	S12_3148	27	123.890000000000001	3
10272	S12_3891	39	148.800000000000011	1
10272	S18_4027	25	126.390000000000001	5
10272	S32_3207	45	56.5499999999999972	6
10272	S50_1514	43	53.8900000000000006	4
10273	S10_4757	30	136	4
10273	S18_3029	34	84.2999999999999972	2
10273	S18_3140	40	117.469999999999999	13
10273	S18_3259	47	87.730000000000004	15
10273	S18_3856	50	105.870000000000005	1
10273	S18_4522	33	72.8499999999999943	12
10273	S24_2011	22	103.230000000000004	11
10273	S24_3151	27	84.0799999999999983	6
10273	S24_3816	48	83.8599999999999994	3
10273	S700_1138	21	66	7
10273	S700_1938	21	77.9500000000000028	14
10273	S700_2610	42	57.8200000000000003	5
10273	S700_3505	40	91.1500000000000057	8
10273	S700_3962	26	89.3799999999999955	9
10273	S72_3212	37	51.3200000000000003	10
10274	S18_1662	41	129.310000000000002	1
10274	S24_2841	40	56.8599999999999994	2
10274	S24_3420	24	65.0900000000000034	3
10274	S700_2047	24	75.1299999999999955	5
10274	S72_1253	32	49.6599999999999966	4
10275	S10_1678	45	81.3499999999999943	1
10275	S10_2016	22	115.370000000000005	4
10275	S10_4698	36	154.930000000000007	3
10275	S18_2581	35	70.1200000000000045	9
10275	S18_2625	37	52.0900000000000034	5
10275	S24_1578	21	105.939999999999998	2
10275	S24_1785	25	97.3799999999999955	11
10275	S24_2000	30	61.7000000000000028	6
10275	S24_3949	41	58	18
10275	S24_4278	27	67.3799999999999955	10
10275	S32_1374	23	89.9000000000000057	7
10275	S32_4289	28	58.4699999999999989	12
10275	S50_1341	38	40.1499999999999986	13
10275	S700_1691	32	85.8599999999999994	14
10275	S700_2466	39	82.769999999999996	16
10275	S700_2834	48	102.040000000000006	8
10275	S700_3167	43	72	15
10275	S700_4002	31	59.9600000000000009	17
10276	S12_1099	50	184.840000000000003	3
10276	S12_2823	43	150.620000000000005	14
10276	S12_3380	47	104.519999999999996	1
10276	S12_3990	38	67.8299999999999983	4
10276	S18_3278	38	78	6
10276	S18_3482	30	139.639999999999986	5
10276	S18_3782	33	54.7100000000000009	9
10276	S18_4721	48	120.530000000000001	8
10276	S24_2360	46	61.6400000000000006	12
10276	S24_3371	20	58.1700000000000017	2
10276	S24_4620	48	67.0999999999999943	7
10276	S32_2206	27	35.3999999999999986	10
10276	S32_4485	38	94.9099999999999966	13
10276	S50_4713	21	67.5300000000000011	11
10277	S12_4675	28	93.2800000000000011	1
10278	S18_1129	34	114.650000000000006	6
10278	S18_1589	23	107.019999999999996	2
10278	S18_1889	29	73.1500000000000057	10
10278	S18_1984	29	118.069999999999993	5
10278	S18_2870	39	117.480000000000004	3
10278	S18_3232	42	167.650000000000006	7
10278	S18_3685	31	114.439999999999998	4
10278	S24_1628	35	48.7999999999999972	1
10278	S24_2972	31	37.3800000000000026	8
10278	S24_3856	25	136.219999999999999	9
10279	S18_4933	26	68.4200000000000017	1
10279	S24_1046	32	68.3499999999999943	5
10279	S24_2766	49	76.3299999999999983	3
10279	S24_2887	48	106.870000000000005	2
10279	S24_3191	33	78.7600000000000051	4
10279	S24_3432	48	95.2999999999999972	6
10280	S10_1949	34	205.72999999999999	2
10280	S18_1097	24	98	1
10280	S18_1342	50	87.3299999999999983	9
10280	S18_1367	27	47.4399999999999977	8
10280	S18_1749	26	161.5	16
10280	S18_2248	25	53.2800000000000011	15
10280	S18_2325	37	109.329999999999998	13
10280	S18_2795	22	158.629999999999995	10
10280	S18_2949	46	82.0600000000000023	3
10280	S18_2957	43	54.3400000000000034	5
10280	S18_3136	29	102.629999999999995	4
10280	S18_3320	34	99.2099999999999937	7
10280	S18_4409	35	77.3100000000000023	17
10280	S24_1937	20	29.870000000000001	12
10280	S24_2022	45	36.2899999999999991	11
10280	S24_3969	33	35.2899999999999991	14
10280	S24_4258	21	79.8599999999999994	6
10281	S10_4962	44	132.969999999999999	9
10281	S12_1666	25	127.099999999999994	13
10281	S12_4473	41	98.3599999999999994	1
10281	S18_2319	48	114.140000000000001	4
10281	S18_2432	29	56.5200000000000031	7
10281	S18_3232	25	135.469999999999999	5
10281	S18_4600	25	96.8599999999999994	10
10281	S18_4668	44	42.759999999999998	14
10281	S24_2300	25	112.459999999999994	6
10281	S24_2840	20	33.9500000000000028	2
10281	S32_1268	29	80.9000000000000057	8
10281	S32_2509	31	44.9099999999999966	3
10281	S32_3522	36	59.4699999999999989	12
10281	S700_2824	27	89.0100000000000051	11
10282	S12_1108	41	176.629999999999995	5
10282	S12_3148	27	142.02000000000001	6
10282	S12_3891	24	169.560000000000002	4
10282	S18_2238	23	147.360000000000014	13
10282	S18_3140	43	122.930000000000007	1
10282	S18_3259	36	88.7399999999999949	3
10282	S18_4027	31	132.129999999999995	8
10282	S24_1444	29	49.7100000000000009	11
10282	S24_4048	39	96.9899999999999949	10
10282	S32_3207	36	51.5799999999999983	9
10282	S50_1392	38	114.590000000000003	12
10282	S50_1514	37	56.240000000000002	7
10282	S700_1938	43	77.9500000000000028	2
10283	S10_4757	25	130.560000000000002	6
10283	S18_3029	21	78.2800000000000011	4
10283	S18_3856	46	100.579999999999998	3
10283	S18_4522	34	71.9699999999999989	14
10283	S24_2011	42	99.5400000000000063	13
10283	S24_3151	34	80.5400000000000063	8
10283	S24_3816	33	77.1500000000000057	5
10283	S700_1138	45	62	9
10283	S700_2047	20	74.230000000000004	2
10283	S700_2610	47	68.6700000000000017	7
10283	S700_3505	22	88.1500000000000057	10
10283	S700_3962	38	85.4099999999999966	11
10283	S72_1253	43	41.2199999999999989	1
10283	S72_3212	33	49.1400000000000006	12
10284	S18_1662	45	137.189999999999998	11
10284	S18_2581	31	68.4300000000000068	1
10284	S24_1785	22	101.760000000000005	3
10284	S24_2841	30	65.0799999999999983	12
10284	S24_3420	39	59.8299999999999983	13
10284	S24_3949	21	65.5100000000000051	10
10284	S24_4278	21	66.6500000000000057	2
10284	S32_4289	50	60.5399999999999991	4
10284	S50_1341	33	35.7800000000000011	5
10284	S700_1691	24	87.6899999999999977	6
10284	S700_2466	45	95.730000000000004	8
10284	S700_3167	25	68	7
10284	S700_4002	32	73.2900000000000063	9
10285	S10_1678	36	95.7000000000000028	6
10285	S10_2016	47	110.609999999999999	9
10285	S10_4698	27	166.550000000000011	8
10285	S12_2823	49	131.039999999999992	5
10285	S18_2625	20	50.8800000000000026	10
10285	S24_1578	34	91.2900000000000063	7
10285	S24_2000	39	61.7000000000000028	11
10285	S24_2360	38	64.4099999999999966	3
10285	S32_1374	37	82.9099999999999966	12
10285	S32_2206	37	36.6099999999999994	1
10285	S32_4485	26	100.010000000000005	4
10285	S50_4713	39	76.480000000000004	2
10285	S700_2834	45	102.040000000000006	13
10286	S18_3782	38	51.6000000000000014	1
10287	S12_1099	21	190.680000000000007	12
10287	S12_3380	45	117.439999999999998	10
10287	S12_3990	41	74.2099999999999937	13
10287	S12_4675	23	107.099999999999994	9
10287	S18_1129	41	113.230000000000004	4
10287	S18_1889	44	61.6000000000000014	8
10287	S18_1984	24	123.760000000000005	3
10287	S18_2870	44	114.840000000000003	1
10287	S18_3232	36	137.169999999999987	5
10287	S18_3278	43	68.3499999999999943	15
10287	S18_3482	40	127.879999999999995	14
10287	S18_3685	27	139.870000000000005	2
10287	S18_4721	34	119.040000000000006	17
10287	S24_2972	36	31.3399999999999999	6
10287	S24_3371	20	58.1700000000000017	11
10287	S24_3856	36	137.620000000000005	7
10287	S24_4620	40	79.2199999999999989	16
10288	S18_1589	20	120.709999999999994	14
10288	S18_1749	32	168.300000000000011	5
10288	S18_2248	28	50.25	4
10288	S18_2325	31	102.980000000000004	2
10288	S18_4409	35	90.1899999999999977	6
10288	S18_4933	23	57.0200000000000031	7
10288	S24_1046	36	66.8799999999999955	11
10288	S24_1628	50	49.2999999999999972	13
10288	S24_1937	29	32.1899999999999977	1
10288	S24_2766	35	81.7800000000000011	9
10288	S24_2887	48	109.219999999999999	8
10288	S24_3191	34	76.1899999999999977	10
10288	S24_3432	41	101.730000000000004	12
10288	S24_3969	33	37.75	3
10289	S18_1342	38	92.4699999999999989	2
10289	S18_1367	24	44.75	1
10289	S18_2795	43	141.75	3
10289	S24_2022	45	41.2199999999999989	4
10290	S18_3320	26	80.3599999999999994	2
10290	S24_4258	45	83.7600000000000051	1
10291	S10_1949	37	210.009999999999991	11
10291	S10_4962	30	141.830000000000013	4
10291	S12_1666	41	123	8
10291	S18_1097	41	96.8400000000000034	10
10291	S18_2432	26	52.259999999999998	2
10291	S18_2949	47	99.2800000000000011	12
10291	S18_2957	37	56.2100000000000009	14
10291	S18_3136	23	93.2000000000000028	13
10291	S18_4600	48	96.8599999999999994	5
10291	S18_4668	29	45.2800000000000011	9
10291	S24_2300	48	109.900000000000006	1
10291	S32_1268	26	82.8299999999999983	3
10291	S32_3522	32	53	7
10291	S700_2824	28	86.9899999999999949	6
10292	S12_4473	21	94.7999999999999972	8
10292	S18_2238	26	140.810000000000002	7
10292	S18_2319	41	103.090000000000003	11
10292	S18_3232	21	147.330000000000013	12
10292	S18_4027	44	114.900000000000006	2
10292	S24_1444	40	48.5499999999999972	5
10292	S24_2840	39	34.2999999999999972	9
10292	S24_4048	27	113.549999999999997	4
10292	S32_2509	50	54.1099999999999994	10
10292	S32_3207	31	59.6499999999999986	3
10292	S50_1392	41	113.439999999999998	6
10292	S50_1514	35	49.7899999999999991	1
10293	S12_1108	46	187.02000000000001	8
10293	S12_3148	24	129.930000000000007	9
10293	S12_3891	45	171.289999999999992	7
10293	S18_3140	24	110.640000000000001	4
10293	S18_3259	22	91.7600000000000051	6
10293	S18_4522	49	72.8499999999999943	3
10293	S24_2011	21	111.829999999999998	2
10293	S700_1938	29	77.9500000000000028	5
10293	S72_3212	32	51.3200000000000003	1
10294	S700_3962	45	98.3199999999999932	1
10295	S10_4757	24	136	1
10295	S24_3151	46	84.0799999999999983	3
10295	S700_1138	26	62	4
10295	S700_2610	44	71.5600000000000023	2
10295	S700_3505	34	93.1599999999999966	5
10296	S18_1662	36	146.650000000000006	7
10296	S18_3029	21	69.6800000000000068	13
10296	S18_3856	22	105.870000000000005	12
10296	S24_2841	21	60.9699999999999989	8
10296	S24_3420	31	63.7800000000000011	9
10296	S24_3816	22	83.019999999999996	14
10296	S24_3949	32	63.4600000000000009	6
10296	S50_1341	26	41.0200000000000031	1
10296	S700_1691	42	75.8100000000000023	2
10296	S700_2047	34	89.6099999999999994	11
10296	S700_2466	24	96.730000000000004	4
10296	S700_3167	22	74.4000000000000057	3
10296	S700_4002	47	61.4399999999999977	5
10296	S72_1253	21	46.6799999999999997	10
10297	S18_2581	25	81.9500000000000028	4
10297	S24_1785	32	107.230000000000004	6
10297	S24_2000	32	70.0799999999999983	1
10297	S24_4278	23	71.730000000000004	5
10297	S32_1374	26	88.9000000000000057	2
10297	S32_4289	28	63.2899999999999991	7
10297	S700_2834	35	111.530000000000001	3
10298	S10_2016	39	105.859999999999999	1
10298	S18_2625	32	60.5700000000000003	2
10299	S10_1678	23	76.5600000000000023	9
10299	S10_4698	29	164.610000000000014	11
10299	S12_2823	24	123.510000000000005	8
10299	S18_3782	39	62.1700000000000017	3
10299	S18_4721	49	119.040000000000006	2
10299	S24_1578	47	107.069999999999993	10
10299	S24_2360	33	58.8699999999999974	6
10299	S24_4620	32	66.2900000000000063	1
10299	S32_2206	24	36.2100000000000009	4
10299	S32_4485	38	84.7000000000000028	7
10299	S50_4713	44	77.2900000000000063	5
10300	S12_1099	33	184.840000000000003	5
10300	S12_3380	29	116.269999999999996	3
10300	S12_3990	22	76.6099999999999994	6
10300	S12_4675	23	95.5799999999999983	2
10300	S18_1889	41	63.1400000000000006	1
10300	S18_3278	49	65.9399999999999977	8
10300	S18_3482	23	144.050000000000011	7
10300	S24_3371	31	52.0499999999999972	4
10301	S18_1129	37	114.650000000000006	8
10301	S18_1589	32	118.219999999999999	4
10301	S18_1984	47	119.489999999999995	7
10301	S18_2870	22	113.519999999999996	5
10301	S18_3232	23	135.469999999999999	9
10301	S18_3685	39	137.039999999999992	6
10301	S24_1046	27	64.6700000000000017	1
10301	S24_1628	22	40.75	3
10301	S24_2972	48	32.1000000000000014	10
10301	S24_3432	22	86.730000000000004	2
10301	S24_3856	50	122.170000000000002	11
10302	S18_1749	43	166.599999999999994	1
10302	S18_4409	38	82.8299999999999983	2
10302	S18_4933	23	70.5600000000000023	3
10302	S24_2766	49	75.4200000000000017	5
10302	S24_2887	45	104.519999999999996	4
10302	S24_3191	48	74.480000000000004	6
10303	S18_2248	46	56.9099999999999966	2
10303	S24_3969	24	35.7000000000000028	1
10304	S10_1949	47	201.439999999999998	6
10304	S12_1666	39	117.540000000000006	3
10304	S18_1097	46	106.170000000000002	5
10304	S18_1342	37	95.5499999999999972	13
10304	S18_1367	37	46.8999999999999986	12
10304	S18_2325	24	102.980000000000004	17
10304	S18_2795	20	141.75	14
10304	S18_2949	46	98.269999999999996	7
10304	S18_2957	24	54.3400000000000034	9
10304	S18_3136	26	90.0600000000000023	8
10304	S18_3320	38	95.2399999999999949	11
10304	S18_4668	34	44.2700000000000031	4
10304	S24_1937	23	29.2100000000000009	16
10304	S24_2022	44	42.1099999999999994	15
10304	S24_4258	33	80.8299999999999983	10
10304	S32_3522	36	52.3599999999999994	2
10304	S700_2824	40	80.9200000000000017	1
10305	S10_4962	38	130.009999999999991	13
10305	S12_4473	38	107.840000000000003	5
10305	S18_2238	27	132.620000000000005	4
10305	S18_2319	36	117.819999999999993	8
10305	S18_2432	41	58.9500000000000028	11
10305	S18_3232	37	160.870000000000005	9
10305	S18_4600	22	112.599999999999994	14
10305	S24_1444	45	48.5499999999999972	2
10305	S24_2300	24	107.340000000000003	10
10305	S24_2840	48	30.7600000000000016	6
10305	S24_4048	36	118.280000000000001	1
10305	S32_1268	28	94.3799999999999955	12
10305	S32_2509	40	48.7000000000000028	7
10305	S50_1392	42	109.959999999999994	3
10306	S12_1108	31	182.860000000000014	13
10306	S12_3148	34	145.039999999999992	14
10306	S12_3891	20	145.340000000000003	12
10306	S18_3140	32	114.739999999999995	9
10306	S18_3259	40	83.7000000000000028	11
10306	S18_4027	23	126.390000000000001	16
10306	S18_4522	39	85.1400000000000006	8
10306	S24_2011	29	109.370000000000005	7
10306	S24_3151	31	76.1200000000000045	2
10306	S32_3207	46	60.2800000000000011	17
10306	S50_1514	34	51.5499999999999972	15
10306	S700_1138	50	61.3400000000000034	3
10306	S700_1938	38	73.6200000000000045	10
10306	S700_2610	43	62.1599999999999966	1
10306	S700_3505	32	99.1700000000000017	4
10306	S700_3962	30	87.3900000000000006	5
10306	S72_3212	35	48.0499999999999972	6
10307	S10_4757	22	118.319999999999993	9
10307	S18_1662	39	135.610000000000014	1
10307	S18_3029	31	71.4000000000000057	7
10307	S18_3856	48	92.1099999999999994	6
10307	S24_2841	25	58.2299999999999969	2
10307	S24_3420	22	64.4399999999999977	3
10307	S24_3816	22	75.4699999999999989	8
10307	S700_2047	34	81.4699999999999989	5
10307	S72_1253	34	44.2000000000000028	4
10308	S10_2016	34	115.370000000000005	2
10308	S10_4698	20	187.849999999999994	1
10308	S18_2581	27	81.9500000000000028	7
10308	S18_2625	34	48.4600000000000009	3
10308	S24_1785	31	99.5699999999999932	9
10308	S24_2000	47	68.5499999999999972	4
10308	S24_3949	43	58	16
10308	S24_4278	44	71.730000000000004	8
10308	S32_1374	24	99.8900000000000006	5
10308	S32_4289	46	61.2199999999999989	10
10308	S50_1341	47	37.0900000000000034	11
10308	S700_1691	21	73.0699999999999932	12
10308	S700_2466	35	88.75	14
10308	S700_2834	31	100.849999999999994	6
10308	S700_3167	21	79.2000000000000028	13
10308	S700_4002	39	62.9299999999999997	15
10309	S10_1678	41	94.7399999999999949	5
10309	S12_2823	26	144.599999999999994	4
10309	S24_1578	21	96.9200000000000017	6
10309	S24_2360	24	59.5600000000000023	2
10309	S32_4485	50	93.8900000000000006	3
10309	S50_4713	28	74.0400000000000063	1
10310	S12_1099	33	165.379999999999995	10
10310	S12_3380	24	105.700000000000003	8
10310	S12_3990	49	77.4099999999999966	11
10310	S12_4675	25	101.340000000000003	7
10310	S18_1129	37	128.800000000000011	2
10310	S18_1889	20	66.9899999999999949	6
10310	S18_1984	24	129.449999999999989	1
10310	S18_3232	48	159.180000000000007	3
10310	S18_3278	27	70.7600000000000051	13
10310	S18_3482	49	122	12
10310	S18_3782	42	59.0600000000000023	16
10310	S18_4721	40	133.919999999999987	15
10310	S24_2972	33	33.2299999999999969	4
10310	S24_3371	38	50.2100000000000009	9
10310	S24_3856	45	139.030000000000001	5
10310	S24_4620	49	75.1800000000000068	14
10310	S32_2206	36	38.6199999999999974	17
10311	S18_1589	29	124.439999999999998	9
10311	S18_2870	43	114.840000000000003	10
10311	S18_3685	32	134.219999999999999	11
10311	S18_4409	41	92.0300000000000011	1
10311	S18_4933	25	66.9899999999999949	2
10311	S24_1046	26	70.5499999999999972	6
10311	S24_1628	45	48.7999999999999972	8
10311	S24_2766	28	89.0499999999999972	4
10311	S24_2887	43	116.269999999999996	3
10311	S24_3191	25	85.6099999999999994	5
10311	S24_3432	46	91.019999999999996	7
10312	S10_1949	48	214.300000000000011	3
10312	S18_1097	32	101.5	2
10312	S18_1342	43	102.739999999999995	10
10312	S18_1367	25	43.6700000000000017	9
10312	S18_1749	48	146.199999999999989	17
10312	S18_2248	30	48.4299999999999997	16
10312	S18_2325	31	111.870000000000005	14
10312	S18_2795	25	150.189999999999998	11
10312	S18_2949	37	91.1800000000000068	4
10312	S18_2957	35	54.3400000000000034	6
10312	S18_3136	38	93.2000000000000028	5
10312	S18_3320	33	84.3299999999999983	8
10312	S18_4668	39	44.2700000000000031	1
10312	S24_1937	39	27.879999999999999	13
10312	S24_2022	23	43.4600000000000009	12
10312	S24_3969	31	40.2100000000000009	15
10312	S24_4258	44	96.4200000000000017	7
10313	S10_4962	40	141.830000000000013	7
10313	S12_1666	21	131.199999999999989	11
10313	S18_2319	29	109.230000000000004	2
10313	S18_2432	34	52.8699999999999974	5
10313	S18_3232	25	143.939999999999998	3
10313	S18_4600	28	110.180000000000007	8
10313	S24_2300	42	102.230000000000004	4
10313	S32_1268	27	96.3100000000000023	6
10313	S32_2509	38	48.7000000000000028	1
10313	S32_3522	34	55.5900000000000034	10
10313	S700_2824	30	96.0900000000000034	9
10314	S12_1108	38	176.629999999999995	5
10314	S12_3148	46	125.400000000000006	6
10314	S12_3891	36	169.560000000000002	4
10314	S12_4473	45	95.9899999999999949	14
10314	S18_2238	42	135.900000000000006	13
10314	S18_3140	20	129.759999999999991	1
10314	S18_3259	23	84.7099999999999937	3
10314	S18_4027	29	129.259999999999991	8
10314	S24_1444	44	51.4399999999999977	11
10314	S24_2840	39	31.8200000000000003	15
10314	S24_4048	38	111.180000000000007	10
10314	S32_3207	35	58.4099999999999966	9
10314	S50_1392	28	115.75	12
10314	S50_1514	38	50.3800000000000026	7
10314	S700_1938	23	83.1500000000000057	2
10315	S18_4522	36	78.1200000000000045	7
10315	S24_2011	35	111.829999999999998	6
10315	S24_3151	24	78.769999999999996	1
10315	S700_1138	41	60.6700000000000017	2
10315	S700_3505	31	99.1700000000000017	3
10315	S700_3962	37	88.3900000000000006	4
10315	S72_3212	40	51.3200000000000003	5
10316	S10_4757	33	126.480000000000004	17
10316	S18_1662	27	140.340000000000003	9
10316	S18_3029	21	72.2600000000000051	15
10316	S18_3856	47	89.9899999999999949	14
10316	S24_1785	25	93.0100000000000051	1
10316	S24_2841	34	67.1400000000000006	10
10316	S24_3420	47	55.2299999999999969	11
10316	S24_3816	25	77.1500000000000057	16
10316	S24_3949	30	67.5600000000000023	8
10316	S32_4289	24	59.1599999999999966	2
10316	S50_1341	34	36.6599999999999966	3
10316	S700_1691	34	74.9000000000000057	4
10316	S700_2047	45	73.3199999999999932	13
10316	S700_2466	23	85.7600000000000051	6
10316	S700_2610	48	67.2199999999999989	18
10316	S700_3167	48	77.5999999999999943	5
10316	S700_4002	44	68.1099999999999994	7
10316	S72_1253	34	43.7000000000000028	12
10317	S24_4278	35	69.5499999999999972	1
10318	S10_1678	46	84.2199999999999989	1
10318	S10_2016	45	102.290000000000006	4
10318	S10_4698	37	189.789999999999992	3
10318	S18_2581	31	81.9500000000000028	9
10318	S18_2625	42	49.6700000000000017	5
10318	S24_1578	48	93.5400000000000063	2
10318	S24_2000	26	60.9399999999999977	6
10318	S32_1374	47	81.9099999999999966	7
10318	S700_2834	50	102.040000000000006	8
10319	S12_2823	30	134.050000000000011	9
10319	S18_3278	46	77.1899999999999977	1
10319	S18_3782	44	54.7100000000000009	4
10319	S18_4721	45	120.530000000000001	3
10319	S24_2360	31	65.7999999999999972	7
10319	S24_4620	43	78.4099999999999966	2
10319	S32_2206	29	35	5
10319	S32_4485	22	96.9500000000000028	8
10319	S50_4713	45	79.730000000000004	6
10320	S12_1099	31	184.840000000000003	3
10320	S12_3380	35	102.170000000000002	1
10320	S12_3990	38	63.8400000000000034	4
10320	S18_3482	25	139.639999999999986	5
10320	S24_3371	26	60.6199999999999974	2
10321	S12_4675	24	105.950000000000003	15
10321	S18_1129	41	123.140000000000001	10
10321	S18_1589	44	120.709999999999994	6
10321	S18_1889	37	73.9200000000000017	14
10321	S18_1984	25	142.25	9
10321	S18_2870	27	126.719999999999999	7
10321	S18_3232	33	164.259999999999991	11
10321	S18_3685	28	138.449999999999989	8
10321	S24_1046	30	68.3499999999999943	3
10321	S24_1628	48	42.759999999999998	5
10321	S24_2766	30	74.5100000000000051	1
10321	S24_2972	37	31.7199999999999989	12
10321	S24_3191	39	81.3299999999999983	2
10321	S24_3432	21	103.870000000000005	4
10321	S24_3856	26	137.620000000000005	13
10322	S10_1949	40	180.009999999999991	1
10322	S10_4962	46	141.830000000000013	8
10322	S12_1666	27	136.669999999999987	9
10322	S18_1097	22	101.5	10
10322	S18_1342	43	92.4699999999999989	14
10322	S18_1367	41	44.2100000000000009	5
10322	S18_2325	50	120.769999999999996	6
10322	S18_2432	35	57.1199999999999974	11
10322	S18_2795	36	158.629999999999995	2
10322	S18_2949	33	100.299999999999997	12
10322	S18_2957	41	54.3400000000000034	13
10322	S18_3136	48	90.0600000000000023	7
10322	S24_1937	20	26.5500000000000007	3
10322	S24_2022	30	40.7700000000000031	4
10323	S18_3320	33	88.2999999999999972	2
10323	S18_4600	47	96.8599999999999994	1
10324	S12_3148	27	148.060000000000002	1
10324	S12_4473	26	100.730000000000004	7
10324	S18_2238	47	142.449999999999989	8
10324	S18_2319	33	105.549999999999997	10
10324	S18_3232	27	137.169999999999987	12
10324	S18_4027	49	120.640000000000001	13
10324	S18_4668	38	49.8100000000000023	6
10324	S24_1444	25	49.7100000000000009	14
10324	S24_2300	31	107.340000000000003	2
10324	S24_2840	30	29.3500000000000014	9
10324	S24_4258	33	95.4399999999999977	3
10324	S32_1268	20	91.4899999999999949	11
10324	S32_3522	48	60.759999999999998	4
10324	S700_2824	34	80.9200000000000017	5
10325	S10_4757	47	111.519999999999996	6
10325	S12_1108	42	193.25	8
10325	S12_3891	24	166.099999999999994	1
10325	S18_3140	24	114.739999999999995	9
10325	S24_4048	44	114.730000000000004	5
10325	S32_2509	38	44.3699999999999974	3
10325	S32_3207	28	55.2999999999999972	2
10325	S50_1392	38	99.5499999999999972	4
10325	S50_1514	44	56.240000000000002	7
10326	S18_3259	32	94.7900000000000063	6
10326	S18_4522	50	73.730000000000004	5
10326	S24_2011	41	120.430000000000007	4
10326	S24_3151	41	86.7399999999999949	3
10326	S24_3816	20	81.3400000000000034	2
10326	S700_1138	39	60.6700000000000017	1
10327	S18_1662	25	154.539999999999992	6
10327	S18_2581	45	74.3400000000000034	8
10327	S18_3029	25	74.8400000000000034	5
10327	S700_1938	20	79.6800000000000068	7
10327	S700_2610	21	65.0499999999999972	1
10327	S700_3505	43	85.1400000000000006	2
10327	S700_3962	37	83.4200000000000017	3
10327	S72_3212	37	48.0499999999999972	4
10328	S18_3856	34	104.810000000000002	6
10328	S24_1785	47	87.5400000000000063	14
10328	S24_2841	48	67.8199999999999932	1
10328	S24_3420	20	56.5499999999999972	2
10328	S24_3949	35	55.9600000000000009	3
10328	S24_4278	43	69.5499999999999972	4
10328	S32_4289	24	57.1000000000000014	5
10328	S50_1341	34	42.3299999999999983	7
10328	S700_1691	27	84.0300000000000011	8
10328	S700_2047	41	75.1299999999999955	9
10328	S700_2466	37	95.730000000000004	10
10328	S700_2834	33	117.459999999999994	11
10328	S700_3167	33	71.2000000000000028	13
10328	S700_4002	39	69.5900000000000034	12
10329	S10_1678	42	80.3900000000000006	1
10329	S10_2016	20	109.420000000000002	2
10329	S10_4698	26	164.610000000000014	3
10329	S12_1099	41	182.900000000000006	5
10329	S12_2823	24	128.030000000000001	6
10329	S12_3380	46	117.439999999999998	13
10329	S12_3990	33	74.2099999999999937	14
10329	S12_4675	39	102.489999999999995	15
10329	S18_1889	29	66.2199999999999989	9
10329	S18_2625	38	55.7199999999999989	12
10329	S18_3278	38	65.1299999999999955	10
10329	S24_1578	30	104.810000000000002	7
10329	S24_2000	37	71.5999999999999943	4
10329	S32_1374	45	80.9099999999999966	11
10329	S72_1253	44	41.2199999999999989	8
10330	S18_3482	37	136.699999999999989	3
10330	S18_3782	29	59.0600000000000023	2
10330	S18_4721	50	133.919999999999987	4
10330	S24_2360	42	56.1000000000000014	1
10331	S18_1129	46	120.310000000000002	6
10331	S18_1589	44	99.5499999999999972	14
10331	S18_1749	44	154.699999999999989	7
10331	S18_1984	30	135.139999999999986	8
10331	S18_2870	26	130.680000000000007	10
10331	S18_3232	27	169.340000000000003	11
10331	S18_3685	26	132.800000000000011	12
10331	S24_2972	27	37	13
10331	S24_3371	25	55.1099999999999994	9
10331	S24_3856	21	139.030000000000001	1
10331	S24_4620	41	70.3299999999999983	2
10331	S32_2206	28	33.3900000000000006	3
10331	S32_4485	32	100.010000000000005	4
10331	S50_4713	20	74.0400000000000063	5
10332	S18_1342	46	89.3799999999999955	15
10332	S18_1367	27	51.2100000000000009	16
10332	S18_2248	38	53.8800000000000026	9
10332	S18_2325	35	116.959999999999994	8
10332	S18_2795	24	138.379999999999995	1
10332	S18_2957	26	53.0900000000000034	17
10332	S18_3136	40	100.530000000000001	18
10332	S18_4409	50	92.0300000000000011	2
10332	S18_4933	21	70.5600000000000023	3
10332	S24_1046	23	61.7299999999999969	4
10332	S24_1628	20	47.2899999999999991	5
10332	S24_1937	45	29.870000000000001	6
10332	S24_2022	26	43.009999999999998	10
10332	S24_2766	39	84.5100000000000051	7
10332	S24_2887	44	108.040000000000006	11
10332	S24_3191	45	77.9099999999999966	12
10332	S24_3432	31	94.230000000000004	13
10332	S24_3969	41	34.4699999999999989	14
10333	S10_1949	26	188.580000000000013	3
10333	S12_1666	33	121.640000000000001	6
10333	S18_1097	29	110.840000000000003	7
10333	S18_2949	31	95.230000000000004	5
10333	S18_3320	46	95.2399999999999949	2
10333	S18_4668	24	42.259999999999998	8
10333	S24_4258	39	95.4399999999999977	1
10333	S32_3522	33	62.0499999999999972	4
10334	S10_4962	26	130.009999999999991	2
10334	S18_2319	46	108	6
10334	S18_2432	34	52.8699999999999974	1
10334	S18_3232	20	147.330000000000013	3
10334	S18_4600	49	101.709999999999994	4
10334	S24_2300	42	117.569999999999993	5
10335	S24_2840	33	32.8800000000000026	2
10335	S32_1268	44	77.0499999999999972	1
10335	S32_2509	40	49.7800000000000011	3
10336	S12_1108	33	176.629999999999995	10
10336	S12_3148	33	126.909999999999997	11
10336	S12_3891	49	141.879999999999995	1
10336	S12_4473	38	95.9899999999999949	3
10336	S18_2238	49	153.909999999999997	6
10336	S18_3140	48	135.219999999999999	12
10336	S18_3259	21	100.840000000000003	7
10336	S24_1444	45	49.7100000000000009	4
10336	S24_4048	31	113.549999999999997	5
10336	S32_3207	31	59.0300000000000011	9
10336	S50_1392	23	109.959999999999994	8
10336	S700_2824	46	94.0699999999999932	2
10337	S10_4757	25	131.919999999999987	8
10337	S18_4027	36	140.75	3
10337	S18_4522	29	76.3599999999999994	2
10337	S24_2011	29	119.200000000000003	4
10337	S50_1514	21	54.4799999999999969	6
10337	S700_1938	36	73.6200000000000045	9
10337	S700_3505	31	84.1400000000000006	1
10337	S700_3962	36	83.4200000000000017	7
10337	S72_3212	42	49.1400000000000006	5
10338	S18_1662	41	137.189999999999998	1
10338	S18_3029	28	80.8599999999999994	3
10338	S18_3856	45	93.1700000000000017	2
10339	S10_2016	40	117.75	4
10339	S10_4698	39	178.169999999999987	3
10339	S18_2581	27	79.4099999999999966	2
10339	S18_2625	30	48.4600000000000009	1
10339	S24_1578	27	96.9200000000000017	10
10339	S24_1785	21	106.140000000000001	7
10339	S24_2841	55	67.8199999999999932	12
10339	S24_3151	55	73.4599999999999937	13
10339	S24_3420	29	57.8599999999999994	14
10339	S24_3816	42	72.9599999999999937	16
10339	S24_3949	45	57.3200000000000003	11
10339	S700_1138	22	53.3400000000000034	5
10339	S700_2047	55	86.9000000000000057	15
10339	S700_2610	50	62.1599999999999966	9
10339	S700_4002	50	66.6299999999999955	8
10339	S72_1253	27	49.6599999999999966	6
10340	S24_2000	55	62.4600000000000009	8
10340	S24_4278	40	63.759999999999998	1
10340	S32_1374	55	95.8900000000000006	2
10340	S32_4289	39	67.4099999999999966	3
10340	S50_1341	40	37.0900000000000034	4
10340	S700_1691	30	73.9899999999999949	5
10340	S700_2466	55	81.769999999999996	7
10340	S700_2834	29	98.480000000000004	6
10341	S10_1678	41	84.2199999999999989	9
10341	S12_1099	45	192.620000000000005	2
10341	S12_2823	55	120.5	8
10341	S12_3380	44	111.569999999999993	1
10341	S12_3990	36	77.4099999999999966	10
10341	S12_4675	55	109.400000000000006	7
10341	S24_2360	32	63.0300000000000011	6
10341	S32_4485	31	95.9300000000000068	4
10341	S50_4713	38	78.1099999999999994	3
10341	S700_3167	34	70.4000000000000057	5
10342	S18_1129	40	118.890000000000001	2
10342	S18_1889	55	63.1400000000000006	1
10342	S18_1984	22	115.219999999999999	3
10342	S18_3232	30	167.650000000000006	4
10342	S18_3278	25	76.3900000000000006	5
10342	S18_3482	55	136.699999999999989	7
10342	S18_3782	26	57.8200000000000003	8
10342	S18_4721	38	124.989999999999995	11
10342	S24_2972	39	30.5899999999999999	9
10342	S24_3371	48	60.009999999999998	10
10342	S24_3856	42	112.340000000000003	6
10343	S18_1589	36	109.510000000000005	4
10343	S18_2870	25	118.799999999999997	3
10343	S18_3685	44	127.150000000000006	2
10343	S24_1628	27	44.7800000000000011	6
10343	S24_4620	30	76.7999999999999972	1
10343	S32_2206	29	37.4099999999999966	5
10344	S18_1749	45	168.300000000000011	1
10344	S18_2248	40	49.0399999999999991	2
10344	S18_2325	30	118.230000000000004	3
10344	S18_4409	21	80.9899999999999949	4
10344	S18_4933	26	68.4200000000000017	5
10344	S24_1046	29	61	7
10344	S24_1937	20	27.879999999999999	6
10345	S24_2022	43	38.9799999999999969	1
10346	S18_1342	42	88.3599999999999994	3
10346	S24_2766	25	87.2399999999999949	1
10346	S24_2887	24	117.439999999999998	5
10346	S24_3191	24	80.4699999999999989	2
10346	S24_3432	26	103.870000000000005	6
10346	S24_3969	22	38.5700000000000003	4
10347	S10_1949	30	188.580000000000013	1
10347	S10_4962	27	132.969999999999999	2
10347	S12_1666	29	132.569999999999993	3
10347	S18_1097	42	113.170000000000002	5
10347	S18_1367	21	46.3599999999999994	7
10347	S18_2432	50	51.0499999999999972	8
10347	S18_2795	21	136.689999999999998	6
10347	S18_2949	48	84.0900000000000034	9
10347	S18_2957	34	60.5900000000000034	10
10347	S18_3136	45	95.2999999999999972	11
10347	S18_3320	26	84.3299999999999983	12
10347	S18_4600	45	115.030000000000001	4
10348	S12_1108	48	207.800000000000011	8
10348	S12_3148	47	122.370000000000005	4
10348	S18_4668	29	43.7700000000000031	6
10348	S24_2300	37	107.340000000000003	1
10348	S24_4258	39	82.7800000000000011	2
10348	S32_1268	42	90.5300000000000011	3
10348	S32_3522	31	62.7000000000000028	5
10348	S700_2824	32	100.140000000000001	7
10349	S12_3891	26	166.099999999999994	10
10349	S12_4473	48	114.950000000000003	9
10349	S18_2238	38	142.449999999999989	8
10349	S18_2319	38	117.819999999999993	7
10349	S18_3232	48	164.259999999999991	6
10349	S18_4027	34	140.75	5
10349	S24_1444	48	50.2899999999999991	4
10349	S24_2840	36	31.4699999999999989	3
10349	S24_4048	23	111.180000000000007	2
10349	S32_2509	33	44.3699999999999974	1
10350	S10_4757	26	110.159999999999997	5
10350	S18_3029	43	84.2999999999999972	6
10350	S18_3140	44	135.219999999999999	1
10350	S18_3259	41	94.7900000000000063	2
10350	S18_4522	30	70.2199999999999989	3
10350	S24_2011	34	98.3100000000000023	7
10350	S24_3151	30	86.7399999999999949	9
10350	S24_3816	25	77.1500000000000057	10
10350	S32_3207	27	61.5200000000000031	14
10350	S50_1392	31	104.180000000000007	8
10350	S50_1514	44	56.8200000000000003	17
10350	S700_1138	46	56	11
10350	S700_1938	28	76.2199999999999989	4
10350	S700_2610	29	68.6700000000000017	12
10350	S700_3505	31	87.1500000000000057	13
10350	S700_3962	25	97.3199999999999932	16
10350	S72_3212	20	48.0499999999999972	15
10351	S18_1662	39	143.5	1
10351	S18_3856	20	104.810000000000002	2
10351	S24_2841	25	64.4000000000000057	5
10351	S24_3420	38	53.9200000000000017	4
10351	S24_3949	34	68.2399999999999949	3
10352	S700_2047	23	75.1299999999999955	3
10352	S700_2466	49	87.75	2
10352	S700_4002	22	62.1899999999999977	1
10352	S72_1253	49	46.1799999999999997	4
10353	S18_2581	27	71.8100000000000023	1
10353	S24_1785	28	107.230000000000004	2
10353	S24_4278	35	69.5499999999999972	3
10353	S32_1374	46	86.9000000000000057	5
10353	S32_4289	40	68.0999999999999943	7
10353	S50_1341	40	35.7800000000000011	8
10353	S700_1691	39	73.0699999999999932	9
10353	S700_2834	48	98.480000000000004	4
10353	S700_3167	43	74.4000000000000057	6
10354	S10_1678	42	84.2199999999999989	6
10354	S10_2016	20	95.1500000000000057	2
10354	S10_4698	42	178.169999999999987	3
10354	S12_1099	31	157.599999999999994	9
10354	S12_2823	35	141.580000000000013	4
10354	S12_3380	29	98.6500000000000057	11
10354	S12_3990	23	76.6099999999999994	12
10354	S12_4675	28	100.189999999999998	13
10354	S18_1889	21	76.230000000000004	8
10354	S18_2625	28	49.0600000000000023	10
10354	S18_3278	36	69.1500000000000057	7
10354	S24_1578	21	96.9200000000000017	5
10354	S24_2000	28	62.4600000000000009	1
10355	S18_3482	23	117.590000000000003	7
10355	S18_3782	31	60.2999999999999972	1
10355	S18_4721	25	124.989999999999995	2
10355	S24_2360	41	56.1000000000000014	3
10355	S24_2972	36	37.3800000000000026	4
10355	S24_3371	44	60.6199999999999974	6
10355	S24_3856	32	137.620000000000005	8
10355	S24_4620	28	75.1800000000000068	9
10355	S32_2206	38	32.990000000000002	10
10355	S32_4485	40	93.8900000000000006	5
10356	S18_1129	43	120.310000000000002	8
10356	S18_1342	50	82.1899999999999977	9
10356	S18_1367	22	44.75	6
10356	S18_1984	27	130.870000000000005	2
10356	S18_2325	29	106.790000000000006	3
10356	S18_2795	30	158.629999999999995	1
10356	S24_1937	48	31.8599999999999994	5
10356	S24_2022	26	42.1099999999999994	7
10356	S50_4713	26	78.1099999999999994	4
10357	S10_1949	32	199.300000000000011	10
10357	S10_4962	43	135.919999999999987	9
10357	S12_1666	49	109.340000000000003	8
10357	S18_1097	39	112	1
10357	S18_2432	41	58.9500000000000028	7
10357	S18_2949	41	91.1800000000000068	6
10357	S18_2957	49	59.3400000000000034	5
10357	S18_3136	44	104.719999999999999	4
10357	S18_3320	25	84.3299999999999983	3
10357	S18_4600	28	105.340000000000003	2
10358	S12_3148	49	129.930000000000007	5
10358	S12_4473	42	98.3599999999999994	9
10358	S18_2238	20	142.449999999999989	10
10358	S18_2319	20	99.4099999999999966	11
10358	S18_3232	32	137.169999999999987	12
10358	S18_4027	25	117.769999999999996	13
10358	S18_4668	30	46.2899999999999991	8
10358	S24_1444	44	56.0700000000000003	14
10358	S24_2300	41	127.790000000000006	7
10358	S24_2840	36	33.5900000000000034	4
10358	S24_4258	41	88.6200000000000045	6
10358	S32_1268	41	82.8299999999999983	1
10358	S32_3522	36	51.7100000000000009	2
10358	S700_2824	27	85.980000000000004	3
10359	S10_4757	48	122.400000000000006	6
10359	S12_1108	42	180.789999999999992	8
10359	S12_3891	49	162.639999999999986	5
10359	S24_4048	22	108.819999999999993	7
10359	S32_2509	36	45.4500000000000028	3
10359	S32_3207	22	62.1400000000000006	1
10359	S50_1392	46	99.5499999999999972	2
10359	S50_1514	25	47.4500000000000028	4
10360	S18_1662	50	126.150000000000006	12
10360	S18_2581	41	68.4300000000000068	13
10360	S18_3029	46	71.4000000000000057	14
10360	S18_3140	29	122.930000000000007	8
10360	S18_3259	29	94.7900000000000063	18
10360	S18_3856	40	101.640000000000001	15
10360	S18_4522	40	76.3599999999999994	1
10360	S24_1785	22	106.140000000000001	17
10360	S24_2011	31	100.769999999999996	2
10360	S24_2841	49	55.490000000000002	16
10360	S24_3151	36	70.8100000000000023	3
10360	S24_3816	22	78.8299999999999983	4
10360	S700_1138	32	64.6700000000000017	5
10360	S700_1938	26	86.6099999999999994	6
10360	S700_2610	30	70.1099999999999994	7
10360	S700_3505	35	83.1400000000000006	9
10360	S700_3962	31	92.3599999999999994	10
10360	S72_3212	31	54.0499999999999972	11
10361	S10_1678	20	92.8299999999999983	13
10361	S10_2016	26	114.180000000000007	8
10361	S24_3420	34	62.4600000000000009	6
10361	S24_3949	26	61.4200000000000017	7
10361	S24_4278	25	68.8299999999999983	1
10361	S32_4289	49	56.4099999999999966	2
10361	S50_1341	33	35.7800000000000011	3
10361	S700_1691	20	88.5999999999999943	4
10361	S700_2047	24	85.9899999999999949	14
10361	S700_2466	26	91.7399999999999949	9
10361	S700_2834	44	107.969999999999999	5
10361	S700_3167	44	76.7999999999999972	10
10361	S700_4002	35	62.1899999999999977	11
10361	S72_1253	23	47.6700000000000017	12
10362	S10_4698	22	182.039999999999992	4
10362	S12_2823	22	131.039999999999992	1
10362	S18_2625	23	53.9099999999999966	3
10362	S24_1578	50	91.2900000000000063	2
10363	S12_1099	33	180.949999999999989	3
10363	S12_3380	34	106.870000000000005	4
10363	S12_3990	34	68.6299999999999955	5
10363	S12_4675	46	103.640000000000001	6
10363	S18_1889	22	61.6000000000000014	7
10363	S18_3278	46	69.1500000000000057	10
10363	S18_3482	24	124.939999999999998	11
10363	S18_3782	32	52.2199999999999989	12
10363	S18_4721	28	123.5	13
10363	S24_2000	21	70.0799999999999983	8
10363	S24_2360	43	56.1000000000000014	14
10363	S24_3371	21	52.0499999999999972	15
10363	S24_3856	31	113.75	1
10363	S24_4620	43	75.9899999999999949	9
10363	S32_1374	50	92.9000000000000057	2
10364	S32_2206	48	38.2199999999999989	1
10365	S18_1129	30	116.060000000000002	1
10365	S32_4485	22	82.6599999999999966	3
10365	S50_4713	44	68.3400000000000034	2
10366	S18_1984	34	116.650000000000006	3
10366	S18_2870	49	105.599999999999994	2
10366	S18_3232	34	154.099999999999994	1
10367	S18_1589	49	105.769999999999996	1
10367	S18_1749	37	144.5	3
10367	S18_2248	45	50.25	4
10367	S18_2325	27	124.590000000000003	5
10367	S18_2795	32	140.060000000000002	7
10367	S18_3685	46	131.389999999999986	6
10367	S18_4409	43	77.3100000000000023	8
10367	S18_4933	44	66.9899999999999949	9
10367	S24_1046	21	72.7600000000000051	10
10367	S24_1628	38	50.3100000000000023	11
10367	S24_1937	23	29.5399999999999991	13
10367	S24_2022	28	43.009999999999998	12
10367	S24_2972	36	36.25	2
10368	S24_2766	40	73.5999999999999943	2
10368	S24_2887	31	115.090000000000003	5
10368	S24_3191	46	83.0400000000000063	1
10368	S24_3432	20	93.1599999999999966	4
10368	S24_3969	46	36.5200000000000031	3
10369	S10_1949	41	195.009999999999991	2
10369	S18_1342	44	89.3799999999999955	8
10369	S18_1367	32	46.3599999999999994	7
10369	S18_2949	42	100.299999999999997	1
10369	S18_2957	28	51.8400000000000034	6
10369	S18_3136	21	90.0600000000000023	5
10369	S18_3320	45	80.3599999999999994	4
10369	S24_4258	40	93.4899999999999949	3
10370	S10_4962	35	128.530000000000001	4
10370	S12_1666	49	128.469999999999999	8
10370	S18_1097	27	100.340000000000003	1
10370	S18_2319	22	101.870000000000005	5
10370	S18_2432	22	60.1599999999999966	7
10370	S18_3232	27	167.650000000000006	9
10370	S18_4600	29	105.340000000000003	6
10370	S18_4668	20	41.759999999999998	2
10370	S32_3522	25	63.990000000000002	3
10371	S12_1108	32	178.710000000000008	6
10371	S12_4473	49	104.280000000000001	4
10371	S18_2238	25	160.460000000000008	7
10371	S24_1444	25	53.75	12
10371	S24_2300	20	126.510000000000005	5
10371	S24_2840	45	35.009999999999998	8
10371	S24_4048	28	95.8100000000000023	9
10371	S32_1268	26	82.8299999999999983	1
10371	S32_2509	20	44.3699999999999974	2
10371	S32_3207	30	53.4399999999999977	11
10371	S50_1392	48	97.230000000000004	10
10371	S700_2824	34	83.9500000000000028	3
10372	S12_3148	40	146.550000000000011	4
10372	S12_3891	34	140.150000000000006	1
10372	S18_3140	28	131.129999999999995	3
10372	S18_3259	25	91.7600000000000051	5
10372	S18_4027	48	119.200000000000003	6
10372	S18_4522	41	78.9899999999999949	7
10372	S24_2011	37	102	8
10372	S50_1514	24	56.8200000000000003	9
10372	S700_1938	44	74.480000000000004	2
10373	S10_4757	39	118.319999999999993	3
10373	S18_1662	28	143.5	4
10373	S18_3029	22	75.7000000000000028	5
10373	S18_3856	50	99.519999999999996	6
10373	S24_2841	38	58.9200000000000017	7
10373	S24_3151	33	82.3100000000000023	12
10373	S24_3420	46	53.9200000000000017	11
10373	S24_3816	23	83.8599999999999994	10
10373	S24_3949	39	62.1000000000000014	13
10373	S700_1138	44	58	14
10373	S700_2047	32	76.9399999999999977	15
10373	S700_2610	41	69.3900000000000006	16
10373	S700_3505	34	94.1599999999999966	2
10373	S700_3962	37	83.4200000000000017	8
10373	S700_4002	45	68.1099999999999994	17
10373	S72_1253	25	44.2000000000000028	9
10373	S72_3212	29	48.0499999999999972	1
10374	S10_2016	39	115.370000000000005	5
10374	S10_4698	22	158.800000000000011	1
10374	S18_2581	42	75.1899999999999977	2
10374	S18_2625	22	48.4600000000000009	4
10374	S24_1578	38	112.700000000000003	6
10374	S24_1785	46	107.230000000000004	3
10375	S10_1678	21	76.5600000000000023	12
10375	S12_1099	45	184.840000000000003	7
10375	S12_2823	49	150.620000000000005	13
10375	S24_2000	23	67.0300000000000011	9
10375	S24_2360	20	60.259999999999998	14
10375	S24_4278	43	60.1300000000000026	2
10375	S32_1374	37	87.9000000000000057	3
10375	S32_4289	44	59.8500000000000014	4
10375	S32_4485	41	96.9500000000000028	15
10375	S50_1341	49	36.2199999999999989	5
10375	S50_4713	49	69.1599999999999966	8
10375	S700_1691	37	86.769999999999996	6
10375	S700_2466	33	94.730000000000004	1
10375	S700_2834	25	98.480000000000004	10
10375	S700_3167	44	69.5999999999999943	11
10376	S12_3380	35	98.6500000000000057	1
10377	S12_3990	24	65.4399999999999977	5
10377	S12_4675	50	112.859999999999999	1
10377	S18_1129	35	124.560000000000002	2
10377	S18_1889	31	61.6000000000000014	4
10377	S18_1984	36	125.180000000000007	6
10377	S18_3232	39	143.939999999999998	3
10378	S18_1589	34	121.950000000000003	5
10378	S18_3278	22	66.7399999999999949	4
10378	S18_3482	43	146.990000000000009	10
10378	S18_3782	28	60.2999999999999972	9
10378	S18_4721	49	122.019999999999996	8
10378	S24_2972	41	30.5899999999999999	7
10378	S24_3371	46	52.6599999999999966	6
10378	S24_3856	33	129.199999999999989	3
10378	S24_4620	41	80.8400000000000034	2
10378	S32_2206	40	35.7999999999999972	1
10379	S18_1749	39	156.400000000000006	2
10379	S18_2248	27	50.8500000000000014	1
10379	S18_2870	29	113.519999999999996	5
10379	S18_3685	32	134.219999999999999	4
10379	S24_1628	32	48.7999999999999972	3
10380	S18_1342	27	88.3599999999999994	13
10380	S18_2325	40	119.5	10
10380	S18_2795	21	156.939999999999998	8
10380	S18_4409	32	78.230000000000004	1
10380	S18_4933	24	66.9899999999999949	2
10380	S24_1046	34	66.8799999999999955	3
10380	S24_1937	32	29.870000000000001	4
10380	S24_2022	27	37.6300000000000026	5
10380	S24_2766	36	77.2399999999999949	6
10380	S24_2887	44	111.569999999999993	7
10380	S24_3191	44	77.0499999999999972	9
10380	S24_3432	34	91.019999999999996	11
10380	S24_3969	43	32.8200000000000003	12
10381	S10_1949	36	182.159999999999997	3
10381	S10_4962	37	138.879999999999995	6
10381	S12_1666	20	132.569999999999993	1
10381	S18_1097	48	114.340000000000003	2
10381	S18_1367	25	49.6000000000000014	9
10381	S18_2432	35	60.7700000000000031	7
10381	S18_2949	41	100.299999999999997	8
10381	S18_2957	40	51.2199999999999989	4
10381	S18_3136	35	93.2000000000000028	5
10382	S12_1108	34	166.240000000000009	10
10382	S12_3148	37	145.039999999999992	11
10382	S12_3891	34	143.610000000000014	12
10382	S12_4473	32	103.099999999999994	13
10382	S18_2238	25	160.460000000000008	5
10382	S18_3320	50	84.3299999999999983	7
10382	S18_4600	39	115.030000000000001	1
10382	S18_4668	39	46.2899999999999991	2
10382	S24_2300	20	120.120000000000005	3
10382	S24_4258	33	97.3900000000000006	4
10382	S32_1268	26	85.7199999999999989	6
10382	S32_3522	48	57.5300000000000011	8
10382	S700_2824	34	101.150000000000006	9
10383	S18_2319	27	119.049999999999997	11
10383	S18_3140	24	125.659999999999997	9
10383	S18_3232	47	155.789999999999992	6
10383	S18_3259	26	83.7000000000000028	12
10383	S18_4027	38	137.879999999999995	1
10383	S18_4522	28	77.2399999999999949	7
10383	S24_1444	22	52.6000000000000014	2
10383	S24_2840	40	33.240000000000002	3
10383	S24_4048	21	117.099999999999994	4
10383	S32_2509	32	53.5700000000000003	5
10383	S32_3207	44	55.9299999999999997	8
10383	S50_1392	29	94.9200000000000017	13
10383	S50_1514	38	48.6199999999999974	10
10384	S10_4757	34	129.199999999999989	4
10384	S24_2011	28	114.290000000000006	3
10384	S24_3151	43	71.6899999999999977	2
10384	S700_1938	49	71.019999999999996	1
10385	S24_3816	37	78.8299999999999983	2
10385	S700_1138	25	62	1
10386	S18_1662	25	130.879999999999995	7
10386	S18_2581	21	72.6500000000000057	18
10386	S18_3029	37	73.1200000000000045	5
10386	S18_3856	22	100.579999999999998	6
10386	S24_1785	33	101.760000000000005	11
10386	S24_2841	39	56.8599999999999994	1
10386	S24_3420	35	54.5700000000000003	9
10386	S24_3949	41	55.9600000000000009	12
10386	S24_4278	50	71.730000000000004	8
10386	S700_2047	29	85.0900000000000034	13
10386	S700_2466	37	90.75	14
10386	S700_2610	37	67.2199999999999989	10
10386	S700_3167	32	68	17
10386	S700_3505	45	83.1400000000000006	2
10386	S700_3962	30	80.4399999999999977	3
10386	S700_4002	44	59.2199999999999989	15
10386	S72_1253	50	47.6700000000000017	16
10386	S72_3212	43	52.4200000000000017	4
10387	S32_1374	44	79.9099999999999966	1
10388	S10_1678	42	80.3900000000000006	4
10388	S10_2016	50	118.939999999999998	5
10388	S10_4698	21	156.860000000000014	7
10388	S12_2823	44	125.010000000000005	6
10388	S32_4289	35	58.4699999999999989	8
10388	S50_1341	27	41.0200000000000031	1
10388	S700_1691	46	74.9000000000000057	2
10388	S700_2834	50	111.530000000000001	3
10389	S12_1099	26	182.900000000000006	4
10389	S12_3380	25	95.1299999999999955	6
10389	S12_3990	36	76.6099999999999994	7
10389	S12_4675	47	102.489999999999995	8
10389	S18_1889	49	63.9099999999999966	3
10389	S18_2625	39	52.0900000000000034	5
10389	S24_1578	45	112.700000000000003	1
10389	S24_2000	49	61.7000000000000028	2
10390	S18_1129	36	117.480000000000004	14
10390	S18_1984	34	132.289999999999992	15
10390	S18_2325	31	102.980000000000004	16
10390	S18_2795	26	162	7
10390	S18_3278	40	75.5900000000000034	9
10390	S18_3482	50	135.22999999999999	1
10390	S18_3782	36	54.0900000000000034	2
10390	S18_4721	49	122.019999999999996	3
10390	S24_2360	35	67.8700000000000045	4
10390	S24_2972	37	35.8699999999999974	5
10390	S24_3371	46	51.4299999999999997	6
10390	S24_3856	45	134.810000000000002	8
10390	S24_4620	30	66.2900000000000063	10
10390	S32_2206	41	39.0200000000000031	11
10390	S32_4485	45	101.030000000000001	12
10390	S50_4713	22	81.3599999999999994	13
10391	S10_1949	24	195.009999999999991	4
10391	S10_4962	37	121.150000000000006	7
10391	S12_1666	39	110.700000000000003	9
10391	S18_1097	29	114.340000000000003	10
10391	S18_1342	35	102.739999999999995	2
10391	S18_1367	42	47.4399999999999977	3
10391	S18_2432	44	57.7299999999999969	5
10391	S18_2949	32	99.2800000000000011	6
10391	S24_1937	33	26.5500000000000007	8
10391	S24_2022	24	36.2899999999999991	1
10392	S18_2957	37	61.2100000000000009	3
10392	S18_3136	29	103.670000000000002	2
10392	S18_3320	36	98.2199999999999989	1
10393	S12_3148	35	145.039999999999992	8
10393	S12_4473	32	99.5400000000000063	10
10393	S18_2238	20	137.530000000000001	11
10393	S18_2319	38	104.319999999999993	7
10393	S18_4600	30	106.549999999999997	9
10393	S18_4668	44	41.759999999999998	1
10393	S24_2300	33	112.459999999999994	2
10393	S24_4258	33	88.6200000000000045	3
10393	S32_1268	38	84.75	4
10393	S32_3522	31	63.3500000000000014	5
10393	S700_2824	21	83.9500000000000028	6
10394	S18_3232	22	135.469999999999999	5
10394	S18_4027	37	124.950000000000003	1
10394	S24_1444	31	53.1799999999999997	2
10394	S24_2840	46	35.3599999999999994	6
10394	S24_4048	37	104.090000000000003	7
10394	S32_2509	36	47.0799999999999983	3
10394	S32_3207	30	55.9299999999999997	4
10395	S10_4757	32	125.120000000000005	2
10395	S12_1108	33	205.719999999999999	1
10395	S50_1392	46	98.3900000000000006	4
10395	S50_1514	45	57.990000000000002	3
10396	S12_3891	33	155.719999999999999	3
10396	S18_3140	33	129.759999999999991	2
10396	S18_3259	24	91.7600000000000051	4
10396	S18_4522	45	83.3799999999999955	5
10396	S24_2011	49	100.769999999999996	6
10396	S24_3151	27	77	7
10396	S24_3816	37	77.9899999999999949	8
10396	S700_1138	39	62	1
10397	S700_1938	32	69.2900000000000063	5
10397	S700_2610	22	62.8800000000000026	4
10397	S700_3505	48	86.1500000000000057	3
10397	S700_3962	36	80.4399999999999977	2
10397	S72_3212	34	52.9600000000000009	1
10398	S18_1662	33	130.879999999999995	11
10398	S18_2581	34	82.7900000000000063	15
10398	S18_3029	28	70.5400000000000063	18
10398	S18_3856	45	92.1099999999999994	17
10398	S24_1785	43	100.670000000000002	16
10398	S24_2841	28	60.2899999999999991	3
10398	S24_3420	34	61.1499999999999986	13
10398	S24_3949	41	56.6400000000000006	2
10398	S24_4278	45	65.9300000000000068	14
10398	S32_4289	22	60.5399999999999991	4
10398	S50_1341	49	38.8400000000000034	5
10398	S700_1691	47	78.5499999999999972	6
10398	S700_2047	36	75.1299999999999955	7
10398	S700_2466	22	98.7199999999999989	8
10398	S700_2834	23	102.040000000000006	9
10398	S700_3167	29	76.7999999999999972	10
10398	S700_4002	36	62.1899999999999977	12
10398	S72_1253	34	41.2199999999999989	1
10399	S10_1678	40	77.519999999999996	8
10399	S10_2016	51	99.9099999999999966	7
10399	S10_4698	22	156.860000000000014	6
10399	S12_2823	29	123.510000000000005	5
10399	S18_2625	30	51.4799999999999969	4
10399	S24_1578	57	104.810000000000002	3
10399	S24_2000	58	75.4099999999999966	2
10399	S32_1374	32	97.8900000000000006	1
10400	S10_4757	64	134.639999999999986	9
10400	S18_1662	34	129.310000000000002	1
10400	S18_3029	30	74.8400000000000034	7
10400	S18_3856	58	88.9300000000000068	6
10400	S24_2841	24	55.490000000000002	2
10400	S24_3420	38	59.1799999999999997	3
10400	S24_3816	42	74.6400000000000006	8
10400	S700_2047	46	82.3700000000000045	5
10400	S72_1253	20	41.7100000000000009	4
10401	S18_2581	42	75.1899999999999977	3
10401	S24_1785	38	87.5400000000000063	5
10401	S24_3949	64	59.3699999999999974	12
10401	S24_4278	52	65.9300000000000068	4
10401	S32_1374	49	81.9099999999999966	1
10401	S32_4289	62	62.6000000000000014	6
10401	S50_1341	56	41.4600000000000009	7
10401	S700_1691	11	77.6400000000000006	8
10401	S700_2466	85	98.7199999999999989	10
10401	S700_2834	21	96.1099999999999994	2
10401	S700_3167	77	73.5999999999999943	9
10401	S700_4002	40	66.6299999999999955	11
10402	S10_2016	45	118.939999999999998	1
10402	S18_2625	55	58.1499999999999986	2
10402	S24_2000	59	61.7000000000000028	3
10403	S10_1678	24	85.1700000000000017	7
10403	S10_4698	66	174.289999999999992	9
10403	S12_2823	66	122	6
10403	S18_3782	36	55.3299999999999983	1
10403	S24_1578	46	109.319999999999993	8
10403	S24_2360	27	57.490000000000002	4
10403	S32_2206	30	35.7999999999999972	2
10403	S32_4485	45	88.7800000000000011	5
10403	S50_4713	31	65.0900000000000034	3
10404	S12_1099	64	163.439999999999998	3
10404	S12_3380	43	102.170000000000002	1
10404	S12_3990	77	67.0300000000000011	4
10404	S18_3278	90	67.5400000000000063	6
10404	S18_3482	28	127.879999999999995	5
10404	S18_4721	48	124.989999999999995	8
10404	S24_3371	49	53.2700000000000031	2
10404	S24_4620	48	65.480000000000004	7
10405	S12_4675	97	115.159999999999997	5
10405	S18_1889	61	72.3799999999999955	4
10405	S18_3232	55	147.330000000000013	1
10405	S24_2972	47	37.3800000000000026	2
10405	S24_3856	76	127.790000000000006	3
10406	S18_1129	61	124.560000000000002	3
10406	S18_1984	48	133.719999999999999	2
10406	S18_3685	65	117.260000000000005	1
10407	S18_1589	59	114.480000000000004	11
10407	S18_1749	76	141.099999999999994	2
10407	S18_2248	42	58.1199999999999974	1
10407	S18_2870	41	132	12
10407	S18_4409	6	91.1099999999999994	3
10407	S18_4933	66	64.1400000000000006	4
10407	S24_1046	26	68.3499999999999943	8
10407	S24_1628	64	45.7800000000000011	10
10407	S24_2766	76	81.7800000000000011	6
10407	S24_2887	59	98.6500000000000057	5
10407	S24_3191	13	77.0499999999999972	7
10407	S24_3432	43	101.730000000000004	9
10408	S24_3969	15	41.0300000000000011	1
10409	S18_2325	6	104.25	2
10409	S24_1937	61	27.879999999999999	1
10410	S18_1342	65	99.6599999999999966	7
10410	S18_1367	44	51.2100000000000009	6
10410	S18_2795	56	145.129999999999995	8
10410	S18_2949	47	93.2099999999999937	1
10410	S18_2957	53	49.9699999999999989	3
10410	S18_3136	34	84.8199999999999932	2
10410	S18_3320	44	81.3499999999999943	5
10410	S24_2022	31	42.5600000000000023	9
10410	S24_4258	50	95.4399999999999977	4
10411	S10_1949	23	205.72999999999999	9
10411	S10_4962	27	144.789999999999992	2
10411	S12_1666	40	110.700000000000003	6
10411	S18_1097	27	109.670000000000002	8
10411	S18_4600	46	106.549999999999997	3
10411	S18_4668	35	41.25	7
10411	S32_1268	26	78.0100000000000051	1
10411	S32_3522	27	60.759999999999998	5
10411	S700_2824	34	89.0100000000000051	4
10412	S12_4473	54	100.730000000000004	5
10412	S18_2238	41	150.629999999999995	4
10412	S18_2319	56	120.280000000000001	8
10412	S18_2432	47	49.8299999999999983	11
10412	S18_3232	60	157.490000000000009	9
10412	S24_1444	21	47.3999999999999986	2
10412	S24_2300	70	109.900000000000006	10
10412	S24_2840	30	32.8800000000000026	6
10412	S24_4048	31	108.819999999999993	1
10412	S32_2509	19	50.8599999999999994	7
10412	S50_1392	26	105.329999999999998	3
10413	S12_1108	36	201.569999999999993	2
10413	S12_3148	47	145.039999999999992	3
10413	S12_3891	22	173.02000000000001	1
10413	S18_4027	49	133.569999999999993	5
10413	S32_3207	24	56.5499999999999972	6
10413	S50_1514	51	53.3100000000000023	4
10414	S10_4757	49	114.239999999999995	3
10414	S18_3029	44	77.4200000000000017	1
10414	S18_3140	41	128.389999999999986	12
10414	S18_3259	48	85.7099999999999937	14
10414	S18_4522	56	83.3799999999999955	11
10414	S24_2011	43	108.140000000000001	10
10414	S24_3151	60	72.5799999999999983	5
10414	S24_3816	51	72.9599999999999937	2
10414	S700_1138	37	62	6
10414	S700_1938	34	74.480000000000004	13
10414	S700_2610	31	61.4399999999999977	4
10414	S700_3505	28	84.1400000000000006	7
10414	S700_3962	40	84.4099999999999966	8
10414	S72_3212	47	54.6000000000000014	9
10415	S18_3856	51	86.8100000000000023	5
10415	S24_2841	21	60.9699999999999989	1
10415	S24_3420	18	59.8299999999999983	2
10415	S700_2047	32	73.3199999999999932	4
10415	S72_1253	42	43.2000000000000028	3
10416	S18_1662	24	129.310000000000002	14
10416	S18_2581	15	70.9599999999999937	4
10416	S24_1785	47	90.8199999999999932	6
10416	S24_2000	32	62.4600000000000009	1
10416	S24_3949	18	64.8299999999999983	13
10416	S24_4278	48	70.2800000000000011	5
10416	S32_1374	45	86.9000000000000057	2
10416	S32_4289	26	68.0999999999999943	7
10416	S50_1341	37	39.7100000000000009	8
10416	S700_1691	23	88.5999999999999943	9
10416	S700_2466	22	84.7600000000000051	11
10416	S700_2834	41	98.480000000000004	3
10416	S700_3167	39	65.5999999999999943	10
10416	S700_4002	43	63.6700000000000017	12
10417	S10_1678	66	79.4300000000000068	2
10417	S10_2016	45	116.560000000000002	5
10417	S10_4698	56	162.669999999999987	4
10417	S12_2823	21	144.599999999999994	1
10417	S18_2625	36	58.75	6
10417	S24_1578	35	109.319999999999993	3
10418	S18_3278	16	70.7600000000000051	2
10418	S18_3482	27	139.639999999999986	1
10418	S18_3782	33	56.5700000000000003	5
10418	S18_4721	28	120.530000000000001	4
10418	S24_2360	52	64.4099999999999966	8
10418	S24_4620	10	66.2900000000000063	3
10418	S32_2206	43	36.6099999999999994	6
10418	S32_4485	50	100.010000000000005	9
10418	S50_4713	40	72.4099999999999966	7
10419	S12_1099	12	182.900000000000006	13
10419	S12_3380	10	111.569999999999993	11
10419	S12_3990	34	64.6400000000000006	14
10419	S12_4675	32	99.0400000000000063	10
10419	S18_1129	38	117.480000000000004	5
10419	S18_1589	37	100.799999999999997	1
10419	S18_1889	39	67.7600000000000051	9
10419	S18_1984	34	133.719999999999999	4
10419	S18_2870	55	116.159999999999997	2
10419	S18_3232	35	165.949999999999989	6
10419	S18_3685	43	114.439999999999998	3
10419	S24_2972	15	32.1000000000000014	7
10419	S24_3371	55	52.6599999999999966	12
10419	S24_3856	70	112.340000000000003	8
10420	S18_1749	37	153	5
10420	S18_2248	36	52.0600000000000023	4
10420	S18_2325	45	116.959999999999994	2
10420	S18_4409	66	73.6200000000000045	6
10420	S18_4933	36	68.4200000000000017	7
10420	S24_1046	60	60.259999999999998	11
10420	S24_1628	37	48.7999999999999972	13
10420	S24_1937	45	32.1899999999999977	1
10420	S24_2766	39	76.3299999999999983	9
10420	S24_2887	55	115.090000000000003	8
10420	S24_3191	35	77.0499999999999972	10
10420	S24_3432	26	104.939999999999998	12
10420	S24_3969	15	35.2899999999999991	3
10421	S18_2795	35	167.060000000000002	1
10421	S24_2022	40	44.7999999999999972	2
10422	S18_1342	51	91.4399999999999977	2
10422	S18_1367	25	47.4399999999999977	1
10423	S18_2949	10	89.1500000000000057	1
10423	S18_2957	31	56.2100000000000009	3
10423	S18_3136	21	98.4399999999999977	2
10423	S18_3320	21	80.3599999999999994	5
10423	S24_4258	28	78.8900000000000006	4
10424	S10_1949	50	201.439999999999998	6
10424	S12_1666	49	121.640000000000001	3
10424	S18_1097	54	108.5	5
10424	S18_4668	26	40.25	4
10424	S32_3522	44	54.9399999999999977	2
10424	S700_2824	46	85.980000000000004	1
10425	S10_4962	38	131.490000000000009	12
10425	S12_4473	33	95.9899999999999949	4
10425	S18_2238	28	147.360000000000014	3
10425	S18_2319	38	117.819999999999993	7
10425	S18_2432	19	48.6199999999999974	10
10425	S18_3232	28	140.550000000000011	8
10425	S18_4600	38	107.760000000000005	13
10425	S24_1444	55	53.75	1
10425	S24_2300	49	127.790000000000006	9
10425	S24_2840	31	31.8200000000000003	5
10425	S32_1268	41	83.7900000000000063	11
10425	S32_2509	11	50.3200000000000003	6
10425	S50_1392	18	94.9200000000000017	2
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: root
--

COPY orders ("orderNumber", "orderDate", "requiredDate", "shippedDate", status, comments, "customerNumber") FROM stdin;
10100	2003-01-06 00:00:00	2003-01-13 00:00:00	2003-01-10 00:00:00	Shipped	\N	363
10101	2003-01-09 00:00:00	2003-01-18 00:00:00	2003-01-11 00:00:00	Shipped	Check on availability.	128
10102	2003-01-10 00:00:00	2003-01-18 00:00:00	2003-01-14 00:00:00	Shipped	\N	181
10103	2003-01-29 00:00:00	2003-02-07 00:00:00	2003-02-02 00:00:00	Shipped	\N	121
10104	2003-01-31 00:00:00	2003-02-09 00:00:00	2003-02-01 00:00:00	Shipped	\N	141
10105	2003-02-11 00:00:00	2003-02-21 00:00:00	2003-02-12 00:00:00	Shipped	\N	145
10106	2003-02-17 00:00:00	2003-02-24 00:00:00	2003-02-21 00:00:00	Shipped	\N	278
10107	2003-02-24 00:00:00	2003-03-03 00:00:00	2003-02-26 00:00:00	Shipped	Difficult to negotiate with customer. We need more marketing materials	131
10108	2003-03-03 00:00:00	2003-03-12 00:00:00	2003-03-08 00:00:00	Shipped	\N	385
10109	2003-03-10 00:00:00	2003-03-19 00:00:00	2003-03-11 00:00:00	Shipped	Customer requested that FedEx Ground is used for this shipping	486
10110	2003-03-18 00:00:00	2003-03-24 00:00:00	2003-03-20 00:00:00	Shipped	\N	187
10111	2003-03-25 00:00:00	2003-03-31 00:00:00	2003-03-30 00:00:00	Shipped	\N	129
10112	2003-03-24 00:00:00	2003-04-03 00:00:00	2003-03-29 00:00:00	Shipped	Customer requested that ad materials (such as posters, pamphlets) be included in the shippment	144
10113	2003-03-26 00:00:00	2003-04-02 00:00:00	2003-03-27 00:00:00	Shipped	\N	124
10114	2003-04-01 00:00:00	2003-04-07 00:00:00	2003-04-02 00:00:00	Shipped	\N	172
10115	2003-04-04 00:00:00	2003-04-12 00:00:00	2003-04-07 00:00:00	Shipped	\N	424
10116	2003-04-11 00:00:00	2003-04-19 00:00:00	2003-04-13 00:00:00	Shipped	\N	381
10117	2003-04-16 00:00:00	2003-04-24 00:00:00	2003-04-17 00:00:00	Shipped	\N	148
10118	2003-04-21 00:00:00	2003-04-29 00:00:00	2003-04-26 00:00:00	Shipped	Customer has worked with some of our vendors in the past and is aware of their MSRP	216
10119	2003-04-28 00:00:00	2003-05-05 00:00:00	2003-05-02 00:00:00	Shipped	\N	382
10120	2003-04-29 00:00:00	2003-05-08 00:00:00	2003-05-01 00:00:00	Shipped	\N	114
10121	2003-05-07 00:00:00	2003-05-13 00:00:00	2003-05-13 00:00:00	Shipped	\N	353
10122	2003-05-08 00:00:00	2003-05-16 00:00:00	2003-05-13 00:00:00	Shipped	\N	350
10123	2003-05-20 00:00:00	2003-05-29 00:00:00	2003-05-22 00:00:00	Shipped	\N	103
10124	2003-05-21 00:00:00	2003-05-29 00:00:00	2003-05-25 00:00:00	Shipped	Customer very concerned about the exact color of the models. There is high risk that he may dispute the order because there is a slight color mismatch	112
10125	2003-05-21 00:00:00	2003-05-27 00:00:00	2003-05-24 00:00:00	Shipped	\N	114
10126	2003-05-28 00:00:00	2003-06-07 00:00:00	2003-06-02 00:00:00	Shipped	\N	458
10127	2003-06-03 00:00:00	2003-06-09 00:00:00	2003-06-06 00:00:00	Shipped	Customer requested special shippment. The instructions were passed along to the warehouse	151
10128	2003-06-06 00:00:00	2003-06-12 00:00:00	2003-06-11 00:00:00	Shipped	\N	141
10129	2003-06-12 00:00:00	2003-06-18 00:00:00	2003-06-14 00:00:00	Shipped	\N	324
10130	2003-06-16 00:00:00	2003-06-24 00:00:00	2003-06-21 00:00:00	Shipped	\N	198
10131	2003-06-16 00:00:00	2003-06-25 00:00:00	2003-06-21 00:00:00	Shipped	\N	447
10132	2003-06-25 00:00:00	2003-07-01 00:00:00	2003-06-28 00:00:00	Shipped	\N	323
10133	2003-06-27 00:00:00	2003-07-04 00:00:00	2003-07-03 00:00:00	Shipped	\N	141
10134	2003-07-01 00:00:00	2003-07-10 00:00:00	2003-07-05 00:00:00	Shipped	\N	250
10135	2003-07-02 00:00:00	2003-07-12 00:00:00	2003-07-03 00:00:00	Shipped	\N	124
10136	2003-07-04 00:00:00	2003-07-14 00:00:00	2003-07-06 00:00:00	Shipped	Customer is interested in buying more Ferrari models	242
10137	2003-07-10 00:00:00	2003-07-20 00:00:00	2003-07-14 00:00:00	Shipped	\N	353
10138	2003-07-07 00:00:00	2003-07-16 00:00:00	2003-07-13 00:00:00	Shipped	\N	496
10139	2003-07-16 00:00:00	2003-07-23 00:00:00	2003-07-21 00:00:00	Shipped	\N	282
10140	2003-07-24 00:00:00	2003-08-02 00:00:00	2003-07-30 00:00:00	Shipped	\N	161
10141	2003-08-01 00:00:00	2003-08-09 00:00:00	2003-08-04 00:00:00	Shipped	\N	334
10142	2003-08-08 00:00:00	2003-08-16 00:00:00	2003-08-13 00:00:00	Shipped	\N	124
10143	2003-08-10 00:00:00	2003-08-18 00:00:00	2003-08-12 00:00:00	Shipped	Can we deliver the new Ford Mustang models by end-of-quarter?	320
10144	2003-08-13 00:00:00	2003-08-21 00:00:00	2003-08-14 00:00:00	Shipped	\N	381
10145	2003-08-25 00:00:00	2003-09-02 00:00:00	2003-08-31 00:00:00	Shipped	\N	205
10146	2003-09-03 00:00:00	2003-09-13 00:00:00	2003-09-06 00:00:00	Shipped	\N	447
10147	2003-09-05 00:00:00	2003-09-12 00:00:00	2003-09-09 00:00:00	Shipped	\N	379
10148	2003-09-11 00:00:00	2003-09-21 00:00:00	2003-09-15 00:00:00	Shipped	They want to reevaluate their terms agreement with Finance.	276
10149	2003-09-12 00:00:00	2003-09-18 00:00:00	2003-09-17 00:00:00	Shipped	\N	487
10150	2003-09-19 00:00:00	2003-09-27 00:00:00	2003-09-21 00:00:00	Shipped	They want to reevaluate their terms agreement with Finance.	148
10151	2003-09-21 00:00:00	2003-09-30 00:00:00	2003-09-24 00:00:00	Shipped	\N	311
10152	2003-09-25 00:00:00	2003-10-03 00:00:00	2003-10-01 00:00:00	Shipped	\N	333
10153	2003-09-28 00:00:00	2003-10-05 00:00:00	2003-10-03 00:00:00	Shipped	\N	141
10154	2003-10-02 00:00:00	2003-10-12 00:00:00	2003-10-08 00:00:00	Shipped	\N	219
10155	2003-10-06 00:00:00	2003-10-13 00:00:00	2003-10-07 00:00:00	Shipped	\N	186
10156	2003-10-08 00:00:00	2003-10-17 00:00:00	2003-10-11 00:00:00	Shipped	\N	141
10157	2003-10-09 00:00:00	2003-10-15 00:00:00	2003-10-14 00:00:00	Shipped	\N	473
10158	2003-10-10 00:00:00	2003-10-18 00:00:00	2003-10-15 00:00:00	Shipped	\N	121
10159	2003-10-10 00:00:00	2003-10-19 00:00:00	2003-10-16 00:00:00	Shipped	\N	321
10160	2003-10-11 00:00:00	2003-10-17 00:00:00	2003-10-17 00:00:00	Shipped	\N	347
10161	2003-10-17 00:00:00	2003-10-25 00:00:00	2003-10-20 00:00:00	Shipped	\N	227
10162	2003-10-18 00:00:00	2003-10-26 00:00:00	2003-10-19 00:00:00	Shipped	\N	321
10163	2003-10-20 00:00:00	2003-10-27 00:00:00	2003-10-24 00:00:00	Shipped	\N	424
10164	2003-10-21 00:00:00	2003-10-30 00:00:00	2003-10-23 00:00:00	Resolved	This order was disputed, but resolved on 11/1/2003; Customer doesn't like the colors and precision of the models.	452
10165	2003-10-22 00:00:00	2003-10-31 00:00:00	2003-12-26 00:00:00	Shipped	This order was on hold because customers's credit limit had been exceeded. Order will ship when payment is received	148
10166	2003-10-21 00:00:00	2003-10-30 00:00:00	2003-10-27 00:00:00	Shipped	\N	462
10167	2003-10-23 00:00:00	2003-10-30 00:00:00	\N	Cancelled	Customer called to cancel. The warehouse was notified in time and the order didn't ship. They have a new VP of Sales and are shifting their sales model. Our VP of Sales should contact them.	448
10168	2003-10-28 00:00:00	2003-11-03 00:00:00	2003-11-01 00:00:00	Shipped	\N	161
10169	2003-11-04 00:00:00	2003-11-14 00:00:00	2003-11-09 00:00:00	Shipped	\N	276
10170	2003-11-04 00:00:00	2003-11-12 00:00:00	2003-11-07 00:00:00	Shipped	\N	452
10171	2003-11-05 00:00:00	2003-11-13 00:00:00	2003-11-07 00:00:00	Shipped	\N	233
10172	2003-11-05 00:00:00	2003-11-14 00:00:00	2003-11-11 00:00:00	Shipped	\N	175
10173	2003-11-05 00:00:00	2003-11-15 00:00:00	2003-11-09 00:00:00	Shipped	Cautious optimism. We have happy customers here, if we can keep them well stocked.  I need all the information I can get on the planned shippments of Porches	278
10174	2003-11-06 00:00:00	2003-11-15 00:00:00	2003-11-10 00:00:00	Shipped	\N	333
10175	2003-11-06 00:00:00	2003-11-14 00:00:00	2003-11-09 00:00:00	Shipped	\N	324
10176	2003-11-06 00:00:00	2003-11-15 00:00:00	2003-11-12 00:00:00	Shipped	\N	386
10177	2003-11-07 00:00:00	2003-11-17 00:00:00	2003-11-12 00:00:00	Shipped	\N	344
10178	2003-11-08 00:00:00	2003-11-16 00:00:00	2003-11-10 00:00:00	Shipped	Custom shipping instructions sent to warehouse	242
10179	2003-11-11 00:00:00	2003-11-17 00:00:00	2003-11-13 00:00:00	Cancelled	Customer cancelled due to urgent budgeting issues. Must be cautious when dealing with them in the future. Since order shipped already we must discuss who would cover the shipping charges.	496
10180	2003-11-11 00:00:00	2003-11-19 00:00:00	2003-11-14 00:00:00	Shipped	\N	171
10181	2003-11-12 00:00:00	2003-11-19 00:00:00	2003-11-15 00:00:00	Shipped	\N	167
10182	2003-11-12 00:00:00	2003-11-21 00:00:00	2003-11-18 00:00:00	Shipped	\N	124
10183	2003-11-13 00:00:00	2003-11-22 00:00:00	2003-11-15 00:00:00	Shipped	We need to keep in close contact with their Marketing VP. He is the decision maker for all their purchases.	339
10184	2003-11-14 00:00:00	2003-11-22 00:00:00	2003-11-20 00:00:00	Shipped	\N	484
10185	2003-11-14 00:00:00	2003-11-21 00:00:00	2003-11-20 00:00:00	Shipped	\N	320
10186	2003-11-14 00:00:00	2003-11-20 00:00:00	2003-11-18 00:00:00	Shipped	They want to reevaluate their terms agreement with the VP of Sales	489
10187	2003-11-15 00:00:00	2003-11-24 00:00:00	2003-11-16 00:00:00	Shipped	\N	211
10188	2003-11-18 00:00:00	2003-11-26 00:00:00	2003-11-24 00:00:00	Shipped	\N	167
10189	2003-11-18 00:00:00	2003-11-25 00:00:00	2003-11-24 00:00:00	Shipped	They want to reevaluate their terms agreement with Finance.	205
10190	2003-11-19 00:00:00	2003-11-29 00:00:00	2003-11-20 00:00:00	Shipped	\N	141
10376	2005-02-08 00:00:00	2005-02-18 00:00:00	2005-02-13 00:00:00	Shipped	\N	219
10191	2003-11-20 00:00:00	2003-11-30 00:00:00	2003-11-24 00:00:00	Shipped	We must be cautions with this customer. Their VP of Sales resigned. Company may be heading down.	259
10192	2003-11-20 00:00:00	2003-11-29 00:00:00	2003-11-25 00:00:00	Shipped	\N	363
10193	2003-11-21 00:00:00	2003-11-28 00:00:00	2003-11-27 00:00:00	Shipped	\N	471
10194	2003-11-25 00:00:00	2003-12-02 00:00:00	2003-11-26 00:00:00	Shipped	\N	146
10195	2003-11-25 00:00:00	2003-12-01 00:00:00	2003-11-28 00:00:00	Shipped	\N	319
10196	2003-11-26 00:00:00	2003-12-03 00:00:00	2003-12-01 00:00:00	Shipped	\N	455
10197	2003-11-26 00:00:00	2003-12-02 00:00:00	2003-12-01 00:00:00	Shipped	Customer inquired about remote controlled models and gold models.	216
10198	2003-11-27 00:00:00	2003-12-06 00:00:00	2003-12-03 00:00:00	Shipped	\N	385
10199	2003-12-01 00:00:00	2003-12-10 00:00:00	2003-12-06 00:00:00	Shipped	\N	475
10200	2003-12-01 00:00:00	2003-12-09 00:00:00	2003-12-06 00:00:00	Shipped	\N	211
10201	2003-12-01 00:00:00	2003-12-11 00:00:00	2003-12-02 00:00:00	Shipped	\N	129
10202	2003-12-02 00:00:00	2003-12-09 00:00:00	2003-12-06 00:00:00	Shipped	\N	357
10203	2003-12-02 00:00:00	2003-12-11 00:00:00	2003-12-07 00:00:00	Shipped	\N	141
10204	2003-12-02 00:00:00	2003-12-10 00:00:00	2003-12-04 00:00:00	Shipped	\N	151
10205	2003-12-03 00:00:00	2003-12-09 00:00:00	2003-12-07 00:00:00	Shipped	 I need all the information I can get on our competitors.	141
10206	2003-12-05 00:00:00	2003-12-13 00:00:00	2003-12-08 00:00:00	Shipped	Can we renegotiate this one?	202
10207	2003-12-09 00:00:00	2003-12-17 00:00:00	2003-12-11 00:00:00	Shipped	Check on availability.	495
10208	2004-01-02 00:00:00	2004-01-11 00:00:00	2004-01-04 00:00:00	Shipped	\N	146
10209	2004-01-09 00:00:00	2004-01-15 00:00:00	2004-01-12 00:00:00	Shipped	\N	347
10210	2004-01-12 00:00:00	2004-01-22 00:00:00	2004-01-20 00:00:00	Shipped	\N	177
10211	2004-01-15 00:00:00	2004-01-25 00:00:00	2004-01-18 00:00:00	Shipped	\N	406
10212	2004-01-16 00:00:00	2004-01-24 00:00:00	2004-01-18 00:00:00	Shipped	\N	141
10213	2004-01-22 00:00:00	2004-01-28 00:00:00	2004-01-27 00:00:00	Shipped	Difficult to negotiate with customer. We need more marketing materials	489
10214	2004-01-26 00:00:00	2004-02-04 00:00:00	2004-01-29 00:00:00	Shipped	\N	458
10215	2004-01-29 00:00:00	2004-02-08 00:00:00	2004-02-01 00:00:00	Shipped	Customer requested that FedEx Ground is used for this shipping	475
10216	2004-02-02 00:00:00	2004-02-10 00:00:00	2004-02-04 00:00:00	Shipped	\N	256
10217	2004-02-04 00:00:00	2004-02-14 00:00:00	2004-02-06 00:00:00	Shipped	\N	166
10218	2004-02-09 00:00:00	2004-02-16 00:00:00	2004-02-11 00:00:00	Shipped	Customer requested that ad materials (such as posters, pamphlets) be included in the shippment	473
10219	2004-02-10 00:00:00	2004-02-17 00:00:00	2004-02-12 00:00:00	Shipped	\N	487
10220	2004-02-12 00:00:00	2004-02-19 00:00:00	2004-02-16 00:00:00	Shipped	\N	189
10221	2004-02-18 00:00:00	2004-02-26 00:00:00	2004-02-19 00:00:00	Shipped	\N	314
10222	2004-02-19 00:00:00	2004-02-27 00:00:00	2004-02-20 00:00:00	Shipped	\N	239
10223	2004-02-20 00:00:00	2004-02-29 00:00:00	2004-02-24 00:00:00	Shipped	\N	114
10224	2004-02-21 00:00:00	2004-03-02 00:00:00	2004-02-26 00:00:00	Shipped	Customer has worked with some of our vendors in the past and is aware of their MSRP	171
10225	2004-02-22 00:00:00	2004-03-01 00:00:00	2004-02-24 00:00:00	Shipped	\N	298
10226	2004-02-26 00:00:00	2004-03-06 00:00:00	2004-03-02 00:00:00	Shipped	\N	239
10227	2004-03-02 00:00:00	2004-03-12 00:00:00	2004-03-08 00:00:00	Shipped	\N	146
10228	2004-03-10 00:00:00	2004-03-18 00:00:00	2004-03-13 00:00:00	Shipped	\N	173
10229	2004-03-11 00:00:00	2004-03-20 00:00:00	2004-03-12 00:00:00	Shipped	\N	124
10230	2004-03-15 00:00:00	2004-03-24 00:00:00	2004-03-20 00:00:00	Shipped	Customer very concerned about the exact color of the models. There is high risk that he may dispute the order because there is a slight color mismatch	128
10231	2004-03-19 00:00:00	2004-03-26 00:00:00	2004-03-25 00:00:00	Shipped	\N	344
10232	2004-03-20 00:00:00	2004-03-30 00:00:00	2004-03-25 00:00:00	Shipped	\N	240
10233	2004-03-29 00:00:00	2004-04-04 00:00:00	2004-04-02 00:00:00	Shipped	Customer requested special shippment. The instructions were passed along to the warehouse	328
10234	2004-03-30 00:00:00	2004-04-05 00:00:00	2004-04-02 00:00:00	Shipped	\N	412
10235	2004-04-02 00:00:00	2004-04-12 00:00:00	2004-04-06 00:00:00	Shipped	\N	260
10236	2004-04-03 00:00:00	2004-04-11 00:00:00	2004-04-08 00:00:00	Shipped	\N	486
10237	2004-04-05 00:00:00	2004-04-12 00:00:00	2004-04-10 00:00:00	Shipped	\N	181
10238	2004-04-09 00:00:00	2004-04-16 00:00:00	2004-04-10 00:00:00	Shipped	\N	145
10239	2004-04-12 00:00:00	2004-04-21 00:00:00	2004-04-17 00:00:00	Shipped	\N	311
10240	2004-04-13 00:00:00	2004-04-20 00:00:00	2004-04-20 00:00:00	Shipped	\N	177
10241	2004-04-13 00:00:00	2004-04-20 00:00:00	2004-04-19 00:00:00	Shipped	\N	209
10242	2004-04-20 00:00:00	2004-04-28 00:00:00	2004-04-25 00:00:00	Shipped	Customer is interested in buying more Ferrari models	456
10243	2004-04-26 00:00:00	2004-05-03 00:00:00	2004-04-28 00:00:00	Shipped	\N	495
10244	2004-04-29 00:00:00	2004-05-09 00:00:00	2004-05-04 00:00:00	Shipped	\N	141
10245	2004-05-04 00:00:00	2004-05-12 00:00:00	2004-05-09 00:00:00	Shipped	\N	455
10246	2004-05-05 00:00:00	2004-05-13 00:00:00	2004-05-06 00:00:00	Shipped	\N	141
10247	2004-05-05 00:00:00	2004-05-11 00:00:00	2004-05-08 00:00:00	Shipped	\N	334
10248	2004-05-07 00:00:00	2004-05-14 00:00:00	\N	Cancelled	Order was mistakenly placed. The warehouse noticed the lack of documentation.	131
10249	2004-05-08 00:00:00	2004-05-17 00:00:00	2004-05-11 00:00:00	Shipped	Can we deliver the new Ford Mustang models by end-of-quarter?	173
10250	2004-05-11 00:00:00	2004-05-19 00:00:00	2004-05-15 00:00:00	Shipped	\N	450
10251	2004-05-18 00:00:00	2004-05-24 00:00:00	2004-05-24 00:00:00	Shipped	\N	328
10252	2004-05-26 00:00:00	2004-06-04 00:00:00	2004-05-29 00:00:00	Shipped	\N	406
10253	2004-06-01 00:00:00	2004-06-09 00:00:00	2004-06-02 00:00:00	Cancelled	Customer disputed the order and we agreed to cancel it. We must be more cautions with this customer going forward, since they are very hard to please. We must cover the shipping fees.	201
10254	2004-06-03 00:00:00	2004-06-13 00:00:00	2004-06-04 00:00:00	Shipped	Customer requested that DHL is used for this shipping	323
10255	2004-06-04 00:00:00	2004-06-12 00:00:00	2004-06-09 00:00:00	Shipped	\N	209
10256	2004-06-08 00:00:00	2004-06-16 00:00:00	2004-06-10 00:00:00	Shipped	\N	145
10257	2004-06-14 00:00:00	2004-06-24 00:00:00	2004-06-15 00:00:00	Shipped	\N	450
10258	2004-06-15 00:00:00	2004-06-25 00:00:00	2004-06-23 00:00:00	Shipped	\N	398
10259	2004-06-15 00:00:00	2004-06-22 00:00:00	2004-06-17 00:00:00	Shipped	\N	166
10260	2004-06-16 00:00:00	2004-06-22 00:00:00	\N	Cancelled	Customer heard complaints from their customers and called to cancel this order. Will notify the Sales Manager.	357
10261	2004-06-17 00:00:00	2004-06-25 00:00:00	2004-06-22 00:00:00	Shipped	\N	233
10262	2004-06-24 00:00:00	2004-07-01 00:00:00	\N	Cancelled	This customer found a better offer from one of our competitors. Will call back to renegotiate.	141
10263	2004-06-28 00:00:00	2004-07-04 00:00:00	2004-07-02 00:00:00	Shipped	\N	175
10264	2004-06-30 00:00:00	2004-07-06 00:00:00	2004-07-01 00:00:00	Shipped	Customer will send a truck to our local warehouse on 7/1/2004	362
10265	2004-07-02 00:00:00	2004-07-09 00:00:00	2004-07-07 00:00:00	Shipped	\N	471
10266	2004-07-06 00:00:00	2004-07-14 00:00:00	2004-07-10 00:00:00	Shipped	\N	386
10267	2004-07-07 00:00:00	2004-07-17 00:00:00	2004-07-09 00:00:00	Shipped	\N	151
10268	2004-07-12 00:00:00	2004-07-18 00:00:00	2004-07-14 00:00:00	Shipped	\N	412
10269	2004-07-16 00:00:00	2004-07-22 00:00:00	2004-07-18 00:00:00	Shipped	\N	382
10270	2004-07-19 00:00:00	2004-07-27 00:00:00	2004-07-24 00:00:00	Shipped	Can we renegotiate this one?	282
10271	2004-07-20 00:00:00	2004-07-29 00:00:00	2004-07-23 00:00:00	Shipped	\N	124
10272	2004-07-20 00:00:00	2004-07-26 00:00:00	2004-07-22 00:00:00	Shipped	\N	157
10273	2004-07-21 00:00:00	2004-07-28 00:00:00	2004-07-22 00:00:00	Shipped	\N	314
10274	2004-07-21 00:00:00	2004-07-29 00:00:00	2004-07-22 00:00:00	Shipped	\N	379
10275	2004-07-23 00:00:00	2004-08-02 00:00:00	2004-07-29 00:00:00	Shipped	\N	119
10276	2004-08-02 00:00:00	2004-08-11 00:00:00	2004-08-08 00:00:00	Shipped	\N	204
10277	2004-08-04 00:00:00	2004-08-12 00:00:00	2004-08-05 00:00:00	Shipped	\N	148
10278	2004-08-06 00:00:00	2004-08-16 00:00:00	2004-08-09 00:00:00	Shipped	\N	112
10279	2004-08-09 00:00:00	2004-08-19 00:00:00	2004-08-15 00:00:00	Shipped	Cautious optimism. We have happy customers here, if we can keep them well stocked.  I need all the information I can get on the planned shippments of Porches	141
10280	2004-08-17 00:00:00	2004-08-27 00:00:00	2004-08-19 00:00:00	Shipped	\N	249
10281	2004-08-19 00:00:00	2004-08-28 00:00:00	2004-08-23 00:00:00	Shipped	\N	157
10282	2004-08-20 00:00:00	2004-08-26 00:00:00	2004-08-22 00:00:00	Shipped	\N	124
10283	2004-08-20 00:00:00	2004-08-30 00:00:00	2004-08-23 00:00:00	Shipped	\N	260
10284	2004-08-21 00:00:00	2004-08-29 00:00:00	2004-08-26 00:00:00	Shipped	Custom shipping instructions sent to warehouse	299
10285	2004-08-27 00:00:00	2004-09-04 00:00:00	2004-08-31 00:00:00	Shipped	\N	286
10286	2004-08-28 00:00:00	2004-09-06 00:00:00	2004-09-01 00:00:00	Shipped	\N	172
10287	2004-08-30 00:00:00	2004-09-06 00:00:00	2004-09-01 00:00:00	Shipped	\N	298
10288	2004-09-01 00:00:00	2004-09-11 00:00:00	2004-09-05 00:00:00	Shipped	\N	166
10289	2004-09-03 00:00:00	2004-09-13 00:00:00	2004-09-04 00:00:00	Shipped	We need to keep in close contact with their Marketing VP. He is the decision maker for all their purchases.	167
10290	2004-09-07 00:00:00	2004-09-15 00:00:00	2004-09-13 00:00:00	Shipped	\N	198
10291	2004-09-08 00:00:00	2004-09-17 00:00:00	2004-09-14 00:00:00	Shipped	\N	448
10292	2004-09-08 00:00:00	2004-09-18 00:00:00	2004-09-11 00:00:00	Shipped	They want to reevaluate their terms agreement with Finance.	131
10293	2004-09-09 00:00:00	2004-09-18 00:00:00	2004-09-14 00:00:00	Shipped	\N	249
10294	2004-09-10 00:00:00	2004-09-17 00:00:00	2004-09-14 00:00:00	Shipped	\N	204
10295	2004-09-10 00:00:00	2004-09-17 00:00:00	2004-09-14 00:00:00	Shipped	They want to reevaluate their terms agreement with Finance.	362
10296	2004-09-15 00:00:00	2004-09-22 00:00:00	2004-09-16 00:00:00	Shipped	\N	415
10297	2004-09-16 00:00:00	2004-09-22 00:00:00	2004-09-21 00:00:00	Shipped	We must be cautions with this customer. Their VP of Sales resigned. Company may be heading down.	189
10298	2004-09-27 00:00:00	2004-10-05 00:00:00	2004-10-01 00:00:00	Shipped	\N	103
10299	2004-09-30 00:00:00	2004-10-10 00:00:00	2004-10-01 00:00:00	Shipped	\N	186
10300	2003-10-04 00:00:00	2003-10-13 00:00:00	2003-10-09 00:00:00	Shipped	\N	128
10301	2003-10-05 00:00:00	2003-10-15 00:00:00	2003-10-08 00:00:00	Shipped	\N	299
10302	2003-10-06 00:00:00	2003-10-16 00:00:00	2003-10-07 00:00:00	Shipped	\N	201
10303	2004-10-06 00:00:00	2004-10-14 00:00:00	2004-10-09 00:00:00	Shipped	Customer inquired about remote controlled models and gold models.	484
10304	2004-10-11 00:00:00	2004-10-20 00:00:00	2004-10-17 00:00:00	Shipped	\N	256
10305	2004-10-13 00:00:00	2004-10-22 00:00:00	2004-10-15 00:00:00	Shipped	Check on availability.	286
10306	2004-10-14 00:00:00	2004-10-21 00:00:00	2004-10-17 00:00:00	Shipped	\N	187
10307	2004-10-14 00:00:00	2004-10-23 00:00:00	2004-10-20 00:00:00	Shipped	\N	339
10308	2004-10-15 00:00:00	2004-10-24 00:00:00	2004-10-20 00:00:00	Shipped	Customer requested that FedEx Ground is used for this shipping	319
10309	2004-10-15 00:00:00	2004-10-24 00:00:00	2004-10-18 00:00:00	Shipped	\N	121
10310	2004-10-16 00:00:00	2004-10-24 00:00:00	2004-10-18 00:00:00	Shipped	\N	259
10311	2004-10-16 00:00:00	2004-10-23 00:00:00	2004-10-20 00:00:00	Shipped	Difficult to negotiate with customer. We need more marketing materials	141
10312	2004-10-21 00:00:00	2004-10-27 00:00:00	2004-10-23 00:00:00	Shipped	\N	124
10313	2004-10-22 00:00:00	2004-10-28 00:00:00	2004-10-25 00:00:00	Shipped	Customer requested that FedEx Ground is used for this shipping	202
10314	2004-10-22 00:00:00	2004-11-01 00:00:00	2004-10-23 00:00:00	Shipped	\N	227
10315	2004-10-29 00:00:00	2004-11-08 00:00:00	2004-10-30 00:00:00	Shipped	\N	119
10316	2004-11-01 00:00:00	2004-11-09 00:00:00	2004-11-07 00:00:00	Shipped	Customer requested that ad materials (such as posters, pamphlets) be included in the shippment	240
10317	2004-11-02 00:00:00	2004-11-12 00:00:00	2004-11-08 00:00:00	Shipped	\N	161
10318	2004-11-02 00:00:00	2004-11-09 00:00:00	2004-11-07 00:00:00	Shipped	\N	157
10319	2004-11-03 00:00:00	2004-11-11 00:00:00	2004-11-06 00:00:00	Shipped	Customer requested that DHL is used for this shipping	456
10320	2004-11-03 00:00:00	2004-11-13 00:00:00	2004-11-07 00:00:00	Shipped	\N	144
10321	2004-11-04 00:00:00	2004-11-12 00:00:00	2004-11-07 00:00:00	Shipped	\N	462
10322	2004-11-04 00:00:00	2004-11-12 00:00:00	2004-11-10 00:00:00	Shipped	Customer has worked with some of our vendors in the past and is aware of their MSRP	363
10323	2004-11-05 00:00:00	2004-11-12 00:00:00	2004-11-09 00:00:00	Shipped	\N	128
10324	2004-11-05 00:00:00	2004-11-11 00:00:00	2004-11-08 00:00:00	Shipped	\N	181
10325	2004-11-05 00:00:00	2004-11-13 00:00:00	2004-11-08 00:00:00	Shipped	\N	121
10326	2004-11-09 00:00:00	2004-11-16 00:00:00	2004-11-10 00:00:00	Shipped	\N	144
10327	2004-11-10 00:00:00	2004-11-19 00:00:00	2004-11-13 00:00:00	Resolved	Order was disputed and resolved on 12/1/04. The Sales Manager was involved. Customer claims the scales of the models don't match what was discussed.	145
10328	2004-11-12 00:00:00	2004-11-21 00:00:00	2004-11-18 00:00:00	Shipped	Customer very concerned about the exact color of the models. There is high risk that he may dispute the order because there is a slight color mismatch	278
10329	2004-11-15 00:00:00	2004-11-24 00:00:00	2004-11-16 00:00:00	Shipped	\N	131
10330	2004-11-16 00:00:00	2004-11-25 00:00:00	2004-11-21 00:00:00	Shipped	\N	385
10331	2004-11-17 00:00:00	2004-11-23 00:00:00	2004-11-23 00:00:00	Shipped	Customer requested special shippment. The instructions were passed along to the warehouse	486
10332	2004-11-17 00:00:00	2004-11-25 00:00:00	2004-11-18 00:00:00	Shipped	\N	187
10333	2004-11-18 00:00:00	2004-11-27 00:00:00	2004-11-20 00:00:00	Shipped	\N	129
10334	2004-11-19 00:00:00	2004-11-28 00:00:00	\N	On Hold	The outstaniding balance for this customer exceeds their credit limit. Order will be shipped when a payment is received.	144
10335	2004-11-19 00:00:00	2004-11-29 00:00:00	2004-11-23 00:00:00	Shipped	\N	124
10336	2004-11-20 00:00:00	2004-11-26 00:00:00	2004-11-24 00:00:00	Shipped	Customer requested that DHL is used for this shipping	172
10337	2004-11-21 00:00:00	2004-11-30 00:00:00	2004-11-26 00:00:00	Shipped	\N	424
10338	2004-11-22 00:00:00	2004-12-02 00:00:00	2004-11-27 00:00:00	Shipped	\N	381
10339	2004-11-23 00:00:00	2004-11-30 00:00:00	2004-11-30 00:00:00	Shipped	\N	398
10340	2004-11-24 00:00:00	2004-12-01 00:00:00	2004-11-25 00:00:00	Shipped	Customer is interested in buying more Ferrari models	216
10341	2004-11-24 00:00:00	2004-12-01 00:00:00	2004-11-29 00:00:00	Shipped	\N	382
10342	2004-11-24 00:00:00	2004-12-01 00:00:00	2004-11-29 00:00:00	Shipped	\N	114
10343	2004-11-24 00:00:00	2004-12-01 00:00:00	2004-11-26 00:00:00	Shipped	\N	353
10344	2004-11-25 00:00:00	2004-12-02 00:00:00	2004-11-29 00:00:00	Shipped	\N	350
10345	2004-11-25 00:00:00	2004-12-01 00:00:00	2004-11-26 00:00:00	Shipped	\N	103
10346	2004-11-29 00:00:00	2004-12-05 00:00:00	2004-11-30 00:00:00	Shipped	\N	112
10347	2004-11-29 00:00:00	2004-12-07 00:00:00	2004-11-30 00:00:00	Shipped	Can we deliver the new Ford Mustang models by end-of-quarter?	114
10348	2004-11-01 00:00:00	2004-11-08 00:00:00	2004-11-05 00:00:00	Shipped	\N	458
10349	2004-12-01 00:00:00	2004-12-07 00:00:00	2004-12-03 00:00:00	Shipped	\N	151
10350	2004-12-02 00:00:00	2004-12-08 00:00:00	2004-12-05 00:00:00	Shipped	\N	141
10351	2004-12-03 00:00:00	2004-12-11 00:00:00	2004-12-07 00:00:00	Shipped	\N	324
10352	2004-12-03 00:00:00	2004-12-12 00:00:00	2004-12-09 00:00:00	Shipped	\N	198
10353	2004-12-04 00:00:00	2004-12-11 00:00:00	2004-12-05 00:00:00	Shipped	\N	447
10354	2004-12-04 00:00:00	2004-12-10 00:00:00	2004-12-05 00:00:00	Shipped	\N	323
10355	2004-12-07 00:00:00	2004-12-14 00:00:00	2004-12-13 00:00:00	Shipped	\N	141
10356	2004-12-09 00:00:00	2004-12-15 00:00:00	2004-12-12 00:00:00	Shipped	\N	250
10357	2004-12-10 00:00:00	2004-12-16 00:00:00	2004-12-14 00:00:00	Shipped	\N	124
10358	2004-12-10 00:00:00	2004-12-16 00:00:00	2004-12-16 00:00:00	Shipped	Customer requested that DHL is used for this shipping	141
10359	2004-12-15 00:00:00	2004-12-23 00:00:00	2004-12-18 00:00:00	Shipped	\N	353
10360	2004-12-16 00:00:00	2004-12-22 00:00:00	2004-12-18 00:00:00	Shipped	\N	496
10361	2004-12-17 00:00:00	2004-12-24 00:00:00	2004-12-20 00:00:00	Shipped	\N	282
10362	2005-01-05 00:00:00	2005-01-16 00:00:00	2005-01-10 00:00:00	Shipped	\N	161
10363	2005-01-06 00:00:00	2005-01-12 00:00:00	2005-01-10 00:00:00	Shipped	\N	334
10364	2005-01-06 00:00:00	2005-01-17 00:00:00	2005-01-09 00:00:00	Shipped	\N	350
10365	2005-01-07 00:00:00	2005-01-18 00:00:00	2005-01-11 00:00:00	Shipped	\N	320
10366	2005-01-10 00:00:00	2005-01-19 00:00:00	2005-01-12 00:00:00	Shipped	\N	381
10367	2005-01-12 00:00:00	2005-01-21 00:00:00	2005-01-16 00:00:00	Resolved	This order was disputed and resolved on 2/1/2005. Customer claimed that container with shipment was damaged. FedEx's investigation proved this wrong.	205
10368	2005-01-19 00:00:00	2005-01-27 00:00:00	2005-01-24 00:00:00	Shipped	Can we renegotiate this one?	124
10369	2005-01-20 00:00:00	2005-01-28 00:00:00	2005-01-24 00:00:00	Shipped	\N	379
10370	2005-01-20 00:00:00	2005-02-01 00:00:00	2005-01-25 00:00:00	Shipped	\N	276
10371	2005-01-23 00:00:00	2005-02-03 00:00:00	2005-01-25 00:00:00	Shipped	\N	124
10372	2005-01-26 00:00:00	2005-02-05 00:00:00	2005-01-28 00:00:00	Shipped	\N	398
10373	2005-01-31 00:00:00	2005-02-08 00:00:00	2005-02-06 00:00:00	Shipped	\N	311
10374	2005-02-02 00:00:00	2005-02-09 00:00:00	2005-02-03 00:00:00	Shipped	\N	333
10375	2005-02-03 00:00:00	2005-02-10 00:00:00	2005-02-06 00:00:00	Shipped	\N	119
10377	2005-02-09 00:00:00	2005-02-21 00:00:00	2005-02-12 00:00:00	Shipped	Cautious optimism. We have happy customers here, if we can keep them well stocked.  I need all the information I can get on the planned shippments of Porches	186
10378	2005-02-10 00:00:00	2005-02-18 00:00:00	2005-02-11 00:00:00	Shipped	\N	141
10379	2005-02-10 00:00:00	2005-02-18 00:00:00	2005-02-11 00:00:00	Shipped	\N	141
10380	2005-02-16 00:00:00	2005-02-24 00:00:00	2005-02-18 00:00:00	Shipped	\N	141
10381	2005-02-17 00:00:00	2005-02-25 00:00:00	2005-02-18 00:00:00	Shipped	\N	321
10382	2005-02-17 00:00:00	2005-02-23 00:00:00	2005-02-18 00:00:00	Shipped	Custom shipping instructions sent to warehouse	124
10383	2005-02-22 00:00:00	2005-03-02 00:00:00	2005-02-25 00:00:00	Shipped	\N	141
10384	2005-02-23 00:00:00	2005-03-06 00:00:00	2005-02-27 00:00:00	Shipped	\N	321
10385	2005-02-28 00:00:00	2005-03-09 00:00:00	2005-03-01 00:00:00	Shipped	\N	124
10386	2005-03-01 00:00:00	2005-03-09 00:00:00	2005-03-06 00:00:00	Resolved	Disputed then Resolved on 3/15/2005. Customer doesn't like the craftsmaship of the models.	141
10387	2005-03-02 00:00:00	2005-03-09 00:00:00	2005-03-06 00:00:00	Shipped	We need to keep in close contact with their Marketing VP. He is the decision maker for all their purchases.	148
10388	2005-03-03 00:00:00	2005-03-11 00:00:00	2005-03-09 00:00:00	Shipped	\N	462
10389	2005-03-03 00:00:00	2005-03-09 00:00:00	2005-03-08 00:00:00	Shipped	\N	448
10390	2005-03-04 00:00:00	2005-03-11 00:00:00	2005-03-07 00:00:00	Shipped	They want to reevaluate their terms agreement with Finance.	124
10391	2005-03-09 00:00:00	2005-03-20 00:00:00	2005-03-15 00:00:00	Shipped	\N	276
10392	2005-03-10 00:00:00	2005-03-18 00:00:00	2005-03-12 00:00:00	Shipped	\N	452
10393	2005-03-11 00:00:00	2005-03-22 00:00:00	2005-03-14 00:00:00	Shipped	They want to reevaluate their terms agreement with Finance.	323
10394	2005-03-15 00:00:00	2005-03-25 00:00:00	2005-03-19 00:00:00	Shipped	\N	141
10395	2005-03-17 00:00:00	2005-03-24 00:00:00	2005-03-23 00:00:00	Shipped	We must be cautions with this customer. Their VP of Sales resigned. Company may be heading down.	250
10396	2005-03-23 00:00:00	2005-04-02 00:00:00	2005-03-28 00:00:00	Shipped	\N	124
10397	2005-03-28 00:00:00	2005-04-09 00:00:00	2005-04-01 00:00:00	Shipped	\N	242
10398	2005-03-30 00:00:00	2005-04-09 00:00:00	2005-03-31 00:00:00	Shipped	\N	353
10399	2005-04-01 00:00:00	2005-04-12 00:00:00	2005-04-03 00:00:00	Shipped	\N	496
10400	2005-04-01 00:00:00	2005-04-11 00:00:00	2005-04-04 00:00:00	Shipped	Customer requested that DHL is used for this shipping	450
10401	2005-04-03 00:00:00	2005-04-14 00:00:00	\N	On Hold	Customer credit limit exceeded. Will ship when a payment is received.	328
10402	2005-04-07 00:00:00	2005-04-14 00:00:00	2005-04-12 00:00:00	Shipped	\N	406
10403	2005-04-08 00:00:00	2005-04-18 00:00:00	2005-04-11 00:00:00	Shipped	\N	201
10404	2005-04-08 00:00:00	2005-04-14 00:00:00	2005-04-11 00:00:00	Shipped	\N	323
10405	2005-04-14 00:00:00	2005-04-24 00:00:00	2005-04-20 00:00:00	Shipped	\N	209
10406	2005-04-15 00:00:00	2005-04-25 00:00:00	2005-04-21 00:00:00	Disputed	Customer claims container with shipment was damaged during shipping and some items were missing. I am talking to FedEx about this.	145
10407	2005-04-22 00:00:00	2005-05-04 00:00:00	\N	On Hold	Customer credit limit exceeded. Will ship when a payment is received.	450
10408	2005-04-22 00:00:00	2005-04-29 00:00:00	2005-04-27 00:00:00	Shipped	\N	398
10409	2005-04-23 00:00:00	2005-05-05 00:00:00	2005-04-24 00:00:00	Shipped	\N	166
10410	2005-04-29 00:00:00	2005-05-10 00:00:00	2005-04-30 00:00:00	Shipped	\N	357
10411	2005-05-01 00:00:00	2005-05-08 00:00:00	2005-05-06 00:00:00	Shipped	\N	233
10412	2005-05-03 00:00:00	2005-05-13 00:00:00	2005-05-05 00:00:00	Shipped	\N	141
10413	2005-05-05 00:00:00	2005-05-14 00:00:00	2005-05-09 00:00:00	Shipped	Customer requested that DHL is used for this shipping	175
10414	2005-05-06 00:00:00	2005-05-13 00:00:00	\N	On Hold	Customer credit limit exceeded. Will ship when a payment is received.	362
10415	2005-05-09 00:00:00	2005-05-20 00:00:00	2005-05-12 00:00:00	Disputed	Customer claims the scales of the models don't match what was discussed. I keep all the paperwork though to prove otherwise	471
10416	2005-05-10 00:00:00	2005-05-16 00:00:00	2005-05-14 00:00:00	Shipped	\N	386
10417	2005-05-13 00:00:00	2005-05-19 00:00:00	2005-05-19 00:00:00	Disputed	Customer doesn't like the colors and precision of the models.	141
10418	2005-05-16 00:00:00	2005-05-24 00:00:00	2005-05-20 00:00:00	Shipped	\N	412
10419	2005-05-17 00:00:00	2005-05-28 00:00:00	2005-05-19 00:00:00	Shipped	\N	382
10420	2005-05-29 00:00:00	2005-06-07 00:00:00	\N	In Process	\N	282
10421	2005-05-29 00:00:00	2005-06-06 00:00:00	\N	In Process	Custom shipping instructions were sent to warehouse	124
10422	2005-05-30 00:00:00	2005-06-11 00:00:00	\N	In Process	\N	157
10423	2005-05-30 00:00:00	2005-06-05 00:00:00	\N	In Process	\N	314
10424	2005-05-31 00:00:00	2005-06-08 00:00:00	\N	In Process	\N	141
10425	2005-05-31 00:00:00	2005-06-07 00:00:00	\N	In Process	\N	119
\.


--
-- Name: orders_ordernumber_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('orders_ordernumber_seq', 10426, true);


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: root
--

COPY payments ("customerNumber", "checkNumber", "paymentDate", amount) FROM stdin;
103	HQ336336	2004-10-19 00:00:00	6066.77999999999975
103	JM555205	2003-06-05 00:00:00	14571.4400000000005
103	OM314933	2004-12-18 00:00:00	1676.1400000000001
112	BO864823	2004-12-17 00:00:00	14191.1200000000008
112	HQ55022	2003-06-06 00:00:00	32641.9799999999996
112	ND748579	2004-08-20 00:00:00	33347.8799999999974
114	GG31455	2003-05-20 00:00:00	45864.0299999999988
114	MA765515	2004-12-15 00:00:00	82261.2200000000012
114	NP603840	2003-05-31 00:00:00	7565.07999999999993
114	NR27552	2004-03-10 00:00:00	44894.739999999998
119	DB933704	2004-11-14 00:00:00	19501.8199999999997
119	LN373447	2004-08-08 00:00:00	47924.1900000000023
119	NG94694	2005-02-22 00:00:00	49523.6699999999983
121	DB889831	2003-02-16 00:00:00	50218.9499999999971
121	FD317790	2003-10-28 00:00:00	1491.38000000000011
121	KI831359	2004-11-04 00:00:00	17876.3199999999997
121	MA302151	2004-11-28 00:00:00	34638.1399999999994
124	AE215433	2005-03-05 00:00:00	101244.589999999997
124	BG255406	2004-08-28 00:00:00	85410.8699999999953
124	CQ287967	2003-04-11 00:00:00	11044.2999999999993
124	ET64396	2005-04-16 00:00:00	83598.0399999999936
124	HI366474	2004-12-27 00:00:00	47142.6999999999971
124	HR86578	2004-11-02 00:00:00	55639.6600000000035
124	KI131716	2003-08-15 00:00:00	111654.399999999994
124	LF217299	2004-03-26 00:00:00	43369.3000000000029
124	NT141748	2003-11-25 00:00:00	45084.3799999999974
128	DI925118	2003-01-28 00:00:00	10549.0100000000002
128	FA465482	2003-10-18 00:00:00	24101.8100000000013
128	FH668230	2004-03-24 00:00:00	33820.6200000000026
128	IP383901	2004-11-18 00:00:00	7466.31999999999971
129	DM826140	2004-12-08 00:00:00	26248.7799999999988
129	ID449593	2003-12-11 00:00:00	23923.9300000000003
129	PI42991	2003-04-09 00:00:00	16537.8499999999985
131	CL442705	2003-03-12 00:00:00	22292.619999999999
131	MA724562	2004-12-02 00:00:00	50025.3499999999985
131	NB445135	2004-09-11 00:00:00	35321.9700000000012
141	AU364101	2003-07-19 00:00:00	36251.0299999999988
141	DB583216	2004-11-01 00:00:00	36140.3799999999974
141	DL460618	2005-05-19 00:00:00	46895.4800000000032
141	HJ32686	2004-01-30 00:00:00	59830.5500000000029
141	ID10962	2004-12-31 00:00:00	116208.399999999994
141	IN446258	2005-03-25 00:00:00	65071.260000000002
141	JE105477	2005-03-18 00:00:00	120166.580000000002
141	JN355280	2003-10-26 00:00:00	49539.3700000000026
141	JN722010	2003-02-25 00:00:00	40206.1999999999971
141	KT52578	2003-12-09 00:00:00	63843.5500000000029
141	MC46946	2004-07-09 00:00:00	35420.739999999998
141	MF629602	2004-08-16 00:00:00	20009.5299999999988
141	NU627706	2004-05-17 00:00:00	26155.9099999999999
144	IR846303	2004-12-12 00:00:00	36005.7099999999991
144	LA685678	2003-04-09 00:00:00	7674.9399999999996
145	CN328545	2004-07-03 00:00:00	4710.72999999999956
145	ED39322	2004-04-26 00:00:00	28211.7000000000007
145	HR182688	2004-12-01 00:00:00	20564.8600000000006
145	JJ246391	2003-02-20 00:00:00	53959.2099999999991
146	FP549817	2004-03-18 00:00:00	40978.5299999999988
146	FU793410	2004-01-16 00:00:00	49614.7200000000012
146	LJ160635	2003-12-10 00:00:00	39712.0999999999985
148	BI507030	2003-04-22 00:00:00	44380.1500000000015
148	DD635282	2004-08-11 00:00:00	2611.84000000000015
148	KM172879	2003-12-26 00:00:00	105743
148	ME497970	2005-03-27 00:00:00	3516.03999999999996
151	BF686658	2003-12-22 00:00:00	58793.5299999999988
151	GB852215	2004-07-26 00:00:00	20314.4399999999987
151	IP568906	2003-06-18 00:00:00	58841.3499999999985
151	KI884577	2004-12-14 00:00:00	39964.6299999999974
157	HI618861	2004-11-19 00:00:00	35152.1200000000026
157	NN711988	2004-09-07 00:00:00	63357.1299999999974
161	BR352384	2004-11-14 00:00:00	2434.25
161	BR478494	2003-11-18 00:00:00	50743.6500000000015
161	KG644125	2005-02-02 00:00:00	12692.1900000000005
161	NI908214	2003-08-05 00:00:00	38675.1299999999974
166	BQ327613	2004-09-16 00:00:00	38785.4800000000032
166	DC979307	2004-07-07 00:00:00	44160.9199999999983
166	LA318629	2004-02-28 00:00:00	22474.1699999999983
167	ED743615	2004-09-19 00:00:00	12538.0100000000002
167	GN228846	2003-12-03 00:00:00	85024.4600000000064
171	GB878038	2004-03-15 00:00:00	18997.8899999999994
171	IL104425	2003-11-22 00:00:00	42783.8099999999977
172	AD832091	2004-09-09 00:00:00	1960.79999999999995
172	CE51751	2004-12-04 00:00:00	51209.5800000000017
172	EH208589	2003-04-20 00:00:00	33383.1399999999994
173	GP545698	2004-05-13 00:00:00	11843.4500000000007
173	IG462397	2004-03-29 00:00:00	20355.2400000000016
175	IO448913	2003-11-19 00:00:00	24879.0800000000017
175	PI15215	2004-07-10 00:00:00	42044.7699999999968
177	AU750837	2004-04-17 00:00:00	15183.6299999999992
177	CI381435	2004-01-19 00:00:00	47177.5899999999965
181	CM564612	2004-04-25 00:00:00	22602.3600000000006
175	CITI3434344	2005-05-19 00:00:00	28500.7799999999988
209	BOAF82044	2005-05-03 00:00:00	35157.75
181	GQ132144	2003-01-30 00:00:00	5494.77999999999975
181	OH367219	2004-11-16 00:00:00	44400.5
186	AE192287	2005-03-10 00:00:00	23602.9000000000015
186	AK412714	2003-10-27 00:00:00	37602.4800000000032
186	KA602407	2004-10-21 00:00:00	34341.0800000000017
187	AM968797	2004-11-03 00:00:00	52825.2900000000009
187	BQ39062	2004-12-08 00:00:00	47159.1100000000006
187	KL124726	2003-03-27 00:00:00	48425.6900000000023
189	BO711618	2004-10-03 00:00:00	17359.5299999999988
189	NM916675	2004-03-01 00:00:00	32538.7400000000016
198	FI192930	2004-12-06 00:00:00	9658.73999999999978
198	HQ920205	2003-07-06 00:00:00	6036.96000000000004
198	IS946883	2004-09-21 00:00:00	5858.5600000000004
201	DP677013	2003-10-20 00:00:00	23908.2400000000016
201	OO846801	2004-06-15 00:00:00	37258.9400000000023
202	HI358554	2003-12-18 00:00:00	36527.6100000000006
202	IQ627690	2004-11-08 00:00:00	33594.5800000000017
204	GC697638	2004-08-13 00:00:00	51152.8600000000006
204	IS150005	2004-09-24 00:00:00	4424.39999999999964
205	GL756480	2003-12-04 00:00:00	3879.96000000000004
205	LL562733	2003-09-05 00:00:00	50342.739999999998
205	NM739638	2005-02-06 00:00:00	39580.5999999999985
209	ED520529	2004-06-21 00:00:00	4632.3100000000004
209	PH785937	2004-05-04 00:00:00	36069.260000000002
211	BJ535230	2003-12-09 00:00:00	45480.7900000000009
216	BG407567	2003-05-09 00:00:00	3101.40000000000009
216	ML780814	2004-12-06 00:00:00	24945.2099999999991
216	MM342086	2003-12-14 00:00:00	40473.8600000000006
219	BN17870	2005-03-02 00:00:00	3452.75
219	BR941480	2003-10-18 00:00:00	4465.85000000000036
227	MQ413968	2003-10-31 00:00:00	36164.4599999999991
227	NU21326	2004-11-02 00:00:00	53745.3399999999965
233	II180006	2004-07-01 00:00:00	22997.4500000000007
233	JG981190	2003-11-18 00:00:00	16909.8400000000001
239	NQ865547	2004-03-15 00:00:00	80375.2400000000052
240	IF245157	2004-11-16 00:00:00	46788.1399999999994
240	JO719695	2004-03-28 00:00:00	24995.6100000000006
242	AF40894	2003-11-22 00:00:00	33818.3399999999965
242	HR224331	2005-06-03 00:00:00	12432.3199999999997
242	KI744716	2003-07-21 00:00:00	14232.7000000000007
249	IJ399820	2004-09-19 00:00:00	33924.239999999998
249	NE404084	2004-09-04 00:00:00	48298.989999999998
250	EQ12267	2005-05-17 00:00:00	17928.0900000000001
250	HD284647	2004-12-30 00:00:00	26311.630000000001
250	HN114306	2003-07-18 00:00:00	23419.4700000000012
256	EP227123	2004-02-10 00:00:00	5759.42000000000007
256	HE84936	2004-10-22 00:00:00	53116.989999999998
259	EU280955	2004-11-06 00:00:00	61234.6699999999983
259	GB361972	2003-12-07 00:00:00	27988.4700000000012
260	IO164641	2004-08-30 00:00:00	37527.5800000000017
260	NH776924	2004-04-24 00:00:00	29284.4199999999983
276	EM979878	2005-02-09 00:00:00	27083.7799999999988
276	KM841847	2003-11-13 00:00:00	38547.1900000000023
276	LE432182	2003-09-28 00:00:00	41554.7300000000032
276	OJ819725	2005-04-30 00:00:00	29848.5200000000004
278	BJ483870	2004-12-05 00:00:00	37654.0899999999965
278	GP636783	2003-03-02 00:00:00	52151.8099999999977
278	NI983021	2003-11-24 00:00:00	37723.7900000000009
282	IA793562	2003-08-03 00:00:00	24013.5200000000004
282	JT819493	2004-08-02 00:00:00	35806.7300000000032
282	OD327378	2005-01-03 00:00:00	31835.3600000000006
286	DR578578	2004-10-28 00:00:00	47411.3300000000017
286	KH910279	2004-09-05 00:00:00	43134.0400000000009
298	AJ574927	2004-03-13 00:00:00	47375.9199999999983
298	LF501133	2004-09-18 00:00:00	61402
299	AD304085	2003-10-24 00:00:00	36798.8799999999974
299	NR157385	2004-09-05 00:00:00	32260.1599999999999
311	DG336041	2005-02-15 00:00:00	46770.5199999999968
311	FA728475	2003-10-06 00:00:00	32723.0400000000009
311	NQ966143	2004-04-25 00:00:00	16212.5900000000001
314	LQ244073	2004-08-09 00:00:00	45352.4700000000012
314	MD809704	2004-03-03 00:00:00	16901.380000000001
319	HL685576	2004-11-06 00:00:00	42339.760000000002
319	OM548174	2003-12-07 00:00:00	36092.4000000000015
320	GJ597719	2005-01-18 00:00:00	8307.28000000000065
320	HO576374	2003-08-20 00:00:00	41016.75
320	MU817160	2003-11-24 00:00:00	52548.489999999998
321	DJ15149	2003-11-03 00:00:00	85559.1199999999953
321	LA556321	2005-03-15 00:00:00	46781.6600000000035
323	AL493079	2005-05-23 00:00:00	75020.1300000000047
323	ES347491	2004-06-24 00:00:00	37281.3600000000006
323	HG738664	2003-07-05 00:00:00	2880
323	PQ803830	2004-12-24 00:00:00	39440.5899999999965
324	DQ409197	2004-12-13 00:00:00	13671.8199999999997
324	FP443161	2003-07-07 00:00:00	29429.1399999999994
324	HB150714	2003-11-23 00:00:00	37455.7699999999968
328	EN930356	2004-04-16 00:00:00	7178.65999999999985
328	NR631421	2004-05-30 00:00:00	31102.8499999999985
333	HL209210	2003-11-15 00:00:00	23936.5299999999988
333	JK479662	2003-10-17 00:00:00	9821.31999999999971
333	NF959653	2005-03-01 00:00:00	21432.3100000000013
334	CS435306	2005-01-27 00:00:00	45785.3399999999965
334	HH517378	2003-08-16 00:00:00	29716.8600000000006
334	LF737277	2004-05-22 00:00:00	28394.5400000000009
339	AP286625	2004-10-24 00:00:00	23333.0600000000013
339	DA98827	2003-11-28 00:00:00	34606.2799999999988
344	AF246722	2003-11-24 00:00:00	31428.2099999999991
344	NJ906924	2004-04-02 00:00:00	15322.9300000000003
347	DG700707	2004-01-18 00:00:00	21053.6899999999987
347	LG808674	2003-10-24 00:00:00	20452.5
350	BQ602907	2004-12-11 00:00:00	18888.3100000000013
350	CI471510	2003-05-25 00:00:00	50824.6600000000035
350	OB648482	2005-01-29 00:00:00	1834.55999999999995
353	CO351193	2005-01-10 00:00:00	49705.5199999999968
353	ED878227	2003-07-21 00:00:00	13920.2600000000002
353	GT878649	2003-05-21 00:00:00	16700.4700000000012
353	HJ618252	2005-06-09 00:00:00	46656.9400000000023
357	AG240323	2003-12-16 00:00:00	20220.0400000000009
357	NB291497	2004-05-15 00:00:00	36442.3399999999965
362	FP170292	2004-07-11 00:00:00	18473.7099999999991
362	OG208861	2004-09-21 00:00:00	15059.7600000000002
363	HL575273	2004-11-17 00:00:00	50799.6900000000023
363	IS232033	2003-01-16 00:00:00	10223.8299999999999
363	PN238558	2003-12-05 00:00:00	55425.7699999999968
379	CA762595	2005-02-12 00:00:00	28322.8300000000017
379	FR499138	2003-09-16 00:00:00	32680.3100000000013
379	GB890854	2004-08-02 00:00:00	12530.5100000000002
381	BC726082	2004-12-03 00:00:00	12081.5200000000004
381	CC475233	2003-04-19 00:00:00	1627.55999999999995
381	GB117430	2005-02-03 00:00:00	14379.8999999999996
381	MS154481	2003-08-22 00:00:00	1128.20000000000005
382	CC871084	2003-05-12 00:00:00	35826.3300000000017
382	CT821147	2004-08-01 00:00:00	6419.84000000000015
382	PH29054	2004-11-27 00:00:00	42813.8300000000017
385	BN347084	2003-12-02 00:00:00	20644.2400000000016
385	CP804873	2004-11-19 00:00:00	15822.8400000000001
385	EK785462	2003-03-09 00:00:00	51001.2200000000012
386	DO106109	2003-11-18 00:00:00	38524.2900000000009
386	HG438769	2004-07-18 00:00:00	51619.0199999999968
398	AJ478695	2005-02-14 00:00:00	33967.7300000000032
398	DO787644	2004-06-21 00:00:00	22037.9099999999999
398	KB54275	2004-11-29 00:00:00	48927.6399999999994
406	HJ217687	2004-01-28 00:00:00	49165.1600000000035
406	NA197101	2004-06-17 00:00:00	25080.9599999999991
412	GH197075	2004-07-25 00:00:00	35034.5699999999997
412	PJ434867	2004-04-14 00:00:00	31670.369999999999
415	ER54537	2004-09-28 00:00:00	31310.0900000000001
424	KF480160	2004-12-07 00:00:00	25505.9799999999996
424	LM271923	2003-04-16 00:00:00	21665.9799999999996
424	OA595449	2003-10-31 00:00:00	22042.369999999999
447	AO757239	2003-09-15 00:00:00	6631.35999999999967
447	ER615123	2003-06-25 00:00:00	17032.2900000000009
447	OU516561	2004-12-17 00:00:00	26304.130000000001
448	FS299615	2005-04-18 00:00:00	27966.5400000000009
448	KR822727	2004-09-30 00:00:00	48809.9000000000015
450	EF485824	2004-06-21 00:00:00	59551.3799999999974
452	ED473873	2003-11-15 00:00:00	27121.9000000000015
452	FN640986	2003-11-20 00:00:00	15130.9699999999993
452	HG635467	2005-05-03 00:00:00	8807.1200000000008
455	HA777606	2003-12-05 00:00:00	38139.1800000000003
455	IR662429	2004-05-12 00:00:00	32239.4700000000012
456	GJ715659	2004-11-13 00:00:00	27550.5099999999984
456	MO743231	2004-04-30 00:00:00	1679.92000000000007
458	DD995006	2004-11-15 00:00:00	33145.5599999999977
458	NA377824	2004-02-06 00:00:00	22162.6100000000006
458	OO606861	2003-06-13 00:00:00	57131.9199999999983
462	ED203908	2005-04-15 00:00:00	30293.7700000000004
462	GC60330	2003-11-08 00:00:00	9977.85000000000036
462	PE176846	2004-11-27 00:00:00	48355.8700000000026
471	AB661578	2004-07-28 00:00:00	9415.1299999999992
471	CO645196	2003-12-10 00:00:00	35505.6299999999974
473	LL427009	2004-02-17 00:00:00	7612.0600000000004
473	PC688499	2003-10-27 00:00:00	17746.2599999999984
475	JP113227	2003-12-09 00:00:00	7678.25
475	PB951268	2004-02-13 00:00:00	36070.4700000000012
484	GK294076	2004-10-26 00:00:00	3474.65999999999985
484	JH546765	2003-11-29 00:00:00	47513.1900000000023
486	BL66528	2004-04-14 00:00:00	5899.38000000000011
486	HS86661	2004-11-23 00:00:00	45994.0699999999997
486	JB117768	2003-03-20 00:00:00	25833.1399999999994
487	AH612904	2003-09-28 00:00:00	29997.0900000000001
487	PT550181	2004-02-29 00:00:00	12573.2800000000007
489	OC773849	2003-12-04 00:00:00	22275.7299999999996
489	PO860906	2004-01-31 00:00:00	7310.42000000000007
495	BH167026	2003-12-26 00:00:00	59265.1399999999994
495	FN155234	2004-05-14 00:00:00	6276.60000000000036
496	EU531600	2005-05-25 00:00:00	30253.75
496	MB342426	2003-07-16 00:00:00	32077.4399999999987
496	MN89921	2004-12-31 00:00:00	52166
233	BOFA23232	2005-05-20 00:00:00	29070.380000000001
398	JPMR4544	2005-05-18 00:00:00	615.450000000000045
406	BJMPR4545	2005-04-23 00:00:00	12190.8500000000004
\.


--
-- Data for Name: productlines; Type: TABLE DATA; Schema: public; Owner: root
--

COPY productlines ("productLine", "textDescription", "htmlDescription", image) FROM stdin;
Vintage Cars	Our Vintage Car models realistically portray automobiles produced from the early 1900s through the 1940s. Materials used include Bakelite, diecast, plastic and wood. Most of the replicas are in the 1:18 and 1:24 scale sizes, which provide the optimum in detail and accuracy. Prices range from $30.00 up to $180.00 for some special limited edition replicas. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.	\N	\N
Ships	The perfect holiday or anniversary gift for executives, clients, friends, and family. These handcrafted model ships are unique, stunning works of art that will be treasured for generations! They come fully assembled and ready for display in the home or office. We guarantee the highest quality, and best value.	\N	\N
Trains	Model trains are a rewarding hobby for enthusiasts of all ages. Whether you're looking for collectible wooden trains, electric streetcars or locomotives, you'll find a number of great choices for any budget within this category. The interactive aspect of trains makes toy trains perfect for young children. The wooden train sets are ideal for children under the age of 5.	\N	\N
Planes	Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, office or classroom decorations. Models contain stunning details such as official logos and insignias, rotating jet engines and propellers, retractable wheels, and so on. Most come fully assembled and with a certificate of authenticity from their manufacturers.	\N	\N
Motorcycles	Our motorcycles are state of the art replicas of classic as well as contemporary motorcycle legends such as Harley Davidson, Ducati and Vespa. Models contain stunning details such as official logos, rotating wheels, working kickstand, front suspension, gear-shift lever, footbrake lever, and drive chain. Materials used include diecast and plastic. The models range in size from 1:10 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. All models come fully assembled and ready for display in the home or office. Most include a certificate of authenticity.	\N	\N
Classic Cars	Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category. These replicas feature superb attention to detail and craftsmanship and offer features such as working steering system, opening forward compartment, opening rear trunk with removable spare wheel, 4-wheel independent spring suspension, and so on. The models range in size from 1:10 to 1:24 scale and include numerous limited edition and several out-of-production vehicles. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.	\N	\N
Trucks and Buses	The Truck and Bus models are realistic replicas of buses and specialized trucks produced from the early 1920s to present. The models range in size from 1:12 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. Materials used include tin, diecast and plastic. All models include a certificate of authenticity from their manufacturers and are a perfect ornament for the home and office.	\N	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: root
--

COPY products ("productCode", "productName", "productLine", "productScale", "productVendor", "productDescription", "quantityInStock", "buyPrice", "MSRP") FROM stdin;
S10_1678	1969 Harley Davidson Ultimate Chopper	Motorcycles	1:10	Min Lin Diecast	This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.	7933	48.8100000000000023	95.7000000000000028
S10_1949	1952 Alpine Renault 1300	Classic Cars	1:10	Classic Metal Creations	Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.	7305	98.5799999999999983	214.300000000000011
S10_2016	1996 Moto Guzzi 1100i	Motorcycles	1:10	Highway 66 Mini Classics	Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.	6625	68.9899999999999949	118.939999999999998
S10_4698	2003 Harley-Davidson Eagle Drag Bike	Motorcycles	1:10	Red Start Diecast	Model features, official Harley Davidson logos and insignias, detachable rear wheelie bar, heavy diecast metal with resin parts, authentic multi-color tampo-printed graphics, separate engine drive belts, free-turning front fork, rotating tires and rear racing slick, certificate of authenticity, detailed engine, display stand\r\n, precision diecast replica, baked enamel finish, 1:10 scale model, removable fender, seat and tank cover piece for displaying the superior detail of the v-twin engine	5582	91.019999999999996	193.659999999999997
S10_4757	1972 Alfa Romeo GTA	Classic Cars	1:10	Motor City Art Classics	Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.	3252	85.6800000000000068	136
S10_4962	1962 LanciaA Delta 16V	Classic Cars	1:10	Second Gear Diecast	Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.	6791	103.420000000000002	147.740000000000009
S12_1099	1968 Ford Mustang	Classic Cars	1:12	Autoart Studio Design	Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color dark green.	68	95.3400000000000034	194.569999999999993
S12_1108	2001 Ferrari Enzo	Classic Cars	1:12	Second Gear Diecast	Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.	3619	95.5900000000000034	207.800000000000011
S12_1666	1958 Setra Bus	Trucks and Buses	1:12	Welly Diecast Productions	Model features 30 windows, skylights & glare resistant glass, working steering system, original logos	1579	77.9000000000000057	136.669999999999987
S12_2823	2002 Suzuki XREO	Motorcycles	1:12	Unimax Art Galleries	Official logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.	9997	66.269999999999996	150.620000000000005
S12_3148	1969 Corvair Monza	Classic Cars	1:18	Welly Diecast Productions	1:18 scale die-cast about 10" long doors open, hood opens, trunk opens and wheels roll	6906	89.1400000000000006	151.080000000000013
S12_3380	1968 Dodge Charger	Classic Cars	1:12	Welly Diecast Productions	1:12 scale model of a 1968 Dodge Charger. Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color black	9123	75.1599999999999966	117.439999999999998
S12_3891	1969 Ford Falcon	Classic Cars	1:12	Second Gear Diecast	Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.	1049	83.0499999999999972	173.02000000000001
S12_3990	1970 Plymouth Hemi Cuda	Classic Cars	1:12	Studio M Art Models	Very detailed 1970 Plymouth Cuda model in 1:12 scale. The Cuda is generally accepted as one of the fastest original muscle cars from the 1970s. This model is a reproduction of one of the orginal 652 cars built in 1970. Red color.	5663	31.9200000000000017	79.7999999999999972
S12_4473	1957 Chevy Pickup	Trucks and Buses	1:12	Exoto Designs	1:12 scale die-cast about 20" long Hood opens, Rubber wheels	6125	55.7000000000000028	118.5
S12_4675	1969 Dodge Charger	Classic Cars	1:12	Welly Diecast Productions	Detailed model of the 1969 Dodge Charger. This model includes finely detailed interior and exterior features. Painted in red and white.	7323	58.7299999999999969	115.159999999999997
S18_1097	1940 Ford Pickup Truck	Trucks and Buses	1:18	Studio M Art Models	This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood,  removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box	2613	58.3299999999999983	116.670000000000002
S18_1129	1993 Mazda RX-7	Classic Cars	1:18	Highway 66 Mini Classics	This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color red.	3975	83.5100000000000051	141.539999999999992
S18_1342	1937 Lincoln Berline	Vintage Cars	1:18	Motor City Art Classics	Features opening engine cover, doors, trunk, and fuel filler cap. Color black	8693	60.6199999999999974	102.739999999999995
S18_1367	1936 Mercedes-Benz 500K Special Roadster	Vintage Cars	1:18	Studio M Art Models	This 1:18 scale replica is constructed of heavy die-cast metal and has all the features of the original: working doors and rumble seat, independent spring suspension, detailed interior, working steering system, and a bifold hood that reveals an engine so accurate that it even includes the wiring. All this is topped off with a baked enamel finish. Color white.	8635	24.2600000000000016	53.9099999999999966
S18_1589	1965 Aston Martin DB5	Classic Cars	1:18	Classic Metal Creations	Die-cast model of the silver 1965 Aston Martin DB5 in silver. This model includes full wire wheels and doors that open with fully detailed passenger compartment. In 1:18 scale, this model measures approximately 10 inches/20 cm long.	9042	65.9599999999999937	124.439999999999998
S18_1662	1980s Black Hawk Helicopter	Planes	1:18	Red Start Diecast	1:18 scale replica of actual Army's UH-60L BLACK HAWK Helicopter. 100% hand-assembled. Features rotating rotor blades, propeller blades and rubber wheels.	5330	77.269999999999996	157.689999999999998
S18_1749	1917 Grand Touring Sedan	Vintage Cars	1:18	Welly Diecast Productions	This 1:18 scale replica of the 1917 Grand Touring car has all the features you would expect from museum quality reproductions: all four doors and bi-fold hood opening, detailed engine and instrument panel, chrome-look trim, and tufted upholstery, all topped off with a factory baked-enamel finish.	2724	86.7000000000000028	170
S18_1889	1948 Porsche 356-A Roadster	Classic Cars	1:18	Gearbox Collectibles	This precision die-cast replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.	8826	53.8999999999999986	77
S72_1253	Boeing X-32A JSF	Planes	1:72	Motor City Art Classics	10" Wingspan with retractable landing gears.Comes with pilot	4857	32.7700000000000031	49.6599999999999966
S18_1984	1995 Honda Civic	Classic Cars	1:18	Min Lin Diecast	This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color yellow.	9772	93.8900000000000006	142.25
S18_2238	1998 Chrysler Plymouth Prowler	Classic Cars	1:18	Gearbox Collectibles	Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.	4724	101.510000000000005	163.72999999999999
S18_2248	1911 Ford Town Car	Vintage Cars	1:18	Motor City Art Classics	Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system.	540	33.2999999999999972	60.5399999999999991
S18_2319	1964 Mercedes Tour Bus	Trucks and Buses	1:18	Unimax Art Galleries	Exact replica. 100+ parts. working steering system, original logos	8258	74.8599999999999994	122.730000000000004
S18_2325	1932 Model A Ford J-Coupe	Vintage Cars	1:18	Autoart Studio Design	This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system, chrome-covered spare, opening doors, detailed and wired engine	9354	58.4799999999999969	127.129999999999995
S18_2432	1926 Ford Fire Engine	Trucks and Buses	1:18	Carousel DieCast Legends	Gleaming red handsome appearance. Everything is here the fire hoses, ladder, axes, bells, lanterns, ready to fight any inferno.	2018	24.9200000000000017	60.7700000000000031
S18_2581	P-51-D Mustang	Planes	1:72	Gearbox Collectibles	Has retractable wheels and comes with a stand	992	49	84.480000000000004
S18_2625	1936 Harley Davidson El Knucklehead	Motorcycles	1:18	Welly Diecast Productions	Intricately detailed with chrome accents and trim, official die-struck logos and baked enamel finish.	4357	24.2300000000000004	60.5700000000000003
S18_2795	1928 Mercedes-Benz SSK	Vintage Cars	1:18	Gearbox Collectibles	This 1:18 replica features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system, chrome-covered spare, opening doors, detailed and wired engine. Color black.	548	72.5600000000000023	168.75
S18_2870	1999 Indy 500 Monte Carlo SS	Classic Cars	1:18	Red Start Diecast	Features include opening and closing doors. Color: Red	8164	56.759999999999998	132
S18_2949	1913 Ford Model T Speedster	Vintage Cars	1:18	Carousel DieCast Legends	This 250 part reproduction includes moving handbrakes, clutch, throttle and foot pedals, squeezable horn, detailed wired engine, removable water, gas, and oil cans, pivoting monocle windshield, all topped with a baked enamel red finish. Each replica comes with an Owners Title and Certificate of Authenticity. Color red.	4189	60.7800000000000011	101.310000000000002
S18_2957	1934 Ford V8 Coupe	Vintage Cars	1:18	Min Lin Diecast	Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System	5649	34.3500000000000014	62.4600000000000009
S18_3029	1999 Yamaha Speed Boat	Ships	1:18	Min Lin Diecast	Exact replica. Wood and Metal. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.	4259	51.6099999999999994	86.019999999999996
S18_3136	18th Century Vintage Horse Carriage	Vintage Cars	1:18	Red Start Diecast	Hand crafted diecast-like metal horse carriage is re-created in about 1:18 scale of antique horse carriage. This antique style metal Stagecoach is all hand-assembled with many different parts.\r\n\r\nThis collectible metal horse carriage is painted in classic Red, and features turning steering wheel and is entirely hand-finished.	5992	60.740000000000002	104.719999999999999
S18_3140	1903 Ford Model A	Vintage Cars	1:18	Unimax Art Galleries	Features opening trunk,  working steering system	3913	68.2999999999999972	136.590000000000003
S18_3232	1992 Ferrari 360 Spider red	Classic Cars	1:18	Unimax Art Galleries	his replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.	8347	77.9000000000000057	169.340000000000003
S18_3233	1985 Toyota Supra	Classic Cars	1:18	Highway 66 Mini Classics	This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood, removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box	7733	57.009999999999998	107.569999999999993
S18_3259	Collectable Wooden Train	Trains	1:18	Carousel DieCast Legends	Hand crafted wooden toy train set is in about 1:18 scale, 25 inches in total length including 2 additional carts, of actual vintage train. This antique style wooden toy train model set is all hand-assembled with 100% wood.	6450	67.5600000000000023	100.840000000000003
S18_3278	1969 Dodge Super Bee	Classic Cars	1:18	Min Lin Diecast	This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.	1917	49.0499999999999972	80.4099999999999966
S18_3320	1917 Maxwell Touring Car	Vintage Cars	1:18	Exoto Designs	Features Gold Trim, Full Size Spare Tire, Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System	7913	57.5399999999999991	99.2099999999999937
S18_3482	1976 Ford Gran Torino	Classic Cars	1:18	Gearbox Collectibles	Highly detailed 1976 Ford Gran Torino "Starsky and Hutch" diecast model. Very well constructed and painted in red and white patterns.	9127	73.4899999999999949	146.990000000000009
S18_3685	1948 Porsche Type 356 Roadster	Classic Cars	1:18	Gearbox Collectibles	This model features working front and rear suspension on accurately replicated and actuating shock absorbers as well as opening engine cover, rear stabilizer flap,  and 4 opening doors.	8990	62.1599999999999966	141.280000000000001
S18_3782	1957 Vespa GS150	Motorcycles	1:18	Studio M Art Models	Features rotating wheels , working kick stand. Comes with stand.	7689	32.9500000000000028	62.1700000000000017
S18_3856	1941 Chevrolet Special Deluxe Cabriolet	Vintage Cars	1:18	Exoto Designs	Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system, leather upholstery. Color black.	2378	64.5799999999999983	105.870000000000005
S18_4027	1970 Triumph Spitfire	Classic Cars	1:18	Min Lin Diecast	Features include opening and closing doors. Color: White.	5545	91.9200000000000017	143.620000000000005
S18_4409	1932 Alfa Romeo 8C2300 Spider Sport	Vintage Cars	1:18	Exoto Designs	This 1:18 scale precision die cast replica features the 6 front headlights of the original, plus a detailed version of the 142 horsepower straight 8 engine, dual spares and their famous comprehensive dashboard. Color black.	6553	43.259999999999998	92.0300000000000011
S18_4522	1904 Buick Runabout	Vintage Cars	1:18	Exoto Designs	Features opening trunk,  working steering system	8290	52.6599999999999966	87.769999999999996
S18_4600	1940s Ford truck	Trucks and Buses	1:18	Motor City Art Classics	This 1940s Ford Pick-Up truck is re-created in 1:18 scale of original 1940s Ford truck. This antique style metal 1940s Ford Flatbed truck is all hand-assembled. This collectible 1940's Pick-Up truck is painted in classic dark green color, and features rotating wheels.	3128	84.7600000000000051	121.079999999999998
S18_4668	1939 Cadillac Limousine	Vintage Cars	1:18	Studio M Art Models	Features completely detailed interior including Velvet flocked drapes,deluxe wood grain floor, and a wood grain casket with seperate chrome handles	6645	23.1400000000000006	50.3100000000000023
S18_4721	1957 Corvette Convertible	Classic Cars	1:18	Classic Metal Creations	1957 die cast Corvette Convertible in Roman Red with white sides and whitewall tires. 1:18 scale quality die-cast with detailed engine and underbvody. Now you can own The Classic Corvette.	1249	69.9300000000000068	148.800000000000011
S18_4933	1957 Ford Thunderbird	Classic Cars	1:18	Studio M Art Models	This 1:18 scale precision die-cast replica, with its optional porthole hardtop and factory baked-enamel Thunderbird Bronze finish, is a 100% accurate rendition of this American classic.	3209	34.2100000000000009	71.269999999999996
S24_1046	1970 Chevy Chevelle SS 454	Classic Cars	1:24	Unimax Art Galleries	This model features rotating wheels, working streering system and opening doors. All parts are particularly delicate due to their precise scale and require special care and attention. It should not be picked up by the doors, roof, hood or trunk.	1005	49.240000000000002	73.4899999999999949
S24_1444	1970 Dodge Coronet	Classic Cars	1:24	Highway 66 Mini Classics	1:24 scale die-cast about 18" long doors open, hood opens and rubber wheels	4074	32.3699999999999974	57.7999999999999972
S24_1578	1997 BMW R 1100 S	Motorcycles	1:24	Autoart Studio Design	Detailed scale replica with working suspension and constructed from over 70 parts	7003	60.8599999999999994	112.700000000000003
S24_1628	1966 Shelby Cobra 427 S/C	Classic Cars	1:24	Carousel DieCast Legends	This diecast model of the 1966 Shelby Cobra 427 S/C includes many authentic details and operating parts. The 1:24 scale model of this iconic lighweight sports car from the 1960s comes in silver and it's own display case.	8197	29.1799999999999997	50.3100000000000023
S24_1785	1928 British Royal Navy Airplane	Planes	1:24	Classic Metal Creations	Official logos and insignias	3627	66.7399999999999949	109.420000000000002
S24_1937	1939 Chevrolet Deluxe Coupe	Vintage Cars	1:24	Motor City Art Classics	This 1:24 scale die-cast replica of the 1939 Chevrolet Deluxe Coupe has the same classy look as the original. Features opening trunk, hood and doors and a showroom quality baked enamel finish.	7332	22.5700000000000003	33.1899999999999977
S24_2000	1960 BSA Gold Star DBD34	Motorcycles	1:24	Highway 66 Mini Classics	Detailed scale replica with working suspension and constructed from over 70 parts	15	37.3200000000000003	76.1700000000000017
S24_2011	18th century schooner	Ships	1:24	Carousel DieCast Legends	All wood with canvas sails. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with 4 masts, all square-rigged.	1898	82.3400000000000034	122.890000000000001
S24_2022	1938 Cadillac V-16 Presidential Limousine	Vintage Cars	1:24	Classic Metal Creations	This 1:24 scale precision die cast replica of the 1938 Cadillac V-16 Presidential Limousine has all the details of the original, from the flags on the front to an opening back seat compartment complete with telephone and rifle. Features factory baked-enamel black finish, hood goddess ornament, working jump seats.	2847	20.6099999999999994	44.7999999999999972
S24_2300	1962 Volkswagen Microbus	Trucks and Buses	1:24	Autoart Studio Design	This 1:18 scale die cast replica of the 1962 Microbus is loaded with features: A working steering system, opening front doors and tailgate, and famous two-tone factory baked enamel finish, are all topped of by the sliding, real fabric, sunroof.	2327	61.3400000000000034	127.790000000000006
S24_2360	1982 Ducati 900 Monster	Motorcycles	1:24	Highway 66 Mini Classics	Features two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand	6840	47.1000000000000014	69.2600000000000051
S24_2766	1949 Jaguar XK 120	Classic Cars	1:24	Classic Metal Creations	Precision-engineered from original Jaguar specification in perfect scale ratio. Features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.	2350	47.25	90.8700000000000045
S24_2840	1958 Chevy Corvette Limited Edition	Classic Cars	1:24	Carousel DieCast Legends	The operating parts of this 1958 Chevy Corvette Limited Edition are particularly delicate due to their precise scale and require special care and attention. Features rotating wheels, working streering, opening doors and trunk. Color dark green.	2542	15.9100000000000001	35.3599999999999994
S24_2841	1900s Vintage Bi-Plane	Planes	1:24	Autoart Studio Design	Hand crafted diecast-like metal bi-plane is re-created in about 1:24 scale of antique pioneer airplane. All hand-assembled with many different parts. Hand-painted in classic yellow and features correct markings of original airplane.	5942	34.25	68.5100000000000051
S24_2887	1952 Citroen-15CV	Classic Cars	1:24	Exoto Designs	Precision crafted hand-assembled 1:18 scale reproduction of the 1952 15CV, with its independent spring suspension, working steering system, opening doors and hood, detailed engine and instrument panel, all topped of with a factory fresh baked enamel finish.	1452	72.8199999999999932	117.439999999999998
S24_2972	1982 Lamborghini Diablo	Classic Cars	1:24	Second Gear Diecast	This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.	7723	16.2399999999999984	37.759999999999998
S24_3151	1912 Ford Model T Delivery Wagon	Vintage Cars	1:24	Min Lin Diecast	This model features chrome trim and grille, opening hood, opening doors, opening trunk, detailed engine, working steering system. Color white.	9173	46.9099999999999966	88.5100000000000051
S24_3191	1969 Chevrolet Camaro Z28	Classic Cars	1:24	Exoto Designs	1969 Z/28 Chevy Camaro 1:24 scale replica. The operating parts of this limited edition 1:24 scale diecast model car 1969 Chevy Camaro Z28- hood, trunk, wheels, streering, suspension and doors- are particularly delicate due to their precise scale and require special care and attention.	4695	50.509999999999998	85.6099999999999994
S24_3371	1971 Alpine Renault 1600s	Classic Cars	1:24	Welly Diecast Productions	This 1971 Alpine Renault 1600s replica Features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.	7995	38.5799999999999983	61.2299999999999969
S24_3420	1937 Horch 930V Limousine	Vintage Cars	1:24	Autoart Studio Design	Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system	2902	26.3000000000000007	65.75
S24_3432	2002 Chevy Corvette	Classic Cars	1:24	Gearbox Collectibles	The operating parts of this limited edition Diecast 2002 Chevy Corvette 50th Anniversary Pace car Limited Edition are particularly delicate due to their precise scale and require special care and attention. Features rotating wheels, poseable streering, opening doors and trunk.	9446	62.1099999999999994	107.079999999999998
S24_3816	1940 Ford Delivery Sedan	Vintage Cars	1:24	Carousel DieCast Legends	Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System. Color black.	6621	48.6400000000000006	83.8599999999999994
S24_3856	1956 Porsche 356A Coupe	Classic Cars	1:18	Classic Metal Creations	Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.	6600	98.2999999999999972	140.430000000000007
S24_3949	Corsair F4U ( Bird Cage)	Planes	1:24	Second Gear Diecast	Has retractable wheels and comes with a stand. Official logos and insignias.	6812	29.3399999999999999	68.2399999999999949
S24_3969	1936 Mercedes Benz 500k Roadster	Vintage Cars	1:24	Red Start Diecast	This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system and rubber wheels. Color black.	2081	21.75	41.0300000000000011
S24_4048	1992 Porsche Cayenne Turbo Silver	Classic Cars	1:24	Exoto Designs	This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.	6582	69.7800000000000011	118.280000000000001
S24_4258	1936 Chrysler Airflow	Vintage Cars	1:24	Second Gear Diecast	Features opening trunk,  working steering system. Color dark green.	4710	57.4600000000000009	97.3900000000000006
S24_4278	1900s Vintage Tri-Plane	Planes	1:24	Unimax Art Galleries	Hand crafted diecast-like metal Triplane is Re-created in about 1:24 scale of antique pioneer airplane. This antique style metal triplane is all hand-assembled with many different parts.	2756	36.2299999999999969	72.4500000000000028
S24_4620	1961 Chevrolet Impala	Classic Cars	1:18	Classic Metal Creations	This 1:18 scale precision die-cast reproduction of the 1961 Chevrolet Impala has all the features-doors, hood and trunk that open; detailed 409 cubic-inch engine; chrome dashboard and stick shift, two-tone interior; working steering system; all topped of with a factory baked-enamel finish.	7869	32.3299999999999983	80.8400000000000034
S32_1268	1980â€™s GM Manhattan Express	Trucks and Buses	1:32	Motor City Art Classics	This 1980â€™s era new look Manhattan express is still active, running from the Bronx to mid-town Manhattan. Has 35 opeining windows and working lights. Needs a battery.	5099	53.9299999999999997	96.3100000000000023
S32_1374	1997 BMW F650 ST	Motorcycles	1:32	Exoto Designs	Features official die-struck logos and baked enamel finish. Comes with stand.	178	66.9200000000000017	99.8900000000000006
S32_2206	1982 Ducati 996 R	Motorcycles	1:32	Gearbox Collectibles	Features rotating wheels , working kick stand. Comes with stand.	9241	24.1400000000000006	40.2299999999999969
S32_2509	1954 Greyhound Scenicruiser	Trucks and Buses	1:32	Classic Metal Creations	Model features bi-level seating, 50 windows, skylights & glare resistant glass, working steering system, original logos	2874	25.9800000000000004	54.1099999999999994
S32_3207	1950's Chicago Surface Lines Streetcar	Trains	1:32	Gearbox Collectibles	This streetcar is a joy to see. It has 80 separate windows, electric wire guides, detailed interiors with seats, poles and drivers controls, rolling and turning wheel assemblies, plus authentic factory baked-enamel finishes (Green Hornet for Chicago and Cream and Crimson for Boston).	8601	26.7199999999999989	62.1400000000000006
S32_3522	1996 Peterbilt 379 Stake Bed with Outrigger	Trucks and Buses	1:32	Red Start Diecast	This model features, opening doors, detailed engine, working steering, tinted windows, detailed interior, die-struck logos, removable stakes operating outriggers, detachable second trailer, functioning 360-degree self loader, precision molded resin trailer and trim, baked enamel finish on cab	814	33.6099999999999994	64.6400000000000006
S32_4289	1928 Ford Phaeton Deluxe	Vintage Cars	1:32	Highway 66 Mini Classics	This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system	136	33.0200000000000031	68.7900000000000063
S32_4485	1974 Ducati 350 Mk3 Desmo	Motorcycles	1:32	Second Gear Diecast	This model features two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand	3341	56.1300000000000026	102.049999999999997
S50_1341	1930 Buick Marquette Phaeton	Vintage Cars	1:50	Studio M Art Models	Features opening trunk,  working steering system	7062	27.0599999999999987	43.6400000000000006
S50_1392	Diamond T620 Semi-Skirted Tanker	Trucks and Buses	1:50	Highway 66 Mini Classics	This limited edition model is licensed and perfectly scaled for Lionel Trains. The Diamond T620 has been produced in solid precision diecast and painted with a fire baked enamel finish. It comes with a removable tanker and is a perfect model to add authenticity to your static train or car layout or to just have on display.	1016	68.2900000000000063	115.75
S50_1514	1962 City of Detroit Streetcar	Trains	1:50	Classic Metal Creations	This streetcar is a joy to see. It has 99 separate windows, electric wire guides, detailed interiors with seats, poles and drivers controls, rolling and turning wheel assemblies, plus authentic factory baked-enamel finishes (Green Hornet for Chicago and Cream and Crimson for Boston).	1645	37.490000000000002	58.5799999999999983
S50_4713	2002 Yamaha YZR M1	Motorcycles	1:50	Autoart Studio Design	Features rotating wheels , working kick stand. Comes with stand.	600	34.1700000000000017	81.3599999999999994
S700_1138	The Schooner Bluenose	Ships	1:700	Autoart Studio Design	All wood with canvas sails. Measures 31 1/2 inches in Length, 22 inches High and 4 3/4 inches Wide. Many extras.\r\nThe schooner Bluenose was built in Nova Scotia in 1921 to fish the rough waters off the coast of Newfoundland. Because of the Bluenose racing prowess she became the pride of all Canadians. Still featured on stamps and the Canadian dime, the Bluenose was lost off Haiti in 1946.	1897	34	66.6700000000000017
S700_1691	American Airlines: B767-300	Planes	1:700	Min Lin Diecast	Exact replia with official logos and insignias and retractable wheels	5841	51.1499999999999986	91.3400000000000034
S700_1938	The Mayflower	Ships	1:700	Studio M Art Models	Measures 31 1/2 inches Long x 25 1/2 inches High x 10 5/8 inches Wide\r\nAll wood with canvas sail. Extras include long boats, rigging, ladders, railing, anchors, side cannons, hand painted, etc.	737	43.2999999999999972	86.6099999999999994
S700_2047	HMS Bounty	Ships	1:700	Unimax Art Galleries	Measures 30 inches Long x 27 1/2 inches High x 4 3/4 inches Wide. \r\nMany extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.	3501	39.8299999999999983	90.519999999999996
S700_2466	America West Airlines B757-200	Planes	1:700	Motor City Art Classics	Official logos and insignias. Working steering system. Rotating jet engines	9653	68.7999999999999972	99.7199999999999989
S700_2610	The USS Constitution Ship	Ships	1:700	Red Start Diecast	All wood with canvas sails. Measures 31 1/2" Length x 22 3/8" High x 8 1/4" Width. Extras include 4 boats on deck, sea sprite on bow, anchors, copper railing, pilot houses, etc.	7083	33.9699999999999989	72.2800000000000011
S700_2824	1982 Camaro Z28	Classic Cars	1:18	Carousel DieCast Legends	Features include opening and closing doors. Color: White. \r\nMeasures approximately 9 1/2" Long.	6934	46.5300000000000011	101.150000000000006
S700_2834	ATA: B757-300	Planes	1:700	Highway 66 Mini Classics	Exact replia with official logos and insignias and retractable wheels	7106	59.3299999999999983	118.650000000000006
S700_3167	F/A 18 Hornet 1/72	Planes	1:72	Motor City Art Classics	10" Wingspan with retractable landing gears.Comes with pilot	551	54.3999999999999986	80
S700_3505	The Titanic	Ships	1:700	Carousel DieCast Legends	Completed model measures 19 1/2 inches long, 9 inches high, 3inches wide and is in barn red/black. All wood and metal.	1956	51.0900000000000034	100.170000000000002
S700_3962	The Queen Mary	Ships	1:700	Welly Diecast Productions	Exact replica. Wood and Metal. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.	5088	53.6300000000000026	99.3100000000000023
S700_4002	American Airlines: MD-11S	Planes	1:700	Second Gear Diecast	Polished finish. Exact replia with official logos and insignias and retractable wheels	8820	36.2700000000000031	74.0300000000000011
S72_3212	Pont Yacht	Ships	1:72	Unimax Art Galleries	Measures 38 inches Long x 33 3/4 inches High. Includes a stand.\r\nMany extras including rigging, long boats, pilot house, anchors, etc. Comes with 2 masts, all square-rigged	414	33.2999999999999972	54.6000000000000014
\.


--
-- Name: actor_actor_id_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY actor
    ADD CONSTRAINT actor_actor_id_pkey PRIMARY KEY (actor_id);


--
-- Name: category_category_id_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_category_id_pkey PRIMARY KEY (category_id);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY ("customerNumber");


--
-- Name: employees_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY ("employeeNumber");


--
-- Name: film_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY film
    ADD CONSTRAINT film_pkey PRIMARY KEY (film_id);


--
-- Name: offices_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY offices
    ADD CONSTRAINT offices_pkey PRIMARY KEY ("officeCode");


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY ("orderNumber");


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY ("productCode");


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

