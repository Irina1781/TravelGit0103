--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-03-03 20:28:33

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 16395)
-- Name: pldbgapi; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pldbgapi WITH SCHEMA public;


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pldbgapi; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pldbgapi IS 'server-side support for debugging PL/pgSQL functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 227 (class 1259 OID 26511)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    id integer NOT NULL,
    city text NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16551)
-- Name: climate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.climate (
    id integer NOT NULL,
    climate text NOT NULL
);


ALTER TABLE public.climate OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16558)
-- Name: rest_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rest_type (
    id integer NOT NULL,
    type text NOT NULL
);


ALTER TABLE public.rest_type OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16544)
-- Name: timezone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timezone (
    id integer NOT NULL,
    timezone text NOT NULL
);


ALTER TABLE public.timezone OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16643)
-- Name: travel_search; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.travel_search (
    id integer NOT NULL,
    name text NOT NULL,
    photo text NOT NULL,
    description text NOT NULL,
    geo text NOT NULL,
    type integer NOT NULL,
    climate integer NOT NULL,
    timezone integer NOT NULL,
    cost integer NOT NULL,
    more text NOT NULL,
    city integer[] NOT NULL
);


ALTER TABLE public.travel_search OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 26773)
-- Name: travel_search_city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.travel_search_city (
    travel_search_id integer NOT NULL,
    city_id integer NOT NULL
);


ALTER TABLE public.travel_search_city OWNER TO postgres;

--
-- TOC entry 4964 (class 0 OID 26511)
-- Dependencies: 227
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (id, city) FROM stdin;
1	Москва
2	Санкт-Петербург
3	Новосибирск
4	Екатеринбург
5	Сочи
6	Владивосток
\.


--
-- TOC entry 4961 (class 0 OID 16551)
-- Dependencies: 224
-- Data for Name: climate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.climate (id, climate) FROM stdin;
8	Антарктический
7	Экваториальный
6	Субэкваториальный
5	Тропический
4	Субтропический
3	Умеренный
2	Арктический
1	Средиземноморский
\.


--
-- TOC entry 4962 (class 0 OID 16558)
-- Dependencies: 225
-- Data for Name: rest_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rest_type (id, type) FROM stdin;
7	Треккинг и походы
6	Древние цивилизации
5	Экскурсионный
4	Гастрономический
3	Оздоровительный
2	Семейный
1	Пляжный
\.


--
-- TOC entry 4960 (class 0 OID 16544)
-- Dependencies: 223
-- Data for Name: timezone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timezone (id, timezone) FROM stdin;
27	UTC+14
26	UTC+13
25	UTC+12
24	UTC+11
23	UTC+10
22	UTC+9
21	UTC+8
20	UTC+7
19	UTC+6
18	UTC+5
17	UTC+4
16	UTC+3
15	UTC+2
14	UTC+1
13	UTC 0
12	UTC-1
11	UTC-2
10	UTC-3
9	UTC-4
8	UTC-5
7	UTC-6
6	UTC-7
5	UTC-8
4	UTC-9
3	UTC-10
2	UTC-11
1	UTC-12
\.


