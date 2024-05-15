--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2024-05-15 09:29:55

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16425)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    id_post bigint NOT NULL,
    id_user bigint NOT NULL,
    date date DEFAULT now() NOT NULL
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16429)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO postgres;

--
-- TOC entry 4330 (class 0 OID 0)
-- Dependencies: 216
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- TOC entry 217 (class 1259 OID 16430)
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    id integer NOT NULL,
    id_post bigint NOT NULL,
    img_link character varying NOT NULL
);


ALTER TABLE public.images OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16435)
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.images_id_seq OWNER TO postgres;

--
-- TOC entry 4331 (class 0 OID 0)
-- Dependencies: 218
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;


--
-- TOC entry 219 (class 1259 OID 16441)
-- Name: profil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profil (
    id integer NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    mail character varying NOT NULL,
    password character varying NOT NULL,
    pseudo character varying NOT NULL,
    admin boolean DEFAULT false NOT NULL
);


ALTER TABLE public.profil OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16446)
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.person_id_seq OWNER TO postgres;

--
-- TOC entry 4332 (class 0 OID 0)
-- Dependencies: 220
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_id_seq OWNED BY public.profil.id;


--
-- TOC entry 221 (class 1259 OID 16447)
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    id_profil bigint NOT NULL,
    title character varying NOT NULL,
    content character varying NOT NULL,
    created_date date DEFAULT now() NOT NULL,
    modified_date date,
    tags character varying NOT NULL
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16453)
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO postgres;

--
-- TOC entry 4333 (class 0 OID 0)
-- Dependencies: 222
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- TOC entry 4155 (class 2604 OID 16460)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 4157 (class 2604 OID 16461)
-- Name: images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);


--
-- TOC entry 4160 (class 2604 OID 16462)
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- TOC entry 4158 (class 2604 OID 16463)
-- Name: profil id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profil ALTER COLUMN id SET DEFAULT nextval('public.person_id_seq'::regclass);


--
-- TOC entry 4317 (class 0 OID 16425)
-- Dependencies: 215
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, id_post, id_user, date) FROM stdin;
\.


--
-- TOC entry 4319 (class 0 OID 16430)
-- Dependencies: 217
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (id, id_post, img_link) FROM stdin;
162	333	https://imageblognico.s3.eu-west-3.amazonaws.com/image_post_333
163	334	https://imageblognico.s3.eu-west-3.amazonaws.com/image_post_334
164	335	https://imageblognico.s3.eu-west-3.amazonaws.com/image_post_335
165	336	https://imageblognico.s3.eu-west-3.amazonaws.com/image_post_336
220	391	https://imageblognico.s3.eu-west-3.amazonaws.com/image_post_391
222	393	https://imageblognico.s3.eu-west-3.amazonaws.com/image_post_393
\.


