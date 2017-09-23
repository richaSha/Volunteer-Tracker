--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: richa
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE projects OWNER TO richa;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: richa
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projects_id_seq OWNER TO richa;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: richa
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: richa
--

CREATE TABLE volunteers (
    id integer NOT NULL,
    name character varying,
    project_id integer,
    hour character varying
);


ALTER TABLE volunteers OWNER TO richa;

--
-- Name: volunteers_id_seq; Type: SEQUENCE; Schema: public; Owner: richa
--

CREATE SEQUENCE volunteers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE volunteers_id_seq OWNER TO richa;

--
-- Name: volunteers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: richa
--

ALTER SEQUENCE volunteers_id_seq OWNED BY volunteers.id;


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: richa
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: volunteers id; Type: DEFAULT; Schema: public; Owner: richa
--

ALTER TABLE ONLY volunteers ALTER COLUMN id SET DEFAULT nextval('volunteers_id_seq'::regclass);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: richa
--

COPY projects (id, name) FROM stdin;
1	Alexa
3	Optus
6	Videocon
2	Enact
4	Enyo
8	E-Commerce
9	Reliance
12	Verizon
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: richa
--

SELECT pg_catalog.setval('projects_id_seq', 12, true);


--
-- Data for Name: volunteers; Type: TABLE DATA; Schema: public; Owner: richa
--

COPY volunteers (id, name, project_id, hour) FROM stdin;
7	Pinky	3	11
15	Rekha	0	25
1	Richa	6	23
23	Rimjhim	1	14
8	Ritu	0	21
24	Mac	0	0
25	Sneha	0	0
26	John	0	0
27	Stuti	0	0
4	Nikki	2	29
5	Sweety	2	30
9	Kushboo	4	15
28	Abrahim	0	0
29	Genellia	0	0
30	Richie	0	0
13	Sheema	12	0
\.


--
-- Name: volunteers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: richa
--

SELECT pg_catalog.setval('volunteers_id_seq', 30, true);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: richa
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: projects unique_name; Type: CONSTRAINT; Schema: public; Owner: richa
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT unique_name UNIQUE (name);


--
-- Name: volunteers volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: richa
--

ALTER TABLE ONLY volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