--
-- TOC entry 4963 (class 0 OID 16643)
-- Dependencies: 226
-- Data for Name: travel_search; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.travel_search (id, name, photo, description, geo, type, climate, timezone, cost, more, city) FROM stdin;
2	Эль-Нидо	https://www.sunny-trip.ru/wp-content/uploads/2017/01/DSCN6881.jpg	Здесь одни из самых красивых пляжей, потрясающие лагуны, острова-скалы и пышная тропическая растительность. Эль-Нидо — одно из самых красивых мест планеты	Филиппины, остров Палаван	1	6	20	78663	https://www.sunny-trip.ru/el-nido/	{1,2,3,4,5}
3	Чиангмай	https://www.sunny-trip.ru/wp-content/uploads/2019/02/DSCN8419.jpg	Основанный в конце XIII века князем Менграй город иначе как столицей храмов и не назовешь. Они здесь на каждом углу: большие и маленькие, высокие и очень высокие, серебристые, белые, красные, черные…	Таиланд, провинция Чианг Май	5	5	20	49467	https://www.sunny-trip.ru/chiang-mai/	{1}
4	Пхукет	https://www.sunny-trip.ru/wp-content/uploads/2019/01/DSCN7245.jpg	Популярный среди россиян остров Пхукет с одноименной столицей расположен на самом юге Таиланда, южнее материкового перешейка, заключенного границами в объятия Мьянмы и Малайзии. Провинция Пхукет, состоящая из самого острова и еще порядка 30-32 более мелких островков, соседствует с тайскими провинциями Пхангнга и Краби. Омывается прозрачными водами Андаманского моря	Таиланд, остров на юге Таиланда	1	5	20	46856	https://www.sunny-trip.ru/phuket/	{1,3}
20	Муйне	https://www.sunny-trip.ru/wp-content/uploads/2017/01/IMG_20160607_150444.jpg	Небольшой туристический Муйне ранее был обычной рыбацкой деревушкой. Однако со временем все возрастающее количество отдыхающих превратило ее в туристический курорт.\nПляжи были застроены отелями, а улицы – кафе и ресторанами. Население работает в сфере обслуживания (туризм, общепит и магазины, отели), занимается сельским хозяйством и рыболовством	Вьетнам, юго-восток	1	5	20	47617	https://www.sunny-trip.ru/mui-ne/	{1}
21	Хошимин	https://www.sunny-trip.ru/wp-content/uploads/2017/01/IMG_20160618_102410.jpg	Хошимин (бывший Сайгон) расположен в дельте самой большой и полноводной реки Азии – Меконга. Наиболее популярные экскурсии проходят в центре города с его достопримечательностями, на реке Меконг и в партизанских туннелях	Вьетнам, юг	5	6	20	47617	https://www.sunny-trip.ru/ho-chi-minh/	{1}
1	Райлей	https://www.sunny-trip.ru/wp-content/uploads/2018/01/thailand.jpg	Тайский райский полуостров Райлей знаменит своими поражающими воображение пляжами и «вырастающими» из морских вод скалами-островами. Белоснежный песок, прозрачная вода и поразительная красота природы вокруг-отдых станет поистине незабываемым	Таиланд, провинция Краби	1	6	21	69170	https://www.sunny-trip.ru/railay/	{1,2,3,4}
5	Нгапали	https://www.sunny-trip.ru/wp-content/uploads/2019/01/DSCN7093.jpg	Пляж Нгапали или Нгапли (Ngapli) считается одним из лучших не только в Мьянме, но и во всей Юго-Восточной Азии. Практически это несколько километров песка, пальм, линии крупных и мелких отелей. По меркам Мьянмы стоимость проживания в них непомерно высока. В пиковый период, то есть в сезон с ноября по март, здесь и правда дороговато.	Мьянма, штат Ракхайн	1	5	19	73037	https://www.sunny-trip.ru/ngapali/	{1}
6	Янгон	https://www.sunny-trip.ru/wp-content/uploads/2019/01/DSCN6790.jpg	Янгон (он же Рангун или Дагон) – город, который чувствуешь сердцем и душой.\nЭто самый густонаселенный город Мьянмы и ее бывшая столица. Ею город перестал быть относительно недавно, 6 ноября 2005 года, когда главная резиденция правительства была перенесена в Нейпьидо	Мьянма (Бирма)	5	5	19	57800	https://www.sunny-trip.ru/yangon/	{1}
32	Тунис	https://www.sunny-trip.ru/wp-content/uploads/2017/03/Dougga-Tunusia.jpg	Тунис знаменит как пляжами, так и руинами древней римской и карфагенской цивилизаций. История страны открывается во время путешествия по ее просторам	Тунис, северная Африка	6	1	14	52334	https://www.sunny-trip.ru/tunisia/	{1}
7	Ангкор Ват	https://www.sunny-trip.ru/wp-content/uploads/2018/02/%D0%90%D0%BD%D0%B3%D0%BA%D0%BE%D1%80-%D0%92%D0%B0%D1%82.jpg	Главная достопримечательность Камбоджи и ее символ, изображенный на государственном флаге – храм Ангкор Ват.\nОн находится недалеко от современного города Сием Реап. Помимо знаменитого храма вокруг города, на территории, где несколько сотен лет билось сердце Кхмерского государства, раскинулось несколько десятков больших и малых храмов, дворец, а также другие постройки, датируемые VIII-XV вв	Камбоджа, Сием Реап	6	5	20	81382	https://www.sunny-trip.ru/angkor-temples/	{1}
8	Ко Чанг	https://www.sunny-trip.ru/wp-content/uploads/2018/01/Lonely-Beach.jpg	Остров Ко Чанг находится у побережья Таиланда в Сиамском заливе и относится к провинции Трат. Часть территории острова занимает Национальный парк Му Ко Чанг. Он включает в себя водопады и тропические горные леса с эндемичными видами растений и насекомых	Таиланд, провинция Трат	1	5	20	46794	https://www.sunny-trip.ru/kho-chang/	{1,3,6}
9	Бангкок	https://www.sunny-trip.ru/wp-content/uploads/2018/01/DSCN2837.jpg	Столицей Таиланда, а также многомиллионным городом, соединяющим в себе черты различных регионов страны является Бангкок.\nОн появился в 1782 году практически одновременно с нынешней правящей династией королей (династия Чакри) на берегу реки Чаопрайя. Находится в центре страны и представляет собой современный город с небоскребами, сочетающий в себе остатки архитектуры в стиле эпохи колониализма (при том, что сам Таиланд никогда не был колонией) и уникальные буддийские храмы и сакральные здания	Таиланд, столица	5	5	20	46794	https://www.sunny-trip.ru/bangkok/	{1,3,6}
10	Рекава	https://www.sunny-trip.ru/wp-content/uploads/2017/02/DSCN3861.jpg	Шри-Ланка, помимо богатой истории, может удивить путешественников красивыми пейзажами с чайными и рисовыми плантациями, невысокими горными хребтами и холмами, водопадами и национальными парками. А также яркой тропической зеленью и красочными цветами, залитыми солнцем пляжами и освежающими брызгами океанских  волн	Шри-Ланка, Рекава	1	5	18	26149	https://www.sunny-trip.ru/beaches-of-sri-lanka/	{1,2,3}
11	Канди	https://www.sunny-trip.ru/wp-content/uploads/2017/02/DSCN3629.jpg	Канди — священный город в Шри-Ланке, религиозный центр страны. Город был основан в XIV в., а с XVIII в. является религиозным центром Шри-Ланки после того, как сюда была перенесена священная буддийская реликвия – Зуб Будды. С этого времени Канди стал столицей сингальского государства, приняв знамя у Полоннарувы 	Шри-Ланка, центральная провинция	5	5	18	26149	https://www.sunny-trip.ru/kandy/	{1,2,3}
12	Сигирия	https://www.sunny-trip.ru/wp-content/uploads/2017/02/DSCN2802.jpg	Сигирия была крепостью и резиденцией короля. Согласно легендам, ее строительство началось целых 7000 лет назад архитектором Маяданавой. Строитель подарил свое творение королю Весамуни	Шри-Ланка, центральная часть	6	5	18	26149	https://www.sunny-trip.ru/sigiriya-and-dambulla/	{1,2,3}
13	Дамбула	https://www.sunny-trip.ru/wp-content/uploads/2017/02/IMG_20150112_160818_0.jpg	Дамбула - пещерный комплекс. Когда-то здесь в пещерах жили монахи (да и сейчас вроде живут). Много детей-послушников. Недалеко от храма стоит позолоченная нарядная ступа.	Шри-Ланка, центральная часть	5	5	18	26149	https://www.sunny-trip.ru/sigiriya-and-dambulla/	{1,2,3}
14	Полоннарува	https://www.sunny-trip.ru/wp-content/uploads/2017/02/DSCN2720.jpg	Средневековая столица Шри-Ланки, Полоннарува, стала вторым одним из важных пунктов нашего путешествия по острову.\nЭтот город привлекает множество путешественников огромным количеством исторических мест — дворцами королей, величественными комплексами, храмами, скульптурами и ступами	Шри-Ланка, центральная часть	6	5	18	26149	https://www.sunny-trip.ru/polonnaruwa/	{1,2,3}
15	Анурадхапура и Михинтале	https://www.sunny-trip.ru/wp-content/uploads/2017/02/DSCN2344.jpg	Анурадхапура — город первых буддийских ступ и древних монастырей, первая столица сингальского королевства, культовый и религиозный центр, где великие святыни встречаются почти на каждом шагу.  Михинтале — не одна гора, а целых три: Манговое плато (Ambastala), Королевский холм (Rajagiri) и Слоновья гора (Anaikutti).  С каждой из них открывается прямо-таки открыточный вид на окрестности. 	Шри-Ланка, Северо-Центральная провинция	6	5	18	28000	https://www.sunny-trip.ru/anuradhapura-and-mihintale/	{1,2,3}
16	Коломбо	https://www.sunny-trip.ru/wp-content/uploads/2017/02/gangaramaya.jpg	Коломбо – крупнейший город страны. Его население – менее миллиона человек. Однако на Цейлоне есть такое понятие как Большой Коломбо. К нему местные жители относят ближайшие крупные города, в том числе, и столицу. Общее население – почти 6 млн. человек! Рядом находится международный аэропорт Бандаранаике	Шри-Ланка, западная провинция	5	5	18	26149	https://www.sunny-trip.ru/colombo-and-sri-lanka/	{1,2,3}
17	Доха	https://www.sunny-trip.ru/wp-content/uploads/2017/02/DSCN8480.jpg	Катар — страна исламской культуры, где высокий уровень жизни населения соединяется с традиционным укладом, а современные бело-голубые индустриальные пейзажи дополняются белыми песками пустыни, зелеными каплями немногочисленной зелени газонов и пальм и глубоким синим цветом неба и моря	Катар, столица	5	5	16	38568	https://www.sunny-trip.ru/qatar-and-doha/	{1,2}
18	Хюэ	https://www.sunny-trip.ru/wp-content/uploads/2017/01/IMG_20160615_115238.jpg	Город Хюэ (Hue) находится на побережье Южно-Китайского моря в центральной части Вьетнама. Здесь множество исторических памятников, ведь Хюэ был столицей вьетнамских императоров династии Нгуен почти полтора столетия, с 1802 по 1945 год	Вьетнам, центральная часть	5	5	20	90410	https://www.sunny-trip.ru/hue/	{1}
19	Фукуок	https://www.sunny-trip.ru/wp-content/uploads/2017/01/DSCN8148.jpg	Остров Фукуок (русскояз. Фукуок, англояз. — Phu Quoc) расположен в Тайском заливе, в самой западной точке Вьетнама, почти на границе с Камбоджей. Самый крупный населенный пункт – город Дуонг Донг. Климат субэкваториальный, отдыхать здесь можно практически круглый год (наибольшее количество осадков в сентябре и октябре)	Вьетнам, остров провинции Кьензянг	1	6	20	37806	https://www.sunny-trip.ru/phu-quoc/	{1}
22	Манила	https://www.sunny-trip.ru/wp-content/uploads/2017/01/DSCN6238.jpg	Столица Филиппин Манила — город крайне неоднозначный, но здесь есть что посмотреть. Сочетание азиатского колорита и католицизма, нищеты  и блеска. Достопримечательности Манилы стоит посмотреть хотя бы раз в жизни	Филиппины, провинция Манила	5	6	21	46162	https://www.sunny-trip.ru/manila/	{1}
23	Боракай	https://www.sunny-trip.ru/wp-content/uploads/2017/01/DSCN6422.jpg	Хотите на одни из лучших пляжей мира с белоснежным песком и прозрачной водой? Тогда Вам точно стоит посетить остров Боракай!\nБоракай – жемчужина Филиппин, остров с восхитительной красоты пляжами	Филиппины, остров, провинция Аклан	1	5	21	81970	https://www.sunny-trip.ru/boracay/	{1}
24	Лангкави	https://www.sunny-trip.ru/wp-content/uploads/2016/12/DSCN4156.jpg	Лангкави (Langkawi Island) находится в Андаманском море на границе с Таиландом. Это одна из самых северных точек Малайзии.\nЛангкави – не один остров, это архипелаг из россыпи более чем 100 островов. Самый большой из них тоже называется Лангкави (Pulau Langkawi). Как с земли, так и с высоты птичьего полета остров восхищает: кристально-голубые воды моря омывают сушу, покрытую горами и ярко-зеленой растительностью, а над белоснежными пляжами гордо реет местный вид красных орлов (langkawi), который и дал архипелагу свое название.	Малайзия, архипелаг штата Кедах	1	7	21	76312	https://www.sunny-trip.ru/langkawi/	{1}
25	Куала-Лумпур	https://www.sunny-trip.ru/wp-content/uploads/2016/12/DSCN6161.jpg	Куала-Лумпур - столица Малайзии, город небоскребов, смешения религий, образов жизни и менталитета. Продвинутые технологии соседствуют с древними пещерными храмами и культурными памятниками. Здесь определенно есть что посмотреть!	Малайзия, столица	5	7	21	47659	https://www.sunny-trip.ru/malaysia	{1}
26	Бали	https://www.sunny-trip.ru/wp-content/uploads/2017/01/DSCN5610.jpg	Чудо-остров с разноцветными пляжами и райскими местечками для разных видов отдыха. А еще потрясающей культурой с индуистскими храмами и древней архитектурой	Индонезия, группа Малых Зондских островов	1	7	21	6326	https://www.sunny-trip.ru/bali/	{1}
27	Менорка	https://ic.pics.livejournal.com/sunny_trip_ru/80336492/40126/40126_800.jpg	Остров Менорка — один из семи Балеарских островов (см. статью Майорка). В нем удивительным образом переплелись история и архитектура Востока и Запада, сохранились древнейшие уникальные сооружения мегалитического периода.  Белоснежные виллы и удивительные по красоте песчаные пляжи, богатство флоры и фауны делают этот остров незаменимым для хорошего отдыха	Испания, Балеарские острова	1	1	14	66087	https://www.sunny-trip.ru/menorca/	{1}
28	Майорка	https://www.sunny-trip.ru/wp-content/uploads/2017/03/DSCN5560.jpg	Майорка (Мальорка) – самый большой из Балеарских островов и самый большой остров в Испании. Он находится в Средиземном море к востоку от берегов Пиренейского полуострова. Балеарский архипелаг состоит из семи островов и двух групп: Сосновые острова – Ибица и Форментера, а также Гимнессийские острова —  Майорка (Insula Maior, «больший остров»), Менорка (Insula Menor или «меньший остров»), Драгонера, остров Воздуха и архипелаг Кабрера из маленьких островков	Испания, Балеарские острова	1	1	14	43355	https://www.sunny-trip.ru/mallorca/	{1}
29	Санторини	https://www.sunny-trip.ru/wp-content/uploads/2017/02/ia-santorini.jpg	Греческий рай, остров Санторини, привлекает внимание путешественников своей уникальной атмосферой, архитектурой, вулканическими пляжами и глубоко-синими водами Эгейского моря. А еще загадками утерянной цивилизации. Ведь не зря остров считают погибшей Атлантидой	Греция, остров архипелага Киклады	5	1	15	42884	https://www.sunny-trip.ru/santorini/	{1}
30	Крит	https://www.sunny-trip.ru/wp-content/uploads/2017/02/DSCN1400.jpg	Во время посещения греческого Крита стоит увидеть древние археологические памятники. Одна из самых интересных — экскурсия в колыбель минойской цивилизации, дворец  царя Миноса в Кноссе	Греция, остров Крит	6	1	15	38916	https://www.sunny-trip.ru/knossos/	{1}
31	Доминикана	https://ic.pics.livejournal.com/sunny_trip_ru/80336492/17934/17934_800.jpg	Доминикана – это пляжи с белоснежным песком, обрамленным стройными или изгибающимися над волнами синего моря кокосовыми пальмами.\nЗдесь можно полюбоваться на водопады и китов, заняться виндсерфингом и дайвингом, совершить прогулку по средневековым улицам Санто-Доминго или покататься на лошадях, в тени пальм насладиться океанскими закатами и россыпями ярких звезд на ночном небе.	Доминиканская республика, остров Гаити	1	5	9	116789	https://www.sunny-trip.ru/dominican-republic/	{1}
33	Санкт-Петербург	https://www.sunny-trip.ru/wp-content/uploads/2017/04/petergof.jpg	Город дворцов и парков, фонтанов и каналов, удивительных образцов российской скульптуры, архитектуры и изобразительного искусства XVIII-XIX вв., столица Российской империи — Санкт-Петербург — вызывает удивление и восхищение своих гостей и жителей	Россия, Санкт-Петербург	5	3	16	4099	https://www.sunny-trip.ru/saint-peterburg/	{1,3,4,5,6}
34	Казань	https://www.sunny-trip.ru/wp-content/uploads/2017/03/Kazan.jpg	Столица Татарстана и один из крупнейших городов Поволжья, Казань, представляет собой настоящий сплав религий, культур и традиций	Россия, Татарстан	2	3	16	4530	https://www.sunny-trip.ru/kazan/	{1,2,4,5}
\.