--
-- TOC entry 4323 (class 0 OID 16447)
-- Dependencies: 221
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, id_profil, title, content, created_date, modified_date, tags) FROM stdin;
333	35	Simplifying Vue.js with Rest and Spread Operators	Take Your Vue.js Skills to the Next Level with These Powerful Techniques\r\n\r\nAs a Vue.js developer, you’re probably always on the lookout for ways to write cleaner, more concise code. Enter the rest and spread operators — two powerful features of modern JavaScript that can help you streamline your Vue.js applications. In this article, we’ll explore what these operators are and how you can leverage them in your Vue.js projects.\r\n\r\nWhat are Rest and Spread Operators?\r\nThe rest operator (...) allows you to collect the remaining elements of an array or object into a new array or object. Here's an example:\r\n\r\nconst [first, ...rest] = [1, 2, 3, 4, 5];\r\nconsole.log(first); // Output: 1\r\nconsole.log(rest); // Output: [2, 3, 4, 5]\r\nThe spread operator (...) does the opposite – it unpacks the elements of an array or object into individual elements. Here's an example:\r\n\r\nconst numbers = [1, 2, 3];\r\nconst moreNumbers = [...numbers, 4, 5];\r\nconsole.log(moreNumbers); // Output: [1, 2, 3, 4, 5]\r\nUsing Rest and Spread Operators in Vue.js\r\nNow that we understand what rest and spread operators are, let’s see how we can use…\r\n\r\n	2024-05-06	\N	tech
334	35	Santé: Le Guide Complet Pour une Vie Équilibrée et Saine	La santé est un aspect essentiel de nos vies, mais parfois, elle peut sembler mystérieuse et complexe. Qu'est-ce que réellement la santé, et comment pouvons-nous la préserver de manière optimale ? Dans cet article, nous allons explorer les différentes facettes de la santé, des façons de la maintenir, et des avantages d'une vie saine.\r\n\r\nQu'est-ce que la Santé ?\r\nLa santé ne se limite pas seulement à l'absence de maladie. C'est un état de bien-être complet, tant physique que mental et social. Avoir une bonne santé signifie se sentir énergique, avoir un esprit clair, et entretenir des relations positives avec les autres. C'est un équilibre délicat que nous devons cultiver chaque jour.\r\n\r\nLes Piliers de la Santé\r\nPour maintenir et améliorer notre santé, il est essentiel de se concentrer sur les piliers fondamentaux : une alimentation équilibrée, une activité physique régulière, un sommeil de qualité et une gestion du stress efficace. En combinant ces différents éléments, nous pouvons renforcer notre système immunitaire, augmenter notre vitalité et réduire les risques de maladies chroniques.\r\n\r\nL'Importance de la Prévention\r\nPrévenir vaut mieux que guérir. En adoptant un mode de vie sain et en suivant des routines de prévention, nous pouvons éviter de nombreux problèmes de santé à long terme. Des examens médicaux réguliers, une hygiène de vie adéquate et des habitudes de vie saines peuvent faire toute la différence pour notre bien-être général.\r\n\r\nLes Bienfaits d'une Vie Saine\r\nVivre de manière saine ne se résume pas seulement à éviter les maladies. Cela signifie aussi profiter d'une meilleure qualité de vie, avoir plus d'énergie pour réaliser nos objectifs, et découvrir un sentiment de bien-être profond. En investissant dans notre santé dès maintenant, nous semons les graines d'un avenir plus radieux et épanouissant.\r\n\r\nEn conclusion, la santé est un trésor précieux que nous devons chérir et protéger. En prenant soin de nous-mêmes, en adoptant des habitudes de vie saines, et en restant conscients de nos besoins physiques et émotionnels, nous pouvons cultiver une santé optimale pour profiter pleinement de la vie. N'oublions jamais que notre bien-être est notre responsabilité la plus précieuse.	2024-05-06	\N	sante
335	35	L'Impact de la Politique Moderne sur la Société Contemporaine	Introduction\r\nLa politique est un sujet complexe qui exerce une influence profonde sur la société. Dans cet article, nous explorerons l'impact de la politique moderne sur la vie quotidienne des citoyens.\r\n\r\nLa Politique et la Vie Quotidienne\r\nLa politique moderne affecte de nombreux aspects de la vie quotidienne, de la gestion des ressources publiques à la réglementation des activités économiques. Les décisions politiques influent sur la qualité de l'éducation, les soins de santé disponibles et même la sécurité des communautés. En comprenant mieux la politique, les citoyens peuvent prendre des décisions éclairées pour façonner l'avenir de leur société.\r\n\r\nLes Défis de l'Engagement Politique\r\nMalgré son importance, l'engagement politique peut sembler intimidant pour de nombreux citoyens. Comprendre le fonctionnement du système politique, décrypter les discours des politiciens et participer activement aux processus démocratiques peut sembler décourageant. Pourtant, s'engager politiquement est essentiel pour garantir une gouvernance juste et équitable.\r\n\r\nL'Importance de la Voix Citoyenne\r\nChaque voix compte en politique. Les citoyens ont le pouvoir d'influencer les décisions politiques en exprimant leurs préoccupations, en votant aux élections et en s'engageant dans des actions communautaires. En unissant leurs voix, les citoyens peuvent défendre des politiques qui reflètent leurs valeurs et leurs intérêts.\r\n\r\nConclusion\r\nEn conclusion, la politique moderne a un impact significatif sur la société contemporaine. En comprenant mieux la politique, en surmontant les défis de l'engagement politique et en faisant entendre leur voix, les citoyens peuvent contribuer à façonner un avenir plus juste et équitable pour tous.	2024-05-06	\N	politique
336	35	Le Monde de la Mode: Un Regard Approfondi	Introduction\r\nLa mode, un univers fascinant qui évolue constamment, offrant un mélange dynamique de style, d'expression et d'innovation. Du chic urbain aux tenues de soirée élégantes, la mode est un moyen puissant de communiquer notre personnalité et notre créativité au monde qui nous entoure.\r\n\r\nHistoire de la Mode\r\nDepuis des siècles, la mode a été un reflet de l'époque et de la société. Des vêtements ornés de l'ère victorienne aux looks audacieux des années 80, chaque période a apporté son lot de tendances et de styles uniques. La mode est bien plus qu'un simple moyen de se vêtir; elle est un langage visuel qui transcende les frontières et les cultures.\r\n\r\nLes Tendances Actuelles\r\nAujourd'hui, la mode est plus diversifiée que jamais. Des influences streetwear aux accents vintage, il n'a jamais été aussi excitant d'explorer et d'expérimenter avec son style personnel. Les designers repoussent les limites de la créativité, offrant des collections qui défient les conventions et inspirent l'individualité.\r\n\r\nL'Impact de la Mode\r\nAu-delà de l'esthétique, la mode a un impact profond sur la société et l'environnement. De plus en plus de marques se tournent vers la durabilité et l'éthique, cherchant à réduire leur empreinte écologique et à promouvoir des pratiques commerciales éthiques. En tant que consommateurs, nous avons le pouvoir de soutenir des marques qui partagent nos valeurs.\r\n\r\nConclusion\r\nLa mode est bien plus qu'une simple question de vêtements; c'est une forme d'art vivante qui évolue et se renouvelle sans cesse. Que vous soyez passionné de haute couture ou adepte du style décontracté, la mode offre un espace pour exprimer qui nous sommes vraiment. Plongez dans ce monde dynamique et laissez votre style personnel briller.\r\n\r\nDécouvrir le monde de la mode, c'est s'engager dans un voyage de découverte de soi et d'expression créative. Que vous soyez un amateur de tendances ou un passionné de style intemporel, il y a toujours quelque chose de nouveau à explorer et à apprécier dans cet univers vibrant et en constante évolution.	2024-05-06	\N	mode
391	35	Demo	Ceci est la démo	2024-05-13	\N	autre
393	35	hh	hdhh	2024-05-13	\N	tech
\.


