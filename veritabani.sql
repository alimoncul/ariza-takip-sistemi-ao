-- Database: ariza-takip-sistemi

-- DROP DATABASE "ariza-takip-sistemi";

CREATE DATABASE "ariza-takip-sistemi"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Turkish_Turkey.1254'
    LC_CTYPE = 'Turkish_Turkey.1254'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
    
-- Table: public.ariza

-- DROP TABLE public.ariza;

CREATE TABLE public.ariza
(
    bolum text COLLATE pg_catalog."default",
    ariza_birakan_isim text COLLATE pg_catalog."default",
    ariza_birakan_soyisim text COLLATE pg_catalog."default",
    aciklama text COLLATE pg_catalog."default",
    cozulme_durumu text COLLATE pg_catalog."default" NOT NULL DEFAULT 0,
    id integer NOT NULL DEFAULT nextval('ariza_id_seq'::regclass),
    ariza_tarihi date,
    CONSTRAINT ariza_no PRIMARY KEY (id),
    CONSTRAINT ariza_no_uniq_a UNIQUE (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ariza
    OWNER to postgres;
    
-- Table: public.kullanici

-- DROP TABLE public.kullanici;

CREATE TABLE public.kullanici
(
    isim text COLLATE pg_catalog."default",
    soyisim text COLLATE pg_catalog."default",
    calistigi_bolum text COLLATE pg_catalog."default",
    sicil_no integer NOT NULL DEFAULT nextval('kullanici_sicil_no_seq'::regclass),
    CONSTRAINT sicil_no_pk_k PRIMARY KEY (sicil_no),
    CONSTRAINT sicil_no_uniq_k UNIQUE (sicil_no),
    CONSTRAINT sicil_no_fk_k FOREIGN KEY (sicil_no)
        REFERENCES public.yetki (sicil_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.kullanici
    OWNER to postgres;

-- Table: public.mudur

-- DROP TABLE public.mudur;

CREATE TABLE public.mudur
(
    isim text COLLATE pg_catalog."default",
    soyisim text COLLATE pg_catalog."default",
    sicil_no integer NOT NULL DEFAULT nextval('mudur_sicil_no_seq'::regclass),
    CONSTRAINT sicil_no_pk PRIMARY KEY (sicil_no),
    CONSTRAINT sicil_no_uniq_m UNIQUE (sicil_no),
    CONSTRAINT sicil_no_fk_m FOREIGN KEY (sicil_no)
        REFERENCES public.yetki (sicil_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.mudur
    OWNER to postgres;
    
-- Table: public.yetki

-- DROP TABLE public.yetki;

CREATE TABLE public.yetki
(
    seviyesi integer NOT NULL,
    kullanici_adi text COLLATE pg_catalog."default" NOT NULL,
    sifre text COLLATE pg_catalog."default" NOT NULL,
    sicil_no integer NOT NULL DEFAULT nextval('yetki_sicil_no_seq'::regclass),
    CONSTRAINT sicil_no_pk_y PRIMARY KEY (sicil_no),
    CONSTRAINT sicil_no_uniq UNIQUE (sicil_no)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.yetki
    OWNER to postgres;