--
-- TOC entry 4965 (class 0 OID 26773)
-- Dependencies: 228
-- Data for Name: travel_search_city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.travel_search_city (travel_search_id, city_id) FROM stdin;
\.


--
-- TOC entry 4807 (class 2606 OID 26517)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- TOC entry 4801 (class 2606 OID 25682)
-- Name: climate climate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.climate
    ADD CONSTRAINT climate_pkey PRIMARY KEY (id);


--
-- TOC entry 4803 (class 2606 OID 25025)
-- Name: rest_type rest_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rest_type
    ADD CONSTRAINT rest_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4799 (class 2606 OID 25669)
-- Name: timezone timezone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timezone
    ADD CONSTRAINT timezone_pkey PRIMARY KEY (id);


--
-- TOC entry 4809 (class 2606 OID 26777)
-- Name: travel_search_city travel_search_city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travel_search_city
    ADD CONSTRAINT travel_search_city_pkey PRIMARY KEY (travel_search_id, city_id);


--
-- TOC entry 4805 (class 2606 OID 24858)
-- Name: travel_search travel_search_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travel_search
    ADD CONSTRAINT travel_search_pkey PRIMARY KEY (id);


--
-- TOC entry 4810 (class 2606 OID 27050)
-- Name: travel_search climate; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travel_search
    ADD CONSTRAINT climate FOREIGN KEY (climate) REFERENCES public.climate(id) NOT VALID;


--
-- TOC entry 4811 (class 2606 OID 27045)
-- Name: travel_search rest_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travel_search
    ADD CONSTRAINT rest_type FOREIGN KEY (type) REFERENCES public.rest_type(id) NOT VALID;


--
-- TOC entry 4812 (class 2606 OID 27055)
-- Name: travel_search timezone; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travel_search
    ADD CONSTRAINT timezone FOREIGN KEY (timezone) REFERENCES public.timezone(id) NOT VALID;


--
-- TOC entry 4813 (class 2606 OID 26783)
-- Name: travel_search_city travel_search_city_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travel_search_city
    ADD CONSTRAINT travel_search_city_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(id);


--
-- TOC entry 4814 (class 2606 OID 26778)
-- Name: travel_search_city travel_search_city_travel_search_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travel_search_city
    ADD CONSTRAINT travel_search_city_travel_search_id_fkey FOREIGN KEY (travel_search_id) REFERENCES public.travel_search(id);


-- Completed on 2025-03-03 20:28:34

--
-- PostgreSQL database dump complete
--