--
-- TOC entry 4321 (class 0 OID 16441)
-- Dependencies: 219
-- Data for Name: profil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profil (id, first_name, last_name, mail, password, pseudo, admin) FROM stdin;
35	Nicolas	Seron	nicoco@live.be	$2b$10$e6emTIMxxXNXcFIL.IFDDOWOaNEWFKo6sB2QU.qg6xmmI5ej8p11i	nico_97	t
36	Nicolas	Seron	nicoco@live.fr	$2b$10$RRQABV3JGPxaH/x0dkqCMOwEJ07z9QM1AgzgdbtUwmXP79h7CzL5C	non_admin97	f
\.


--
-- TOC entry 4334 (class 0 OID 0)
-- Dependencies: 216
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- TOC entry 4335 (class 0 OID 0)
-- Dependencies: 218
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_id_seq', 223, true);


--
-- TOC entry 4336 (class 0 OID 0)
-- Dependencies: 220
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_id_seq', 36, true);


--
-- TOC entry 4337 (class 0 OID 0)
-- Dependencies: 222
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 394, true);


--
-- TOC entry 4163 (class 2606 OID 16466)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 4165 (class 2606 OID 16468)
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- TOC entry 4169 (class 2606 OID 16470)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 4167 (class 2606 OID 16472)
-- Name: profil profil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profil
    ADD CONSTRAINT profil_pkey PRIMARY KEY (id);


--
-- TOC entry 4170 (class 2606 OID 16480)
-- Name: comments comments_id_post_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.posts(id) NOT VALID;


--
-- TOC entry 4171 (class 2606 OID 16475)
-- Name: comments comments_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.profil(id) NOT VALID;


--
-- TOC entry 4172 (class 2606 OID 16485)
-- Name: images images_id_post_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.posts(id) NOT VALID;


--
-- TOC entry 4173 (class 2606 OID 16495)
-- Name: posts posts_id_profil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_id_profil_fkey FOREIGN KEY (id_profil) REFERENCES public.profil(id) NOT VALID;


-- Completed on 2024-05-15 09:29:57

--
-- PostgreSQL database dump complete
--

