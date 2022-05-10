--
-- PostgreSQL database dump
--

-- Dumped from database version 11.15
-- Dumped by pg_dump version 11.15

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

SET default_with_oids = false;

--
-- Name: announcements; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.announcements (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "pluginId" integer,
    heading character varying(255) NOT NULL,
    body text NOT NULL,
    unread boolean DEFAULT true NOT NULL,
    "dateRead" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.announcements OWNER TO craft;

--
-- Name: announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.announcements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.announcements_id_seq OWNER TO craft;

--
-- Name: announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.announcements_id_seq OWNED BY public.announcements.id;


--
-- Name: assetindexdata; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.assetindexdata (
    id integer NOT NULL,
    "sessionId" character varying(36) DEFAULT ''::character varying NOT NULL,
    "volumeId" integer NOT NULL,
    uri text,
    size bigint,
    "timestamp" timestamp(0) without time zone,
    "recordId" integer,
    "inProgress" boolean DEFAULT false,
    completed boolean DEFAULT false,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.assetindexdata OWNER TO craft;

--
-- Name: assetindexdata_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.assetindexdata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assetindexdata_id_seq OWNER TO craft;

--
-- Name: assetindexdata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.assetindexdata_id_seq OWNED BY public.assetindexdata.id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    "volumeId" integer,
    "folderId" integer NOT NULL,
    "uploaderId" integer,
    filename character varying(255) NOT NULL,
    kind character varying(50) DEFAULT 'unknown'::character varying NOT NULL,
    width integer,
    height integer,
    size bigint,
    "focalPoint" character varying(13) DEFAULT NULL::character varying,
    "deletedWithVolume" boolean,
    "keptFile" boolean,
    "dateModified" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.assets OWNER TO craft;

--
-- Name: assettransformindex; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.assettransformindex (
    id integer NOT NULL,
    "assetId" integer NOT NULL,
    filename character varying(255),
    format character varying(255),
    location character varying(255) NOT NULL,
    "volumeId" integer,
    "fileExists" boolean DEFAULT false NOT NULL,
    "inProgress" boolean DEFAULT false NOT NULL,
    error boolean DEFAULT false NOT NULL,
    "dateIndexed" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.assettransformindex OWNER TO craft;

--
-- Name: assettransformindex_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.assettransformindex_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assettransformindex_id_seq OWNER TO craft;

--
-- Name: assettransformindex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.assettransformindex_id_seq OWNED BY public.assettransformindex.id;


--
-- Name: assettransforms; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.assettransforms (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    mode character varying(255) DEFAULT 'crop'::character varying NOT NULL,
    "position" character varying(255) DEFAULT 'center-center'::character varying NOT NULL,
    width integer,
    height integer,
    format character varying(255),
    quality integer,
    interlace character varying(255) DEFAULT 'none'::character varying NOT NULL,
    "dimensionChangeTime" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    CONSTRAINT assettransforms_interlace_check CHECK (((interlace)::text = ANY (ARRAY[('none'::character varying)::text, ('line'::character varying)::text, ('plane'::character varying)::text, ('partition'::character varying)::text]))),
    CONSTRAINT assettransforms_mode_check CHECK (((mode)::text = ANY (ARRAY[('stretch'::character varying)::text, ('fit'::character varying)::text, ('crop'::character varying)::text]))),
    CONSTRAINT assettransforms_position_check CHECK ((("position")::text = ANY (ARRAY[('top-left'::character varying)::text, ('top-center'::character varying)::text, ('top-right'::character varying)::text, ('center-left'::character varying)::text, ('center-center'::character varying)::text, ('center-right'::character varying)::text, ('bottom-left'::character varying)::text, ('bottom-center'::character varying)::text, ('bottom-right'::character varying)::text])))
);


ALTER TABLE public.assettransforms OWNER TO craft;

--
-- Name: assettransforms_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.assettransforms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assettransforms_id_seq OWNER TO craft;

--
-- Name: assettransforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.assettransforms_id_seq OWNED BY public.assettransforms.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    "groupId" integer NOT NULL,
    "parentId" integer,
    "deletedWithGroup" boolean,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.categories OWNER TO craft;

--
-- Name: categorygroups; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.categorygroups (
    id integer NOT NULL,
    "structureId" integer NOT NULL,
    "fieldLayoutId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "defaultPlacement" character varying(255) DEFAULT 'end'::character varying NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    CONSTRAINT "categorygroups_defaultPlacement_check" CHECK ((("defaultPlacement")::text = ANY (ARRAY[('beginning'::character varying)::text, ('end'::character varying)::text])))
);


ALTER TABLE public.categorygroups OWNER TO craft;

--
-- Name: categorygroups_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.categorygroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorygroups_id_seq OWNER TO craft;

--
-- Name: categorygroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.categorygroups_id_seq OWNED BY public.categorygroups.id;


--
-- Name: categorygroups_sites; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.categorygroups_sites (
    id integer NOT NULL,
    "groupId" integer NOT NULL,
    "siteId" integer NOT NULL,
    "hasUrls" boolean DEFAULT true NOT NULL,
    "uriFormat" text,
    template character varying(500),
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.categorygroups_sites OWNER TO craft;

--
-- Name: categorygroups_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.categorygroups_sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorygroups_sites_id_seq OWNER TO craft;

--
-- Name: categorygroups_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.categorygroups_sites_id_seq OWNED BY public.categorygroups_sites.id;


--
-- Name: changedattributes; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.changedattributes (
    "elementId" integer NOT NULL,
    "siteId" integer NOT NULL,
    attribute character varying(255) NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    propagated boolean NOT NULL,
    "userId" integer
);


ALTER TABLE public.changedattributes OWNER TO craft;

--
-- Name: changedfields; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.changedfields (
    "elementId" integer NOT NULL,
    "siteId" integer NOT NULL,
    "fieldId" integer NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    propagated boolean NOT NULL,
    "userId" integer
);


ALTER TABLE public.changedfields OWNER TO craft;

--
-- Name: content; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.content (
    id integer NOT NULL,
    "elementId" integer NOT NULL,
    "siteId" integer NOT NULL,
    title character varying(255),
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    "field_altText" text,
    "field_linkText" text,
    "field_plainText" text,
    "field_siteDescription" text,
    "field_siteTitle" text,
    field_text text,
    "field_pageType_kxxunrnk" character varying(255)
);


ALTER TABLE public.content OWNER TO craft;

--
-- Name: content_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_id_seq OWNER TO craft;

--
-- Name: content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.content_id_seq OWNED BY public.content.id;


--
-- Name: craftidtokens; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.craftidtokens (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "accessToken" text NOT NULL,
    "expiryDate" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.craftidtokens OWNER TO craft;

--
-- Name: craftidtokens_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.craftidtokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.craftidtokens_id_seq OWNER TO craft;

--
-- Name: craftidtokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.craftidtokens_id_seq OWNED BY public.craftidtokens.id;


--
-- Name: deprecationerrors; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.deprecationerrors (
    id integer NOT NULL,
    key character varying(255) NOT NULL,
    fingerprint character varying(255) NOT NULL,
    "lastOccurrence" timestamp(0) without time zone NOT NULL,
    file character varying(255) NOT NULL,
    line smallint,
    message text,
    traces text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.deprecationerrors OWNER TO craft;

--
-- Name: deprecationerrors_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.deprecationerrors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deprecationerrors_id_seq OWNER TO craft;

--
-- Name: deprecationerrors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.deprecationerrors_id_seq OWNED BY public.deprecationerrors.id;


--
-- Name: drafts; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.drafts (
    id integer NOT NULL,
    "sourceId" integer,
    "creatorId" integer,
    provisional boolean DEFAULT false NOT NULL,
    name character varying(255) NOT NULL,
    notes text,
    "trackChanges" boolean DEFAULT false NOT NULL,
    "dateLastMerged" timestamp(0) without time zone,
    saved boolean DEFAULT true NOT NULL
);


ALTER TABLE public.drafts OWNER TO craft;

--
-- Name: drafts_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.drafts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drafts_id_seq OWNER TO craft;

--
-- Name: drafts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.drafts_id_seq OWNED BY public.drafts.id;


--
-- Name: elementindexsettings; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.elementindexsettings (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    settings text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.elementindexsettings OWNER TO craft;

--
-- Name: elementindexsettings_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.elementindexsettings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.elementindexsettings_id_seq OWNER TO craft;

--
-- Name: elementindexsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.elementindexsettings_id_seq OWNED BY public.elementindexsettings.id;


--
-- Name: elements; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.elements (
    id integer NOT NULL,
    "canonicalId" integer,
    "draftId" integer,
    "revisionId" integer,
    "fieldLayoutId" integer,
    type character varying(255) NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateLastMerged" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.elements OWNER TO craft;

--
-- Name: elements_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.elements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.elements_id_seq OWNER TO craft;

--
-- Name: elements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.elements_id_seq OWNED BY public.elements.id;


--
-- Name: elements_sites; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.elements_sites (
    id integer NOT NULL,
    "elementId" integer NOT NULL,
    "siteId" integer NOT NULL,
    slug character varying(255),
    uri character varying(255),
    enabled boolean DEFAULT true NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.elements_sites OWNER TO craft;

--
-- Name: elements_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.elements_sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.elements_sites_id_seq OWNER TO craft;

--
-- Name: elements_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.elements_sites_id_seq OWNED BY public.elements_sites.id;


--
-- Name: entries; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.entries (
    id integer NOT NULL,
    "sectionId" integer NOT NULL,
    "parentId" integer,
    "typeId" integer NOT NULL,
    "authorId" integer,
    "postDate" timestamp(0) without time zone,
    "expiryDate" timestamp(0) without time zone,
    "deletedWithEntryType" boolean,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.entries OWNER TO craft;

--
-- Name: entrytypes; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.entrytypes (
    id integer NOT NULL,
    "sectionId" integer NOT NULL,
    "fieldLayoutId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "hasTitleField" boolean DEFAULT true NOT NULL,
    "titleTranslationMethod" character varying(255) DEFAULT 'site'::character varying NOT NULL,
    "titleTranslationKeyFormat" text,
    "titleFormat" character varying(255),
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.entrytypes OWNER TO craft;

--
-- Name: entrytypes_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.entrytypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entrytypes_id_seq OWNER TO craft;

--
-- Name: entrytypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.entrytypes_id_seq OWNED BY public.entrytypes.id;


--
-- Name: fieldgroups; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.fieldgroups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.fieldgroups OWNER TO craft;

--
-- Name: fieldgroups_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.fieldgroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fieldgroups_id_seq OWNER TO craft;

--
-- Name: fieldgroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.fieldgroups_id_seq OWNED BY public.fieldgroups.id;


--
-- Name: fieldlayoutfields; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.fieldlayoutfields (
    id integer NOT NULL,
    "layoutId" integer NOT NULL,
    "tabId" integer NOT NULL,
    "fieldId" integer NOT NULL,
    required boolean DEFAULT false NOT NULL,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.fieldlayoutfields OWNER TO craft;

--
-- Name: fieldlayoutfields_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.fieldlayoutfields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fieldlayoutfields_id_seq OWNER TO craft;

--
-- Name: fieldlayoutfields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.fieldlayoutfields_id_seq OWNED BY public.fieldlayoutfields.id;


--
-- Name: fieldlayouts; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.fieldlayouts (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.fieldlayouts OWNER TO craft;

--
-- Name: fieldlayouts_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.fieldlayouts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fieldlayouts_id_seq OWNER TO craft;

--
-- Name: fieldlayouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.fieldlayouts_id_seq OWNED BY public.fieldlayouts.id;


--
-- Name: fieldlayouttabs; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.fieldlayouttabs (
    id integer NOT NULL,
    "layoutId" integer NOT NULL,
    name character varying(255) NOT NULL,
    elements text,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.fieldlayouttabs OWNER TO craft;

--
-- Name: fieldlayouttabs_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.fieldlayouttabs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fieldlayouttabs_id_seq OWNER TO craft;

--
-- Name: fieldlayouttabs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.fieldlayouttabs_id_seq OWNED BY public.fieldlayouttabs.id;


--
-- Name: fields; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.fields (
    id integer NOT NULL,
    "groupId" integer,
    name character varying(255) NOT NULL,
    handle character varying(64) NOT NULL,
    context character varying(255) DEFAULT 'global'::character varying NOT NULL,
    "columnSuffix" character(8),
    instructions text,
    searchable boolean DEFAULT true NOT NULL,
    "translationMethod" character varying(255) DEFAULT 'none'::character varying NOT NULL,
    "translationKeyFormat" text,
    type character varying(255) NOT NULL,
    settings text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.fields OWNER TO craft;

--
-- Name: fields_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fields_id_seq OWNER TO craft;

--
-- Name: fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.fields_id_seq OWNED BY public.fields.id;


--
-- Name: globalsets; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.globalsets (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "fieldLayoutId" integer,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.globalsets OWNER TO craft;

--
-- Name: globalsets_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.globalsets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.globalsets_id_seq OWNER TO craft;

--
-- Name: globalsets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.globalsets_id_seq OWNED BY public.globalsets.id;


--
-- Name: gql_refresh_tokens; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.gql_refresh_tokens (
    id integer NOT NULL,
    token text NOT NULL,
    "userId" integer NOT NULL,
    "schemaId" integer NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "expiryDate" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.gql_refresh_tokens OWNER TO craft;

--
-- Name: gqlschemas; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.gqlschemas (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    scope text,
    "isPublic" boolean DEFAULT false NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.gqlschemas OWNER TO craft;

--
-- Name: gqlschemas_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.gqlschemas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gqlschemas_id_seq OWNER TO craft;

--
-- Name: gqlschemas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.gqlschemas_id_seq OWNED BY public.gqlschemas.id;


--
-- Name: gqltokens; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.gqltokens (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "accessToken" character varying(255) NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    "expiryDate" timestamp(0) without time zone,
    "lastUsed" timestamp(0) without time zone,
    "schemaId" integer,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.gqltokens OWNER TO craft;

--
-- Name: gqltokens_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.gqltokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gqltokens_id_seq OWNER TO craft;

--
-- Name: gqltokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.gqltokens_id_seq OWNED BY public.gqltokens.id;


--
-- Name: info; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.info (
    id integer NOT NULL,
    version character varying(50) NOT NULL,
    "schemaVersion" character varying(15) NOT NULL,
    maintenance boolean DEFAULT false NOT NULL,
    "configVersion" character(12) DEFAULT '000000000000'::bpchar NOT NULL,
    "fieldVersion" character(12) DEFAULT '000000000000'::bpchar NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.info OWNER TO craft;

--
-- Name: info_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.info_id_seq OWNER TO craft;

--
-- Name: info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.info_id_seq OWNED BY public.info.id;


--
-- Name: lenz_linkfield; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.lenz_linkfield (
    id integer NOT NULL,
    "elementId" integer NOT NULL,
    "fieldId" integer NOT NULL,
    "siteId" integer NOT NULL,
    type character varying(63),
    "linkedUrl" text,
    "linkedId" integer,
    "linkedSiteId" integer,
    "linkedTitle" character varying(255),
    payload text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.lenz_linkfield OWNER TO craft;

--
-- Name: lenz_linkfield_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.lenz_linkfield_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lenz_linkfield_id_seq OWNER TO craft;

--
-- Name: lenz_linkfield_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.lenz_linkfield_id_seq OWNED BY public.lenz_linkfield.id;


--
-- Name: matrixblocks; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.matrixblocks (
    id integer NOT NULL,
    "ownerId" integer NOT NULL,
    "fieldId" integer NOT NULL,
    "typeId" integer NOT NULL,
    "sortOrder" smallint,
    "deletedWithOwner" boolean,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.matrixblocks OWNER TO craft;

--
-- Name: matrixblocktypes; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.matrixblocktypes (
    id integer NOT NULL,
    "fieldId" integer NOT NULL,
    "fieldLayoutId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.matrixblocktypes OWNER TO craft;

--
-- Name: matrixblocktypes_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.matrixblocktypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.matrixblocktypes_id_seq OWNER TO craft;

--
-- Name: matrixblocktypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.matrixblocktypes_id_seq OWNED BY public.matrixblocktypes.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    track character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "applyTime" timestamp(0) without time zone NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.migrations OWNER TO craft;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO craft;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: neoblocks; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.neoblocks (
    id integer NOT NULL,
    "ownerId" integer NOT NULL,
    "ownerSiteId" integer,
    "fieldId" integer NOT NULL,
    "typeId" integer NOT NULL,
    "sortOrder" smallint,
    "deletedWithOwner" boolean,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.neoblocks OWNER TO craft;

--
-- Name: neoblockstructures; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.neoblockstructures (
    id integer NOT NULL,
    "structureId" integer NOT NULL,
    "ownerId" integer NOT NULL,
    "ownerSiteId" integer,
    "fieldId" integer NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.neoblockstructures OWNER TO craft;

--
-- Name: neoblockstructures_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.neoblockstructures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.neoblockstructures_id_seq OWNER TO craft;

--
-- Name: neoblockstructures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.neoblockstructures_id_seq OWNED BY public.neoblockstructures.id;


--
-- Name: neoblocktypegroups; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.neoblocktypegroups (
    id integer NOT NULL,
    "fieldId" integer NOT NULL,
    name character varying(255) NOT NULL,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.neoblocktypegroups OWNER TO craft;

--
-- Name: neoblocktypegroups_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.neoblocktypegroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.neoblocktypegroups_id_seq OWNER TO craft;

--
-- Name: neoblocktypegroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.neoblocktypegroups_id_seq OWNED BY public.neoblocktypegroups.id;


--
-- Name: neoblocktypes; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.neoblocktypes (
    id integer NOT NULL,
    "fieldId" integer NOT NULL,
    "fieldLayoutId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "maxBlocks" smallint,
    "maxSiblingBlocks" smallint DEFAULT 0,
    "maxChildBlocks" smallint,
    "childBlocks" text,
    "topLevel" boolean DEFAULT true NOT NULL,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.neoblocktypes OWNER TO craft;

--
-- Name: neoblocktypes_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.neoblocktypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.neoblocktypes_id_seq OWNER TO craft;

--
-- Name: neoblocktypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.neoblocktypes_id_seq OWNED BY public.neoblocktypes.id;


--
-- Name: plugins; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.plugins (
    id integer NOT NULL,
    handle character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    "schemaVersion" character varying(255) NOT NULL,
    "licenseKeyStatus" character varying(255) DEFAULT 'unknown'::character varying NOT NULL,
    "licensedEdition" character varying(255),
    "installDate" timestamp(0) without time zone NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    CONSTRAINT "plugins_licenseKeyStatus_check" CHECK ((("licenseKeyStatus")::text = ANY (ARRAY[('valid'::character varying)::text, ('trial'::character varying)::text, ('invalid'::character varying)::text, ('mismatched'::character varying)::text, ('astray'::character varying)::text, ('unknown'::character varying)::text])))
);


ALTER TABLE public.plugins OWNER TO craft;

--
-- Name: plugins_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.plugins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plugins_id_seq OWNER TO craft;

--
-- Name: plugins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.plugins_id_seq OWNED BY public.plugins.id;


--
-- Name: projectconfig; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.projectconfig (
    path character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.projectconfig OWNER TO craft;

--
-- Name: queue; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.queue (
    id integer NOT NULL,
    channel character varying(255) DEFAULT 'queue'::character varying NOT NULL,
    job bytea NOT NULL,
    description text,
    "timePushed" integer NOT NULL,
    ttr integer NOT NULL,
    delay integer DEFAULT 0 NOT NULL,
    priority integer DEFAULT 1024 NOT NULL,
    "dateReserved" timestamp(0) without time zone,
    "timeUpdated" integer,
    progress smallint DEFAULT 0 NOT NULL,
    "progressLabel" character varying(255),
    attempt integer,
    fail boolean DEFAULT false,
    "dateFailed" timestamp(0) without time zone,
    error text
);


ALTER TABLE public.queue OWNER TO craft;

--
-- Name: queue_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.queue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.queue_id_seq OWNER TO craft;

--
-- Name: queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.queue_id_seq OWNED BY public.queue.id;


--
-- Name: relations; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.relations (
    id integer NOT NULL,
    "fieldId" integer NOT NULL,
    "sourceId" integer NOT NULL,
    "sourceSiteId" integer,
    "targetId" integer NOT NULL,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.relations OWNER TO craft;

--
-- Name: relations_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.relations_id_seq OWNER TO craft;

--
-- Name: relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.relations_id_seq OWNED BY public.relations.id;


--
-- Name: resourcepaths; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.resourcepaths (
    hash character varying(255) NOT NULL,
    path character varying(255) NOT NULL
);


ALTER TABLE public.resourcepaths OWNER TO craft;

--
-- Name: revisions; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.revisions (
    id integer NOT NULL,
    "sourceId" integer NOT NULL,
    "creatorId" integer,
    num integer NOT NULL,
    notes text
);


ALTER TABLE public.revisions OWNER TO craft;

--
-- Name: revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.revisions_id_seq OWNER TO craft;

--
-- Name: revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.revisions_id_seq OWNED BY public.revisions.id;


--
-- Name: searchindex; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.searchindex (
    "elementId" integer NOT NULL,
    attribute character varying(25) NOT NULL,
    "fieldId" integer NOT NULL,
    "siteId" integer NOT NULL,
    keywords text NOT NULL,
    keywords_vector tsvector NOT NULL
);


ALTER TABLE public.searchindex OWNER TO craft;

--
-- Name: sections; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.sections (
    id integer NOT NULL,
    "structureId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    type character varying(255) DEFAULT 'channel'::character varying NOT NULL,
    "enableVersioning" boolean DEFAULT false NOT NULL,
    "propagationMethod" character varying(255) DEFAULT 'all'::character varying NOT NULL,
    "defaultPlacement" character varying(255) DEFAULT 'end'::character varying NOT NULL,
    "previewTargets" text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    CONSTRAINT "sections_defaultPlacement_check" CHECK ((("defaultPlacement")::text = ANY (ARRAY[('beginning'::character varying)::text, ('end'::character varying)::text]))),
    CONSTRAINT sections_type_check CHECK (((type)::text = ANY (ARRAY[('single'::character varying)::text, ('channel'::character varying)::text, ('structure'::character varying)::text])))
);


ALTER TABLE public.sections OWNER TO craft;

--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sections_id_seq OWNER TO craft;

--
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.sections_id_seq OWNED BY public.sections.id;


--
-- Name: sections_sites; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.sections_sites (
    id integer NOT NULL,
    "sectionId" integer NOT NULL,
    "siteId" integer NOT NULL,
    "hasUrls" boolean DEFAULT true NOT NULL,
    "uriFormat" text,
    template character varying(500),
    "enabledByDefault" boolean DEFAULT true NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.sections_sites OWNER TO craft;

--
-- Name: sections_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.sections_sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sections_sites_id_seq OWNER TO craft;

--
-- Name: sections_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.sections_sites_id_seq OWNED BY public.sections_sites.id;


--
-- Name: sequences; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.sequences (
    name character varying(255) NOT NULL,
    next integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.sequences OWNER TO craft;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    token character(100) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.sessions OWNER TO craft;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO craft;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: shunnedmessages; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.shunnedmessages (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    message character varying(255) NOT NULL,
    "expiryDate" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.shunnedmessages OWNER TO craft;

--
-- Name: shunnedmessages_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.shunnedmessages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shunnedmessages_id_seq OWNER TO craft;

--
-- Name: shunnedmessages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.shunnedmessages_id_seq OWNED BY public.shunnedmessages.id;


--
-- Name: sitegroups; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.sitegroups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.sitegroups OWNER TO craft;

--
-- Name: sitegroups_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.sitegroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sitegroups_id_seq OWNER TO craft;

--
-- Name: sitegroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.sitegroups_id_seq OWNED BY public.sitegroups.id;


--
-- Name: sites; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.sites (
    id integer NOT NULL,
    "groupId" integer NOT NULL,
    "primary" boolean NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    language character varying(12) NOT NULL,
    "hasUrls" boolean DEFAULT false NOT NULL,
    "baseUrl" character varying(255),
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.sites OWNER TO craft;

--
-- Name: sites_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sites_id_seq OWNER TO craft;

--
-- Name: sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.sites_id_seq OWNED BY public.sites.id;


--
-- Name: structureelements; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.structureelements (
    id integer NOT NULL,
    "structureId" integer NOT NULL,
    "elementId" integer,
    root integer,
    lft integer NOT NULL,
    rgt integer NOT NULL,
    level smallint NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.structureelements OWNER TO craft;

--
-- Name: structureelements_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.structureelements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.structureelements_id_seq OWNER TO craft;

--
-- Name: structureelements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.structureelements_id_seq OWNED BY public.structureelements.id;


--
-- Name: structures; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.structures (
    id integer NOT NULL,
    "maxLevels" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.structures OWNER TO craft;

--
-- Name: structures_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.structures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.structures_id_seq OWNER TO craft;

--
-- Name: structures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.structures_id_seq OWNED BY public.structures.id;


--
-- Name: supertableblocks; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.supertableblocks (
    id integer NOT NULL,
    "ownerId" integer NOT NULL,
    "fieldId" integer NOT NULL,
    "typeId" integer NOT NULL,
    "sortOrder" smallint,
    "deletedWithOwner" boolean,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.supertableblocks OWNER TO craft;

--
-- Name: supertableblocktypes; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.supertableblocktypes (
    id integer NOT NULL,
    "fieldId" integer NOT NULL,
    "fieldLayoutId" integer,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.supertableblocktypes OWNER TO craft;

--
-- Name: supertableblocktypes_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.supertableblocktypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supertableblocktypes_id_seq OWNER TO craft;

--
-- Name: supertableblocktypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.supertableblocktypes_id_seq OWNED BY public.supertableblocktypes.id;


--
-- Name: systemmessages; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.systemmessages (
    id integer NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    subject text NOT NULL,
    body text NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.systemmessages OWNER TO craft;

--
-- Name: systemmessages_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.systemmessages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.systemmessages_id_seq OWNER TO craft;

--
-- Name: systemmessages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.systemmessages_id_seq OWNED BY public.systemmessages.id;


--
-- Name: taggroups; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.taggroups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    "fieldLayoutId" integer,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.taggroups OWNER TO craft;

--
-- Name: taggroups_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.taggroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggroups_id_seq OWNER TO craft;

--
-- Name: taggroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.taggroups_id_seq OWNED BY public.taggroups.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    "groupId" integer NOT NULL,
    "deletedWithGroup" boolean,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.tags OWNER TO craft;

--
-- Name: templatecacheelements; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.templatecacheelements (
    id integer NOT NULL,
    "cacheId" integer NOT NULL,
    "elementId" integer NOT NULL
);


ALTER TABLE public.templatecacheelements OWNER TO craft;

--
-- Name: templatecacheelements_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.templatecacheelements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templatecacheelements_id_seq OWNER TO craft;

--
-- Name: templatecacheelements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.templatecacheelements_id_seq OWNED BY public.templatecacheelements.id;


--
-- Name: templatecachequeries; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.templatecachequeries (
    id integer NOT NULL,
    "cacheId" integer NOT NULL,
    type character varying(255) NOT NULL,
    query text NOT NULL
);


ALTER TABLE public.templatecachequeries OWNER TO craft;

--
-- Name: templatecachequeries_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.templatecachequeries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templatecachequeries_id_seq OWNER TO craft;

--
-- Name: templatecachequeries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.templatecachequeries_id_seq OWNED BY public.templatecachequeries.id;


--
-- Name: templatecaches; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.templatecaches (
    id integer NOT NULL,
    "siteId" integer NOT NULL,
    "cacheKey" character varying(255) NOT NULL,
    path character varying(255),
    "expiryDate" timestamp(0) without time zone NOT NULL,
    body text NOT NULL
);


ALTER TABLE public.templatecaches OWNER TO craft;

--
-- Name: templatecaches_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.templatecaches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templatecaches_id_seq OWNER TO craft;

--
-- Name: templatecaches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.templatecaches_id_seq OWNED BY public.templatecaches.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.tokens (
    id integer NOT NULL,
    token character(32) NOT NULL,
    route text,
    "usageLimit" smallint,
    "usageCount" smallint,
    "expiryDate" timestamp(0) without time zone NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.tokens OWNER TO craft;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_seq OWNER TO craft;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: universaldamintegrator_asset_metadata; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.universaldamintegrator_asset_metadata (
    id integer NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL,
    "assetId" integer NOT NULL,
    dam_meta_key character varying(255) NOT NULL,
    dam_meta_value character varying(1000) NOT NULL
);


ALTER TABLE public.universaldamintegrator_asset_metadata OWNER TO craft;

--
-- Name: universaldamintegrator_asset_metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.universaldamintegrator_asset_metadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.universaldamintegrator_asset_metadata_id_seq OWNER TO craft;

--
-- Name: universaldamintegrator_asset_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.universaldamintegrator_asset_metadata_id_seq OWNED BY public.universaldamintegrator_asset_metadata.id;


--
-- Name: usergroups; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.usergroups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    description text,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.usergroups OWNER TO craft;

--
-- Name: usergroups_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.usergroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usergroups_id_seq OWNER TO craft;

--
-- Name: usergroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.usergroups_id_seq OWNED BY public.usergroups.id;


--
-- Name: usergroups_users; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.usergroups_users (
    id integer NOT NULL,
    "groupId" integer NOT NULL,
    "userId" integer NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.usergroups_users OWNER TO craft;

--
-- Name: usergroups_users_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.usergroups_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usergroups_users_id_seq OWNER TO craft;

--
-- Name: usergroups_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.usergroups_users_id_seq OWNED BY public.usergroups_users.id;


--
-- Name: userpermissions; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.userpermissions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.userpermissions OWNER TO craft;

--
-- Name: userpermissions_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.userpermissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userpermissions_id_seq OWNER TO craft;

--
-- Name: userpermissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.userpermissions_id_seq OWNED BY public.userpermissions.id;


--
-- Name: userpermissions_usergroups; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.userpermissions_usergroups (
    id integer NOT NULL,
    "permissionId" integer NOT NULL,
    "groupId" integer NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.userpermissions_usergroups OWNER TO craft;

--
-- Name: userpermissions_usergroups_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.userpermissions_usergroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userpermissions_usergroups_id_seq OWNER TO craft;

--
-- Name: userpermissions_usergroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.userpermissions_usergroups_id_seq OWNED BY public.userpermissions_usergroups.id;


--
-- Name: userpermissions_users; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.userpermissions_users (
    id integer NOT NULL,
    "permissionId" integer NOT NULL,
    "userId" integer NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.userpermissions_users OWNER TO craft;

--
-- Name: userpermissions_users_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.userpermissions_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userpermissions_users_id_seq OWNER TO craft;

--
-- Name: userpermissions_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.userpermissions_users_id_seq OWNED BY public.userpermissions_users.id;


--
-- Name: userpreferences; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.userpreferences (
    "userId" integer NOT NULL,
    preferences text
);


ALTER TABLE public.userpreferences OWNER TO craft;

--
-- Name: userpreferences_userId_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public."userpreferences_userId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userpreferences_userId_seq" OWNER TO craft;

--
-- Name: userpreferences_userId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public."userpreferences_userId_seq" OWNED BY public.userpreferences."userId";


--
-- Name: users; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    "photoId" integer,
    "firstName" character varying(100),
    "lastName" character varying(100),
    email character varying(255) NOT NULL,
    password character varying(255),
    admin boolean DEFAULT false NOT NULL,
    locked boolean DEFAULT false NOT NULL,
    suspended boolean DEFAULT false NOT NULL,
    pending boolean DEFAULT false NOT NULL,
    "lastLoginDate" timestamp(0) without time zone,
    "lastLoginAttemptIp" character varying(45),
    "invalidLoginWindowStart" timestamp(0) without time zone,
    "invalidLoginCount" smallint,
    "lastInvalidLoginDate" timestamp(0) without time zone,
    "lockoutDate" timestamp(0) without time zone,
    "hasDashboard" boolean DEFAULT false NOT NULL,
    "verificationCode" character varying(255),
    "verificationCodeIssuedDate" timestamp(0) without time zone,
    "unverifiedEmail" character varying(255),
    "passwordResetRequired" boolean DEFAULT false NOT NULL,
    "lastPasswordChangeDate" timestamp(0) without time zone,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.users OWNER TO craft;

--
-- Name: volumefolders; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.volumefolders (
    id integer NOT NULL,
    "parentId" integer,
    "volumeId" integer,
    name character varying(255) NOT NULL,
    path character varying(255),
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.volumefolders OWNER TO craft;

--
-- Name: volumefolders_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.volumefolders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volumefolders_id_seq OWNER TO craft;

--
-- Name: volumefolders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.volumefolders_id_seq OWNED BY public.volumefolders.id;


--
-- Name: volumes; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.volumes (
    id integer NOT NULL,
    "fieldLayoutId" integer,
    name character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    "hasUrls" boolean DEFAULT true NOT NULL,
    url character varying(255),
    "titleTranslationMethod" character varying(255) DEFAULT 'site'::character varying NOT NULL,
    "titleTranslationKeyFormat" text,
    settings text,
    "sortOrder" smallint,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    "dateDeleted" timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.volumes OWNER TO craft;

--
-- Name: volumes_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.volumes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volumes_id_seq OWNER TO craft;

--
-- Name: volumes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.volumes_id_seq OWNED BY public.volumes.id;


--
-- Name: widgets; Type: TABLE; Schema: public; Owner: craft
--

CREATE TABLE public.widgets (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    type character varying(255) NOT NULL,
    "sortOrder" smallint,
    colspan smallint,
    settings text,
    enabled boolean DEFAULT true NOT NULL,
    "dateCreated" timestamp(0) without time zone NOT NULL,
    "dateUpdated" timestamp(0) without time zone NOT NULL,
    uid character(36) DEFAULT '0'::bpchar NOT NULL
);


ALTER TABLE public.widgets OWNER TO craft;

--
-- Name: widgets_id_seq; Type: SEQUENCE; Schema: public; Owner: craft
--

CREATE SEQUENCE public.widgets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.widgets_id_seq OWNER TO craft;

--
-- Name: widgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: craft
--

ALTER SEQUENCE public.widgets_id_seq OWNED BY public.widgets.id;


--
-- Name: announcements id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.announcements ALTER COLUMN id SET DEFAULT nextval('public.announcements_id_seq'::regclass);


--
-- Name: assetindexdata id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assetindexdata ALTER COLUMN id SET DEFAULT nextval('public.assetindexdata_id_seq'::regclass);


--
-- Name: assettransformindex id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assettransformindex ALTER COLUMN id SET DEFAULT nextval('public.assettransformindex_id_seq'::regclass);


--
-- Name: assettransforms id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assettransforms ALTER COLUMN id SET DEFAULT nextval('public.assettransforms_id_seq'::regclass);


--
-- Name: categorygroups id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categorygroups ALTER COLUMN id SET DEFAULT nextval('public.categorygroups_id_seq'::regclass);


--
-- Name: categorygroups_sites id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categorygroups_sites ALTER COLUMN id SET DEFAULT nextval('public.categorygroups_sites_id_seq'::regclass);


--
-- Name: content id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.content ALTER COLUMN id SET DEFAULT nextval('public.content_id_seq'::regclass);


--
-- Name: craftidtokens id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.craftidtokens ALTER COLUMN id SET DEFAULT nextval('public.craftidtokens_id_seq'::regclass);


--
-- Name: deprecationerrors id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.deprecationerrors ALTER COLUMN id SET DEFAULT nextval('public.deprecationerrors_id_seq'::regclass);


--
-- Name: drafts id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.drafts ALTER COLUMN id SET DEFAULT nextval('public.drafts_id_seq'::regclass);


--
-- Name: elementindexsettings id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elementindexsettings ALTER COLUMN id SET DEFAULT nextval('public.elementindexsettings_id_seq'::regclass);


--
-- Name: elements id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elements ALTER COLUMN id SET DEFAULT nextval('public.elements_id_seq'::regclass);


--
-- Name: elements_sites id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elements_sites ALTER COLUMN id SET DEFAULT nextval('public.elements_sites_id_seq'::regclass);


--
-- Name: entrytypes id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.entrytypes ALTER COLUMN id SET DEFAULT nextval('public.entrytypes_id_seq'::regclass);


--
-- Name: fieldgroups id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldgroups ALTER COLUMN id SET DEFAULT nextval('public.fieldgroups_id_seq'::regclass);


--
-- Name: fieldlayoutfields id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldlayoutfields ALTER COLUMN id SET DEFAULT nextval('public.fieldlayoutfields_id_seq'::regclass);


--
-- Name: fieldlayouts id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldlayouts ALTER COLUMN id SET DEFAULT nextval('public.fieldlayouts_id_seq'::regclass);


--
-- Name: fieldlayouttabs id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldlayouttabs ALTER COLUMN id SET DEFAULT nextval('public.fieldlayouttabs_id_seq'::regclass);


--
-- Name: fields id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fields ALTER COLUMN id SET DEFAULT nextval('public.fields_id_seq'::regclass);


--
-- Name: globalsets id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.globalsets ALTER COLUMN id SET DEFAULT nextval('public.globalsets_id_seq'::regclass);


--
-- Name: gqlschemas id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.gqlschemas ALTER COLUMN id SET DEFAULT nextval('public.gqlschemas_id_seq'::regclass);


--
-- Name: gqltokens id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.gqltokens ALTER COLUMN id SET DEFAULT nextval('public.gqltokens_id_seq'::regclass);


--
-- Name: info id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.info ALTER COLUMN id SET DEFAULT nextval('public.info_id_seq'::regclass);


--
-- Name: lenz_linkfield id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.lenz_linkfield ALTER COLUMN id SET DEFAULT nextval('public.lenz_linkfield_id_seq'::regclass);


--
-- Name: matrixblocktypes id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.matrixblocktypes ALTER COLUMN id SET DEFAULT nextval('public.matrixblocktypes_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: neoblockstructures id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblockstructures ALTER COLUMN id SET DEFAULT nextval('public.neoblockstructures_id_seq'::regclass);


--
-- Name: neoblocktypegroups id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocktypegroups ALTER COLUMN id SET DEFAULT nextval('public.neoblocktypegroups_id_seq'::regclass);


--
-- Name: neoblocktypes id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocktypes ALTER COLUMN id SET DEFAULT nextval('public.neoblocktypes_id_seq'::regclass);


--
-- Name: plugins id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.plugins ALTER COLUMN id SET DEFAULT nextval('public.plugins_id_seq'::regclass);


--
-- Name: queue id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.queue ALTER COLUMN id SET DEFAULT nextval('public.queue_id_seq'::regclass);


--
-- Name: relations id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.relations ALTER COLUMN id SET DEFAULT nextval('public.relations_id_seq'::regclass);


--
-- Name: revisions id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.revisions ALTER COLUMN id SET DEFAULT nextval('public.revisions_id_seq'::regclass);


--
-- Name: sections id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sections ALTER COLUMN id SET DEFAULT nextval('public.sections_id_seq'::regclass);


--
-- Name: sections_sites id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sections_sites ALTER COLUMN id SET DEFAULT nextval('public.sections_sites_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: shunnedmessages id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.shunnedmessages ALTER COLUMN id SET DEFAULT nextval('public.shunnedmessages_id_seq'::regclass);


--
-- Name: sitegroups id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sitegroups ALTER COLUMN id SET DEFAULT nextval('public.sitegroups_id_seq'::regclass);


--
-- Name: sites id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sites ALTER COLUMN id SET DEFAULT nextval('public.sites_id_seq'::regclass);


--
-- Name: structureelements id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.structureelements ALTER COLUMN id SET DEFAULT nextval('public.structureelements_id_seq'::regclass);


--
-- Name: structures id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.structures ALTER COLUMN id SET DEFAULT nextval('public.structures_id_seq'::regclass);


--
-- Name: supertableblocktypes id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.supertableblocktypes ALTER COLUMN id SET DEFAULT nextval('public.supertableblocktypes_id_seq'::regclass);


--
-- Name: systemmessages id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.systemmessages ALTER COLUMN id SET DEFAULT nextval('public.systemmessages_id_seq'::regclass);


--
-- Name: taggroups id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.taggroups ALTER COLUMN id SET DEFAULT nextval('public.taggroups_id_seq'::regclass);


--
-- Name: templatecacheelements id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.templatecacheelements ALTER COLUMN id SET DEFAULT nextval('public.templatecacheelements_id_seq'::regclass);


--
-- Name: templatecachequeries id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.templatecachequeries ALTER COLUMN id SET DEFAULT nextval('public.templatecachequeries_id_seq'::regclass);


--
-- Name: templatecaches id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.templatecaches ALTER COLUMN id SET DEFAULT nextval('public.templatecaches_id_seq'::regclass);


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: universaldamintegrator_asset_metadata id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.universaldamintegrator_asset_metadata ALTER COLUMN id SET DEFAULT nextval('public.universaldamintegrator_asset_metadata_id_seq'::regclass);


--
-- Name: usergroups id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.usergroups ALTER COLUMN id SET DEFAULT nextval('public.usergroups_id_seq'::regclass);


--
-- Name: usergroups_users id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.usergroups_users ALTER COLUMN id SET DEFAULT nextval('public.usergroups_users_id_seq'::regclass);


--
-- Name: userpermissions id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpermissions ALTER COLUMN id SET DEFAULT nextval('public.userpermissions_id_seq'::regclass);


--
-- Name: userpermissions_usergroups id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpermissions_usergroups ALTER COLUMN id SET DEFAULT nextval('public.userpermissions_usergroups_id_seq'::regclass);


--
-- Name: userpermissions_users id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpermissions_users ALTER COLUMN id SET DEFAULT nextval('public.userpermissions_users_id_seq'::regclass);


--
-- Name: userpreferences userId; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpreferences ALTER COLUMN "userId" SET DEFAULT nextval('public."userpreferences_userId_seq"'::regclass);


--
-- Name: volumefolders id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.volumefolders ALTER COLUMN id SET DEFAULT nextval('public.volumefolders_id_seq'::regclass);


--
-- Name: volumes id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.volumes ALTER COLUMN id SET DEFAULT nextval('public.volumes_id_seq'::regclass);


--
-- Name: widgets id; Type: DEFAULT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.widgets ALTER COLUMN id SET DEFAULT nextval('public.widgets_id_seq'::regclass);


--
-- Data for Name: announcements; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.announcements (id, "userId", "pluginId", heading, body, unread, "dateRead", "dateCreated") FROM stdin;
\.


--
-- Data for Name: assetindexdata; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.assetindexdata (id, "sessionId", "volumeId", uri, size, "timestamp", "recordId", "inProgress", completed, "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.assets (id, "volumeId", "folderId", "uploaderId", filename, kind, width, height, size, "focalPoint", "deletedWithVolume", "keptFile", "dateModified", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: assettransformindex; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.assettransformindex (id, "assetId", filename, format, location, "volumeId", "fileExists", "inProgress", error, "dateIndexed", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: assettransforms; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.assettransforms (id, name, handle, mode, "position", width, height, format, quality, interlace, "dimensionChangeTime", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.categories (id, "groupId", "parentId", "deletedWithGroup", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: categorygroups; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.categorygroups (id, "structureId", "fieldLayoutId", name, handle, "defaultPlacement", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
6	6	41	Search Filters	searchFilters	end	2022-04-15 04:01:17	2022-04-15 04:01:17	\N	0928ff1a-513d-41e0-acc1-606d93988618
7	7	42	Sort Options	sortOptions	end	2022-04-15 04:01:17	2022-04-15 04:01:17	\N	70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2
1	1	23	Event Filters	eventFilters	end	2022-04-15 04:01:10	2022-04-15 04:01:10	2022-04-15 04:21:17	3a3af2ab-b037-455a-ba95-bc3be89efdb0
5	5	40	Gallery Types	galleryTypes	end	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:21	4ead9327-61fc-4b46-810c-5f490c2c45ad
4	4	38	Job Types	jobTypes	end	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:24	cc8c47f0-3dec-44db-a47f-7ca6c984864a
2	2	34	Location	location	end	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:26	df7f4ec2-58b2-4c3a-afff-b07f4764fa4b
3	3	36	News Filters	newsFilters	end	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:29	7cb3bc06-c4c4-4017-8c0c-fa6aad7cbd8e
8	8	43	Staff Filters	staffFilters	end	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:34	aa60fd40-45d4-48bb-8b81-8ec736456687
\.


--
-- Data for Name: categorygroups_sites; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.categorygroups_sites (id, "groupId", "siteId", "hasUrls", "uriFormat", template, "dateCreated", "dateUpdated", uid) FROM stdin;
1	1	2	t	event-filters/{slug}	\N	2022-04-15 04:01:10	2022-04-15 04:01:10	c6f3dfc9-1e34-4710-95d7-b44cb9403c17
2	1	1	t	event-filters/{slug}	\N	2022-04-15 04:01:10	2022-04-15 04:01:10	117ae6da-7705-4227-ac27-f419c52a2537
3	2	2	t	location/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	23f7ded3-8d6e-40ba-9c82-f86626ee233a
4	2	1	t	location/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	d7e66745-9be1-4f7b-ba3e-1833e538331c
5	3	2	t	news-filters/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	3a1227ce-98f3-4cf5-8b98-b580b5913bb6
6	3	1	t	news-filters/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	ce86ac05-77e6-44e6-8433-d39ccf2d3b96
7	4	2	t	job-types/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	1f54a4c0-fa56-499c-8957-2fa819b4ec8f
8	4	1	t	job-types/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	aa6dc761-f5f5-4c96-b065-d62c0de83fd2
9	5	2	t	gallery-types/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	262d5e52-25d5-4045-9ddd-bc6f7dcb0886
10	5	1	t	gallery-types/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	43a2a0f0-b5e3-4a16-9391-aa23c0c041ce
11	6	2	f	\N	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	e572ae5c-c18d-4439-a736-ec6ea4808803
12	6	1	f	\N	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	4493f519-bafe-459f-a5e6-fcf12808e12b
13	7	2	t	sort-options/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	adbc402b-af6f-4b08-a1e1-73bc4f5cf9ce
14	7	1	t	sort-options/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	26de4915-0f13-4f7b-a551-31abcf48375f
15	8	2	t	staff-filters/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	2bce64a1-bddd-4ff6-ab0e-54b639963fd2
16	8	1	t	staff-filters/{slug}	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	17552ef6-46d8-446d-81c7-3fcd4e95a05d
\.


--
-- Data for Name: changedattributes; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.changedattributes ("elementId", "siteId", attribute, "dateUpdated", propagated, "userId") FROM stdin;
13	2	slug	2022-04-15 04:30:28	t	12
13	2	uri	2022-04-15 04:30:28	t	12
13	2	title	2022-04-15 04:30:28	t	12
13	1	slug	2022-04-15 04:30:28	f	12
13	1	uri	2022-04-15 04:30:28	f	12
13	1	title	2022-04-15 04:30:28	f	12
14	2	title	2022-04-15 04:33:08	t	12
14	1	title	2022-04-15 04:33:08	f	12
14	2	slug	2022-04-17 01:27:38	t	12
14	2	uri	2022-04-17 01:27:38	t	12
14	1	slug	2022-04-17 01:27:38	f	12
14	1	uri	2022-04-17 01:27:38	f	12
5	1	title	2022-04-17 16:57:21	t	12
5	2	title	2022-04-17 16:57:21	f	12
12	1	fieldLayoutId	2022-04-17 17:03:17	f	12
12	1	username	2022-04-17 17:03:17	f	12
12	1	firstName	2022-04-17 17:03:17	f	12
12	1	lastName	2022-04-17 17:03:17	f	12
12	1	email	2022-04-17 17:03:17	f	12
12	1	password	2022-04-17 17:03:17	f	12
12	1	lastPasswordChangeDate	2022-04-17 17:03:17	f	12
\.


--
-- Data for Name: changedfields; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.changedfields ("elementId", "siteId", "fieldId", "dateUpdated", propagated, "userId") FROM stdin;
13	2	70	2022-04-15 04:30:33	t	12
14	1	103	2022-04-15 04:33:12	f	12
14	2	103	2022-04-15 04:33:20	t	12
5	2	140	2022-04-17 00:45:26	t	12
5	1	140	2022-04-17 00:45:26	f	12
14	2	140	2022-04-17 00:45:33	t	12
14	1	140	2022-04-17 00:45:33	f	12
5	1	103	2022-04-17 00:48:00	f	12
5	1	141	2022-04-17 16:43:41	f	12
14	1	141	2022-04-17 16:43:53	f	12
5	2	141	2022-04-17 16:57:21	f	12
\.


--
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.content (id, "elementId", "siteId", title, "dateCreated", "dateUpdated", uid, "field_altText", "field_linkText", "field_plainText", "field_siteDescription", "field_siteTitle", field_text, "field_pageType_kxxunrnk") FROM stdin;
11	6	1	Homepage	2022-04-15 04:01:19	2022-04-15 04:01:19	308af40c-5c97-4c36-97a3-81401780577b	\N	\N	\N	\N	\N	\N	\N
12	6	2	Homepage	2022-04-15 04:01:19	2022-04-15 04:01:19	69d6cfe2-6f39-42f1-be7c-370eea020ba6	\N	\N	\N	\N	\N	\N	\N
17	9	1	User Profile	2022-04-15 04:01:21	2022-04-15 04:01:21	3167188e-9c2e-44e4-b076-692c0c6147a4	\N	\N	\N	\N	\N	\N	\N
18	9	2	User Profile	2022-04-15 04:01:21	2022-04-15 04:01:21	02e10a15-a1ca-4198-b886-0ef0521e4d73	\N	\N	\N	\N	\N	\N	\N
21	11	1	User Profile Page	2022-04-15 04:01:22	2022-04-15 04:01:22	a542e2b0-6326-4e49-b433-b20fd00f20ab	\N	\N	\N	\N	\N	\N	\N
22	11	2	User Profile Page	2022-04-15 04:01:22	2022-04-15 04:01:22	df3be416-0084-40bd-b6e5-2595806def34	\N	\N	\N	\N	\N	\N	\N
3	2	1	\N	2022-04-15 04:01:09	2022-04-15 04:01:30	58c8f2dc-8dc1-4973-96b0-75d51d0fa1a5	\N	\N	\N	\N	\N	\N	\N
4	2	2	\N	2022-04-15 04:01:09	2022-04-15 04:01:30	3ac24931-f11c-4fa5-98eb-98aaf26bd435	\N	\N	\N	\N	\N	\N	\N
5	3	1	\N	2022-04-15 04:01:09	2022-04-15 04:01:30	93a73467-8460-4c5a-b680-7cb60bac2156	\N	\N	\N	\N	\N	\N	\N
6	3	2	\N	2022-04-15 04:01:09	2022-04-15 04:01:30	41f33aa9-ff3a-4089-8410-54d7d59a921f	\N	\N	\N	\N	\N	\N	\N
7	4	1	\N	2022-04-15 04:01:17	2022-04-15 04:01:30	116c02e0-9b49-4e5b-9919-ab535284e627	\N	\N	\N	\N	\N	\N	\N
8	4	2	\N	2022-04-15 04:01:17	2022-04-15 04:01:30	12def2d3-df88-4167-8ecb-38ab69cb6e03	\N	\N	\N	\N	\N	\N	\N
24	13	1	Test Page	2022-04-15 04:30:24	2022-04-15 04:30:33	4196f2a2-b00d-4f01-ad24-f18f98a9e34e	\N	\N	\N	\N	\N	\N	\N
25	13	2	Test Page	2022-04-15 04:30:24	2022-04-15 04:30:33	a40f1926-41ac-4e71-87fb-24e2381e2197	\N	\N	\N	\N	\N	\N	\N
28	15	1	Test Page Title	2022-04-15 04:33:20	2022-04-15 04:33:20	dc64082c-8a5b-4b75-b076-176dac3e57c6	\N	\N	\N	\N	\N	<p>Test Page Text</p>	\N
29	15	2	Test Page Title	2022-04-15 04:33:21	2022-04-15 04:33:21	1a4172d9-9e09-4c89-adce-e67fc3101506	\N	\N	\N	\N	\N	<p>Test Page Text</p>	\N
38	20	1	Homepage	2022-04-17 00:43:45	2022-04-17 00:43:45	5ee1331b-e353-42e3-b057-08346ba283f0	\N	\N	\N	\N	\N	\N	\N
39	20	2	Homepage	2022-04-17 00:43:45	2022-04-17 00:43:45	5a8f746f-d0d9-4667-8c2a-4926408760f0	\N	\N	\N	\N	\N	\N	\N
30	16	1	User Profile Page	2022-04-17 00:24:14	2022-04-17 00:24:14	909af8aa-2d9e-4720-8b1a-95559be0d7d9	\N	\N	\N	\N	\N	\N	\N
31	16	2	User Profile Page	2022-04-17 00:24:14	2022-04-17 00:24:14	344b123a-665c-4c83-8090-8bf4d9b1b622	\N	\N	\N	\N	\N	\N	\N
46	24	1	Test Page Title	2022-04-17 00:45:33	2022-04-17 00:45:33	46a85d9e-a4b1-4cfd-bf94-553d116f3b1a	\N	\N	\N	\N	\N	<p>Test Page Text</p>	standard
47	24	2	Test Page Title	2022-04-17 00:45:33	2022-04-17 00:45:33	0df0408e-bfc5-4160-b485-9f0f09f12b7a	\N	\N	\N	\N	\N	<p>Test Page Text</p>	standard
32	17	1	User Profile	2022-04-17 00:24:14	2022-04-17 00:24:14	2fedfee2-205b-4177-8c60-77bb8a7a7d0a	\N	\N	\N	\N	\N	\N	\N
33	17	2	User Profile	2022-04-17 00:24:14	2022-04-17 00:24:14	0310419b-5e97-4268-8338-f1c33e5d6810	\N	\N	\N	\N	\N	\N	\N
26	14	1	Test Page Title	2022-04-15 04:33:02	2022-04-17 16:43:53	b549262b-a5fe-46ad-9c44-ad77a973c362	\N	\N	\N	\N	\N	<p>Test Page Text</p>	standard
27	14	2	Test Page Title	2022-04-15 04:33:02	2022-04-17 16:43:53	b7166689-6207-4a36-b68e-b947ccf260dd	\N	\N	\N	\N	\N	<p>Test Page Text</p>	standard
34	18	1	Homepage	2022-04-17 00:24:14	2022-04-17 00:24:14	45e45d19-3764-4665-b114-63e4026ea662	\N	\N	\N	\N	\N	\N	\N
35	18	2	Homepage	2022-04-17 00:24:14	2022-04-17 00:24:14	68ebb19d-cd41-457a-b322-6adb1948d8aa	\N	\N	\N	\N	\N	\N	\N
19	10	1	User Profile Page	2022-04-15 04:01:22	2022-04-17 00:24:14	fa88ae19-35a7-48ba-baa1-50b10639641b	\N	\N	\N	\N	\N	\N	\N
20	10	2	User Profile Page	2022-04-15 04:01:22	2022-04-17 00:24:14	0ea36d0b-7a46-4654-9053-37ec5f201fe3	\N	\N	\N	\N	\N	\N	\N
15	8	1	User Profile	2022-04-15 04:01:21	2022-04-17 00:24:14	40b89862-1888-48bc-b52e-f71fa86e30d2	\N	\N	\N	\N	\N	\N	\N
16	8	2	User Profile	2022-04-15 04:01:21	2022-04-17 00:24:14	ab87ddbd-c7c6-47d4-92f1-26f3f8d39d2e	\N	\N	\N	\N	\N	\N	\N
13	7	1	Search Results	2022-04-15 04:01:20	2022-04-17 00:24:14	eba3a9ab-e61b-47df-a10c-61503ee65feb	\N	\N	\N	\N	\N	\N	\N
14	7	2	Search Results	2022-04-15 04:01:20	2022-04-17 00:24:14	a0023a09-c833-4403-83ff-e4671d397ac0	\N	\N	\N	\N	\N	\N	\N
42	22	1	Homepage	2022-04-17 00:45:26	2022-04-17 00:45:26	fdefba2b-0336-40cb-8223-78a18caa95a6	\N	\N	\N	\N	\N	\N	standard
43	22	2	Homepage	2022-04-17 00:45:26	2022-04-17 00:45:26	e6da311d-87a4-4c38-95ff-333726105f3f	\N	\N	\N	\N	\N	\N	standard
1	1	1	\N	2022-04-15 04:01:09	2022-04-17 00:24:15	046343a0-b731-40c3-8863-9144ecff9b91	\N	\N	\N	Site Description	Site title	\N	\N
2	1	2	\N	2022-04-15 04:01:09	2022-04-17 00:24:15	66467490-6389-411d-8c87-9881f0a89ba5	\N	\N	\N	\N	\N	\N	\N
36	19	1	Homepage	2022-04-17 00:37:45	2022-04-17 00:37:45	2f5a54c3-ee7a-4f15-b413-7854be821def	\N	\N	\N	\N	\N	\N	\N
37	19	2	Homepage	2022-04-17 00:37:45	2022-04-17 00:37:45	44028044-5797-4c79-bf89-5b033a19db50	\N	\N	\N	\N	\N	\N	\N
56	29	1	Homepage	2022-04-17 16:43:26	2022-04-17 16:43:26	e1f0759f-9a7e-4d0d-8646-ceac41753659	\N	\N	\N	\N	\N	\N	standard
57	29	2	Homepage	2022-04-17 16:43:26	2022-04-17 16:43:26	ade57d63-166a-4254-a7c7-ffe430bfa508	\N	\N	\N	\N	\N	\N	standard
60	31	1	\N	2022-04-17 16:43:35	2022-04-17 16:43:35	bd44cbda-3d70-4beb-9d57-6fbfc700b264	\N	\N	\N	\N	\N	\N	\N
61	31	2	\N	2022-04-17 16:43:35	2022-04-17 16:43:35	d69107a8-93ae-4b20-8e74-d596569faf93	\N	\N	\N	\N	\N	\N	\N
10	5	2	Spanish Homepage	2022-04-15 04:01:19	2022-04-17 16:57:21	236dc791-4323-404b-86c5-2b29abe63650	\N	\N	\N	\N	\N	\N	standard
9	5	1	Homepage	2022-04-15 04:01:19	2022-04-17 16:57:21	32fd991c-cc0e-4de2-b4d8-4c30f733f5dc	\N	\N	\N	\N	\N	<p>This is the homepage</p>	standard
50	26	1	Homepage	2022-04-17 00:48:00	2022-04-17 00:48:00	2f8c5aa1-599f-457e-8a4c-667567ecd060	\N	\N	\N	\N	\N	<p>This is the homepage</p>	standard
51	26	2	Homepage	2022-04-17 00:48:00	2022-04-17 00:48:00	9662b426-73b5-45c4-a1b1-68c3c17813e9	\N	\N	\N	\N	\N	\N	standard
23	12	1	\N	2022-04-15 04:01:35	2022-04-17 17:03:16	b490e389-8b24-43a6-b802-fd11dd2be06a	\N	\N	\N	\N	\N	\N	\N
54	28	1	Test Page Title	2022-04-17 01:27:38	2022-04-17 01:27:38	f43902d9-54ca-4a16-987e-baf61d5d3e19	\N	\N	\N	\N	\N	<p>Test Page Text</p>	standard
55	28	2	Test Page Title	2022-04-17 01:27:38	2022-04-17 01:27:38	683924fa-4d89-44fa-9c91-f2e97a589cae	\N	\N	\N	\N	\N	<p>Test Page Text</p>	standard
64	33	1	\N	2022-04-17 16:43:40	2022-04-17 16:43:40	c56827bd-87d1-493c-9443-bc1bcba24d0e	\N	\N	\N	\N	\N	<p>This is the Homepage</p>	\N
62	32	1	\N	2022-04-17 16:43:39	2022-04-17 16:43:39	559f3aa4-7e22-41d8-9db9-4f7f93acdd2a	\N	\N	\N	\N	\N	<p>This is the </p>	\N
63	32	2	\N	2022-04-17 16:43:39	2022-04-17 16:43:39	f03bf800-2f9b-431d-b110-66b1a2ed36b3	\N	\N	\N	\N	\N	<p>This is the </p>	\N
65	33	2	\N	2022-04-17 16:43:40	2022-04-17 16:43:40	d1e5f4bf-ebb8-4b29-9c42-f402b6410024	\N	\N	\N	\N	\N	<p>This is the Homepage</p>	\N
66	34	1	\N	2022-04-17 16:43:41	2022-04-17 16:43:41	c64b4fe2-4adc-4efb-9f04-0dd3b4890a39	\N	\N	\N	\N	\N	<p>This is the Homepage</p>	\N
67	34	2	\N	2022-04-17 16:43:41	2022-04-17 16:43:41	9f39d4a0-f25e-405e-8eb2-eefbbd8cc87b	\N	\N	\N	\N	\N	<p>This is the Homepage</p>	\N
68	35	1	Homepage	2022-04-17 16:43:41	2022-04-17 16:43:41	b085fa7b-41bc-49e3-864f-1ca84d53af1f	\N	\N	\N	\N	\N	\N	standard
69	35	2	Homepage	2022-04-17 16:43:41	2022-04-17 16:43:41	596f7c4e-fa90-4089-a3b7-359094799441	\N	\N	\N	\N	\N	\N	standard
70	36	1	\N	2022-04-17 16:43:41	2022-04-17 16:43:41	b5463b27-6455-4064-8627-6f7d78ab0bcb	\N	\N	\N	\N	\N	<p>This is the Homepage</p>	\N
71	36	2	\N	2022-04-17 16:43:41	2022-04-17 16:43:41	7a4e1842-d634-45fc-af0b-ad800a569ebe	\N	\N	\N	\N	\N	<p>This is the Homepage</p>	\N
74	38	1	\N	2022-04-17 16:43:46	2022-04-17 16:43:46	1e0b6f7e-38ab-4ece-87b3-e28bba4e4079	\N	\N	\N	\N	\N	\N	\N
75	38	2	\N	2022-04-17 16:43:46	2022-04-17 16:43:46	437b664d-b134-4893-bc2b-3dca7049411d	\N	\N	\N	\N	\N	\N	\N
76	39	1	\N	2022-04-17 16:43:50	2022-04-17 16:43:50	af691fd2-d4d2-47a9-b8b8-4daf965be512	\N	\N	\N	\N	\N	<p>This is the </p>	\N
77	39	2	\N	2022-04-17 16:43:50	2022-04-17 16:43:50	84d6ea29-e8f6-4006-82bb-3da7bb5e32b7	\N	\N	\N	\N	\N	<p>This is the </p>	\N
78	40	1	\N	2022-04-17 16:43:52	2022-04-17 16:43:52	4cda2a21-23dc-4096-ae4c-46cfd5910bbf	\N	\N	\N	\N	\N	<p>This is the Test Page</p>	\N
79	40	2	\N	2022-04-17 16:43:52	2022-04-17 16:43:52	bf3f75c8-15ae-401b-9fbd-c22a8a88b7ec	\N	\N	\N	\N	\N	<p>This is the Test Page</p>	\N
80	41	1	\N	2022-04-17 16:43:53	2022-04-17 16:43:53	b05152b5-ec59-46dd-98d8-0e28016e5570	\N	\N	\N	\N	\N	<p>This is the Test Page</p>	\N
81	41	2	\N	2022-04-17 16:43:53	2022-04-17 16:43:53	3a3c8737-b45d-4339-81b1-f3c49e3b160e	\N	\N	\N	\N	\N	<p>This is the Test Page</p>	\N
82	42	1	\N	2022-04-17 16:43:53	2022-04-17 16:43:53	afac4b8d-c7b5-4b87-a0dd-599f69b96bd8	\N	\N	\N	\N	\N	<p>This is the Test Page</p>	\N
83	42	2	\N	2022-04-17 16:43:53	2022-04-17 16:43:53	356d9987-9bbc-4b39-bb2f-5ed5042fced1	\N	\N	\N	\N	\N	<p>This is the Test Page</p>	\N
84	43	1	Test Page Title	2022-04-17 16:43:54	2022-04-17 16:43:54	04615a8e-98bf-4a7b-85cf-d5cf56bc8485	\N	\N	\N	\N	\N	\N	standard
85	43	2	Test Page Title	2022-04-17 16:43:54	2022-04-17 16:43:54	4cd9f094-73dd-43d3-b052-aa4fb5cefa45	\N	\N	\N	\N	\N	\N	standard
86	44	1	\N	2022-04-17 16:43:54	2022-04-17 16:43:54	c45988b6-5bd2-46e5-8640-51721361efec	\N	\N	\N	\N	\N	<p>This is the Test Page</p>	\N
87	44	2	\N	2022-04-17 16:44:09	2022-04-17 16:44:09	e37121ff-cc77-4b37-aa50-06870d24e8a7	\N	\N	\N	\N	\N	<p>This is the Test Page</p>	\N
90	46	2	\N	2022-04-17 16:57:17	2022-04-17 16:57:20	acfc6377-8243-48d3-a38f-7c4afc0dddc9	\N	\N	\N	\N	\N	<p>This is the Spanish Homepage</p>	\N
91	46	1	\N	2022-04-17 16:57:17	2022-04-17 16:57:20	8149ab2a-7576-4bcf-a42d-0f919c39e04d	\N	\N	\N	\N	\N	<p>This is the Homepage</p>	\N
92	47	2	\N	2022-04-17 16:57:21	2022-04-17 16:57:21	7b3f1b6d-5299-44e5-8276-660eb0ab51dc	\N	\N	\N	\N	\N	<p>This is the Spanish Homepage</p>	\N
93	47	1	\N	2022-04-17 16:57:21	2022-04-17 16:57:21	0db70ab0-00d8-48c2-a2a6-34afac2af1e2	\N	\N	\N	\N	\N	<p>This is the Homepage</p>	\N
94	48	2	Spanish Homepage	2022-04-17 16:57:21	2022-04-17 16:57:21	328fdcfa-2c37-480a-81ca-e078993fb1d7	\N	\N	\N	\N	\N	\N	standard
95	48	1	Homepage	2022-04-17 16:57:21	2022-04-17 16:57:21	3ef3dfe9-fa4e-4d57-8ad4-4a61bf1c78ed	\N	\N	\N	\N	\N	\N	standard
96	49	2	\N	2022-04-17 16:57:21	2022-04-17 16:57:21	627875d5-eff2-4d46-99c2-0909e854e6dd	\N	\N	\N	\N	\N	<p>This is the Spanish Homepage</p>	\N
97	49	1	\N	2022-04-17 16:57:21	2022-04-17 16:57:21	4ac27442-2f30-45fe-9052-36765d01ffa8	\N	\N	\N	\N	\N	<p>This is the Homepage</p>	\N
\.


--
-- Data for Name: craftidtokens; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.craftidtokens (id, "userId", "accessToken", "expiryDate", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: deprecationerrors; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.deprecationerrors (id, key, fingerprint, "lastOccurrence", file, line, message, traces, "dateCreated", "dateUpdated", uid) FROM stdin;
1	craft\\base\\Element::getSourceUid	__string_template__cdea43c7ab4d8073710bf2cbc6417376220398e44eb50b2025a10863324fc4b8:1	2022-04-17 16:59:46	__string_template__cdea43c7ab4d8073710bf2cbc6417376220398e44eb50b2025a10863324fc4b8	1	Elements’ `getSourceUid()` method has been deprecated. Use `getCanonicalUid()` instead.	[{"objectClass":"craft\\\\services\\\\Deprecator","file":"/var/www/html/vendor/craftcms/cms/src/base/Element.php","line":2333,"class":"craft\\\\services\\\\Deprecator","method":"log","args":"\\"craft\\\\base\\\\Element::getSourceUid\\", \\"Elements’ `getSourceUid()` method has been deprecated. Use `getC...\\""},{"objectClass":"craft\\\\elements\\\\Entry","file":"/var/www/html/vendor/yiisoft/yii2/base/Component.php","line":139,"class":"craft\\\\base\\\\Element","method":"getSourceUid","args":null},{"objectClass":"craft\\\\elements\\\\Entry","file":"/var/www/html/vendor/craftcms/cms/src/base/Element.php","line":1736,"class":"yii\\\\base\\\\Component","method":"__get","args":"\\"sourceUid\\""},{"objectClass":"craft\\\\elements\\\\Entry","file":"/var/www/html/vendor/craftcms/cms/src/helpers/Template.php","line":90,"class":"craft\\\\base\\\\Element","method":"__get","args":"\\"sourceUid\\""},{"objectClass":null,"file":"/var/www/html/storage/runtime/compiled_templates/d8/d8bfbe729a62deff92424ee405a31b315584bcc9ecc5c957d655647066a177ac.php","line":41,"class":"craft\\\\helpers\\\\Template","method":"attribute","args":"craft\\\\web\\\\twig\\\\Environment, Twig\\\\Source, craft\\\\elements\\\\Entry, \\"sourceUid\\", ..."},{"objectClass":"__TwigTemplate_ffda20b1db318ffc8e9c2c865b4d758da5246f552969a84f00b331492ecb79ce","file":"/var/www/html/vendor/twig/twig/src/Template.php","line":405,"class":"__TwigTemplate_ffda20b1db318ffc8e9c2c865b4d758da5246f552969a84f00b331492ecb79ce","method":"doDisplay","args":"[\\"sectionId\\" => 13, \\"typeId\\" => 7, \\"authorId\\" => null, \\"postDate\\" => \\"2022-04-14T21:01:00-07:00\\", ...], []"},{"objectClass":"__TwigTemplate_ffda20b1db318ffc8e9c2c865b4d758da5246f552969a84f00b331492ecb79ce","file":"/var/www/html/vendor/twig/twig/src/Template.php","line":378,"class":"Twig\\\\Template","method":"displayWithErrorHandling","args":"[\\"sectionId\\" => 13, \\"typeId\\" => 7, \\"authorId\\" => null, \\"postDate\\" => \\"2022-04-14T21:01:00-07:00\\", ...], []"},{"objectClass":"__TwigTemplate_ffda20b1db318ffc8e9c2c865b4d758da5246f552969a84f00b331492ecb79ce","file":"/var/www/html/vendor/twig/twig/src/Template.php","line":390,"class":"Twig\\\\Template","method":"display","args":"[\\"sectionId\\" => 13, \\"typeId\\" => 7, \\"authorId\\" => null, \\"postDate\\" => \\"2022-04-14T21:01:00-07:00\\", ...]"},{"objectClass":"__TwigTemplate_ffda20b1db318ffc8e9c2c865b4d758da5246f552969a84f00b331492ecb79ce","file":"/var/www/html/vendor/twig/twig/src/TemplateWrapper.php","line":45,"class":"Twig\\\\Template","method":"render","args":"[\\"sectionId\\" => 13, \\"typeId\\" => 7, \\"authorId\\" => null, \\"postDate\\" => \\"2022-04-14T21:01:00-07:00\\", ...], []"},{"objectClass":"Twig\\\\TemplateWrapper","file":"/var/www/html/vendor/craftcms/cms/src/web/View.php","line":623,"class":"Twig\\\\TemplateWrapper","method":"render","args":"[\\"sectionId\\" => 13, \\"typeId\\" => 7, \\"authorId\\" => null, \\"postDate\\" => \\"2022-04-14T21:01:00-07:00\\", ...]"},{"objectClass":"craft\\\\web\\\\View","file":"/var/www/html/vendor/craftcms/cms/src/base/Element.php","line":2662,"class":"craft\\\\web\\\\View","method":"renderObjectTemplate","args":"\\"http://localhost:3000/api/preview?site={{ (_variables.site ?? ob...\\", craft\\\\elements\\\\Entry"},{"objectClass":"craft\\\\elements\\\\Entry","file":"/var/www/html/vendor/twig/twig/src/Extension/CoreExtension.php","line":1566,"class":"craft\\\\base\\\\Element","method":"getPreviewTargets","args":null},{"objectClass":null,"file":"/var/www/html/vendor/craftcms/cms/src/helpers/Template.php","line":106,"class":null,"method":"twig_get_attribute","args":"craft\\\\web\\\\twig\\\\Environment, Twig\\\\Source, craft\\\\elements\\\\Entry, \\"getPreviewTargets\\", ..."},{"objectClass":null,"file":"/var/www/html/storage/runtime/compiled_templates/06/06c6e07463c446c52fc8f87aea3d4e051d4ac38e5f9663a8bb01b8a32e4780ba.php","line":114,"class":"craft\\\\helpers\\\\Template","method":"attribute","args":"craft\\\\web\\\\twig\\\\Environment, Twig\\\\Source, craft\\\\elements\\\\Entry, \\"getPreviewTargets\\", ..."},{"objectClass":"__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21","file":"/var/www/html/vendor/twig/twig/src/Template.php","line":405,"class":"__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21","method":"doDisplay","args":"[\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...], [\\"header\\" => [__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21, \\"block_header\\"], \\"contextMenu\\" => [__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21, \\"block_contextMenu\\"], \\"actionButton\\" => [__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21, \\"block_actionButton\\"], \\"main\\" => [__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21, \\"block_main\\"], ...]"},{"objectClass":"__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21","file":"/var/www/html/vendor/twig/twig/src/Template.php","line":378,"class":"Twig\\\\Template","method":"displayWithErrorHandling","args":"[\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...], [\\"header\\" => [__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21, \\"block_header\\"], \\"contextMenu\\" => [__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21, \\"block_contextMenu\\"], \\"actionButton\\" => [__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21, \\"block_actionButton\\"], \\"main\\" => [__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21, \\"block_main\\"], ...]"},{"objectClass":"__TwigTemplate_79742244161952c10294f09de12a48e85d1367c7e9c1109ec7a7f582c5128e21","file":"/var/www/html/storage/runtime/compiled_templates/fb/fb716e48cd6d20f76a996b0792a6e5bcc2a8d06e05ec3ab0d09bd3f6e6be1780.php","line":124,"class":"Twig\\\\Template","method":"display","args":"[\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...], [\\"content\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_content\\"], \\"settings\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_settings\\"], \\"meta\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_meta\\"], \\"details\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_details\\"]]"},{"objectClass":"__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d","file":"/var/www/html/vendor/twig/twig/src/Template.php","line":405,"class":"__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d","method":"doDisplay","args":"[\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...], [\\"content\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_content\\"], \\"settings\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_settings\\"], \\"meta\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_meta\\"], \\"details\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_details\\"]]"},{"objectClass":"__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d","file":"/var/www/html/vendor/twig/twig/src/Template.php","line":378,"class":"Twig\\\\Template","method":"displayWithErrorHandling","args":"[\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...], [\\"content\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_content\\"], \\"settings\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_settings\\"], \\"meta\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_meta\\"], \\"details\\" => [__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d, \\"block_details\\"]]"},{"objectClass":"__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d","file":"/var/www/html/vendor/twig/twig/src/Template.php","line":390,"class":"Twig\\\\Template","method":"display","args":"[\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...]"},{"objectClass":"__TwigTemplate_4a056159e6eba0195a3029ae11619fe299228b6a95a65e697cb1ad540358871d","file":"/var/www/html/vendor/twig/twig/src/TemplateWrapper.php","line":45,"class":"Twig\\\\Template","method":"render","args":"[\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...], []"},{"objectClass":"Twig\\\\TemplateWrapper","file":"/var/www/html/vendor/twig/twig/src/Environment.php","line":318,"class":"Twig\\\\TemplateWrapper","method":"render","args":"[\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...]"},{"objectClass":"craft\\\\web\\\\twig\\\\Environment","file":"/var/www/html/vendor/craftcms/cms/src/web/View.php","line":408,"class":"Twig\\\\Environment","method":"render","args":"\\"entries/_edit\\", [\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...]"},{"objectClass":"craft\\\\web\\\\View","file":"/var/www/html/vendor/craftcms/cms/src/web/View.php","line":461,"class":"craft\\\\web\\\\View","method":"renderTemplate","args":"\\"entries/_edit\\", [\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...]"},{"objectClass":"craft\\\\web\\\\View","file":"/var/www/html/vendor/craftcms/cms/src/web/Controller.php","line":201,"class":"craft\\\\web\\\\View","method":"renderPageTemplate","args":"\\"entries/_edit\\", [\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...], \\"cp\\""},{"objectClass":"craft\\\\controllers\\\\EntriesController","file":"/var/www/html/vendor/craftcms/cms/src/controllers/EntriesController.php","line":249,"class":"craft\\\\web\\\\Controller","method":"renderTemplate","args":"\\"entries/_edit\\", [\\"sectionHandle\\" => \\"homepage\\", \\"entryId\\" => 5, \\"draftId\\" => null, \\"revisionId\\" => null, ...]"},{"objectClass":"craft\\\\controllers\\\\EntriesController","file":null,"line":null,"class":"craft\\\\controllers\\\\EntriesController","method":"actionEditEntry","args":"craft\\\\models\\\\Section, 5, null, null, ..."},{"objectClass":null,"file":"/var/www/html/vendor/yiisoft/yii2/base/InlineAction.php","line":57,"class":null,"method":"call_user_func_array","args":"[craft\\\\controllers\\\\EntriesController, \\"actionEditEntry\\"], [\\"homepage\\", 5, null, null, ...]"},{"objectClass":"yii\\\\base\\\\InlineAction","file":"/var/www/html/vendor/yiisoft/yii2/base/Controller.php","line":178,"class":"yii\\\\base\\\\InlineAction","method":"runWithParams","args":"[\\"section\\" => \\"homepage\\", \\"entryId\\" => \\"5\\", \\"slug\\" => \\"-homepage\\", \\"p\\" => \\"admin/entries/homepage/5-homepage\\", ...]"},{"objectClass":"craft\\\\controllers\\\\EntriesController","file":"/var/www/html/vendor/yiisoft/yii2/base/Module.php","line":552,"class":"yii\\\\base\\\\Controller","method":"runAction","args":"\\"edit-entry\\", [\\"section\\" => \\"homepage\\", \\"entryId\\" => \\"5\\", \\"slug\\" => \\"-homepage\\", \\"p\\" => \\"admin/entries/homepage/5-homepage\\", ...]"},{"objectClass":"craft\\\\web\\\\Application","file":"/var/www/html/vendor/craftcms/cms/src/web/Application.php","line":277,"class":"yii\\\\base\\\\Module","method":"runAction","args":"\\"entries/edit-entry\\", [\\"section\\" => \\"homepage\\", \\"entryId\\" => \\"5\\", \\"slug\\" => \\"-homepage\\", \\"p\\" => \\"admin/entries/homepage/5-homepage\\", ...]"},{"objectClass":"craft\\\\web\\\\Application","file":"/var/www/html/vendor/yiisoft/yii2/web/Application.php","line":103,"class":"craft\\\\web\\\\Application","method":"runAction","args":"\\"entries/edit-entry\\", [\\"section\\" => \\"homepage\\", \\"entryId\\" => \\"5\\", \\"slug\\" => \\"-homepage\\", \\"p\\" => \\"admin/entries/homepage/5-homepage\\", ...]"},{"objectClass":"craft\\\\web\\\\Application","file":"/var/www/html/vendor/craftcms/cms/src/web/Application.php","line":262,"class":"yii\\\\web\\\\Application","method":"handleRequest","args":"craft\\\\web\\\\Request"},{"objectClass":"craft\\\\web\\\\Application","file":"/var/www/html/vendor/yiisoft/yii2/base/Application.php","line":384,"class":"craft\\\\web\\\\Application","method":"handleRequest","args":"craft\\\\web\\\\Request"},{"objectClass":"craft\\\\web\\\\Application","file":"/var/www/html/web/index.php","line":23,"class":"yii\\\\base\\\\Application","method":"run","args":null}]	2022-04-17 16:59:46	2022-04-17 16:59:46	5bfba5af-12c2-4a3e-bee4-2871002f97b3
\.


--
-- Data for Name: drafts; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.drafts (id, "sourceId", "creatorId", provisional, name, notes, "trackChanges", "dateLastMerged", saved) FROM stdin;
1	\N	12	f	First draft		f	\N	t
\.


--
-- Data for Name: elementindexsettings; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.elementindexsettings (id, type, settings, "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: elements; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.elements (id, "canonicalId", "draftId", "revisionId", "fieldLayoutId", type, enabled, archived, "dateCreated", "dateUpdated", "dateLastMerged", "dateDeleted", uid) FROM stdin;
6	5	\N	1	74	craft\\elements\\Entry	t	f	2022-04-15 04:01:19	2022-04-15 04:01:19	\N	\N	18033e43-fe36-449e-944d-7c9dd0a7050d
4	\N	\N	\N	28	craft\\elements\\GlobalSet	t	f	2022-04-15 04:01:17	2022-04-15 04:01:30	\N	2022-04-15 04:28:09	1a2ba41a-3949-4982-9cb3-f8b03863bcfd
3	\N	\N	\N	20	craft\\elements\\GlobalSet	t	f	2022-04-15 04:01:09	2022-04-15 04:01:30	\N	2022-04-15 04:28:12	b8393df9-fb81-4d70-9ccb-6d030c818580
2	\N	\N	\N	17	craft\\elements\\GlobalSet	t	f	2022-04-15 04:01:09	2022-04-15 04:01:30	\N	2022-04-15 04:28:14	994d5664-f056-4969-b2cc-c62660f069af
13	\N	1	\N	77	craft\\elements\\Entry	t	f	2022-04-15 04:30:24	2022-04-15 04:30:33	\N	2022-04-15 04:33:01	d576e2a8-ea16-47d3-8b1d-8fb815230864
15	14	\N	4	77	craft\\elements\\Entry	t	f	2022-04-15 04:33:20	2022-04-15 04:33:20	\N	\N	a70fb194-31ac-44d1-b3f7-2bc20e351193
41	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:53	2022-04-17 16:43:53	\N	2022-04-17 16:44:09	838846e6-d174-4c72-966c-e983bdd3afe9
32	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:39	2022-04-17 16:43:39	\N	2022-04-17 16:43:40	a3ba9fbc-ef02-4427-a889-2f6856322358
18	5	\N	7	74	craft\\elements\\Entry	t	f	2022-04-17 00:24:14	2022-04-17 00:24:14	\N	\N	667e979a-35df-4a42-adaa-39fec8276d30
1	\N	\N	\N	15	craft\\elements\\GlobalSet	t	f	2022-04-15 04:01:09	2022-04-17 00:24:15	\N	\N	8ccd6c1c-8e9b-44e8-93a9-f62589fb4819
7	\N	\N	\N	80	craft\\elements\\Entry	t	f	2022-04-15 04:01:20	2022-04-17 00:24:14	\N	2022-04-17 00:32:54	9eb6647e-617a-4904-ad67-78a1866d6cac
8	\N	\N	\N	84	craft\\elements\\Entry	t	f	2022-04-15 04:01:21	2022-04-17 00:24:14	\N	2022-04-17 00:32:57	7d24cbc1-999c-4cd7-8036-222fa89f2748
9	8	\N	2	84	craft\\elements\\Entry	t	f	2022-04-15 04:01:21	2022-04-15 04:01:21	\N	2022-04-17 00:32:57	71dfd86a-1071-4adc-bcfb-9a6807eb3b0f
17	8	\N	6	84	craft\\elements\\Entry	t	f	2022-04-17 00:24:14	2022-04-17 00:24:14	\N	2022-04-17 00:32:57	7d28d414-627a-44f6-8d7c-66297f3b21de
10	\N	\N	\N	85	craft\\elements\\Entry	f	f	2022-04-15 04:01:21	2022-04-17 00:24:14	\N	2022-04-17 00:33:00	ebcadb72-e0c5-475d-904a-3c4a2974d04c
11	10	\N	3	85	craft\\elements\\Entry	f	f	2022-04-15 04:01:21	2022-04-15 04:01:22	\N	2022-04-17 00:33:00	8436d04f-d340-4906-a210-8e707ce5cd11
16	10	\N	5	85	craft\\elements\\Entry	f	f	2022-04-17 00:24:14	2022-04-17 00:24:14	\N	2022-04-17 00:33:00	834549e8-60a6-454d-9f1b-de9a6c0cb26b
19	5	\N	8	74	craft\\elements\\Entry	t	f	2022-04-17 00:37:45	2022-04-17 00:37:45	\N	\N	86f6c1eb-7959-4e48-a471-a9cc24bd479b
35	5	\N	15	74	craft\\elements\\Entry	t	f	2022-04-17 16:43:41	2022-04-17 16:43:41	\N	\N	34774d3c-23ca-4a4d-9d38-8beb71a0b7a2
20	5	\N	9	74	craft\\elements\\Entry	t	f	2022-04-17 00:43:45	2022-04-17 00:43:45	\N	\N	3ea8b9b9-cc58-4a12-8c55-8f96f2e50412
36	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:41	2022-04-17 16:43:41	\N	\N	3ef88ba1-467e-4f16-815c-1bf7a9d4941f
33	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:40	2022-04-17 16:43:40	\N	2022-04-17 16:43:41	597eafe9-601a-47d7-b313-8e74b9970f91
22	5	\N	10	74	craft\\elements\\Entry	t	f	2022-04-17 00:45:26	2022-04-17 00:45:26	\N	\N	d155e552-2c2a-41eb-ac44-df68b32e1f13
24	14	\N	11	77	craft\\elements\\Entry	t	f	2022-04-17 00:45:33	2022-04-17 00:45:33	\N	\N	60fcfa2d-488c-48a1-aa9f-ff6b43b42802
26	5	\N	12	74	craft\\elements\\Entry	t	f	2022-04-17 00:48:00	2022-04-17 00:48:00	\N	\N	52aaf276-1409-4f8b-9675-95c435d38ab7
28	14	\N	13	77	craft\\elements\\Entry	t	f	2022-04-17 01:27:38	2022-04-17 01:27:38	\N	\N	5d1407f2-3b63-4452-a8a8-09bfc0b33efb
29	5	\N	14	74	craft\\elements\\Entry	t	f	2022-04-17 16:43:26	2022-04-17 16:43:26	\N	\N	0fb8b910-4982-4cdf-8318-13a16a08555a
31	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:35	2022-04-17 16:43:35	\N	2022-04-17 16:43:39	3fd99b8e-bb8b-4833-a1b7-6ca75f2553e8
38	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:46	2022-04-17 16:43:46	\N	2022-04-17 16:43:50	851595b9-f454-415c-a161-4ea6baa3474c
39	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:50	2022-04-17 16:43:50	\N	2022-04-17 16:43:52	801413e3-6c38-431c-91c7-5b7a9deedd9c
40	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:52	2022-04-17 16:43:52	\N	2022-04-17 16:43:53	dcfd8b6e-86e1-4a56-bce8-af5159afa3f9
14	\N	\N	\N	77	craft\\elements\\Entry	t	f	2022-04-15 04:33:02	2022-04-17 16:43:53	\N	\N	50889932-4472-46db-9548-0484eac8a773
42	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:53	2022-04-17 16:43:53	\N	\N	a440dc74-4e39-4441-a9e5-b8458d5426d7
43	14	\N	16	77	craft\\elements\\Entry	t	f	2022-04-17 16:43:53	2022-04-17 16:43:54	\N	\N	731efde1-349d-4267-8b6e-51ed7f385ab1
44	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:54	2022-04-17 16:44:09	\N	\N	14f668f1-f664-4779-9108-85ab390af9be
5	\N	\N	\N	74	craft\\elements\\Entry	t	f	2022-04-15 04:01:19	2022-04-17 16:57:21	\N	\N	94d86976-f04d-467b-92de-d0cf67a5545b
47	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:57:21	2022-04-17 16:57:21	\N	\N	273fcc61-8a48-4123-aa90-9bc806678ac5
34	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:43:41	2022-04-17 16:43:41	\N	2022-04-17 16:57:21	c16d0717-4e3e-4ad2-916e-c7cb879a5da5
48	5	\N	17	74	craft\\elements\\Entry	t	f	2022-04-17 16:57:21	2022-04-17 16:57:21	\N	\N	2c316061-78be-4f8b-9d12-1ffbf71122df
49	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:57:21	2022-04-17 16:57:21	\N	\N	a10793f1-3f9a-4d00-a090-bb698a8119ab
46	\N	\N	\N	89	benf\\neo\\elements\\Block	t	f	2022-04-17 16:57:17	2022-04-17 16:57:20	\N	2022-04-17 16:57:21	d3e76a3c-7024-4f38-ab36-12bd38240ee2
12	\N	\N	\N	67	craft\\elements\\User	t	f	2022-04-15 04:01:35	2022-04-17 17:03:16	\N	\N	e3004493-20c2-47c4-89f0-c35d19ff1319
\.


--
-- Data for Name: elements_sites; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.elements_sites (id, "elementId", "siteId", slug, uri, enabled, "dateCreated", "dateUpdated", uid) FROM stdin;
1	1	1	\N	\N	t	2022-04-15 04:01:09	2022-04-15 04:01:09	c1d4dfc6-8b76-4752-9e1f-5e928b9e8353
2	1	2	\N	\N	t	2022-04-15 04:01:09	2022-04-15 04:01:09	865a3879-3e25-494a-829f-526540b3ea49
3	2	1	\N	\N	t	2022-04-15 04:01:09	2022-04-15 04:01:09	af37deab-ceb2-42f9-a3f4-6efba0f6d6be
4	2	2	\N	\N	t	2022-04-15 04:01:09	2022-04-15 04:01:09	9ede4044-2d34-4bc0-8a98-78962c54e23f
5	3	1	\N	\N	t	2022-04-15 04:01:09	2022-04-15 04:01:09	a0658b94-78fb-46db-a1f2-d36450d80a5a
6	3	2	\N	\N	t	2022-04-15 04:01:09	2022-04-15 04:01:09	8069d62a-f171-4963-8fc7-3462f94d92d5
7	4	1	\N	\N	t	2022-04-15 04:01:17	2022-04-15 04:01:17	3db80e2a-3cde-45f7-aef1-2382df201233
8	4	2	\N	\N	t	2022-04-15 04:01:17	2022-04-15 04:01:17	794862fd-dab6-4b55-89e5-131108e423ef
9	5	1	homepage	__home__	t	2022-04-15 04:01:19	2022-04-15 04:01:19	e1a3cc5b-d1a0-4ce8-864f-1beafae91e4a
10	5	2	homepage	es	t	2022-04-15 04:01:19	2022-04-15 04:01:19	ae4e5eeb-ac71-40a0-94ac-5c7c2c6e62f9
11	6	1	homepage	__home__	t	2022-04-15 04:01:19	2022-04-15 04:01:19	d9cd4ade-3ca0-4554-a717-12a0a9692c1c
12	6	2	homepage	es	t	2022-04-15 04:01:19	2022-04-15 04:01:19	ac09da54-bbdd-4fb9-80b3-e4ede5c13414
13	7	1	search-results	search	t	2022-04-15 04:01:20	2022-04-15 04:01:20	40c2cc8e-7892-4e61-838a-625cf7d8757b
14	7	2	search-results	es/search	t	2022-04-15 04:01:20	2022-04-15 04:01:20	b7aba1ad-1326-4ec3-876a-fbd94da92dd6
15	8	1	user-profile	user-profile	t	2022-04-15 04:01:21	2022-04-15 04:01:21	96b845d7-97c6-4530-83f6-bb38bd9a38b1
16	8	2	user-profile	user-profile	t	2022-04-15 04:01:21	2022-04-15 04:01:21	85a3e602-f334-4ba4-83d9-5d56452acbc2
17	9	1	user-profile	user-profile	t	2022-04-15 04:01:21	2022-04-15 04:01:21	801c33cd-03bf-4f42-8074-0ebc1e8d563f
18	9	2	user-profile	user-profile	t	2022-04-15 04:01:21	2022-04-15 04:01:21	bf8d9e15-1c70-479c-ad75-4572bd26a165
19	10	1	user-profile-page	\N	t	2022-04-15 04:01:22	2022-04-15 04:01:22	72809749-09a9-40f1-8697-4bf3fd8d1167
20	10	2	user-profile-page	es/user-profile	t	2022-04-15 04:01:22	2022-04-15 04:01:22	553e2f4c-3bea-4b91-b729-11915883a9f4
21	11	1	user-profile-page	\N	t	2022-04-15 04:01:22	2022-04-15 04:01:22	709d37e7-ae20-4a66-95c0-842da6296fb8
22	11	2	user-profile-page	es/user-profile	t	2022-04-15 04:01:22	2022-04-15 04:01:22	b4f9716f-7856-4e9e-8294-77382ac5086a
23	12	1	\N	\N	t	2022-04-15 04:01:35	2022-04-15 04:01:35	41bee11d-f97b-425b-bec4-c80ada3e2cac
24	13	1	test-page	test-page	t	2022-04-15 04:30:24	2022-04-15 04:30:28	53648e49-763e-434c-8311-c4cc531e8c36
25	13	2	test-page	es/test-page	t	2022-04-15 04:30:24	2022-04-15 04:30:28	46d73ee6-2706-454a-b912-bcef608d0a34
28	15	1	test-page-title	test-page-title	t	2022-04-15 04:33:20	2022-04-15 04:33:20	36936d18-eba2-455f-a273-ccc158c3b19b
29	15	2	test-page-title	es/test-page-title	t	2022-04-15 04:33:21	2022-04-15 04:33:21	3fbf9081-39ed-4b2e-832e-885a86ae2f59
30	16	1	user-profile-page	\N	t	2022-04-17 00:24:14	2022-04-17 00:24:14	7761cfe2-214c-477c-90f7-11fcc9fafc14
31	16	2	user-profile-page	es/user-profile	t	2022-04-17 00:24:14	2022-04-17 00:24:14	a33b5d67-fa96-4514-9671-e039493c5f96
32	17	1	user-profile	user-profile	t	2022-04-17 00:24:14	2022-04-17 00:24:14	cd35408f-9ca3-4da5-b239-6d39b4b5888e
33	17	2	user-profile	user-profile	t	2022-04-17 00:24:14	2022-04-17 00:24:14	60bb3c0e-1bbe-4b73-9d39-579f262f892d
34	18	1	homepage	__home__	t	2022-04-17 00:24:14	2022-04-17 00:24:14	f0d7c584-0c2f-4ba6-87ca-3124149137f4
35	18	2	homepage	es	t	2022-04-17 00:24:14	2022-04-17 00:24:14	299df676-d752-4d66-96b7-b3df163b2a2c
36	19	1	homepage	__home__	t	2022-04-17 00:37:45	2022-04-17 00:37:45	d59fbf6b-aa73-4b78-befa-94ce14bd4693
37	19	2	homepage	es	t	2022-04-17 00:37:45	2022-04-17 00:37:45	a407191e-ac29-4409-be0c-ea3cb5728d65
38	20	1	homepage	__home__	t	2022-04-17 00:43:45	2022-04-17 00:43:45	feb53ae5-ada3-4b7a-bb78-67cee53586e8
39	20	2	homepage	es	t	2022-04-17 00:43:45	2022-04-17 00:43:45	db9db85f-01aa-4db2-823e-ad7ed8f3d506
42	22	1	homepage	__home__	t	2022-04-17 00:45:26	2022-04-17 00:45:26	8bda0b19-9a02-4cbd-be01-ccf25b343d91
43	22	2	homepage	es	t	2022-04-17 00:45:26	2022-04-17 00:45:26	b8539e70-37ea-4bf1-a222-d16105534a43
46	24	1	test-page-title	test-page-title	t	2022-04-17 00:45:33	2022-04-17 00:45:33	d7e74a51-344f-41ac-8b1a-75e7fe8b9fa9
47	24	2	test-page-title	es/test-page-title	t	2022-04-17 00:45:33	2022-04-17 00:45:33	406e420e-c7ba-47fb-9d07-49e0cdce99a8
50	26	1	homepage	__home__	t	2022-04-17 00:48:00	2022-04-17 00:48:00	2218f64d-0675-4fe9-8904-3813e2a9de8a
51	26	2	homepage	es	t	2022-04-17 00:48:00	2022-04-17 00:48:00	5fddad4c-2b81-45b9-b3a5-5ed7403fd15b
54	28	1	test	test	t	2022-04-17 01:27:38	2022-04-17 01:27:38	b8d5a79a-ed12-45c9-8fc2-860eb07136f2
55	28	2	test-page-title	es/test-page-title	t	2022-04-17 01:27:38	2022-04-17 01:27:38	728993eb-8728-4f84-aac3-98aa5dc7f5da
56	29	1	homepage	__home__	t	2022-04-17 16:43:26	2022-04-17 16:43:26	f687a8bc-3831-4d28-8083-fc6703ec1957
57	29	2	homepage	es	t	2022-04-17 16:43:26	2022-04-17 16:43:26	fc1cf9c1-498e-4e3d-a780-8e156b9d9518
60	31	1	\N	\N	t	2022-04-17 16:43:35	2022-04-17 16:43:35	bdb1d277-fca0-458b-b0c5-578d0cd903f9
61	31	2	\N	\N	t	2022-04-17 16:43:35	2022-04-17 16:43:35	e2a9f9a2-d31e-4295-98af-8066e43a9c9e
62	32	1	\N	\N	t	2022-04-17 16:43:39	2022-04-17 16:43:39	24fc2310-6f14-47fa-9c96-3d3087e6cbd1
63	32	2	\N	\N	t	2022-04-17 16:43:39	2022-04-17 16:43:39	7c9a28ce-01bf-4854-9bcc-0764c97e6f21
64	33	1	\N	\N	t	2022-04-17 16:43:40	2022-04-17 16:43:40	e8415e8b-6c37-41ea-9b7e-c5994eb36921
65	33	2	\N	\N	t	2022-04-17 16:43:40	2022-04-17 16:43:40	2e5b3f5b-8f2b-4e3b-a351-d7a28c85677d
66	34	1	\N	\N	t	2022-04-17 16:43:41	2022-04-17 16:43:41	969694d8-0fa0-4028-92c7-983780c654bf
67	34	2	\N	\N	t	2022-04-17 16:43:41	2022-04-17 16:43:41	8f7aa2db-adb6-4d40-81ff-b90f3b55dc3d
68	35	1	homepage	__home__	t	2022-04-17 16:43:41	2022-04-17 16:43:41	3724565c-578d-41c6-bb34-50fef47bf3aa
69	35	2	homepage	es	t	2022-04-17 16:43:41	2022-04-17 16:43:41	8d463c1a-17ef-4aea-87aa-8def42e43749
70	36	1	\N	\N	t	2022-04-17 16:43:41	2022-04-17 16:43:41	220b9823-71b1-49ae-937f-180fcb2b5257
71	36	2	\N	\N	t	2022-04-17 16:43:41	2022-04-17 16:43:41	db49a6c3-a23c-4619-b7d9-9336bb9c5be9
74	38	1	\N	\N	t	2022-04-17 16:43:46	2022-04-17 16:43:46	16fc0ec2-64d5-4a5a-b40e-993d43fdccb5
75	38	2	\N	\N	t	2022-04-17 16:43:46	2022-04-17 16:43:46	c6250928-96e4-4e56-8cd4-f4d6130aaf01
76	39	1	\N	\N	t	2022-04-17 16:43:50	2022-04-17 16:43:50	d22c5fbe-0969-49e6-ae0c-b7c3d3e4593c
77	39	2	\N	\N	t	2022-04-17 16:43:50	2022-04-17 16:43:50	b9d2f681-01bd-4d47-98dc-042bd8e9170b
78	40	1	\N	\N	t	2022-04-17 16:43:52	2022-04-17 16:43:52	d4ca1abc-4131-4d65-8d56-603bf413a3c8
79	40	2	\N	\N	t	2022-04-17 16:43:52	2022-04-17 16:43:52	479d78da-c59b-45ad-b584-7aae09455cea
26	14	1	test	test	t	2022-04-15 04:33:02	2022-04-17 16:44:10	db57f773-ce52-47fa-a3b8-47397c229fb9
27	14	2	test-page-title	es/test-page-title	t	2022-04-15 04:33:02	2022-04-17 16:44:10	f15beb55-4912-4613-be78-ce43e75de3cb
80	41	1	\N	\N	t	2022-04-17 16:43:53	2022-04-17 16:43:53	b97fc31e-c10f-4b55-a418-20d00275bc40
81	41	2	\N	\N	t	2022-04-17 16:43:53	2022-04-17 16:43:53	e8def55d-03fd-4942-92e6-5de4beadb53c
82	42	1	\N	\N	t	2022-04-17 16:43:53	2022-04-17 16:43:53	de006bea-a0d1-4c9b-8869-27c07eb1c336
83	42	2	\N	\N	t	2022-04-17 16:43:53	2022-04-17 16:43:53	f5e55e33-f98d-4dc9-9d61-a7cff52a0542
84	43	1	test	test	t	2022-04-17 16:43:54	2022-04-17 16:43:54	ea2e1dc9-205d-45e6-9cd9-bfdc49cbe788
85	43	2	test-page-title	es/test-page-title	t	2022-04-17 16:43:54	2022-04-17 16:43:54	c2030da3-c6ec-43a2-b278-06525c7731aa
86	44	1	\N	\N	t	2022-04-17 16:43:54	2022-04-17 16:43:54	03d956cf-1bc6-4384-9946-4d98ff6e8d23
87	44	2	\N	\N	t	2022-04-17 16:44:09	2022-04-17 16:44:09	1f4993bd-2479-4880-9343-ea64dea8e927
90	46	2	\N	\N	t	2022-04-17 16:57:17	2022-04-17 16:57:17	16f92db6-50b0-4d4c-a428-839f0edc7e32
91	46	1	\N	\N	t	2022-04-17 16:57:17	2022-04-17 16:57:17	76ab3da1-d939-4262-b46a-fd41f07a4692
92	47	2	\N	\N	t	2022-04-17 16:57:21	2022-04-17 16:57:21	34cb03f6-e049-4818-9e4a-a389fe48ae4a
93	47	1	\N	\N	t	2022-04-17 16:57:21	2022-04-17 16:57:21	ef881423-5f31-4ce7-b39f-45b087fdabe4
94	48	2	homepage	es	t	2022-04-17 16:57:21	2022-04-17 16:57:21	61d5fc11-dcd1-49f0-908c-23d8929f6db6
95	48	1	homepage	__home__	t	2022-04-17 16:57:21	2022-04-17 16:57:21	fa8be4ec-2022-4e0f-b1a1-d830f7f5a4d4
96	49	2	\N	\N	t	2022-04-17 16:57:21	2022-04-17 16:57:21	e7447ef7-c4ee-4297-a1ef-f8921d0e9113
97	49	1	\N	\N	t	2022-04-17 16:57:21	2022-04-17 16:57:21	2fc5ba41-b4f1-4573-b129-5294b254a69d
\.


--
-- Data for Name: entries; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.entries (id, "sectionId", "parentId", "typeId", "authorId", "postDate", "expiryDate", "deletedWithEntryType", "dateCreated", "dateUpdated", uid) FROM stdin;
5	13	\N	7	\N	2022-04-15 04:01:00	\N	\N	2022-04-15 04:01:19	2022-04-15 04:01:19	57444dc7-8707-4ebb-8481-e1bbc08c0e75
6	13	\N	7	\N	2022-04-15 04:01:00	\N	\N	2022-04-15 04:01:19	2022-04-15 04:01:19	83779cc0-8f43-44a9-825e-8fcfe02db55c
9	2	\N	17	\N	2022-04-15 04:01:00	\N	\N	2022-04-15 04:01:21	2022-04-15 04:01:21	9d2d40b4-b9f5-4ba3-82dc-e741165c0f00
11	10	\N	18	\N	\N	\N	\N	2022-04-15 04:01:22	2022-04-15 04:01:22	55efc1ac-bb38-4696-b70f-121cfa8701bc
13	8	\N	10	12	2022-04-15 04:30:00	\N	f	2022-04-15 04:30:24	2022-04-15 04:30:24	d4e4dd01-e1e9-4399-bc34-90741f12065a
14	8	\N	10	12	2022-04-15 04:33:00	\N	\N	2022-04-15 04:33:02	2022-04-15 04:33:02	5fae3510-cbbd-4684-a3ca-dc9bcbb2df5b
15	8	\N	10	12	2022-04-15 04:33:00	\N	\N	2022-04-15 04:33:20	2022-04-15 04:33:20	6e0aaa58-d129-45a2-8c57-18c27c8295f9
16	10	\N	18	\N	\N	\N	\N	2022-04-17 00:24:14	2022-04-17 00:24:14	49bc4cb7-1c3d-4278-94be-3e8a9c84f3e4
17	2	\N	17	\N	2022-04-15 04:01:00	\N	\N	2022-04-17 00:24:14	2022-04-17 00:24:14	a44fab11-caec-4519-8c09-12434993dcd1
18	13	\N	7	\N	2022-04-15 04:01:00	\N	\N	2022-04-17 00:24:14	2022-04-17 00:24:14	f8215157-e93c-4bbe-8dd6-49ec0aead16a
7	5	\N	13	\N	2022-04-15 04:01:00	\N	t	2022-04-15 04:01:20	2022-04-15 04:01:20	102a1cdf-c429-43c4-906f-7246c1d5463f
8	2	\N	17	\N	2022-04-15 04:01:00	\N	t	2022-04-15 04:01:21	2022-04-15 04:01:21	4dc10c25-b063-4625-84ed-47e4bae8496b
10	10	\N	18	\N	\N	\N	t	2022-04-15 04:01:22	2022-04-15 04:01:22	192e1401-4fe2-44d8-beb0-b45122b2a57e
19	13	\N	7	\N	2022-04-15 04:01:00	\N	\N	2022-04-17 00:37:45	2022-04-17 00:37:45	223b2c59-2efd-4acc-8d32-1c43f269e7c4
20	13	\N	7	\N	2022-04-15 04:01:00	\N	\N	2022-04-17 00:43:45	2022-04-17 00:43:45	d594ab0b-e580-4e5b-acb5-5fb101b2dca4
22	13	\N	7	\N	2022-04-15 04:01:00	\N	\N	2022-04-17 00:45:26	2022-04-17 00:45:26	c3478c72-6789-4cdc-8f3b-6d5017cd8194
24	8	\N	10	12	2022-04-15 04:33:00	\N	\N	2022-04-17 00:45:33	2022-04-17 00:45:33	9500dc46-79d4-496b-990a-94b4edb02291
26	13	\N	7	\N	2022-04-15 04:01:00	\N	\N	2022-04-17 00:48:00	2022-04-17 00:48:00	238d60ab-5e77-4f89-88ac-0813141e31e0
28	8	\N	10	12	2022-04-15 04:33:00	\N	\N	2022-04-17 01:27:38	2022-04-17 01:27:38	d8ed38af-90c6-4b5a-9188-20448360a9d4
29	13	\N	7	\N	2022-04-15 04:01:00	\N	\N	2022-04-17 16:43:26	2022-04-17 16:43:26	eb55d844-b022-402a-8671-1f1bcb8f6a62
35	13	\N	7	\N	2022-04-15 04:01:00	\N	\N	2022-04-17 16:43:41	2022-04-17 16:43:41	445263b4-55d4-4815-a347-6452a62fd040
43	8	\N	10	12	2022-04-15 04:33:00	\N	\N	2022-04-17 16:43:54	2022-04-17 16:43:54	6ecbf2be-969b-40e5-a02d-c9eb24184324
48	13	\N	7	\N	2022-04-15 04:01:00	\N	\N	2022-04-17 16:57:21	2022-04-17 16:57:21	fb80a2d5-9819-45f8-88be-d35f2dffaf50
\.


--
-- Data for Name: entrytypes; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.entrytypes (id, "sectionId", "fieldLayoutId", name, handle, "hasTitleField", "titleTranslationMethod", "titleTranslationKeyFormat", "titleFormat", "sortOrder", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
7	13	74	Homepage	homepage	t	site	\N	{section.name|raw}	1	2022-04-15 04:01:19	2022-04-15 04:01:19	\N	8145b1c9-cb8f-4c86-91ba-34fe5ded34e6
10	8	77	Pages	pages	t	site	\N	\N	1	2022-04-15 04:01:19	2022-04-15 04:01:19	\N	23eda090-7e8e-401d-ab49-ee4becc34935
12	14	79	Callout	callout	t	site	\N	\N	1	2022-04-15 04:01:19	2022-04-15 04:01:19	2022-04-15 04:19:48	942c9e60-2760-42ed-b03b-9e5eb133751b
1	14	68	Callout - two-tone	calloutTwoTone	t	site	\N	\N	2	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:48	34f61e7c-358c-48b8-8439-42bc05ed255c
2	14	69	Callout - quote	calloutQuote	t	site	\N	\N	3	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:48	fa15bb4c-adb8-4393-82c3-15c2b830867c
5	1	72	Events	events	t	site	\N	\N	1	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:53	6acd6e24-26c9-4e55-a35b-c29cd36a7a3c
6	3	73	Gallery Item	galleryItem	t	site	\N	\N	1	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:57	7187131b-681b-45de-a1ea-87a8d070c05a
4	4	71	Glossary Term	glossaryTerm	t	site	\N	\N	1	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:20:04	bbf936fb-1787-437b-8ebd-a6e79409896e
8	11	75	Investigation	investigation	t	site	\N	\N	1	2022-04-15 04:01:19	2022-04-15 04:01:19	2022-04-15 04:20:10	0b946ecb-12e3-4999-9d02-fc902cb66fdf
9	9	76	Job	job	t	site	\N	\N	1	2022-04-15 04:01:19	2022-04-15 04:01:19	2022-04-15 04:20:15	39558c70-8baf-4748-9f12-49e78a04eed5
11	12	78	News Post	post	t	site	\N	\N	1	2022-04-15 04:01:19	2022-04-15 04:01:19	2022-04-15 04:20:20	4729ad5e-485e-4f98-995d-79fa5254cd42
14	6	81	Slideshow	slideshow	t	site	\N	\N	1	2022-04-15 04:01:20	2022-04-15 04:01:20	2022-04-15 04:20:30	a77c49d2-2441-459e-bfea-63e571d25a12
15	7	82	Staff Profiles	staffProfiles	t	site	\N	{staffName}	1	2022-04-15 04:01:21	2022-04-15 04:01:21	2022-04-15 04:20:35	7d60273b-66b0-4843-a42c-4b4387185a15
3	8	70	Educator Pages	educatorPages	t	site	\N	\N	2	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:20:49	9d045432-a0fb-4fcd-8bca-3bc93b1f7056
16	8	83	Student Pages	studentPages	t	site	\N	\N	3	2022-04-15 04:01:21	2022-04-15 04:01:21	2022-04-15 04:20:53	26ca2777-e4c8-41b4-ac93-aa28d09117dd
13	5	80	Search Results	searchResults	f	site	\N	{section.name|raw}	1	2022-04-15 04:01:20	2022-04-15 04:01:20	2022-04-17 00:32:54	229f2975-93d3-4c6a-9996-dfa1de3004ef
17	2	84	User Profile	userProfile	f	site	\N	{section.name|raw}	1	2022-04-15 04:01:21	2022-04-15 04:01:21	2022-04-17 00:32:58	573c9705-aca2-4419-b039-c7071536a2ce
18	10	85	User Profile Page	userProfilePage	t	site	\N	{section.name|raw}	1	2022-04-15 04:01:21	2022-04-15 04:01:21	2022-04-17 00:33:00	534d275e-b6e9-4064-9965-07e804e0fcc1
\.


--
-- Data for Name: fieldgroups; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.fieldgroups (id, name, "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
1	Common	2022-04-15 04:01:04	2022-04-15 04:01:04	\N	9940892d-32f4-4399-acac-ab559ce1c82b
6	Pages	2022-04-15 04:01:04	2022-04-15 04:01:04	\N	99f4a28a-48c3-49ca-bb4a-7acbb49fde30
10	Site Information	2022-04-15 04:01:04	2022-04-15 04:01:04	\N	cee5c2f8-2801-42c2-a56c-4fe40c85b6f3
11	Callouts	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:22:33	df8c8d8a-c7d1-45bf-b551-ef790a5b59ad
9	Events	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:22:55	bb77d190-487e-45c5-a1d2-0208510a7d88
2	Gallery Area	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:23:58	3754ce62-7e5c-46da-8738-2f15f70f00a4
3	Investigations	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:24:21	3eefd793-f1fb-4692-ba0e-ff68f354543b
4	Jobs	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:24:35	8096dc6c-f1bd-4d24-8add-7df7f190a17c
5	News Posts	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:24:51	824d9ca2-e755-4e41-8f6a-18e573fec8e4
8	Staff Profiles	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:25:41	b93cb5a6-f862-4912-9d41-4dcb4fd9e105
7	Users	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:26:06	9b9ff039-061b-4efd-988e-553f811623b2
\.


--
-- Data for Name: fieldlayoutfields; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.fieldlayoutfields (id, "layoutId", "tabId", "fieldId", required, "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
188	68	106	103	f	2	2022-04-15 04:01:18	2022-04-15 04:01:18	a7198e22-b7ba-4331-be48-47f54793b251
189	68	106	54	f	3	2022-04-15 04:01:18	2022-04-15 04:01:18	351d6934-0f66-4f44-a34a-38fcbaf69f04
196	69	109	103	f	3	2022-04-15 04:01:18	2022-04-15 04:01:18	167e9635-27dc-4bd3-9740-d5dd5bf0bc79
197	69	109	54	f	4	2022-04-15 04:01:18	2022-04-15 04:01:18	e013adf6-d7fe-49b1-b0c8-4e405f76f17a
208	70	112	70	f	0	2022-04-15 04:01:18	2022-04-15 04:01:18	c6a51d10-a6e5-490a-b162-3a7c5f7b01fb
210	71	113	103	f	1	2022-04-15 04:01:18	2022-04-15 04:01:18	67f9075b-a429-477b-8b1c-f6ccf2b281d7
239	6	116	3	f	1	2022-04-15 04:01:19	2022-04-15 04:01:19	fa366bbd-8a4e-41e0-bb1f-9b124f89a40b
250	75	118	70	f	5	2022-04-15 04:01:19	2022-04-15 04:01:19	cfce8767-6eb8-4cd1-b383-4f42882c63d9
256	1	120	3	f	1	2022-04-15 04:01:19	2022-04-15 04:01:19	32134aa8-e5e7-4f66-8264-fdfb52c151a6
276	79	124	103	f	2	2022-04-15 04:01:19	2022-04-15 04:01:19	5e7f369b-3436-423e-91e5-21b9d6446716
280	79	124	54	f	6	2022-04-15 04:01:19	2022-04-15 04:01:19	79875f32-2bb5-4bb3-bb8d-d7570ade88fa
285	33	127	3	f	1	2022-04-15 04:01:19	2022-04-15 04:01:19	56194597-0efc-4fb4-81fe-cbda7849cc57
290	39	129	3	f	1	2022-04-15 04:01:19	2022-04-15 04:01:19	0e0591ca-d313-4f23-8cb8-2c936146cd82
291	35	132	3	f	1	2022-04-15 04:01:19	2022-04-15 04:01:19	fc3129da-ca57-4f06-be4a-582f23782447
294	37	134	3	f	1	2022-04-15 04:01:20	2022-04-15 04:01:20	4f8daf92-4166-4994-acea-0e7c7c945473
301	82	141	70	t	1	2022-04-15 04:01:21	2022-04-15 04:01:21	1c60f1a0-010b-4fff-ae71-a5934b7dd749
317	83	143	70	f	0	2022-04-15 04:01:21	2022-04-15 04:01:21	5c0531a9-79cc-481a-a84a-a26082e6c315
325	4	150	52	f	1	2022-04-15 04:01:22	2022-04-15 04:01:22	be37691c-4331-4bf9-b43c-76ac5f6d5a4d
326	4	150	66	f	2	2022-04-15 04:01:22	2022-04-15 04:01:22	840ea0d4-c1ed-446b-807f-1721e6131616
330	10	152	70	f	0	2022-04-15 04:01:22	2022-04-15 04:01:22	86cf575d-1244-43d8-9d53-122cd8ee8158
338	13	156	66	f	1	2022-04-15 04:01:22	2022-04-15 04:01:22	1f29eaf0-2390-4769-8b86-32c53950423d
344	12	160	103	t	1	2022-04-15 04:01:22	2022-04-15 04:01:22	ace6d802-7003-4896-bb5c-bc56befe0066
365	3	171	59	t	1	2022-04-15 04:01:23	2022-04-15 04:01:23	8912898a-76eb-4c73-b1c2-27cd30922fae
393	28	181	54	f	1	2022-04-15 04:01:30	2022-04-15 04:01:30	96190300-cd93-4799-9905-d1d2649e027b
403	7	187	59	f	1	2022-04-15 04:01:31	2022-04-15 04:01:31	f66ad78e-8ad3-4ed8-afe5-05f9989a5f98
409	63	189	59	f	1	2022-04-15 04:01:31	2022-04-15 04:01:31	ffcca0f9-84f9-4940-aa5f-9dbc00d88108
421	60	195	103	f	0	2022-04-15 04:01:31	2022-04-15 04:01:31	58ce9fb0-4586-410f-bbf5-1c3e08f3dfa8
423	61	197	103	f	0	2022-04-15 04:01:31	2022-04-15 04:01:31	868986e2-916b-4c43-ba9f-5ff0927cd267
431	62	203	59	f	1	2022-04-15 04:01:31	2022-04-15 04:01:31	735f2a92-36ce-4cd6-b9e6-6d88f34b4cfe
453	52	217	59	f	0	2022-04-15 04:01:31	2022-04-15 04:01:31	c29bcb0e-8558-478d-95fa-4e95d324d66c
463	53	221	59	f	1	2022-04-15 04:01:31	2022-04-15 04:01:31	b37f620c-f75e-4ef9-b433-91c2c212f127
470	48	223	59	f	1	2022-04-15 04:01:31	2022-04-15 04:01:31	878ad77e-8a85-49ef-b796-58cfb80965ac
478	44	227	59	f	1	2022-04-15 04:01:31	2022-04-15 04:01:31	f255c0f3-c67c-4f5b-a18c-99a32574b98c
512	51	260	59	f	0	2022-04-17 00:24:15	2022-04-17 00:24:15	53f66bd8-8533-458f-95dd-702e58fe4249
513	15	261	89	f	0	2022-04-17 00:24:15	2022-04-17 00:24:15	e584cd48-fc66-40a3-9e94-7dea19cdf423
514	15	261	87	f	1	2022-04-17 00:24:15	2022-04-17 00:24:15	a32423b9-ee42-41c2-bc2e-8c9cb57b716e
520	89	265	103	f	0	2022-04-17 16:41:46	2022-04-17 16:41:46	0933f289-32ca-4d8f-970d-5d66a98f1df1
521	77	266	141	f	1	2022-04-17 16:43:10	2022-04-17 16:43:10	28158b03-3c1a-4e70-b56d-d48bad48968d
522	77	266	140	f	2	2022-04-17 16:43:10	2022-04-17 16:43:10	38dc86bc-dde2-4285-be26-d70a92b1cf33
523	74	267	141	f	1	2022-04-17 16:43:26	2022-04-17 16:43:26	7f02e174-cae9-4600-8b5f-ddfbc398cfff
524	74	267	140	f	2	2022-04-17 16:43:26	2022-04-17 16:43:26	465fe836-2de7-4c88-8275-5f0c92ca0bf5
\.


--
-- Data for Name: fieldlayouts; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.fieldlayouts (id, type, "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
15	craft\\elements\\GlobalSet	2022-04-15 04:01:09	2022-04-15 04:01:09	\N	3a661c42-268a-4134-af14-45715ef1c9c2
41	craft\\elements\\Category	2022-04-15 04:01:17	2022-04-15 04:01:17	\N	f8bd46cf-4a8b-49dc-8ef0-6c7840257051
42	craft\\elements\\Category	2022-04-15 04:01:17	2022-04-15 04:01:17	\N	90bed1d1-9225-4f28-ba44-a9c3c65d1b28
51	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	\N	2652f9f9-85e2-47f9-a54a-74e393426c43
59	craft\\elements\\Asset	2022-04-15 04:01:18	2022-04-15 04:01:18	\N	20979f8e-10d5-4ac3-9946-bb661cd56a3d
67	craft\\elements\\User	2022-04-15 04:01:18	2022-04-15 04:01:18	\N	cb6d67cc-50a9-41ad-9b81-f54853c2b0da
33	craft\\elements\\Asset	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:06:53	0c26bb1c-20cb-447f-b98d-994b3a4d7057
6	craft\\elements\\Asset	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:06:58	693d6c3c-68a1-4095-af9e-0b2d893972a6
37	craft\\elements\\Asset	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:07:02	f4f84d50-a7c3-4ef6-9b0f-6979320aa08b
39	craft\\elements\\Asset	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:07:06	8826f9f3-67f3-420e-8a4b-d20ea5fbf1c4
68	craft\\elements\\Entry	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:48	d4231f44-575b-44ed-8325-65698b21ee70
69	craft\\elements\\Entry	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:48	638ddd76-0ab8-4760-bd20-3008020611f2
70	craft\\elements\\Entry	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:20:49	b2f278fa-9b21-477c-9134-f052bc39ba23
23	craft\\elements\\Category	2022-04-15 04:01:10	2022-04-15 04:01:10	2022-04-15 04:21:17	3a7f2ebe-5ee7-42c5-bd24-e50a1e333fe8
40	craft\\elements\\Category	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:21	9532aabf-f9e0-4533-bf83-e8151ee1690d
38	craft\\elements\\Category	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:24	274b1396-94aa-4b4a-867f-ece69df4061f
34	craft\\elements\\Category	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:26	b75f3c94-e912-44f0-aff9-907c7b042bac
36	craft\\elements\\Category	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:29	477b93c5-3de7-4381-872f-6d729f123491
43	craft\\elements\\Category	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:34	9b2d602d-13ea-459b-9437-cda493e4c6b0
30	craft\\elements\\MatrixBlock	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:23:45	bbf3925e-2c0c-40c1-ba0e-1a171d19acb0
58	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:24:40	a0940026-9c0c-4897-803a-ccda4fa0dc50
19	craft\\elements\\MatrixBlock	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:24:42	007709ed-b343-4721-9b2a-e6874c493fe6
2	craft\\elements\\MatrixBlock	2022-04-15 04:01:08	2022-04-15 04:01:08	2022-04-15 04:24:42	5045d08e-1627-42b2-a2c8-8c0698ccbb44
24	craft\\elements\\MatrixBlock	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:24:42	908d7981-63ac-461e-81c4-da6c921a1db9
18	craft\\elements\\MatrixBlock	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:24:42	bc20e833-6858-4927-bb1f-e3f2210012d2
25	craft\\elements\\MatrixBlock	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:24:42	735b7a3e-8f34-47ba-8b65-d9c1571564ca
27	craft\\elements\\MatrixBlock	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:25:00	73eb819a-d08d-483b-9006-bbadd229c2d4
29	craft\\elements\\MatrixBlock	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:25:00	c83931c4-a320-4c61-8034-d02aaa53b369
16	craft\\elements\\MatrixBlock	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:26:19	e60906a6-87e6-43fc-bdca-b28f7a636a06
9	verbb\\supertable\\elements\\SuperTableBlockElement	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:26:28	6d7de242-d6d1-42a1-907a-cad7e9ba769f
28	craft\\elements\\GlobalSet	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:28:09	5b083a00-8eea-4a2e-9aae-1aa4400e850c
20	craft\\elements\\GlobalSet	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:28:12	ed838c10-71c3-4eee-9933-3e83d266a14b
17	craft\\elements\\GlobalSet	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:28:14	2504b1ee-ec68-4059-90ea-7ef9aaf7259c
64	craft\\elements\\Tag	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:28:32	b8dd71e1-4eb2-415d-bed8-53a366de6934
21	craft\\elements\\Tag	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:28:33	b0e00f53-dc6a-41b2-94dd-ab9c862eb8ad
66	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	d606865c-35e5-4458-a367-6579a71decf8
10	benf\\neo\\elements\\Block	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:31:19	c102e484-6dbd-4935-a91b-9673b3f53d97
55	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	a0bb671e-e629-437d-b918-aa4636879c89
8	benf\\neo\\elements\\Block	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:31:19	a3ad26d8-31e3-47be-8a53-30b10466c167
57	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	e41c0041-21b6-4d8f-ba64-e263d7b9d6ae
13	benf\\neo\\elements\\Block	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:31:22	747dd2e5-0613-44a9-a2c6-433af65f0343
22	craft\\elements\\MatrixBlock	2022-04-15 04:01:10	2022-04-15 04:01:10	2022-04-15 04:31:26	9318c35e-328a-4ee7-b7c4-06e6beb9a5fb
74	craft\\elements\\Entry	2022-04-15 04:01:19	2022-04-15 04:01:19	\N	290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e
77	craft\\elements\\Entry	2022-04-15 04:01:19	2022-04-15 04:01:19	\N	4cb617a1-f4f9-4f4f-ae58-c44be48749b8
35	craft\\elements\\Asset	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:06:47	eb8fe352-25cf-40ad-8936-2c2da39d8451
1	craft\\elements\\Asset	2022-04-15 04:01:08	2022-04-15 04:01:08	2022-04-15 04:07:17	d9f18ed7-102c-4169-b9e8-6fb4b8401ebd
79	craft\\elements\\Entry	2022-04-15 04:01:19	2022-04-15 04:01:19	2022-04-15 04:19:48	07a17729-4353-45e5-b214-5c8a058996a0
72	craft\\elements\\Entry	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:53	3f368182-1b28-45f6-8acc-ce602279d8ce
73	craft\\elements\\Entry	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:57	a1e7507c-8f05-496a-bcf1-7f0c660a18b3
71	craft\\elements\\Entry	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:20:04	a8cd2eac-2f6d-4d2d-8c0b-bb3f624542dd
75	craft\\elements\\Entry	2022-04-15 04:01:19	2022-04-15 04:01:19	2022-04-15 04:20:10	a71ccdf1-e22b-4223-a3d9-c5cffb283ff2
76	craft\\elements\\Entry	2022-04-15 04:01:19	2022-04-15 04:01:19	2022-04-15 04:20:15	eabbd9fa-466c-4447-949f-c961d410b273
78	craft\\elements\\Entry	2022-04-15 04:01:19	2022-04-15 04:01:19	2022-04-15 04:20:20	1a9ed06e-35d9-4eda-925c-f2d9095e0364
81	craft\\elements\\Entry	2022-04-15 04:01:20	2022-04-15 04:01:20	2022-04-15 04:20:30	7173d363-4be4-4b08-b42c-f8d184b33399
82	craft\\elements\\Entry	2022-04-15 04:01:21	2022-04-15 04:01:21	2022-04-15 04:20:35	389cec8b-4c52-452f-b228-8e59f42953fd
83	craft\\elements\\Entry	2022-04-15 04:01:21	2022-04-15 04:01:21	2022-04-15 04:20:53	95fb48a9-5d74-4bdd-bad7-5bdcd47cbf66
26	craft\\elements\\MatrixBlock	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:23:01	900be27e-c6e3-4ec1-a077-9c5fde0de66a
88	craft\\elements\\MatrixBlock	2022-04-15 04:01:24	2022-04-15 04:01:24	2022-04-15 04:23:02	d4f1bbbd-99bc-4368-8df7-61e6ef202234
45	benf\\neo\\elements\\Block	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:24:40	96e80ddc-8155-4f7e-99db-4292a90623d3
48	benf\\neo\\elements\\Block	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:24:40	434722a0-17ca-49aa-908b-6a945f4cf383
5	benf\\neo\\elements\\Block	2022-04-15 04:01:08	2022-04-15 04:01:08	2022-04-15 04:24:40	4cd78446-0a20-4a25-87ab-8e4e36551c55
50	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:24:40	09613661-a838-4f69-a268-d8e9fb11b021
31	benf\\neo\\elements\\Block	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:24:40	ec992cc9-cc3c-4e35-846c-4c5f7b2c5bcc
84	craft\\elements\\Entry	2022-04-15 04:01:21	2022-04-15 04:01:21	2022-04-17 00:32:58	0a7fe430-4407-4e33-987b-a11f3a83de99
85	craft\\elements\\Entry	2022-04-15 04:01:21	2022-04-15 04:01:21	2022-04-17 00:33:00	0bb6c604-c476-48b5-aaa7-1a297fd47a97
60	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:24:40	987cc3e9-191e-4f9e-bc39-12a738e462f7
87	craft\\elements\\MatrixBlock	2022-04-15 04:01:23	2022-04-15 04:01:23	2022-04-15 04:26:28	9b2a8c49-6d16-4855-9829-45ea09202d2b
86	craft\\elements\\MatrixBlock	2022-04-15 04:01:22	2022-04-15 04:01:22	2022-04-15 04:27:27	0a6fe3d4-aab8-496a-bfb7-db947e8f8ab1
49	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	72820c08-6638-412b-bb2c-97b8150cc0ec
47	benf\\neo\\elements\\Block	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:31:19	21547f51-6313-4ae1-bb0f-fbe1a5857821
46	benf\\neo\\elements\\Block	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:31:19	24eed9a2-1842-4d0b-96f0-485dfe1c7c35
44	benf\\neo\\elements\\Block	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:31:19	6258b6b1-bf13-44d9-87b7-640daf507005
65	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	6ff970b8-a87f-48f0-8424-563eaae86027
62	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	2755516f-02bd-49aa-9f6e-32e5ad8cbb79
54	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	4e3c5644-e500-403a-8c9e-f66bf7c4937f
53	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	4b6d230e-1301-4912-919c-6c690036b3e6
4	benf\\neo\\elements\\Block	2022-04-15 04:01:08	2022-04-15 04:01:08	2022-04-15 04:31:19	d9c9eb2f-9504-4dc2-8371-f61bdf5daa34
56	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	756e8454-fa42-4a48-b89b-7b6e4a39b0b7
63	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	51150454-bc59-4d8d-a40b-4bc71f14e149
3	benf\\neo\\elements\\Block	2022-04-15 04:01:08	2022-04-15 04:01:08	2022-04-15 04:31:19	2c3aebef-93a3-4cb1-beda-4d47a13a0b8e
7	benf\\neo\\elements\\Block	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:31:19	42368af2-9545-4c5c-95a7-b4049101ef09
12	benf\\neo\\elements\\Block	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:31:19	d12c81d8-7643-44fc-93c0-6b61963076b0
11	benf\\neo\\elements\\Block	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:31:19	b1c3fdf1-1d88-48ee-a27f-cbec1ec53c1d
14	benf\\neo\\elements\\Block	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:31:19	1e2db49e-b024-4fac-bf2c-2cc02ab01005
52	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	5ed91041-488b-4b8e-a7b2-e76f8ccc0fa3
32	benf\\neo\\elements\\Block	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:31:19	7ea8d42a-0d28-422c-ada3-fdafdfe9ce8c
61	benf\\neo\\elements\\Block	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:31:19	25297778-9fc8-485a-ad7d-5c49b6aff101
80	craft\\elements\\Entry	2022-04-15 04:01:20	2022-04-15 04:01:20	2022-04-17 00:32:54	3deda0f1-30dc-4e23-ba79-2b959145b27e
89	benf\\neo\\elements\\Block	2022-04-17 16:41:46	2022-04-17 16:41:46	\N	2dd1cc59-93d5-4a43-914c-395016509e05
\.


--
-- Data for Name: fieldlayouttabs; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.fieldlayouttabs (id, "layoutId", name, elements, "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
120	1	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"39af5de5-d299-4bc5-965a-af2d128c7f1a"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"ce5de347-f24d-4cc2-b80f-7db689345533"}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	8c7052ae-7203-4211-8e55-d8ac1002d61e
106	68	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"7db205b7-a548-42f1-8c26-416ec51cf3fa"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"4c977b75-9ee1-4cdb-9d2a-203639f4af84"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"fb052686-4537-4fe5-9ce2-ff3fd4a341a2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"61b9d842-7365-4bbf-883c-1b6433dc15f4"}]	1	2022-04-15 04:01:18	2022-04-15 04:01:18	63fa85b1-a3d6-478e-810e-d3faefecdf48
107	68	Appearance	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"8b8ed305-e6e6-4754-925f-bb07427b2060"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Background Image","instructions":"","tip":null,"warning":null,"required":"","width":50,"fieldUid":"496e755e-78ab-4e3f-8c3a-9b320023b8ec"}]	2	2022-04-15 04:01:18	2022-04-15 04:01:18	7924bae8-7257-4be4-aafd-0825d6297ff8
109	69	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d7fc5f39-2426-421b-bd0b-10aadae80ae3"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"7db205b7-a548-42f1-8c26-416ec51cf3fa"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"4c977b75-9ee1-4cdb-9d2a-203639f4af84"}]	1	2022-04-15 04:01:18	2022-04-15 04:01:18	622fc188-3112-4419-ad6d-b5ed95ebc7cd
110	69	Quote	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"271253b0-e9b7-4bf1-be32-ce31d71b48b1"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"d12b2ae4-6d10-41ef-8e22-778f54b2f2d0"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"48ba11bd-90a5-4239-a24c-d44d01affbcf"}]	2	2022-04-15 04:01:18	2022-04-15 04:01:18	7856901e-291c-4b1b-a3c0-fdf700613d24
147	64	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100}]	1	2022-04-15 04:01:22	2022-04-15 04:01:22	586b1ef1-71b7-4295-a715-366732be82e8
199	66	Content	[{"type":"craft\\\\fieldlayoutelements\\\\Tip","tip":"Complex Tables nested inside this container will use a tabbed presentation with each Complex Table having its own tab.","style":"tip"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	fc312c4f-edc5-466b-98dd-2f8c66476873
111	70	Pages	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":75},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"831db889-442e-4553-9076-fc3bc2843c8c"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"cd801712-4ba3-4a9c-8fab-0d3e2a58b4eb"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"3c9eb8f7-9f84-4c22-84d5-531be77aa6b6"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"05eead62-7bf9-43e4-a7e8-bcd8f9f77323"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"72e5075a-9b06-4674-b040-615f4a6f7b70"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"8b5bcbee-1883-48ca-8c9a-6c506b9abb99"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"fa690eba-6d46-4a5e-9dcd-0845f5b56c1b"}]	1	2022-04-15 04:01:18	2022-04-15 04:01:18	f477ea9a-6759-47bf-a1b6-fcc1f610484d
112	70	Sub Hero Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Sub Hero Header","instructions":"","tip":null,"warning":null,"required":"","width":100,"fieldUid":"7970cd65-7a96-418a-8581-d6df4e039e6d"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"24f23fec-fc66-46f8-86e1-396d01315ad2"}]	2	2022-04-15 04:01:18	2022-04-15 04:01:18	8a6163fd-63ec-406c-8309-e2eb9bc8c2a4
113	71	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Term","instructions":"","tip":null,"warning":null,"width":25},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Definition","instructions":"","tip":null,"warning":null,"required":"","width":75,"fieldUid":"7db205b7-a548-42f1-8c26-416ec51cf3fa"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"496e755e-78ab-4e3f-8c3a-9b320023b8ec"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"10118ebf-e3bf-4b1b-bbb8-4b57ab3753c8"}]	1	2022-04-15 04:01:18	2022-04-15 04:01:18	5ee7377a-b64c-4692-a24c-7597fdfb0c83
114	72	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"05eead62-7bf9-43e4-a7e8-bcd8f9f77323"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"3146b06e-af03-43e7-b278-3a65c81f610e"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"","width":25,"fieldUid":"a8ba2de3-ff22-4a96-9a53-00b6dec31def"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"","width":25,"fieldUid":"87362cd0-662a-4068-9482-5ff62fe472c4"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"","width":25,"fieldUid":"04000104-ec26-4d82-959a-729454e7f1cc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"","width":25,"fieldUid":"ddb3efd5-1bce-43e1-9fb9-399ada8a8126"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"d93d96b1-80fe-486a-9ada-5d52b6e67009"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":25,"fieldUid":"75f0b770-5006-4359-848f-96415196bfe0"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"960543c0-3ba6-466b-aa9e-9182279dd49a"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":25,"fieldUid":"72a74d52-7fcc-4c4e-8db1-1528c7ae5ee3"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"cd801712-4ba3-4a9c-8fab-0d3e2a58b4eb"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"72e5075a-9b06-4674-b040-615f4a6f7b70"}]	1	2022-04-15 04:01:18	2022-04-15 04:01:18	d6adad3f-3254-4504-989d-97e1ed11c40f
115	73	Gallery Assets	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Title","instructions":null,"tip":null,"warning":null,"width":50},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":50,"fieldUid":"e425947f-95b4-443c-ab86-fe521acc1f29"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"8bfcc6b7-ec2f-4759-bce9-c62bc12aecd4"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Video URL","instructions":"If a video is the main asset, link to it here.","tip":null,"warning":null,"required":"","width":100,"fieldUid":"a71f443d-14a3-402b-90ba-524dcce806d2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Description","instructions":"Teaser for the gallery item","tip":null,"warning":null,"required":"","width":100,"fieldUid":"657b9edd-b6d3-4b7f-af89-36117c5d98a8"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"","width":50,"fieldUid":"46d17af4-896a-4fc5-90bf-ac826090d9bc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"983dcb96-8eb2-4138-9c79-603b779fe2bb"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"51414e74-22c3-4134-9ccb-34f524920c2c"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"5a6d7b10-920d-464d-85ea-fc3881082fd7"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"","width":50,"fieldUid":"39e18ee6-2a14-4d32-94b9-867cbba8380b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"30885296-ea6f-4481-8e0f-e9d17e37c7c5"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"fbebfdbb-a4ca-48dd-8627-37fc2ffff0a3"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"40b120c8-203c-4787-b78c-7bfd9c56fe2f"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"5b70de37-9d5f-4c8f-87c7-9f2225761f54"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d23a9bfc-61f9-46fa-bfe4-a4ca97a20a61"}]	1	2022-04-15 04:01:18	2022-04-15 04:01:18	0c405b48-f6cf-4d9b-b0ef-92db651f6afa
116	6	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"39af5de5-d299-4bc5-965a-af2d128c7f1a"}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	9cc03051-4f26-48ec-bc8d-872d471e59fd
132	35	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"39af5de5-d299-4bc5-965a-af2d128c7f1a"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"58aa24c3-97e4-43e7-a812-7374e5650180"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"0073b1d1-a221-431d-aab9-bf4e193adf4f"}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	260b9227-94e3-4cba-a080-163afda69edf
133	36	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Label","instructions":"User-friendly name","tip":null,"warning":null,"width":100}]	1	2022-04-15 04:01:20	2022-04-15 04:01:20	a3f9e75d-3dac-4a74-a53a-3e1b52224b0d
118	75	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":75},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"10e8304e-93be-4c77-b1e9-7d9058c4aa92"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"a71f443d-14a3-402b-90ba-524dcce806d2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Internal Landing Page","instructions":"","tip":null,"warning":null,"required":"","width":50,"fieldUid":"a8fbf209-7591-40fa-88d4-b5944f4d27d8"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":75,"fieldUid":"496e755e-78ab-4e3f-8c3a-9b320023b8ec"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Approximate Duration","instructions":"","tip":null,"warning":null,"required":"","width":25,"fieldUid":"7970cd65-7a96-418a-8581-d6df4e039e6d"}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	0641f69a-c159-4054-bc43-e5c97c10274a
119	76	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Location","instructions":"","tip":null,"warning":null,"required":"1","width":50,"fieldUid":"40b120c8-203c-4787-b78c-7bfd9c56fe2f"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":50,"fieldUid":"f282d5ff-8da0-4ebb-a160-e5446c02193d"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":50,"fieldUid":"70d00340-3577-4a61-a2be-6e6fd986b5a7"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":50,"fieldUid":"84116f7d-7a26-41d7-bd7f-79761f9b50a9"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"a71f443d-14a3-402b-90ba-524dcce806d2"}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	1423d624-af2c-4a3e-be7a-99bf563bef2b
123	78	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"05eead62-7bf9-43e4-a7e8-bcd8f9f77323"},{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"75f0b770-5006-4359-848f-96415196bfe0"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":25,"fieldUid":"4404d713-d76b-4bb1-a9aa-bd88253b11d3"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"d49be42e-1e68-4688-ac3a-d8c7f7181965"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"6ed14c66-fec8-4bca-8f29-02cbd1620d12"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"c11d26d4-236a-4b06-99f6-3a8f67821ada"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"522db817-08b6-4ecf-a423-4aec204ab85d"}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	75ef5e01-e51b-437a-8d43-b59a259ebd76
134	37	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"39af5de5-d299-4bc5-965a-af2d128c7f1a"}]	1	2022-04-15 04:01:20	2022-04-15 04:01:20	377a52e9-6af3-4d67-b17f-038ebe793f7d
124	79	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Title","instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"7db205b7-a548-42f1-8c26-416ec51cf3fa"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"496e755e-78ab-4e3f-8c3a-9b320023b8ec"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"cc3b4231-1a7c-42f3-934c-cadeb0076f8c"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"In place of an image, a dynamic component can be chosen (currently only for Alert Stream)","tip":null,"warning":null,"required":"","width":25,"fieldUid":"fa690eba-6d46-4a5e-9dcd-0845f5b56c1b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"4c977b75-9ee1-4cdb-9d2a-203639f4af84"}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	0346a5ff-2d4b-44a5-a14f-135035893683
125	79	Appearance	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"8b8ed305-e6e6-4754-925f-bb07427b2060"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"36247100-a0f8-4eb9-b190-898131bf97b3"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"dfd8564d-5db6-4167-99db-29867a64bc2c"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"753b10b6-e9e6-44f5-a9d9-4a07788733e1"}]	2	2022-04-15 04:01:19	2022-04-15 04:01:19	54c75fe3-4554-4267-987c-6bd2ffc8fb17
195	60	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"7db205b7-a548-42f1-8c26-416ec51cf3fa"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	d2f16214-a2f0-47fd-9b48-484912d91925
127	33	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"39af5de5-d299-4bc5-965a-af2d128c7f1a"}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	a00d96cb-fe9b-4f4c-a996-2f9c5ac6e5c3
128	34	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"3146b06e-af03-43e7-b278-3a65c81f610e"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"a8ba2de3-ff22-4a96-9a53-00b6dec31def"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"87362cd0-662a-4068-9482-5ff62fe472c4"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"04000104-ec26-4d82-959a-729454e7f1cc"}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	421123c5-91bb-41ab-9f7f-057c80970ff7
129	39	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"39af5de5-d299-4bc5-965a-af2d128c7f1a"}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	3f724ba4-c64f-412c-88ae-89ede6953d54
130	40	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Label","instructions":"","tip":null,"warning":null,"width":100}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	1c841ed3-23e9-4b78-a177-8091f1abc726
131	38	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Label","instructions":"User-friendly job type","tip":null,"warning":null,"width":100}]	1	2022-04-15 04:01:19	2022-04-15 04:01:19	33924e10-387b-43b5-b394-6a4390b751b3
136	43	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Label","instructions":"User-friendly filter name","tip":null,"warning":null,"width":100}]	1	2022-04-15 04:01:20	2022-04-15 04:01:20	b43244bd-3ee4-4b32-84a4-8032d2c587a3
138	81	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Description","instructions":"Teaser for the slideshow as a whole","tip":null,"warning":null,"required":"","width":100,"fieldUid":"657b9edd-b6d3-4b7f-af89-36117c5d98a8"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"8bfcc6b7-ec2f-4759-bce9-c62bc12aecd4"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b4139639-fe83-4dd3-acf6-581a798190b5"}]	1	2022-04-15 04:01:20	2022-04-15 04:01:20	4b88bc18-0798-4461-8f42-21e11c478c74
140	9	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"9ad13bcd-637a-4757-9968-cdcc02cfd478"}]	1	2022-04-15 04:01:21	2022-04-15 04:01:21	70c2c917-fae1-4595-b3cb-eb019eda8584
141	82	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Name","instructions":"","tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Title","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"7970cd65-7a96-418a-8581-d6df4e039e6d"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"1d7324d5-d322-4b06-9eb5-52a6c2f856f3"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"40b120c8-203c-4787-b78c-7bfd9c56fe2f"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"7beb32e3-0674-4b9c-9878-022862950868"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"7e3805b7-2117-4d8a-865a-5abd90b6d518"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Pull Quote","instructions":"","tip":null,"warning":null,"required":"","width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b144a695-58be-4586-81cf-0ae9030280ce"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"67348234-547f-437f-8356-934347dddb5a"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"40ee52fe-bbe1-4b44-97ea-ef987105496b"}]	1	2022-04-15 04:01:21	2022-04-15 04:01:21	cd4b0d81-a055-4ebd-b4b8-6a1a3f7f237c
142	83	Pages	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"831db889-442e-4553-9076-fc3bc2843c8c"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"cd801712-4ba3-4a9c-8fab-0d3e2a58b4eb"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"3c9eb8f7-9f84-4c22-84d5-531be77aa6b6"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"05eead62-7bf9-43e4-a7e8-bcd8f9f77323"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"72e5075a-9b06-4674-b040-615f4a6f7b70"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"8b5bcbee-1883-48ca-8c9a-6c506b9abb99"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"fa690eba-6d46-4a5e-9dcd-0845f5b56c1b"}]	1	2022-04-15 04:01:21	2022-04-15 04:01:21	e1906e2c-5223-477b-b919-32f9eb0fb07a
143	83	Sub Hero Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Sub Hero Header","instructions":"","tip":null,"warning":null,"required":"","width":100,"fieldUid":"7970cd65-7a96-418a-8581-d6df4e039e6d"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"24f23fec-fc66-46f8-86e1-396d01315ad2"}]	2	2022-04-15 04:01:21	2022-04-15 04:01:21	19890dd4-d94d-47de-a8d0-c74e40e4cbde
146	21	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100}]	1	2022-04-15 04:01:22	2022-04-15 04:01:22	dc79c7de-ddf3-4002-bab0-7b2ba096a0a4
148	19	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"a61323db-26ac-4898-873c-a6c6b66fcb86"}]	1	2022-04-15 04:01:22	2022-04-15 04:01:22	5aae7dab-66c7-4708-a13a-4f1169f177d0
201	65	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d4696dbe-019e-4c97-a95d-07bfaf9dbd03"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	95c88bb8-f392-4b09-baf8-7214a15137fc
150	4	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":false,"width":50,"fieldUid":"e9726196-f241-49d4-9b6b-9e8d419e6669"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"5f0325e0-cdba-4181-a634-bd8ebf451723"}]	1	2022-04-15 04:01:22	2022-04-15 04:01:22	8829235d-5aab-4c53-bcf4-1f9daafa43f8
152	10	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Table Title","instructions":"","tip":null,"warning":null,"required":false,"width":50,"fieldUid":"7970cd65-7a96-418a-8581-d6df4e039e6d"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"635a4a93-f10b-4d3c-bd44-2ea1474ad4cb"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"f0603433-ef74-4883-8aec-03e31f8dc34e"}]	1	2022-04-15 04:01:22	2022-04-15 04:01:22	294be91f-036c-4366-8c86-ec4bb518fdcf
154	14	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"aa649fa7-795e-427b-bb5e-dbbf5668c3b1"}]	1	2022-04-15 04:01:22	2022-04-15 04:01:22	cfbc145d-cac4-4025-9513-1ef0f886f49e
156	13	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"5f0325e0-cdba-4181-a634-bd8ebf451723"}]	1	2022-04-15 04:01:22	2022-04-15 04:01:22	7082bd6f-a1c9-4d1a-b9b1-ce3e061da116
158	11	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"}]	1	2022-04-15 04:01:22	2022-04-15 04:01:22	c042c750-79ac-4f34-abfd-0e6ca227d4c5
160	12	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Question","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Answer","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"7db205b7-a548-42f1-8c26-416ec51cf3fa"}]	1	2022-04-15 04:01:22	2022-04-15 04:01:22	baba5377-c448-4a3a-b24f-777c24501472
161	2	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"0f48338c-1c16-4600-9230-68bacb7c21e3"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"f444667c-6ea1-4e0f-89b2-35b059e27bfc"}]	1	2022-04-15 04:01:22	2022-04-15 04:01:22	3d527b5b-a8db-412e-b87e-6ea934f73ab4
179	17	Custom Breadcrumbs	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"","width":100,"fieldUid":"9c34fc8b-8bc3-4f8a-bbc8-ea58a018719a"}]	1	2022-04-15 04:01:30	2022-04-15 04:01:30	dd58f81e-83f4-452a-826a-8b0c71b193c4
164	30	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":true,"width":100,"fieldUid":"966a6b65-ca53-48a8-89dc-74983cd624ef"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":true,"width":100,"fieldUid":"ddf8dce2-4fa1-43d1-b306-b34d9d97a91b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":true,"width":100,"fieldUid":"4294fb85-8029-437c-a2e5-76bcd1a79ef1"}]	1	2022-04-15 04:01:23	2022-04-15 04:01:23	16c33743-89ea-4728-aac0-a573a1343e6b
165	29	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":true,"width":100,"fieldUid":"cb6a7cee-4f9e-4191-8c6d-33ccdd921fec"}]	1	2022-04-15 04:01:23	2022-04-15 04:01:23	203e9b0c-09be-495a-89a1-672649472913
166	27	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":true,"width":100,"fieldUid":"cc694df6-ebfe-4e0c-b4fe-713761f100df"}]	1	2022-04-15 04:01:23	2022-04-15 04:01:23	c3fb6320-47d2-4652-a79f-41ca33643664
167	16	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":true,"width":100,"fieldUid":"af1b8590-3d8a-4eb1-90e1-60e3d7407a1a"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":true,"width":100,"fieldUid":"d889713c-632a-4323-bb10-4b2bc53545ad"}]	1	2022-04-15 04:01:23	2022-04-15 04:01:23	eb0c965d-f114-433d-986c-c47665160e18
168	18	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"a5bb0742-012f-4683-a471-874944bf3280"}]	1	2022-04-15 04:01:23	2022-04-15 04:01:23	354ea070-7e70-420c-b21e-2ede9ca005c5
169	26	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"5075e912-4aa1-4ce4-96b2-8868358b51e3"}]	1	2022-04-15 04:01:23	2022-04-15 04:01:23	e9b33212-20c8-4358-943b-f2d4872d2b86
171	3	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Image","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"fb052686-4537-4fe5-9ce2-ff3fd4a341a2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"d019727b-a6d5-43d9-a688-f10df985a87e"}]	1	2022-04-15 04:01:23	2022-04-15 04:01:23	01929e59-b3f9-46b8-ad87-957ce6f1fe04
172	25	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"1e0c12ac-5dd7-4ed2-8cda-3801130b11e1"}]	1	2022-04-15 04:01:23	2022-04-15 04:01:23	fc24c3ac-6325-4ecc-ab72-80a28fa939bf
173	24	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"c4060079-e438-4c63-8b06-77cdea857fd9"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"95b97a67-eccb-4910-b0e8-77f5860058b4"}]	1	2022-04-15 04:01:23	2022-04-15 04:01:23	4ecd8b35-e10d-4ec5-9f57-c86e6210f37d
193	57	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Video URL","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"a71f443d-14a3-402b-90ba-524dcce806d2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"10118ebf-e3bf-4b1b-bbb8-4b57ab3753c8"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	119d7d0b-2995-4609-99e8-5c661b819ae4
197	61	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"7db205b7-a548-42f1-8c26-416ec51cf3fa"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	27ebd961-9d14-4daa-970a-26d09559d8e1
174	22	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"5ca18cb3-5a7b-4764-9e18-fc24b4cecc14"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"5548b745-642b-4b15-8f17-4ce7457689a8"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"9c14ac7e-c466-4c2d-a2fd-e19a68fc706d"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"e338eebb-6488-4f58-a07e-db43f28ff56b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"2755abe1-7dd5-428c-a6bb-30d2bd59a362"}]	1	2022-04-15 04:01:24	2022-04-15 04:01:24	3f5277df-6439-46ae-8c1b-f004cb1e2769
180	20	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"e48cbecf-107a-43c6-b099-9d6f3d7cadd8"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"c9bce017-1c1c-4949-ad3b-a5c0b991a83a"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"03d7331c-b357-4eed-a6b0-3c5a403cae73"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"58f1a805-f9c5-46ce-81dd-e17a3ea99353"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"61e2311c-55a3-4219-9afe-606f0f422e3f"}]	1	2022-04-15 04:01:30	2022-04-15 04:01:30	8eba6aa5-f285-4ce3-ae8c-840d7a4fa79d
181	28	Links	[{"type":"craft\\\\fieldlayoutelements\\\\Tip","tip":"Select an internal entry (page or gallery asset) or provide a link to an external webpage.","style":"tip"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"4c977b75-9ee1-4cdb-9d2a-203639f4af84"}]	1	2022-04-15 04:01:30	2022-04-15 04:01:30	e1756793-d8cb-4566-a19d-008505e27efb
182	28	Colophon	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"20aeb76c-ce1e-47c4-96bd-6ebc1d456ef7"}]	2	2022-04-15 04:01:30	2022-04-15 04:01:30	972386df-5d65-41a1-bb94-000115604601
183	28	Financial Supporters	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"5ca378e1-cfb5-4db9-ad3c-1d6ef36536b7"}]	3	2022-04-15 04:01:30	2022-04-15 04:01:30	054611b4-4f71-4493-b9a4-1092eb46a867
185	5	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Staff Profile","instructions":"","tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d4696dbe-019e-4c97-a95d-07bfaf9dbd03"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	82179e6e-9060-4d95-ac8b-b351144593ee
187	7	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Heading","instructions":" ","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"Optional link that appears at the bottom of the grid.","tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d019727b-a6d5-43d9-a688-f10df985a87e"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	1383d3cf-cadd-4d06-a3a4-f01d78f230f9
189	63	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Heading","instructions":"","tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d019727b-a6d5-43d9-a688-f10df985a87e"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"fa690eba-6d46-4a5e-9dcd-0845f5b56c1b"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Slider Items Number","instructions":"Max # dynamic slide items to add to this block.","tip":null,"warning":null,"required":false,"width":50,"fieldUid":"660361f1-3ecb-4c5e-9274-76e54f1f291f"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	e586ea15-8a7d-4ec3-9b66-812959d6e8bb
191	58	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Video URL","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"a71f443d-14a3-402b-90ba-524dcce806d2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"10118ebf-e3bf-4b1b-bbb8-4b57ab3753c8"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	68256df8-d512-4717-90d1-f702f618f120
203	62	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Heading","instructions":"","tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d019727b-a6d5-43d9-a688-f10df985a87e"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Staff Type","instructions":"Leave blank for all profiles","tip":null,"warning":null,"required":false,"width":100,"fieldUid":"7beb32e3-0674-4b9c-9878-022862950868"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"660361f1-3ecb-4c5e-9274-76e54f1f291f"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	3269e1ca-2c43-4235-92dc-aaebf7c2a749
205	56	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"e98e0ffd-73fa-4e57-808c-dcb9873209ca"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":50,"fieldUid":"d4696dbe-019e-4c97-a95d-07bfaf9dbd03"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	27ca7a88-c5bf-4a7f-af78-bda78d659f85
207	8	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"af3e9835-4926-4399-bda9-7f6882cdce5e"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	abe4b07f-80a1-49f6-9b41-0536c8c80bf4
209	54	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"c5f150d4-fc85-4a5f-a3a7-4d4a1d655861"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	4e32dd96-9a4d-477d-baba-608eb28df259
211	31	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"fb052686-4537-4fe5-9ce2-ff3fd4a341a2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"10118ebf-e3bf-4b1b-bbb8-4b57ab3753c8"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	f5cb6bdc-2c81-4521-9df3-1b1e6dd3facf
213	32	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"fb052686-4537-4fe5-9ce2-ff3fd4a341a2"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"10118ebf-e3bf-4b1b-bbb8-4b57ab3753c8"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	3a2a65e3-b993-41b3-bae6-abbb541e0704
217	52	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d019727b-a6d5-43d9-a688-f10df985a87e"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	1583fbbf-8cec-4f59-ac68-71a30a2f0f88
219	50	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Link text","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":100,"fieldUid":"a71f443d-14a3-402b-90ba-524dcce806d2"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	1fb41614-19fa-4a98-8801-dbca710a84a9
221	53	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Heading","instructions":"","tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d019727b-a6d5-43d9-a688-f10df985a87e"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"4404d713-d76b-4bb1-a9aa-bd88253b11d3"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"660361f1-3ecb-4c5e-9274-76e54f1f291f"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	f3bb3ac8-190e-4e9c-91b1-ac03e5df5f80
223	48	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Heading","instructions":"","tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d019727b-a6d5-43d9-a688-f10df985a87e"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"660361f1-3ecb-4c5e-9274-76e54f1f291f"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	980f4c20-2986-433f-af0a-5f187319f4e1
225	55	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"838028d1-bb13-49aa-a2ee-b0b2e7e6a4fa"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	3fe89b61-386b-4a6b-af40-58df468ffdf1
227	44	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"Heading","instructions":"","tip":null,"warning":null,"required":false,"width":100,"fieldUid":"b0ce3829-20c1-44ef-a7c7-499800645afc"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d019727b-a6d5-43d9-a688-f10df985a87e"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"660361f1-3ecb-4c5e-9274-76e54f1f291f"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	3ff836d8-85ab-44d9-98b0-4545851c06f5
229	45	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"0df27088-950f-4f9e-9115-06e8f780b5ca"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	e5b36e3c-528e-4de7-b2e9-31b1b1c38696
231	46	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"0df27088-950f-4f9e-9115-06e8f780b5ca"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	5ad38545-3f83-4169-b6ac-4d13c060b3ff
233	47	default	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":50,"fieldUid":"75f0b770-5006-4359-848f-96415196bfe0"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"cd801712-4ba3-4a9c-8fab-0d3e2a58b4eb"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	cf529c30-fc23-4c1d-bf46-915cd8a504c0
235	49	default	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":25,"fieldUid":"36eb6d5c-23a9-43c9-bf13-4ca926869004"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"4a55a5d1-655b-4e30-8466-c84b6d8558dd"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":"","instructions":"","tip":null,"warning":null,"required":"1","width":50,"fieldUid":"cd801712-4ba3-4a9c-8fab-0d3e2a58b4eb"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"6f86b4dc-dab0-46fa-860d-81f6ebe6b541"}]	1	2022-04-15 04:01:31	2022-04-15 04:01:31	64a4b576-9a18-4a36-8177-981df4c29100
236	23	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Label","instructions":"User-friendly name","tip":null,"warning":null,"width":100}]	1	2022-04-15 04:01:33	2022-04-15 04:01:33	516139c9-270d-46ce-9487-9a95947f7708
237	88	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"1ed94e58-7078-46fb-b590-0692fbdf9c20"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"e7913600-c914-4ab1-a9bb-abd2bdcbfb94"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"74319755-d24f-4991-a84a-0c1c031cb21e"}]	1	2022-04-15 04:01:34	2022-04-15 04:01:34	760696b9-809f-4505-806c-4883031f965b
238	87	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":25,"fieldUid":"380c1cbe-884e-421b-9e31-1f0dfc81e15f"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":75,"fieldUid":"c9e9db12-fcdb-4b82-a8c8-eef21b3543af"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"4b94ba3d-060c-4a09-b2dc-c519a4c83709"}]	1	2022-04-15 04:01:34	2022-04-15 04:01:34	e58c8efc-5df5-4d03-a882-f3897c54d799
239	86	Content	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"991c5031-3b97-45d8-8829-c8e0c79537a9"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"dff2a767-333e-4c9d-880c-143e1ca2aaa3"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"cbf3fbbb-2f2b-4568-a228-f8c63ff4601c"}]	1	2022-04-15 04:01:35	2022-04-15 04:01:35	a1407f4c-ce31-45d8-b7f4-340947098ed4
251	85	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100}]	1	2022-04-17 00:24:14	2022-04-17 00:24:14	0a987b4f-8073-416e-87f3-7f9ab349c6b9
253	84	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100}]	1	2022-04-17 00:24:14	2022-04-17 00:24:14	ca2b38c8-ffb7-4ac0-b391-9b2ab9123f3c
254	80	Content	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100}]	1	2022-04-17 00:24:14	2022-04-17 00:24:14	e6e4190e-fdde-445c-9c86-adceba01eb29
257	42	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Label","instructions":"User-friendly name","tip":null,"warning":null,"width":100}]	1	2022-04-17 00:24:14	2022-04-17 00:24:14	c167253a-62d5-4006-a167-4967488b25f5
258	59	Content	[{"type":"craft\\\\fieldlayoutelements\\\\AssetTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100}]	1	2022-04-17 00:24:15	2022-04-17 00:24:15	d5c3ca66-a24f-4036-86ce-b8ee07cfc86f
259	41	Content	[{"type":"craft\\\\fieldlayoutelements\\\\TitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Label","instructions":"","tip":null,"warning":null,"width":100}]	1	2022-04-17 00:24:15	2022-04-17 00:24:15	56c27595-a906-4bd7-9942-9737996bff0d
260	51	Link	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"d019727b-a6d5-43d9-a688-f10df985a87e"}]	1	2022-04-17 00:24:15	2022-04-17 00:24:15	a37c7f02-a3e0-41a0-b86a-1d4f2236ad3d
261	15	Metadata	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"8fff3c50-28ba-4af7-8166-e3d82a23ae26"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"acbea415-ee80-409c-90e2-90ac546820a6"}]	1	2022-04-17 00:24:15	2022-04-17 00:24:15	af59b61d-1cb3-4325-bb4d-00c625c77fef
265	89	Tab 1	[{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"7db205b7-a548-42f1-8c26-416ec51cf3fa"}]	1	2022-04-17 16:41:46	2022-04-17 16:41:46	5e7cbd3e-6218-4860-8e19-e3e6a0fb55a0
266	77	Pages	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":"Title","instructions":null,"tip":null,"warning":null,"width":75},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"641bcbaa-093a-41bc-a403-6696f52ce6a9"}]	1	2022-04-17 16:43:10	2022-04-17 16:43:10	f743d294-a642-438b-91e2-a378698091a1
267	74	Pages	[{"type":"craft\\\\fieldlayoutelements\\\\EntryTitleField","autocomplete":false,"class":null,"size":null,"name":null,"autocorrect":true,"autocapitalize":true,"disabled":false,"readonly":false,"title":null,"placeholder":null,"step":null,"min":null,"max":null,"requirable":false,"id":null,"containerAttributes":[],"inputContainerAttributes":[],"labelAttributes":[],"orientation":null,"label":null,"instructions":null,"tip":null,"warning":null,"width":100},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4"},{"type":"craft\\\\fieldlayoutelements\\\\CustomField","label":null,"instructions":null,"tip":null,"warning":null,"required":false,"width":100,"fieldUid":"641bcbaa-093a-41bc-a403-6696f52ce6a9"}]	1	2022-04-17 16:43:26	2022-04-17 16:43:26	72b82cfc-2af9-4432-b63f-fd34e6d32e59
\.


--
-- Data for Name: fields; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.fields (id, "groupId", name, handle, context, "columnSuffix", instructions, searchable, "translationMethod", "translationKeyFormat", type, settings, "dateCreated", "dateUpdated", uid) FROM stdin;
3	1	Alternative Text	altText	global	\N	Required description of the image for non-sighted users (https://webaim.org/techniques/alttext/).	t	site	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":null,"uiMode":"normal"}	2022-04-15 04:01:04	2022-04-15 04:01:04	39af5de5-d299-4bc5-965a-af2d128c7f1a
52	1	Link Text	linkText	global	\N	Text for optional link at end of block. Will be populated by the page title if left blank and referencing an internal entry.	t	none	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":null,"uiMode":"normal"}	2022-04-15 04:01:06	2022-04-15 04:01:06	e9726196-f241-49d4-9b6b-9e8d419e6669
54	1	Links	links	global	\N		t	site	\N	benf\\neo\\Field	{"maxBlocks":"","maxTopBlocks":"","minBlocks":"","propagationMethod":"all","wasModified":false}	2022-04-15 04:01:06	2022-04-15 04:01:06	4c977b75-9ee1-4cdb-9d2a-203639f4af84
59	1	Link	mixedLink	global	\N		t	site	\N	lenz\\linkfield\\fields\\LinkField	{"allowCustomText":true,"allowTarget":true,"autoNoReferrer":true,"customTextMaxLength":0,"customTextRequired":false,"defaultLinkName":"entry","defaultText":"","enableAllLinkTypes":false,"enableAriaLabel":false,"enableElementCache":false,"enableTitle":false,"typeSettings":{"asset":{"allowCrossSiteLink":false,"allowCustomQuery":false,"enabled":false,"sources":"*"},"category":{"allowCrossSiteLink":false,"allowCustomQuery":false,"enabled":false,"sources":"*"},"custom":{"allowAliases":false,"disableValidation":false,"enabled":false},"email":{"allowAliases":false,"disableValidation":false,"enabled":true},"entry":{"allowCrossSiteLink":false,"allowCustomQuery":false,"enabled":true,"sources":"*"},"site":{"enabled":false,"sites":"*"},"tel":{"allowAliases":false,"disableValidation":false,"enabled":true},"url":{"allowAliases":false,"disableValidation":false,"enabled":true},"user":{"allowCrossSiteLink":false,"allowCustomQuery":false,"enabled":false,"sources":"*"}}}	2022-04-15 04:01:06	2022-04-15 04:01:06	d019727b-a6d5-43d9-a688-f10df985a87e
66	1	Entry - Page	pageEntry	global	\N		t	site	\N	craft\\fields\\Entries	{"allowSelfRelations":false,"limit":"","localizeRelations":false,"selectionLabel":"Add a Page","showSiteMenu":true,"source":null,"sources":["section:f1b8c943-bc12-4001-9e2a-d531379f1aaf"],"targetSiteId":null,"validateRelatedElements":false,"viewMode":null}	2022-04-15 04:01:07	2022-04-15 04:01:07	5f0325e0-cdba-4181-a634-bd8ebf451723
70	1	Plain Text	plainText	global	\N		t	site	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":"Text","uiMode":"normal"}	2022-04-15 04:01:07	2022-04-15 04:01:07	7970cd65-7a96-418a-8581-d6df4e039e6d
87	10	Description	siteDescription	global	\N		f	site	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":null,"uiMode":"normal"}	2022-04-15 04:01:07	2022-04-15 04:01:07	acbea415-ee80-409c-90e2-90ac546820a6
89	10	Title	siteTitle	global	\N		f	site	\N	craft\\fields\\PlainText	{"byteLimit":null,"charLimit":null,"code":"","columnType":null,"initialRows":"4","multiline":"","placeholder":null,"uiMode":"normal"}	2022-04-15 04:01:07	2022-04-15 04:01:07	8fff3c50-28ba-4af7-8166-e3d82a23ae26
103	1	Text	text	global	\N		t	site	\N	craft\\redactor\\Field	{"availableTransforms":"*","availableVolumes":"*","cleanupHtml":true,"columnType":"text","configSelectionMode":"choose","defaultTransform":"","manualConfig":"","purifierConfig":"","purifyHtml":"1","redactorConfig":"","removeEmptyTags":"1","removeInlineStyles":"1","removeNbsp":"1","showHtmlButtonForNonAdmins":"","showUnpermittedFiles":false,"showUnpermittedVolumes":false,"uiMode":"enlarged"}	2022-04-15 04:01:08	2022-04-15 04:01:08	7db205b7-a548-42f1-8c26-416ec51cf3fa
140	6	Page Type	pageType	global	kxxunrnk	Defines the type of page: `Standard` for content pages, `Dynamic` for fully API-driven, `Single` for pages defined as the entry type single, `External` for external pages.	t	none	\N	craft\\fields\\RadioButtons	{"options":[{"label":"Standard","value":"standard","default":"1"},{"label":"Dynamic","value":"dynamic","default":""},{"label":"Single","value":"single","default":""},{"label":"External","value":"external","default":""}]}	2022-04-17 00:43:10	2022-04-17 00:43:10	641bcbaa-093a-41bc-a403-6696f52ce6a9
141	6	Content Blocks	contentBlocks	global	\N		t	site	\N	benf\\neo\\Field	{"maxBlocks":"","maxTopBlocks":"","minBlocks":"","propagationMethod":"all","wasModified":false}	2022-04-17 16:41:46	2022-04-17 16:41:46	4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4
\.


--
-- Data for Name: globalsets; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.globalsets (id, name, handle, "fieldLayoutId", "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
1	Site Information	siteInfo	15	0	2022-04-15 04:01:09	2022-04-15 04:01:09	8ccd6c1c-8e9b-44e8-93a9-f62589fb4819
2	Root Page Information	rootPageInformation	17	0	2022-04-15 04:01:09	2022-04-15 04:01:09	994d5664-f056-4969-b2cc-c62660f069af
3	Gallery Item Defaults	galleryItemDefaults	20	0	2022-04-15 04:01:09	2022-04-15 04:01:09	b8393df9-fb81-4d70-9ccb-6d030c818580
4	Footer Content	footer	28	0	2022-04-15 04:01:17	2022-04-15 04:01:17	1a2ba41a-3949-4982-9cb3-f8b03863bcfd
\.


--
-- Data for Name: gql_refresh_tokens; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.gql_refresh_tokens (id, token, "userId", "schemaId", "dateCreated", "dateUpdated", "expiryDate", uid) FROM stdin;
\.


--
-- Data for Name: gqlschemas; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.gqlschemas (id, name, scope, "isPublic", "dateCreated", "dateUpdated", uid) FROM stdin;
3	Public Schema	["sections.7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b:read","entrytypes.942c9e60-2760-42ed-b03b-9e5eb133751b:read","entrytypes.34f61e7c-358c-48b8-8439-42bc05ed255c:read","entrytypes.fa15bb4c-adb8-4393-82c3-15c2b830867c:read","sections.4305f2e2-40b8-47b2-8b62-135b8b57be7f:read","entrytypes.6acd6e24-26c9-4e55-a35b-c29cd36a7a3c:read","sections.3a8b9653-cdd3-46ce-84b2-d73b5dc4de63:read","entrytypes.7187131b-681b-45de-a1ea-87a8d070c05a:read","sections.4ffeb743-f02d-42af-8656-a6f9c1363e79:read","entrytypes.bbf936fb-1787-437b-8ebd-a6e79409896e:read","sections.3e10dcca-4dd1-4578-8add-708cd9740881:read","entrytypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6:read","sections.546e0c6d-dd32-4997-8487-cc4c2fcc9480:read","entrytypes.0b946ecb-12e3-4999-9d02-fc902cb66fdf:read","sections.59fb5a9e-74f4-4618-adba-601791f42c92:read","entrytypes.39558c70-8baf-4748-9f12-49e78a04eed5:read","sections.11be7603-f576-4af8-93a6-e285e4ff42c4:read","entrytypes.4729ad5e-485e-4f98-995d-79fa5254cd42:read","sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf:read","entrytypes.23eda090-7e8e-401d-ab49-ee4becc34935:read","entrytypes.9d045432-a0fb-4fcd-8bca-3bc93b1f7056:read","entrytypes.26ca2777-e4c8-41b4-ac93-aa28d09117dd:read","sections.04a48967-eac4-449f-b164-c8ecbb7036d6:read","entrytypes.229f2975-93d3-4c6a-9996-dfa1de3004ef:read","sections.fb3283a6-7286-4b2b-a77a-010783dcee7e:read","entrytypes.a77c49d2-2441-459e-bfea-63e571d25a12:read","sections.78410791-6edc-46c9-a17b-4358dcd545ec:read","entrytypes.7d60273b-66b0-4843-a42c-4b4387185a15:read","sections.89cab4ff-f556-4b7e-bae9-8db545ce38dd:read","entrytypes.573c9705-aca2-4419-b039-c7071536a2ce:read","sections.1ee32484-2cca-457e-ac23-b3cb13e652d3:read","entrytypes.534d275e-b6e9-4064-9965-07e804e0fcc1:read","volumes.8e9ec71e-2cf0-4f6a-b856-8976de0ce100:read","volumes.cd6f2275-4f9b-4ba4-aa4c-7c7468366172:read","volumes.f52f3e9c-434e-43b5-89eb-a5776e6bc4a6:read","volumes.18a75c63-648f-4145-9cc3-386e7c8a0106:read","volumes.c3d1c243-1703-4117-abc7-88487a1f8f24:read","volumes.d41cc960-99a4-41a8-a7a6-7891a22e4a93:read","volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d:read","globalsets.b8393df9-fb81-4d70-9ccb-6d030c818580:read","globalsets.994d5664-f056-4969-b2cc-c62660f069af:read","globalsets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819:read","globalsets.1a2ba41a-3949-4982-9cb3-f8b03863bcfd:read","usergroups.everyone:read","usergroups.01b89d98-9aa4-46d5-a9a0-60a0c07fd815:read","usergroups.58efa872-9485-42e3-a1e3-a5435def5392:read","usergroups.e0be58f6-fc1b-4a02-816c-0a37b0fcd602:read","categorygroups.3a3af2ab-b037-455a-ba95-bc3be89efdb0:read","categorygroups.4ead9327-61fc-4b46-810c-5f490c2c45ad:read","categorygroups.cc8c47f0-3dec-44db-a47f-7ca6c984864a:read","categorygroups.df7f4ec2-58b2-4c3a-afff-b07f4764fa4b:read","categorygroups.7cb3bc06-c4c4-4017-8c0c-fa6aad7cbd8e:read","categorygroups.0928ff1a-513d-41e0-acc1-606d93988618:read","categorygroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2:read","categorygroups.aa60fd40-45d4-48bb-8b81-8ec736456687:read","taggroups.c30bad12-1372-49fe-ab6c-a9c33b2860bb:read","taggroups.0d02fdfb-053c-4d46-a5f8-0abf2542a5d2:read"]	t	2022-04-15 04:01:18	2022-04-15 04:01:18	4fe339ec-7579-46f4-a362-df6ee8de4b3c
\.


--
-- Data for Name: gqltokens; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.gqltokens (id, name, "accessToken", enabled, "expiryDate", "lastUsed", "schemaId", "dateCreated", "dateUpdated", uid) FROM stdin;
1	Public Token	__PUBLIC__	t	\N	\N	3	2022-04-15 04:01:24	2022-04-15 04:01:24	9105d474-41ad-48e6-b24c-e5691af3acc4
\.


--
-- Data for Name: info; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.info (id, version, "schemaVersion", maintenance, "configVersion", "fieldVersion", "dateCreated", "dateUpdated", uid) FROM stdin;
1	3.7.17.1	3.7.8	f	qfxqwuiexsnv	hwqjoarnnrtp	2022-04-15 04:01:03	2022-04-17 16:43:26	281c362b-f703-48d1-88d9-a4ccd6686175
\.


--
-- Data for Name: lenz_linkfield; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.lenz_linkfield (id, "elementId", "fieldId", "siteId", type, "linkedUrl", "linkedId", "linkedSiteId", "linkedTitle", payload, "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: matrixblocks; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.matrixblocks (id, "ownerId", "fieldId", "typeId", "sortOrder", "deletedWithOwner", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: matrixblocktypes; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.matrixblocktypes (id, "fieldId", "fieldLayoutId", name, handle, "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.migrations (id, track, name, "applyTime", "dateCreated", "dateUpdated", uid) FROM stdin;
1	plugin:asset-metadata	m180919_000000_craft3	2022-04-15 04:01:03	2022-04-15 04:01:03	2022-04-15 04:01:03	96a97b35-7245-4998-b77e-6c85457084b5
8	plugin:graphql-authentication	Install	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	4885db40-0a2f-45d7-8e60-6181f809e26c
9	plugin:graphql-authentication	m201129_224453_create_refresh_tokens	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	78e5bc54-85f7-41de-8fbf-ef221c133ccf
10	plugin:graphql-authentication	m211014_234909_schema_id_to_schema_name	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	d14aa919-6835-455b-a7e0-9cef4294194a
11	plugin:neo	Install	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	40eac2f6-f805-431a-a7d7-3470d279fb1b
12	plugin:neo	m181022_123749_craft3_upgrade	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	37331682-9217-498f-83c0-94b5b9b88768
13	plugin:neo	m190127_023247_soft_delete_compatibility	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	5f5d5744-9f14-4be3-a896-b50a23925ab2
14	plugin:neo	m200313_015120_structure_update	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	f6e694c3-c1aa-48a1-9fd6-8cf4d4fe4e72
15	plugin:neo	m200722_061114_add_max_sibling_blocks	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	9523c6c8-51cd-471e-8c4e-57720acfed23
16	plugin:neo	m201108_123758_block_propagation_method_fix	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	4ea44e37-0153-4f31-b497-9d0171be1df2
17	plugin:neo	m201208_110049_delete_blocks_without_sort_order	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	a4a8f72a-7e9b-41fa-b5fd-13fc21a1b139
18	plugin:redactor	m180430_204710_remove_old_plugins	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	18b16515-2dd4-4cbd-8e3e-77413e81f5b9
19	plugin:redactor	Install	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	050e6c4d-ebac-44fa-8773-d9fd7db66bb8
20	plugin:redactor	m190225_003922_split_cleanup_html_settings	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	6f29b80d-e95f-47c6-af87-47e37aee7865
21	plugin:super-table	Install	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	d6db9292-6aef-4f64-9f1a-20238d21b6f9
22	plugin:super-table	m180210_000000_migrate_content_tables	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	c8cebdf1-601e-4ce7-8f55-2e90c1a14e69
23	plugin:super-table	m180211_000000_type_columns	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	78108e0a-f3ee-46ae-8552-b31c2bd01d90
24	plugin:super-table	m180219_000000_sites	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	4951e939-cb18-47c8-93a5-8df4a32b3120
25	plugin:super-table	m180220_000000_fix_context	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	8ed7a03f-54ac-4a9b-a1ba-5209531e9185
26	plugin:super-table	m190117_000000_soft_deletes	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	0ac4cd30-8505-472f-9a7d-39f788a0838d
27	plugin:super-table	m190117_000001_context_to_uids	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	5a51f6ac-dc78-46e5-8cac-368ecc17976f
28	plugin:super-table	m190120_000000_fix_supertablecontent_tables	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	20b828e8-77bd-46e1-bee1-df924392bb9b
29	plugin:super-table	m190131_000000_fix_supertable_missing_fields	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	bf625eb9-0033-4ba7-b2c6-7defb14b5fa7
30	plugin:super-table	m190227_100000_fix_project_config	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	de582c28-8bab-4fc8-9baa-4128635c6ffb
31	plugin:super-table	m190511_100000_fix_project_config	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	958c80d5-e431-41c1-9e6b-03243b2edcde
32	plugin:super-table	m190520_000000_fix_project_config	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	371096e1-6668-45bf-840c-0c8efb8b0da6
33	plugin:super-table	m190714_000000_propagation_method	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	1a96cdf3-b2bb-495e-9b0a-64195626894b
34	plugin:super-table	m191127_000000_fix_width	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	40ede899-7e99-4511-95c1-aaa59f7e420b
35	plugin:typedlinkfield	Install	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	107fc984-a819-43e1-8416-e666839afedc
36	plugin:typedlinkfield	m190417_202153_migrateDataToTable	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	3fa016df-8b86-4a26-a5e6-2aa2209d10c8
37	plugin:universal-dam-integrator	Install	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:01:04	9d14ddea-b042-4f50-ac84-92f182eb7506
38	craft	Install	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	742ba433-d8a4-4dcb-bf85-9573298ccbfb
39	craft	m150403_183908_migrations_table_changes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	d5249890-dd62-4aeb-a881-35a35c65b383
40	craft	m150403_184247_plugins_table_changes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	e09db41c-467e-490e-b4c6-366222706788
41	craft	m150403_184533_field_version	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	f96f4a1e-1125-43c2-8883-3e3198dee9fe
42	craft	m150403_184729_type_columns	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	a37497d8-e89c-4366-85cd-df9cbea0bef1
43	craft	m150403_185142_volumes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	a2e513ae-5165-4209-826f-887d24eaa97c
44	craft	m150428_231346_userpreferences	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	9009290b-8463-4404-96e7-c0cd119e8f72
45	craft	m150519_150900_fieldversion_conversion	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b7fe2c3b-5af2-43e2-a35c-76bc8ac4d8ad
46	craft	m150617_213829_update_email_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	bf553633-5467-447a-8a06-40c3baf38a1a
47	craft	m150721_124739_templatecachequeries	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	5261005f-a2a7-4d8a-8526-93c96a469809
48	craft	m150724_140822_adjust_quality_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	04dfb33b-88a8-40f3-9ce1-e56c25cecc4b
49	craft	m150815_133521_last_login_attempt_ip	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	ffb02bc8-6c3c-4645-971f-eeef0d480aec
50	craft	m151002_095935_volume_cache_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	edb28fa5-ddbc-45b7-8df8-7fd13ae6b0fd
51	craft	m151005_142750_volume_s3_storage_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	5fc77a13-4e06-4482-be54-a697f64d7ad4
52	craft	m151016_133600_delete_asset_thumbnails	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	3c496839-d9a8-464e-ab62-9e73fe1ab385
53	craft	m151209_000000_move_logo	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	e61ddc49-c81f-44bf-8314-d0632ace7d5a
54	craft	m151211_000000_rename_fileId_to_assetId	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	8367004e-2c45-4e77-a686-bf663dbea247
55	craft	m151215_000000_rename_asset_permissions	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	f0035714-e290-426f-acca-635ba5a4b9e0
56	craft	m160707_000001_rename_richtext_assetsource_setting	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	e3d4bb27-c92f-4d64-b049-5a15539b12dc
57	craft	m160708_185142_volume_hasUrls_setting	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	df213280-98a2-4e44-83d9-d1d9e5506a75
58	craft	m160714_000000_increase_max_asset_filesize	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	620a518e-deb6-4625-b519-f2c3d39c19b5
59	craft	m160727_194637_column_cleanup	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	58de7b75-8294-4b0e-bf06-199213590cba
60	craft	m160804_110002_userphotos_to_assets	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	aa6b81bf-f6dc-41ff-9dc6-bbc54ed501e3
61	craft	m160807_144858_sites	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	db5a1a1e-26e2-4bb0-b177-8749165f7b63
62	craft	m160829_000000_pending_user_content_cleanup	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	d80327e5-501b-4d7c-8fa8-ff6ae48a5f2f
63	craft	m160830_000000_asset_index_uri_increase	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b1d2728e-9329-4b32-94f7-da1e98f32167
64	craft	m160912_230520_require_entry_type_id	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	fac54f5e-5bb0-4b41-888a-b4f764ca6be3
65	craft	m160913_134730_require_matrix_block_type_id	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	8a068716-cbfe-42a0-adce-4f49ca452261
66	craft	m160920_174553_matrixblocks_owner_site_id_nullable	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	6b6a6268-147f-467d-ae11-729c08eae40f
67	craft	m160920_231045_usergroup_handle_title_unique	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	51655fa3-b319-4b6c-89ee-1f38e9667e7f
68	craft	m160925_113941_route_uri_parts	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	05f45139-33f7-4b7c-90f8-cd7cb0d359c3
69	craft	m161006_205918_schemaVersion_not_null	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	2034e571-7e85-4025-9bdf-ddad1feb9d5f
70	craft	m161007_130653_update_email_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	59255aea-0cf6-4694-92f9-bd6e187fb224
71	craft	m161013_175052_newParentId	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	16a35539-8b53-44a1-bdf1-ec5d0cdc21d7
72	craft	m161021_102916_fix_recent_entries_widgets	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	879358a8-0209-442e-aea8-a2922e090094
73	craft	m161021_182140_rename_get_help_widget	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	459e1d38-48ef-4255-8304-ca22461fc75a
74	craft	m161025_000000_fix_char_columns	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b0cb1deb-ab6a-4a89-ab1f-c36ee590d2ed
75	craft	m161029_124145_email_message_languages	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	3b5f693d-ef86-493b-ad4a-e3dbea042434
76	craft	m161108_000000_new_version_format	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	482bc1ef-9ecc-4bf5-b971-f1508d104ea7
77	craft	m161109_000000_index_shuffle	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	2d2757de-916c-434e-a592-264acce6b5ec
78	craft	m161122_185500_no_craft_app	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	2fcfb8c3-cf4a-4685-9d4e-7912e2df5d25
79	craft	m161125_150752_clear_urlmanager_cache	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	c424f5da-41e5-4144-a106-2e9b169353fb
80	craft	m161220_000000_volumes_hasurl_notnull	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	15f2760b-e387-4d7a-bf74-fc17a9c07d86
81	craft	m170114_161144_udates_permission	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	6ee4f376-49b1-496f-bd27-234761aa91c7
82	craft	m170120_000000_schema_cleanup	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	de864551-8274-472d-bcb6-68d40172f051
83	craft	m170126_000000_assets_focal_point	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	032fd0cc-acac-4a48-8d67-85464612f533
84	craft	m170206_142126_system_name	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b945a163-379e-45ff-8e26-8724b17a0241
85	craft	m170217_044740_category_branch_limits	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	a081bb2c-0c41-4592-9d6f-c917b908bbcd
86	craft	m170217_120224_asset_indexing_columns	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	e6b15ddd-c72e-4a3b-8ff2-4a9e852b2489
87	craft	m170223_224012_plain_text_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	cb12f1cc-ac52-4ab3-96a1-9c9c21d86c04
88	craft	m170227_120814_focal_point_percentage	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	751dd7d4-1450-490c-a70d-4170472c174f
89	craft	m170228_171113_system_messages	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	1bd1ae32-c787-4e91-9cea-fa70c65489a0
90	craft	m170303_140500_asset_field_source_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	c4106002-707d-4ff2-8220-11053f4dd6dd
91	craft	m170306_150500_asset_temporary_uploads	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b6b75cdf-ce9d-42a5-b1c3-5b36406645d7
92	craft	m170523_190652_element_field_layout_ids	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	d4043f67-f814-4dd1-b31f-992fa355b366
93	craft	m170621_195237_format_plugin_handles	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	85cb2b71-3940-4428-989e-b23fb7be9949
94	craft	m170630_161027_deprecation_line_nullable	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	aaa932dd-c862-4d06-b6bb-59ae078fd04b
95	craft	m170630_161028_deprecation_changes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	274494d7-ef76-4ee8-8360-c18e278aebcc
96	craft	m170703_181539_plugins_table_tweaks	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	f8ba3140-5f62-4b7f-988d-38a6c2481109
97	craft	m170704_134916_sites_tables	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	89dd51d6-bd0b-42ea-9888-77ac9aaf198b
98	craft	m170706_183216_rename_sequences	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	effc5a80-c3a7-48ed-95c6-7f35c6a53fff
99	craft	m170707_094758_delete_compiled_traits	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	62465ce4-10b5-4869-a46d-ae586dc21611
100	craft	m170731_190138_drop_asset_packagist	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	84d32dea-c1d5-4c30-97c7-830179346cfd
101	craft	m170810_201318_create_queue_table	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	96782936-6b11-40a6-b287-eb059b931557
102	craft	m170903_192801_longblob_for_queue_jobs	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	bbca1358-aec3-4424-81e3-8d161d00c77e
103	craft	m170914_204621_asset_cache_shuffle	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	a751c70c-ae67-45ec-b956-9f0be98f825b
104	craft	m171011_214115_site_groups	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	6c430d7d-1b8e-43c2-8b5e-23bb5e33010f
105	craft	m171012_151440_primary_site	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	bce9a671-4271-4246-94ea-dbde697d3f83
106	craft	m171013_142500_transform_interlace	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b39fe121-e318-44b9-91a2-1642db96e3ce
107	craft	m171016_092553_drop_position_select	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	c1ae0aca-3374-4535-af79-44ac23405de5
108	craft	m171016_221244_less_strict_translation_method	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	425af5be-d890-40c9-a145-cf83e7fef445
109	craft	m171107_000000_assign_group_permissions	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	162e32a5-3d3c-4c1b-b8cb-b411698226df
110	craft	m171117_000001_templatecache_index_tune	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	305fb06e-0edb-460f-ac02-204e4e746f64
111	craft	m171126_105927_disabled_plugins	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	1568d1a9-c3c3-4305-8937-06a97aa04585
112	craft	m171130_214407_craftidtokens_table	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	41212c47-de94-4332-b5c3-dc93cdc760ec
113	craft	m171202_004225_update_email_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	5af575ee-c978-4fc1-9d48-ae0de5ef0183
227	craft	m210613_184103_announcements	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	93e5847c-68bb-494d-909b-f33d999d6b21
114	craft	m171204_000001_templatecache_index_tune_deux	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	f6b22d78-57b3-4cb0-a802-9e571a8cab34
115	craft	m171205_130908_remove_craftidtokens_refreshtoken_column	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	23873244-6ee5-46fa-b6f6-47cf0b56955e
116	craft	m171218_143135_longtext_query_column	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	ef7ce2e5-a565-4654-8c68-0e9d511ceb37
117	craft	m171231_055546_environment_variables_to_aliases	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	32ae2995-623c-4998-8180-2c127568a9e9
118	craft	m180113_153740_drop_users_archived_column	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	0a7e853c-d71e-4b25-9d4e-519654af2135
119	craft	m180122_213433_propagate_entries_setting	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	5e432665-af1d-441d-badd-1c5ca018f406
120	craft	m180124_230459_fix_propagate_entries_values	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	1a8e3901-98c5-4985-9e80-d6d88c273b2d
121	craft	m180128_235202_set_tag_slugs	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	9347f114-fcf8-4665-a358-c1cd6c80dbb6
122	craft	m180202_185551_fix_focal_points	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	c39b68f4-8f27-4bce-a5ad-ee8bfd3761f3
123	craft	m180217_172123_tiny_ints	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	46275de8-da28-4fcb-80b9-0d5f7c7c9326
124	craft	m180321_233505_small_ints	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	322058e1-56e0-4a1f-927e-07f383a3b490
125	craft	m180404_182320_edition_changes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	36edc5c3-66d7-477f-8f45-864a60814d04
126	craft	m180411_102218_fix_db_routes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	270e3baa-8805-4d4a-ab9d-80a849b0c2b8
127	craft	m180416_205628_resourcepaths_table	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	fcb4daf9-72a1-4bf4-b34f-4c3b86f155a4
128	craft	m180418_205713_widget_cleanup	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	bed958a9-f00c-46e2-b6b0-cbd39f9ed381
129	craft	m180425_203349_searchable_fields	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	52b0cb01-b2ca-41fa-b531-6d8210d784fb
130	craft	m180516_153000_uids_in_field_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	a6239296-03b4-4892-889c-36d97483af25
131	craft	m180517_173000_user_photo_volume_to_uid	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	70e69b7b-dce5-4ca8-88a5-fc2437f33e5e
132	craft	m180518_173000_permissions_to_uid	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	dc4fe01e-cad6-48d5-9e87-9357d9f53d16
133	craft	m180520_173000_matrix_context_to_uids	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	e72bb88e-53b0-42c2-bca9-282ed684a30e
134	craft	m180521_172900_project_config_table	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	0e6ee266-d796-4c0c-b167-c00f92b87539
135	craft	m180521_173000_initial_yml_and_snapshot	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	e5621333-bee9-463b-84a5-36cee3c030b7
136	craft	m180731_162030_soft_delete_sites	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	4ca6f2d0-898f-46b9-a484-fe8794a5331a
137	craft	m180810_214427_soft_delete_field_layouts	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	9d73d18d-0986-4c5c-9ae4-bc02eb7ad469
138	craft	m180810_214439_soft_delete_elements	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	25a8ef44-eb3f-46a6-a2f4-b92316e6edb5
139	craft	m180824_193422_case_sensitivity_fixes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	7477f483-86c4-4482-bc7c-93dd5cfe5c5d
140	craft	m180901_151639_fix_matrixcontent_tables	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	90710e9a-7d50-4565-973d-9ce5de8789f2
141	craft	m180904_112109_permission_changes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b097704d-e005-4627-a77b-efa7570f06cd
142	craft	m180910_142030_soft_delete_sitegroups	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	8a1edb5e-2191-475b-9df7-4620715791f1
143	craft	m181011_160000_soft_delete_asset_support	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	8e01c28e-7b2b-420c-baba-7e67b4f56899
144	craft	m181016_183648_set_default_user_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	7a511c1e-dec3-49ae-802f-36cb8c652852
145	craft	m181017_225222_system_config_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	2c1729dd-937d-43de-af75-48a32140d7b8
146	craft	m181018_222343_drop_userpermissions_from_config	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	ba0ceddc-1fe5-420a-94c5-2c48610bb43d
147	craft	m181029_130000_add_transforms_routes_to_config	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	692e46c3-148c-4695-a6e8-990d5fa73d11
148	craft	m181112_203955_sequences_table	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	70026916-4f76-482f-8bee-d5092d5107aa
149	craft	m181121_001712_cleanup_field_configs	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	097b3ec2-b0f7-4649-9767-a04f46390ab4
150	craft	m181128_193942_fix_project_config	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	7d7296be-b99f-4e88-85a5-25951bee3778
151	craft	m181130_143040_fix_schema_version	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	286a750e-0e23-4687-9562-1683e5c718de
152	craft	m181211_143040_fix_entry_type_uids	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	8989e005-52b0-454c-a5da-380377a80a98
153	craft	m181217_153000_fix_structure_uids	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	80873659-5459-4bd2-9e30-ee954ac7d25d
154	craft	m190104_152725_store_licensed_plugin_editions	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b544e5ab-e04f-4b38-9ed4-10047e630268
155	craft	m190108_110000_cleanup_project_config	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b79d163b-ed19-497d-a335-4377bdf31d20
156	craft	m190108_113000_asset_field_setting_change	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	9204e796-b2f4-43f3-be04-9f30a1e1e21b
157	craft	m190109_172845_fix_colspan	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	77771799-f0ff-4808-bbb9-bf3d55934937
158	craft	m190110_150000_prune_nonexisting_sites	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	dbb43160-4ac9-4d2e-a1fc-9f2134ced98c
159	craft	m190110_214819_soft_delete_volumes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	2d65f6d6-ac28-44ce-a16b-bf403b914340
160	craft	m190112_124737_fix_user_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	6ed4009f-6456-4460-84f3-0278052429b6
161	craft	m190112_131225_fix_field_layouts	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	10577cc8-c919-4104-85e7-8ca4fa72f60b
162	craft	m190112_201010_more_soft_deletes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	8b5c22c7-4d8a-4163-9c27-90d44f08e6e5
163	craft	m190114_143000_more_asset_field_setting_changes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	3c67b736-ff19-4ceb-ba6a-c63cda285a7e
164	craft	m190121_120000_rich_text_config_setting	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	406db77d-95bc-4f09-897c-63b6ec27a67c
165	craft	m190125_191628_fix_email_transport_password	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	4e06d544-8225-4d67-b6a4-5e3a97d14d69
166	craft	m190128_181422_cleanup_volume_folders	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	7cd6c763-e0ff-4f3d-8148-7d137611e257
167	craft	m190205_140000_fix_asset_soft_delete_index	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	afb2634f-abca-4fba-88b5-fe852fb029d2
168	craft	m190218_143000_element_index_settings_uid	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b61948ac-4e5f-49c5-b3e9-d65ae10ab637
169	craft	m190312_152740_element_revisions	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	83d0a208-f340-458a-9884-baa9f18909f0
170	craft	m190327_235137_propagation_method	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	6c9a4d3a-73c4-4fb2-a1fd-339cf2116fb2
171	craft	m190401_223843_drop_old_indexes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	e719cdc2-8462-45c0-be66-bd836ae73f67
172	craft	m190416_014525_drop_unique_global_indexes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	42eb0081-1dc6-40f0-95f4-55562d501204
173	craft	m190417_085010_add_image_editor_permissions	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	bc5b4274-b326-4723-8568-79c7825400c5
174	craft	m190502_122019_store_default_user_group_uid	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	8cb03850-bec1-4150-adfe-b16cedca828f
175	craft	m190504_150349_preview_targets	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	25576b2c-5c9c-4bcd-b8b9-56b9f580e876
176	craft	m190516_184711_job_progress_label	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	f2a6555e-4b7a-49dd-93d0-cdf21fa3d9df
177	craft	m190523_190303_optional_revision_creators	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	7597008c-24a2-4f05-840d-c17f85d4cf96
178	craft	m190529_204501_fix_duplicate_uids	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	6bf243be-0788-4a8c-a402-5d82e4e5a068
179	craft	m190605_223807_unsaved_drafts	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	8cb57d16-48b6-4787-8867-092ec4016d13
180	craft	m190607_230042_entry_revision_error_tables	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	c764463d-f025-4e48-ae00-f91f27e05943
181	craft	m190608_033429_drop_elements_uid_idx	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	3c155a2a-6bcb-4118-9cb4-3f830104cf5b
182	craft	m190617_164400_add_gqlschemas_table	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	ea96dbba-30f5-49ac-b279-9ca4bd834610
183	craft	m190624_234204_matrix_propagation_method	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	90b92c3e-d054-4ee6-8506-ca82431028bb
184	craft	m190711_153020_drop_snapshots	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	cce11266-ed72-4a58-95a5-d0e7c23ce97b
185	craft	m190712_195914_no_draft_revisions	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	48477458-df0c-4ed0-b2fc-56218ffb9727
186	craft	m190723_140314_fix_preview_targets_column	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	d21a7dc2-6a00-4caf-9e6b-22ca80315f86
187	craft	m190820_003519_flush_compiled_templates	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	f2f57d54-1b71-447e-b591-d493fe3bfd52
188	craft	m190823_020339_optional_draft_creators	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	4cae99f4-2805-44ec-9750-a051ff974547
189	craft	m190913_152146_update_preview_targets	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	1b8025c8-4016-4a52-8a32-6bae0a35a03a
190	craft	m191107_122000_add_gql_project_config_support	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	40c7d688-e1b6-4da8-b504-ffa035446512
191	craft	m191204_085100_pack_savable_component_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	c05c1451-fbc5-4790-b7d7-6416c9185be5
192	craft	m191206_001148_change_tracking	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	692970f9-ccf6-44af-9c5c-04f494dbadc8
193	craft	m191216_191635_asset_upload_tracking	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b838e986-2a5d-43f1-9f08-cf3c16770087
194	craft	m191222_002848_peer_asset_permissions	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	d4f5fdbe-006e-4d2b-8e36-cc21db48b113
195	craft	m200127_172522_queue_channels	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	3fc695a0-92d4-4903-942f-2ca6fb593a5e
196	craft	m200211_175048_truncate_element_query_cache	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	1d76e8dc-6fc0-465c-8b4c-76a78d75893d
197	craft	m200213_172522_new_elements_index	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	e73ecaf5-a68b-4566-9be1-00885ccfda2b
198	craft	m200228_195211_long_deprecation_messages	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	557f051d-06fb-434e-ac16-25be5c26f65c
199	craft	m200306_054652_disabled_sites	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	0aa8b114-baf0-4149-ae34-91b81194d405
200	craft	m200522_191453_clear_template_caches	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	60740b2e-12ac-46ed-8640-d3ba7496eb28
201	craft	m200606_231117_migration_tracks	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	3e746785-324f-4882-9d35-f8b196909274
202	craft	m200619_215137_title_translation_method	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	d99a1d93-7ab9-4df4-8f5d-ab285176a0c3
203	craft	m200620_005028_user_group_descriptions	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	0d2e441f-ad58-44b9-bccb-7e3f7107bfba
204	craft	m200620_230205_field_layout_changes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	67cd9313-c45f-487e-afa2-a4cf70ce8903
205	craft	m200625_131100_move_entrytypes_to_top_project_config	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b996b6b3-6654-4740-a620-692f78ed6ea4
206	craft	m200629_112700_remove_project_config_legacy_files	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	38a34cc5-0964-44e3-bb92-6e594a8c7919
207	craft	m200630_183000_drop_configmap	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	51d0604e-73dd-4b12-bd03-80fcc2dac33b
208	craft	m200715_113400_transform_index_error_flag	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	1ffd64b4-6e0e-4a05-957f-488e0580b8f2
209	craft	m200716_110900_replace_file_asset_permissions	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	9a6b79b5-f5bf-4b36-b72b-ae0bb785c0e4
210	craft	m200716_153800_public_token_settings_in_project_config	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	3e846827-55b6-4d5e-9421-e35b7c51db02
211	craft	m200720_175543_drop_unique_constraints	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	3c16cb40-0f90-4862-91f4-8d593640050c
212	craft	m200825_051217_project_config_version	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	81464328-f2e5-4ec6-b770-c4c7e9d7e052
213	craft	m201116_190500_asset_title_translation_method	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	45ebc1bd-62e2-4629-af31-9d8a9cd5f6cb
214	craft	m201124_003555_plugin_trials	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	bdbd7b7b-7962-4ee8-8234-2a278400168a
215	craft	m210209_135503_soft_delete_field_groups	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	5f51066c-c35c-4113-befa-a06b82c873b0
216	craft	m210212_223539_delete_invalid_drafts	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	62539068-2974-4a8a-8605-c9481726a291
217	craft	m210214_202731_track_saved_drafts	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	9f111283-0612-43c7-8b10-0527cbff51ae
218	craft	m210223_150900_add_new_element_gql_schema_components	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b1c2910f-e166-49cc-a63f-9493eb4e34c0
219	craft	m210302_212318_canonical_elements	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	e8aa4e01-3d43-403d-9ab2-0dd10d4ed0ec
220	craft	m210326_132000_invalidate_projectconfig_cache	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	391e9c2d-45d6-48c6-88dc-d6cfd7950e78
221	craft	m210329_214847_field_column_suffixes	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	5901351a-2ba8-4cc4-bafc-bbd319cdf1df
222	craft	m210331_220322_null_author	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	cdb3394c-3bb5-40b4-922b-9f0d26ff3cf3
223	craft	m210405_231315_provisional_drafts	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	02edff77-f66f-419c-a487-9fb4026a6366
224	craft	m210602_111300_project_config_names_in_config	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	d02b94bb-bf45-4c0f-b106-5f8be8793f5d
225	craft	m210611_233510_default_placement_settings	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	df483749-3ea4-43fb-9dfd-20a28eeeb793
226	craft	m210613_145522_sortable_global_sets	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	102d6e6d-f233-43b2-ae4f-fbc0340d70a0
228	craft	m210829_000000_element_index_tweak	2022-04-15 04:01:35	2022-04-15 04:01:35	2022-04-15 04:01:35	b3063a06-1467-4e04-9e33-5e10618cf650
\.


--
-- Data for Name: neoblocks; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.neoblocks (id, "ownerId", "ownerSiteId", "fieldId", "typeId", "sortOrder", "deletedWithOwner", "dateCreated", "dateUpdated", uid) FROM stdin;
36	35	\N	141	35	1	\N	2022-04-17 16:43:41	2022-04-17 16:43:41	dcec4c63-1d97-4275-a789-8942f08f6da8
42	14	\N	141	35	1	\N	2022-04-17 16:43:53	2022-04-17 16:43:53	ab526890-1b6f-44a5-9a8c-2a976f95d049
44	43	\N	141	35	1	\N	2022-04-17 16:43:54	2022-04-17 16:43:54	e1fa8924-74d5-461e-8196-6b5f668c7e54
47	5	\N	141	35	1	\N	2022-04-17 16:57:21	2022-04-17 16:57:21	f9e71989-e9dd-4b29-9e49-e7e2bafcd923
34	5	\N	141	35	1	f	2022-04-17 16:43:41	2022-04-17 16:43:41	5073e6d3-e4c0-4265-8914-570f6fda2f0f
49	48	\N	141	35	1	\N	2022-04-17 16:57:21	2022-04-17 16:57:21	6d56026a-552a-4f21-a882-a3fa6d13236a
\.


--
-- Data for Name: neoblockstructures; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.neoblockstructures (id, "structureId", "ownerId", "ownerSiteId", "fieldId", "dateCreated", "dateUpdated", uid) FROM stdin;
13	17	35	1	141	2022-04-17 16:43:42	2022-04-17 16:43:42	950a3fe9-6f90-468e-8ba0-23a319c57b91
14	17	35	2	141	2022-04-17 16:43:42	2022-04-17 16:43:42	0cd99a07-0f34-473f-94dc-e438334eac7c
25	23	14	1	141	2022-04-17 16:43:54	2022-04-17 16:43:54	96c4ee21-6007-4745-bc15-235046752f98
26	23	14	2	141	2022-04-17 16:43:54	2022-04-17 16:43:54	3aa6614a-e354-4ac9-a267-04a607613994
29	26	43	1	141	2022-04-17 16:44:10	2022-04-17 16:44:10	cc09c804-5eb5-4e63-b065-44ba9d701f7b
30	26	43	2	141	2022-04-17 16:44:10	2022-04-17 16:44:10	d9820eba-eda2-46c8-9a6e-36edf4a89858
33	28	5	2	141	2022-04-17 16:57:21	2022-04-17 16:57:21	7406f199-5aff-4953-8e48-e1daa53bca31
34	28	5	1	141	2022-04-17 16:57:21	2022-04-17 16:57:21	6997cb7a-1cb5-494b-bc64-6ba08fa814d7
37	31	48	2	141	2022-04-17 16:57:22	2022-04-17 16:57:22	61ded1ea-1394-48a5-8e8d-f624b0281fd3
38	31	48	1	141	2022-04-17 16:57:22	2022-04-17 16:57:22	2754d664-3609-4674-98bc-77ba96df5081
\.


--
-- Data for Name: neoblocktypegroups; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.neoblocktypegroups (id, "fieldId", name, "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: neoblocktypes; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.neoblocktypes (id, "fieldId", "fieldLayoutId", name, handle, "maxBlocks", "maxSiblingBlocks", "maxChildBlocks", "childBlocks", "topLevel", "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
20	54	51	Link	link	0	0	0		t	1	2022-04-15 04:01:18	2022-04-15 04:01:18	e24265aa-f05d-42eb-8d44-1ead0005aec1
35	141	89	Text	text	0	0	0		t	1	2022-04-17 16:41:46	2022-04-17 16:41:46	e217cce2-4f3d-44f9-90c5-42149175876a
\.


--
-- Data for Name: plugins; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.plugins (id, handle, version, "schemaVersion", "licenseKeyStatus", "licensedEdition", "installDate", "dateCreated", "dateUpdated", uid) FROM stdin;
5	graphql-authentication	1.12.2	1.2.0	trial	\N	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-15 04:09:14	8e64b593-a79a-4dd4-84ca-8d61dd530c09
1	asset-metadata	3.0.0	3.0.0	unknown	\N	2022-04-15 04:01:03	2022-04-15 04:01:03	2022-04-17 17:04:48	55e09342-f999-4875-8ede-640a7829382f
6	neo	2.8.15.1	2.8.15	valid	standard	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-17 17:04:48	a8b9f665-b513-4e70-a024-1b23f34e5229
8	redactor	2.8.5	2.3.0	unknown	\N	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-17 17:04:48	0b122880-9ffd-48a4-848e-f2404bcf86f8
9	super-table	2.7.1	2.2.1	unknown	\N	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-17 17:04:48	cc0d43b4-e1f8-4ab8-8765-401d09f5e522
10	typedlinkfield	2.0.0-rc.1	2.0.0	unknown	\N	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-17 17:04:48	46a46d4e-3d78-4382-8758-9d33114c63f1
11	universal-dam-integrator	dev-main	1.0.0	unknown	\N	2022-04-15 04:01:04	2022-04-15 04:01:04	2022-04-17 17:04:48	226a3ab5-b528-421f-b64f-011c56016b67
\.


--
-- Data for Name: projectconfig; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.projectconfig (path, value) FROM stdin;
siteGroups.1a35bfab-6a39-4c03-b273-2d5e3151c335.name	"Rubin Telescope Education and Public Outreach"
sites.547128fa-4529-4483-9968-66425996b69f.baseUrl	"@webBaseUrl"
sites.547128fa-4529-4483-9968-66425996b69f.enabled	true
sites.547128fa-4529-4483-9968-66425996b69f.handle	"default"
sites.547128fa-4529-4483-9968-66425996b69f.hasUrls	true
sites.547128fa-4529-4483-9968-66425996b69f.language	"en-US"
sites.547128fa-4529-4483-9968-66425996b69f.name	"EN"
sites.547128fa-4529-4483-9968-66425996b69f.primary	true
sites.547128fa-4529-4483-9968-66425996b69f.siteGroup	"1a35bfab-6a39-4c03-b273-2d5e3151c335"
sites.547128fa-4529-4483-9968-66425996b69f.sortOrder	1
sites.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.baseUrl	"@webBaseUrl"
sites.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.enabled	true
sites.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.handle	"es"
sites.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.hasUrls	true
sites.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.language	"es"
sites.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.name	"ES"
sites.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.primary	false
sites.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.siteGroup	"1a35bfab-6a39-4c03-b273-2d5e3151c335"
sites.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.sortOrder	2
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.childBlocks	""
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.field	"4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4"
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.fieldLayouts.2dd1cc59-93d5-4a43-914c-395016509e05.tabs.0.elements.0.fieldUid	"7db205b7-a548-42f1-8c26-416ec51cf3fa"
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.fieldLayouts.2dd1cc59-93d5-4a43-914c-395016509e05.tabs.0.elements.0.instructions	null
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.fieldLayouts.2dd1cc59-93d5-4a43-914c-395016509e05.tabs.0.elements.0.label	null
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.fieldLayouts.2dd1cc59-93d5-4a43-914c-395016509e05.tabs.0.elements.0.required	false
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.fieldLayouts.2dd1cc59-93d5-4a43-914c-395016509e05.tabs.0.elements.0.tip	null
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.fieldLayouts.2dd1cc59-93d5-4a43-914c-395016509e05.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.fieldLayouts.2dd1cc59-93d5-4a43-914c-395016509e05.tabs.0.elements.0.warning	null
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.fieldLayouts.2dd1cc59-93d5-4a43-914c-395016509e05.tabs.0.elements.0.width	100
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.fieldLayouts.2dd1cc59-93d5-4a43-914c-395016509e05.tabs.0.name	"Tab 1"
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.fieldLayouts.2dd1cc59-93d5-4a43-914c-395016509e05.tabs.0.sortOrder	1
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.handle	"text"
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.maxBlocks	0
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.maxChildBlocks	0
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.maxSiblingBlocks	0
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.name	"Text"
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.sortOrder	1
neoBlockTypes.e217cce2-4f3d-44f9-90c5-42149175876a.topLevel	true
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.columnSuffix	null
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.contentColumnType	"string"
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.fieldGroup	"99f4a28a-48c3-49ca-bb4a-7acbb49fde30"
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.handle	"contentBlocks"
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.instructions	""
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.name	"Content Blocks"
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.searchable	true
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.settings.maxBlocks	""
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.settings.maxTopBlocks	""
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.settings.minBlocks	""
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.settings.propagationMethod	"all"
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.settings.wasModified	false
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.translationKeyFormat	null
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.translationMethod	"site"
fields.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4.type	"benf\\\\neo\\\\Field"
meta.__names__.4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4	"Content Blocks"
meta.__names__.e217cce2-4f3d-44f9-90c5-42149175876a	"Text"
plugins.neo.edition	"standard"
plugins.neo.enabled	true
plugins.neo.licenseKey	"3ZVYZYMFBDVZNFFTO4ZHHX88"
plugins.neo.schemaVersion	"2.8.15"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.isPublic	true
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.name	"Public Schema"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.0	"sections.7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.1	"entrytypes.942c9e60-2760-42ed-b03b-9e5eb133751b:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.2	"entrytypes.34f61e7c-358c-48b8-8439-42bc05ed255c:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.3	"entrytypes.fa15bb4c-adb8-4393-82c3-15c2b830867c:read"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.defaultPlacement	"end"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.autocapitalize	true
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.translationMethod	"site"
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.type	"craft\\\\fields\\\\PlainText"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.defaultPlacement	"end"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.enableVersioning	true
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.handle	"pages"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.name	"Pages"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.previewTargets.0.__assoc__.0.0	"label"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.previewTargets.0.__assoc__.0.1	"Primary entry page"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.previewTargets.0.__assoc__.1.0	"urlFormat"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.previewTargets.0.__assoc__.1.1	"@previewUrlFormat"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.previewTargets.0.__assoc__.2.0	"refresh"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.previewTargets.0.__assoc__.2.1	"1"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.propagationMethod	"all"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.enabledByDefault	true
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.hasUrls	true
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.template	null
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.uriFormat	"{parent ? parent.uri : 'es'}/{slug}"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.siteSettings.547128fa-4529-4483-9968-66425996b69f.enabledByDefault	true
plugins.universal-dam-integrator.edition	"standard"
plugins.universal-dam-integrator.enabled	true
plugins.universal-dam-integrator.schemaVersion	"1.0.0"
plugins.universal-dam-integrator.settings.appId	"$CANTO_APP_ID"
plugins.universal-dam-integrator.settings.authEndpoint	"$CANTO_AUTH_ENDPOINT"
plugins.universal-dam-integrator.settings.damVolume	"cantoDam"
plugins.universal-dam-integrator.settings.retrieveAssetMetadataEndpoint	"$CANTO_ASSET_ENDPOINT"
plugins.universal-dam-integrator.settings.secretKey	"$CANTO_SECRET_KEY"
plugins.asset-metadata.edition	"standard"
plugins.asset-metadata.enabled	true
plugins.asset-metadata.schemaVersion	"3.0.0"
meta.__names__.0f48338c-1c16-4600-9230-68bacb7c21e3	"Text"
meta.__names__.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2	"Sort Options"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.autocapitalize	true
meta.__names__.95b97a67-eccb-4910-b0e8-77f5860058b4	"Link"
meta.__names__.99f4a28a-48c3-49ca-bb4a-7acbb49fde30	"Pages"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.autocomplete	false
meta.__names__.380c1cbe-884e-421b-9e31-1f0dfc81e15f	"Cell Width"
meta.__names__.522bc2d7-fcc3-4817-a986-5c860e53351c	"Internal Entry"
meta.__names__.0928ff1a-513d-41e0-acc1-606d93988618	"Search Filters"
meta.__names__.966a6b65-ca53-48a8-89dc-74983cd624ef	"Title"
meta.__names__.991c5031-3b97-45d8-8829-c8e0c79537a9	"Row Title"
meta.__names__.2755abe1-7dd5-428c-a6bb-30d2bd59a362	"Link"
meta.__names__.4294fb85-8029-437c-a2e5-76bcd1a79ef1	"Asset"
meta.__names__.5075e912-4aa1-4ce4-96b2-8868358b51e3	"Header"
meta.__names__.5548b745-642b-4b15-8f17-4ce7457689a8	"Header"
meta.__names__.7754bae8-c6eb-4fbe-882b-236621e35f2d	"Canto DAM"
meta.__names__.7970cd65-7a96-418a-8581-d6df4e039e6d	"Plain Text"
meta.__names__.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6	"Homepage"
meta.__names__.547128fa-4529-4483-9968-66425996b69f	"EN"
meta.__names__.9940892d-32f4-4399-acac-ab559ce1c82b	"Common"
meta.__names__.74319755-d24f-4991-a84a-0c1c031cb21e	"Asset Link"
meta.__names__.a5b8e4fe-87da-48fc-8156-2a2a973b29e5	"URL"
meta.__names__.a5bb0742-012f-4683-a471-874944bf3280	"Image"
meta.__names__.a61323db-26ac-4898-873c-a6c6b66fcb86	"Header"
meta.__names__.acbea415-ee80-409c-90e2-90ac546820a6	"Description"
meta.__names__.af1b8590-3d8a-4eb1-90e1-60e3d7407a1a	"Link text"
meta.__names__.b882fa04-8a43-4715-a55d-b3344db891bf	"Table Title"
meta.__names__.c9e9db12-fcdb-4b82-a8c8-eef21b3543af	"Cell Background"
meta.__names__.c44a71b5-f4c8-4209-8433-9878aece9aa5	"Text"
meta.__names__.c4060079-e438-4c63-8b06-77cdea857fd9	"Text"
meta.__names__.cb6a7cee-4f9e-4191-8c6d-33ccdd921fec	"Text"
meta.__names__.cbf3fbbb-2f2b-4568-a228-f8c63ff4601c	"Row Color"
meta.__names__.cc694df6-ebfe-4e0c-b4fe-713761f100df	"Text"
meta.__names__.cee5c2f8-2801-42c2-a56c-4fe40c85b6f3	"Site Information"
meta.__names__.d019727b-a6d5-43d9-a688-f10df985a87e	"Link"
meta.__names__.d889713c-632a-4323-bb10-4b2bc53545ad	"Asset"
meta.__names__.ddf8dce2-4fa1-43d1-b306-b34d9d97a91b	"Content"
meta.__names__.dff2a767-333e-4c9d-880c-143e1ca2aaa3	"Row Content"
meta.__names__.e338eebb-6488-4f58-a07e-db43f28ff56b	"Image"
meta.__names__.e24265aa-f05d-42eb-8d44-1ead0005aec1	"Link"
meta.__names__.e7913600-c914-4ab1-a9bb-abd2bdcbfb94	"Custom Name"
meta.__names__.e9726196-f241-49d4-9b6b-9e8d419e6669	"Link Text"
meta.__names__.f1b8c943-bc12-4001-9e2a-d531379f1aaf	"Pages"
meta.__names__.f444667c-6ea1-4e0f-89b2-35b059e27bfc	"Link"
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.settings.multiline	""
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.settings.placeholder	null
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.settings.uiMode	"normal"
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.translationKeyFormat	null
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.translationMethod	"none"
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.type	"craft\\\\fields\\\\PlainText"
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.columnSuffix	null
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.contentColumnType	"string"
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.fieldGroup	"9940892d-32f4-4399-acac-ab559ce1c82b"
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.handle	"links"
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.instructions	""
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.name	"Links"
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.searchable	true
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.settings.maxBlocks	""
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.settings.maxTopBlocks	""
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.settings.minBlocks	""
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.settings.propagationMethod	"all"
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.settings.wasModified	false
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.translationKeyFormat	null
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.translationMethod	"site"
fields.4c977b75-9ee1-4cdb-9d2a-203639f4af84.type	"benf\\\\neo\\\\Field"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.4	"sections.4305f2e2-40b8-47b2-8b62-135b8b57be7f:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.5	"entrytypes.6acd6e24-26c9-4e55-a35b-c29cd36a7a3c:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.6	"sections.3a8b9653-cdd3-46ce-84b2-d73b5dc4de63:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.7	"entrytypes.7187131b-681b-45de-a1ea-87a8d070c05a:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.8	"sections.4ffeb743-f02d-42af-8656-a6f9c1363e79:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.9	"entrytypes.bbf936fb-1787-437b-8ebd-a6e79409896e:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.10	"sections.3e10dcca-4dd1-4578-8add-708cd9740881:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.11	"entrytypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.12	"sections.546e0c6d-dd32-4997-8487-cc4c2fcc9480:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.13	"entrytypes.0b946ecb-12e3-4999-9d02-fc902cb66fdf:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.14	"sections.59fb5a9e-74f4-4618-adba-601791f42c92:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.15	"entrytypes.39558c70-8baf-4748-9f12-49e78a04eed5:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.16	"sections.11be7603-f576-4af8-93a6-e285e4ff42c4:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.17	"entrytypes.4729ad5e-485e-4f98-995d-79fa5254cd42:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.18	"sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.19	"entrytypes.23eda090-7e8e-401d-ab49-ee4becc34935:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.20	"entrytypes.9d045432-a0fb-4fcd-8bca-3bc93b1f7056:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.21	"entrytypes.26ca2777-e4c8-41b4-ac93-aa28d09117dd:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.22	"sections.04a48967-eac4-449f-b164-c8ecbb7036d6:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.23	"entrytypes.229f2975-93d3-4c6a-9996-dfa1de3004ef:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.24	"sections.fb3283a6-7286-4b2b-a77a-010783dcee7e:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.25	"entrytypes.a77c49d2-2441-459e-bfea-63e571d25a12:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.26	"sections.78410791-6edc-46c9-a17b-4358dcd545ec:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.27	"entrytypes.7d60273b-66b0-4843-a42c-4b4387185a15:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.28	"sections.89cab4ff-f556-4b7e-bae9-8db545ce38dd:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.29	"entrytypes.573c9705-aca2-4419-b039-c7071536a2ce:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.30	"sections.1ee32484-2cca-457e-ac23-b3cb13e652d3:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.31	"entrytypes.534d275e-b6e9-4064-9965-07e804e0fcc1:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.32	"volumes.8e9ec71e-2cf0-4f6a-b856-8976de0ce100:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.33	"volumes.cd6f2275-4f9b-4ba4-aa4c-7c7468366172:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.34	"volumes.f52f3e9c-434e-43b5-89eb-a5776e6bc4a6:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.35	"volumes.18a75c63-648f-4145-9cc3-386e7c8a0106:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.36	"volumes.c3d1c243-1703-4117-abc7-88487a1f8f24:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.37	"volumes.d41cc960-99a4-41a8-a7a6-7891a22e4a93:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.38	"volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.39	"globalsets.b8393df9-fb81-4d70-9ccb-6d030c818580:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.40	"globalsets.994d5664-f056-4969-b2cc-c62660f069af:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.41	"globalsets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.42	"globalsets.1a2ba41a-3949-4982-9cb3-f8b03863bcfd:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.43	"usergroups.everyone:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.44	"usergroups.01b89d98-9aa4-46d5-a9a0-60a0c07fd815:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.45	"usergroups.58efa872-9485-42e3-a1e3-a5435def5392:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.46	"usergroups.e0be58f6-fc1b-4a02-816c-0a37b0fcd602:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.47	"categorygroups.3a3af2ab-b037-455a-ba95-bc3be89efdb0:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.48	"categorygroups.4ead9327-61fc-4b46-810c-5f490c2c45ad:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.49	"categorygroups.cc8c47f0-3dec-44db-a47f-7ca6c984864a:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.50	"categorygroups.df7f4ec2-58b2-4c3a-afff-b07f4764fa4b:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.51	"categorygroups.7cb3bc06-c4c4-4017-8c0c-fa6aad7cbd8e:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.52	"categorygroups.0928ff1a-513d-41e0-acc1-606d93988618:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.53	"categorygroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.54	"categorygroups.aa60fd40-45d4-48bb-8b81-8ec736456687:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.55	"taggroups.c30bad12-1372-49fe-ab6c-a9c33b2860bb:read"
graphql.schemas.4fe339ec-7579-46f4-a362-df6ee8de4b3c.scope.56	"taggroups.0d02fdfb-053c-4d46-a5f8-0abf2542a5d2:read"
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.autocapitalize	true
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.autocomplete	false
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.autocorrect	true
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.class	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.disabled	false
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.id	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.instructions	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.label	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.max	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.min	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.name	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.orientation	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.placeholder	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.readonly	false
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.requirable	false
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.size	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.step	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.tip	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.title	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\AssetTitleField"
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.warning	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.elements.0.width	100
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.name	"Content"
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.fieldLayouts.20979f8e-10d5-4ac3-9946-bb661cd56a3d.tabs.0.sortOrder	1
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.handle	"cantoDam"
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.hasUrls	true
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.name	"Canto DAM"
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.settings.quickTest	"eric"
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.sortOrder	9
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.titleTranslationKeyFormat	null
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.titleTranslationMethod	"site"
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.type	"rosas\\\\dam\\\\volumes\\\\DAMVolume"
volumes.7754bae8-c6eb-4fbe-882b-236621e35f2d.url	"$CANTO_ASSET_BASEURL"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.defaultPlacement	"end"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.enableVersioning	true
sections.3e10dcca-4dd1-4578-8add-708cd9740881.handle	"homepage"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.name	"Homepage"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.previewTargets.0.__assoc__.0.0	"label"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.previewTargets.0.__assoc__.0.1	"Primary entry page"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.previewTargets.0.__assoc__.1.0	"urlFormat"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.previewTargets.0.__assoc__.1.1	"@previewUrlFormat"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.previewTargets.0.__assoc__.2.0	"refresh"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.previewTargets.0.__assoc__.2.1	"1"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.propagationMethod	"all"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.enabledByDefault	true
sections.3e10dcca-4dd1-4578-8add-708cd9740881.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.hasUrls	true
sections.3e10dcca-4dd1-4578-8add-708cd9740881.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.template	null
sections.3e10dcca-4dd1-4578-8add-708cd9740881.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.uriFormat	"es"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.siteSettings.547128fa-4529-4483-9968-66425996b69f.enabledByDefault	true
sections.3e10dcca-4dd1-4578-8add-708cd9740881.siteSettings.547128fa-4529-4483-9968-66425996b69f.hasUrls	true
sections.3e10dcca-4dd1-4578-8add-708cd9740881.siteSettings.547128fa-4529-4483-9968-66425996b69f.template	null
sections.3e10dcca-4dd1-4578-8add-708cd9740881.siteSettings.547128fa-4529-4483-9968-66425996b69f.uriFormat	"__home__"
sections.3e10dcca-4dd1-4578-8add-708cd9740881.type	"single"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.autocorrect	true
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.class	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.disabled	false
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.id	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.instructions	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.label	"Title"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.max	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.min	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.name	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.orientation	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.placeholder	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.readonly	false
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.requirable	false
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.size	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.step	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.tip	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.title	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\EntryTitleField"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.warning	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.0.width	75
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.1.fieldUid	"4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.1.instructions	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.1.label	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.1.required	false
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.1.tip	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.1.warning	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.1.width	100
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.2.fieldUid	"641bcbaa-093a-41bc-a403-6696f52ce6a9"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.2.instructions	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.2.label	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.2.required	false
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.2.tip	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.2.warning	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.elements.2.width	100
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.name	"Pages"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.fieldLayouts.4cb617a1-f4f9-4f4f-ae58-c44be48749b8.tabs.0.sortOrder	1
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.handle	"pages"
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.min	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.hasTitleField	true
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.name	"Pages"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.section	"f1b8c943-bc12-4001-9e2a-d531379f1aaf"
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.sortOrder	1
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.titleFormat	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.titleTranslationKeyFormat	null
entryTypes.23eda090-7e8e-401d-ab49-ee4becc34935.titleTranslationMethod	"site"
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.defaultPlacement	"end"
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.autocapitalize	true
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.autocomplete	false
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.autocorrect	true
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.class	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.disabled	false
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.id	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.instructions	""
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.label	"Label"
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.max	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.name	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.orientation	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.placeholder	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.readonly	false
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.requirable	false
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.size	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.step	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.tip	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.title	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\TitleField"
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.warning	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.elements.0.width	100
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.name	"Content"
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.fieldLayouts.f8bd46cf-4a8b-49dc-8ef0-6c7840257051.tabs.0.sortOrder	1
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.handle	"searchFilters"
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.name	"Search Filters"
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.hasUrls	false
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.template	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.uriFormat	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.siteSettings.547128fa-4529-4483-9968-66425996b69f.hasUrls	false
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.siteSettings.547128fa-4529-4483-9968-66425996b69f.template	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.siteSettings.547128fa-4529-4483-9968-66425996b69f.uriFormat	null
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.structure.maxLevels	1
categoryGroups.0928ff1a-513d-41e0-acc1-606d93988618.structure.uid	"6499aa74-c14b-4510-b512-8c1eedf7a594"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.autocomplete	false
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.autocorrect	true
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.class	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.disabled	false
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.id	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.instructions	"User-friendly name"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.label	"Label"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.max	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.min	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.name	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.orientation	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.placeholder	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.readonly	false
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.requirable	false
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.size	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.step	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.tip	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.title	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\TitleField"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.warning	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.elements.0.width	100
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.name	"Content"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.fieldLayouts.90bed1d1-9225-4f28-ba44-a9c3c65d1b28.tabs.0.sortOrder	1
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.handle	"sortOptions"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.name	"Sort Options"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.hasUrls	true
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.template	null
dateModified	1650213806
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.siteSettings.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354.uriFormat	"sort-options/{slug}"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.siteSettings.547128fa-4529-4483-9968-66425996b69f.hasUrls	true
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.siteSettings.547128fa-4529-4483-9968-66425996b69f.template	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.siteSettings.547128fa-4529-4483-9968-66425996b69f.uriFormat	"sort-options/{slug}"
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.structure.maxLevels	null
categoryGroups.70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2.structure.uid	"d4c428f8-5094-4d5c-a6b5-5f3a58a35787"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.autocapitalize	true
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.autocomplete	false
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.autocorrect	true
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.class	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.disabled	false
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.id	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.instructions	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.label	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.max	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.min	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.name	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.orientation	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.placeholder	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.readonly	false
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.requirable	false
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.size	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.step	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.tip	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.title	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\EntryTitleField"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.warning	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.0.width	100
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.1.fieldUid	"4c6c84cf-d5a1-4d83-a3fa-e1d0276c9ae4"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.1.instructions	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.1.label	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.1.required	false
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.1.tip	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.1.warning	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.1.width	100
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.2.fieldUid	"641bcbaa-093a-41bc-a403-6696f52ce6a9"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.2.instructions	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.2.label	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.2.required	false
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.2.tip	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.2.warning	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.elements.2.width	100
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.name	"Pages"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.fieldLayouts.290ef876-62b5-4cf7-94d4-9ecbcc0c5d3e.tabs.0.sortOrder	1
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.handle	"homepage"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.hasTitleField	true
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.name	"Homepage"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.section	"3e10dcca-4dd1-4578-8add-708cd9740881"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.sortOrder	1
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.titleFormat	"{section.name|raw}"
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.titleTranslationKeyFormat	null
entryTypes.8145b1c9-cb8f-4c86-91ba-34fe5ded34e6.titleTranslationMethod	"site"
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.columnSuffix	null
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.contentColumnType	"text"
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.fieldGroup	"9940892d-32f4-4399-acac-ab559ce1c82b"
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.handle	"altText"
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.instructions	"Required description of the image for non-sighted users (https://webaim.org/techniques/alttext/)."
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.name	"Alternative Text"
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.searchable	true
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.settings.byteLimit	null
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.settings.charLimit	null
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.settings.code	""
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.settings.columnType	null
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.settings.initialRows	"4"
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.settings.multiline	""
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.settings.placeholder	null
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.settings.uiMode	"normal"
fields.39af5de5-d299-4bc5-965a-af2d128c7f1a.translationKeyFormat	null
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.siteSettings.547128fa-4529-4483-9968-66425996b69f.hasUrls	true
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.siteSettings.547128fa-4529-4483-9968-66425996b69f.template	null
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.siteSettings.547128fa-4529-4483-9968-66425996b69f.uriFormat	"{parent.uri}/{slug}"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.structure.maxLevels	null
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.structure.uid	"54619a73-dde0-4ec5-b77a-b6649f3a946b"
sections.f1b8c943-bc12-4001-9e2a-d531379f1aaf.type	"structure"
fieldGroups.9940892d-32f4-4399-acac-ab559ce1c82b.name	"Common"
fieldGroups.99f4a28a-48c3-49ca-bb4a-7acbb49fde30.name	"Pages"
fieldGroups.cee5c2f8-2801-42c2-a56c-4fe40c85b6f3.name	"Site Information"
graphql.publicToken.enabled	true
graphql.publicToken.expiryDate	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.0.fieldUid	"8fff3c50-28ba-4af7-8166-e3d82a23ae26"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.0.instructions	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.0.label	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.0.required	false
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.0.tip	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.0.warning	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.0.width	100
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.1.fieldUid	"acbea415-ee80-409c-90e2-90ac546820a6"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.1.instructions	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.1.label	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.1.required	false
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.1.tip	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.1.warning	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.1.width	100
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.2.fieldUid	"e46ce1e1-606c-4043-acea-5ddab0358221"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.2.instructions	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.2.label	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.2.required	false
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.2.tip	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.2.warning	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.elements.2.width	100
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.name	"Metadata"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.0.sortOrder	1
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.0.fieldUid	"033c2694-fbf5-48d0-aa4f-7d14e86f0aa8"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.0.instructions	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.0.label	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.0.required	false
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.0.tip	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.0.warning	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.0.width	100
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.1.fieldUid	"5b0d5d69-4003-4a56-8940-b9cbc2d691e8"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.1.instructions	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.1.label	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.1.required	false
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.1.tip	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.1.warning	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.1.width	100
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.2.fieldUid	"bc12b31b-5681-4d9c-bbc1-80042dca1a82"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.2.instructions	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.2.label	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.2.required	false
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.2.tip	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.2.warning	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.2.width	100
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.3.fieldUid	"fba2e6e2-54d4-47e5-94de-b140c01cbed6"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.3.instructions	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.3.label	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.3.required	false
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.3.tip	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.3.warning	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.3.width	100
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.4.fieldUid	"31bdcba6-2552-4cc2-8e02-e4a057a0edf0"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.4.instructions	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.4.label	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.4.required	false
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.4.tip	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.4.type	"craft\\\\fieldlayoutelements\\\\CustomField"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.4.warning	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.4.width	100
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.5.fieldUid	"40ee52fe-bbe1-4b44-97ea-ef987105496b"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.5.instructions	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.5.label	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.5.required	false
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.5.tip	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.5.type	"craft\\\\fieldlayoutelements\\\\CustomField"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.5.warning	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.elements.5.width	100
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.name	"Social Media"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.1.sortOrder	2
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.2.elements.0.fieldUid	"d7bdf364-6905-4919-b4b1-08f0010d7a08"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.2.elements.0.instructions	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.2.elements.0.label	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.2.elements.0.required	false
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.2.elements.0.tip	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.2.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.2.elements.0.warning	null
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.2.elements.0.width	100
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.2.name	"Contact Info"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.fieldLayouts.3a661c42-268a-4134-af14-45715ef1c9c2.tabs.2.sortOrder	3
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.handle	"siteInfo"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.name	"Site Information"
globalSets.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819.sortOrder	0
plugins.graphql-authentication.edition	"standard"
plugins.graphql-authentication.enabled	true
plugins.graphql-authentication.licenseKey	"2O72FZR51K6PB2RMARXXAGU6"
plugins.graphql-authentication.schemaVersion	"1.2.0"
plugins.graphql-authentication.settings.activationEmailSent	"You will receive an email if it matches an account in our system"
plugins.graphql-authentication.settings.allowRegistration	"1"
plugins.graphql-authentication.settings.allowedFacebookDomains	null
plugins.graphql-authentication.settings.allowedGoogleDomains	null
plugins.graphql-authentication.settings.allowedTwitterDomains	null
plugins.graphql-authentication.settings.appleClientId	null
plugins.graphql-authentication.settings.appleClientSecret	null
plugins.graphql-authentication.settings.appleRedirectUrl	null
plugins.graphql-authentication.settings.appleServiceId	null
plugins.graphql-authentication.settings.appleServiceSecret	null
plugins.graphql-authentication.settings.assetMutations	null
plugins.graphql-authentication.settings.assetNotFound	"We couldn't find any matching assets"
plugins.graphql-authentication.settings.assetQueries	null
plugins.graphql-authentication.settings.emailNotInScope	"No email in scope"
plugins.graphql-authentication.settings.entryMutations	null
plugins.graphql-authentication.settings.entryNotFound	"We couldn't find any matching entries"
plugins.graphql-authentication.settings.entryQueries	null
plugins.graphql-authentication.settings.facebookAppId	"$FACEBOOK_APP_ID"
plugins.graphql-authentication.settings.facebookAppSecret	"$FACEBOOK_APP_SECRET"
plugins.graphql-authentication.settings.facebookEmailMismatch	"Email address doesn't match allowed Facebook domains"
plugins.graphql-authentication.settings.facebookRedirectUrl	"$FACEBOOK_APP_REDIRECT_URL"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.0	"schema-1"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.0.0	"address"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.0.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.1.0	"altText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.1.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.2.0	"assetVariants"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.2.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.3.0	"assetsList"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.3.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.4.0	"attribution"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.4.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.5.0	"backgroundColor"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.5.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.6.0	"staffBio"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.6.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.7.0	"bold"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.7.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.8.0	"callout"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.8.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.9.0	"caption"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.9.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.10.0	"captionRichText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.10.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.11.0	"city"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.11.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.12.0	"closeDate"
fields.acbea415-ee80-409c-90e2-90ac546820a6.settings.charLimit	null
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.12.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.13.0	"colophon"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.13.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.14.0	"colorScheme"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.14.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.15.0	"contactInfo"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.15.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.16.0	"contentBlocksNews"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.16.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.17.0	"contentBlocks"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.17.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.18.0	"contentImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.18.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.19.0	"order"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.19.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.20.0	"ratio"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.20.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.21.0	"country"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.21.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.22.0	"credit"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.22.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.23.0	"creditDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.23.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.24.0	"customBreadcrumbs"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.24.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.25.0	"customHero"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.25.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.26.0	"date"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.26.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.27.0	"customDateCreated"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.27.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.28.0	"description"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.28.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.29.0	"siteDescription"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.29.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.30.0	"dynamicComponent"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.30.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.31.0	"email"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.31.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.32.0	"emailSubscription"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.32.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.33.0	"endDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.33.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.34.0	"endTime"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.34.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.35.0	"galleryEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.35.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.36.0	"newsEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.36.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.37.0	"pageEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.37.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.38.0	"pagePostEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.38.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.39.0	"slideshowEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.39.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.40.0	"staffEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.40.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.41.0	"eventType"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.41.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.42.0	"externalUrl"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.42.1	"queryMutate"
fields.acbea415-ee80-409c-90e2-90ac546820a6.settings.code	""
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.43.0	"facebook"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.43.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.44.0	"featuredImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.44.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.45.0	"focalPointX"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.45.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.46.0	"focalPointY"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.46.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.47.0	"galleryItemTags"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.47.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.48.0	"galleryItemCategory"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.48.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.49.0	"header"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.49.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.50.0	"hero"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.50.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.51.0	"hideTitle"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.51.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.52.0	"image"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.52.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.53.0	"siteImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.53.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.54.0	"imageQuote"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.54.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.55.0	"padImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.55.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.56.0	"instagram"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.56.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.57.0	"jobPosition"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.57.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.58.0	"mixedLink"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.58.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.59.0	"linkText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.59.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.60.0	"linkedIn"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.60.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.61.0	"links"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.61.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.62.0	"staffLocation"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.62.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.63.0	"metadataDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.63.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.64.0	"metadataVersion"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.64.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.65.0	"metadataVersionDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.65.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.66.0	"newsAssets"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.66.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.67.0	"numberOfItems"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.67.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.68.0	"openDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.68.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.69.0	"pageType"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.69.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.70.0	"phoneNumber"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.70.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.71.0	"plainText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.71.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.72.0	"staffPortrait"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.72.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.73.0	"postType"
fields.acbea415-ee80-409c-90e2-90ac546820a6.settings.columnType	null
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.73.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.74.0	"preferredLanguage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.74.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.75.0	"publisher"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.75.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.76.0	"publisherDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.76.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.77.0	"publisherId"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.77.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.78.0	"publisherIdDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.78.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.79.0	"quote"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.79.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.80.0	"registrationCloseDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.80.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.81.0	"registrationOpenDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.81.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.82.0	"representativeAssetVariant"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.82.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.83.0	"richTextDescription"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.83.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.84.0	"school"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.84.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.85.0	"simpleTable"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.85.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.86.0	"slideshowItems"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.86.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.87.0	"startTime"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.87.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.88.0	"state"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.88.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.89.0	"subHeroText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.89.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.90.0	"subLocation"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.90.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.91.0	"supportersLogos"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.91.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.92.0	"postTags"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.92.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.93.0	"teaser"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.93.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.94.0	"text"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.94.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.95.0	"siteTitle"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.95.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.96.0	"twitter"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.96.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.97.0	"staffType"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.97.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.98.0	"usageTerms"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.98.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.99.0	"usageTermsDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.99.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.100.0	"width"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.100.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.101.0	"youTube"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.101.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.102.0	"metadata"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.0.1.__assoc__.102.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.0	"schema-Educator Schema"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.0.0	"address"
users.allowPublicRegistration	false
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.0.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.1.0	"altText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.1.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.2.0	"assetVariants"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.2.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.3.0	"assetsList"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.3.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.4.0	"attribution"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.4.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.5.0	"backgroundColor"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.5.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.6.0	"staffBio"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.6.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.7.0	"bold"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.7.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.8.0	"callout"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.8.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.9.0	"caption"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.9.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.10.0	"captionRichText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.10.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.11.0	"city"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.11.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.12.0	"closeDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.12.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.13.0	"colophon"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.13.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.14.0	"colorScheme"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.14.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.15.0	"contactInfo"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.15.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.16.0	"contentBlocksNews"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.16.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.17.0	"contentBlocks"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.17.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.18.0	"contentImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.18.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.19.0	"order"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.19.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.20.0	"ratio"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.20.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.21.0	"country"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.21.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.22.0	"credit"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.22.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.23.0	"creditDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.23.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.24.0	"customBreadcrumbs"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.24.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.25.0	"customHero"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.25.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.26.0	"date"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.26.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.27.0	"customDateCreated"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.27.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.28.0	"description"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.28.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.29.0	"siteDescription"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.29.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.30.0	"dynamicComponent"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.30.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.31.0	"email"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.31.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.32.0	"emailSubscription"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.32.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.33.0	"endDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.33.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.34.0	"endTime"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.34.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.35.0	"galleryEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.35.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.36.0	"newsEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.36.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.37.0	"pageEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.37.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.38.0	"pagePostEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.38.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.39.0	"slideshowEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.39.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.40.0	"staffEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.40.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.41.0	"eventType"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.41.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.42.0	"externalUrl"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.42.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.43.0	"facebook"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.43.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.44.0	"featuredImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.44.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.45.0	"focalPointX"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.45.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.46.0	"focalPointY"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.46.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.47.0	"galleryItemTags"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.47.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.48.0	"galleryItemCategory"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.48.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.49.0	"header"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.49.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.50.0	"hero"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.50.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.51.0	"hideTitle"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.51.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.52.0	"image"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.52.1	"queryMutate"
plugins.typedlinkfield.schemaVersion	"2.0.0"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.53.0	"siteImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.53.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.54.0	"imageQuote"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.54.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.55.0	"padImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.55.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.56.0	"instagram"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.56.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.57.0	"jobPosition"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.57.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.58.0	"mixedLink"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.58.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.59.0	"linkText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.59.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.60.0	"linkedIn"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.60.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.61.0	"links"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.61.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.62.0	"staffLocation"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.62.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.63.0	"metadataDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.63.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.64.0	"metadataVersion"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.64.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.65.0	"metadataVersionDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.65.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.66.0	"newsAssets"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.66.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.67.0	"numberOfItems"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.67.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.68.0	"openDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.68.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.69.0	"pageType"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.69.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.70.0	"phoneNumber"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.70.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.71.0	"plainText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.71.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.72.0	"staffPortrait"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.72.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.73.0	"postType"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.73.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.74.0	"preferredLanguage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.74.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.75.0	"publisher"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.75.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.76.0	"publisherDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.76.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.77.0	"publisherId"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.77.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.78.0	"publisherIdDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.78.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.79.0	"quote"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.79.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.80.0	"registrationCloseDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.80.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.81.0	"registrationOpenDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.81.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.82.0	"representativeAssetVariant"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.82.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.83.0	"richTextDescription"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.83.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.84.0	"school"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.84.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.85.0	"simpleTable"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.85.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.86.0	"slideshowItems"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.86.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.87.0	"startTime"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.87.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.88.0	"state"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.88.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.89.0	"subHeroText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.89.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.90.0	"subLocation"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.90.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.91.0	"supportersLogos"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.91.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.92.0	"postTags"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.92.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.93.0	"teaser"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.93.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.94.0	"text"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.94.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.95.0	"siteTitle"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.95.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.96.0	"twitter"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.96.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.97.0	"staffType"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.97.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.98.0	"usageTerms"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.98.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.99.0	"usageTermsDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.99.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.100.0	"width"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.100.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.101.0	"youTube"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.101.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.102.0	"metadata"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.1.1.__assoc__.102.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.0	"schema-Student Schema"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.0.0	"address"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.0.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.1.0	"altText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.1.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.2.0	"assetVariants"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.2.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.3.0	"assetsList"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.3.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.4.0	"attribution"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.4.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.5.0	"backgroundColor"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.5.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.6.0	"staffBio"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.6.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.7.0	"bold"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.7.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.8.0	"callout"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.8.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.9.0	"caption"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.9.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.10.0	"captionRichText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.10.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.11.0	"city"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.11.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.12.0	"closeDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.12.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.13.0	"colophon"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.13.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.14.0	"colorScheme"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.14.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.15.0	"contactInfo"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.15.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.16.0	"contentBlocksNews"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.16.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.17.0	"contentBlocks"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.17.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.18.0	"contentImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.18.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.19.0	"order"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.19.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.20.0	"ratio"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.20.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.21.0	"country"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.21.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.22.0	"credit"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.22.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.23.0	"creditDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.23.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.24.0	"customBreadcrumbs"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.24.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.25.0	"customHero"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.25.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.26.0	"date"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.26.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.27.0	"customDateCreated"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.27.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.28.0	"description"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.28.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.29.0	"siteDescription"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.29.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.30.0	"dynamicComponent"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.30.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.31.0	"email"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.31.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.32.0	"emailSubscription"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.32.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.33.0	"endDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.33.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.34.0	"endTime"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.34.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.35.0	"galleryEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.35.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.36.0	"newsEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.36.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.37.0	"pageEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.37.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.38.0	"pagePostEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.38.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.39.0	"slideshowEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.39.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.40.0	"staffEntry"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.40.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.41.0	"eventType"
plugins.super-table.edition	"standard"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.41.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.42.0	"externalUrl"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.42.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.43.0	"facebook"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.43.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.44.0	"featuredImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.44.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.45.0	"focalPointX"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.45.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.46.0	"focalPointY"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.46.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.47.0	"galleryItemTags"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.47.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.48.0	"galleryItemCategory"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.48.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.49.0	"header"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.49.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.50.0	"hero"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.50.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.51.0	"hideTitle"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.51.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.52.0	"image"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.52.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.53.0	"siteImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.53.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.54.0	"imageQuote"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.54.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.55.0	"padImage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.55.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.56.0	"instagram"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.56.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.57.0	"jobPosition"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.57.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.58.0	"mixedLink"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.58.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.59.0	"linkText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.59.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.60.0	"linkedIn"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.60.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.61.0	"links"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.61.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.62.0	"staffLocation"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.62.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.63.0	"metadataDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.63.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.64.0	"metadataVersion"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.64.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.65.0	"metadataVersionDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.65.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.66.0	"newsAssets"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.66.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.67.0	"numberOfItems"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.67.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.68.0	"openDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.68.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.69.0	"pageType"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.69.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.70.0	"phoneNumber"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.70.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.71.0	"plainText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.71.1	"queryMutate"
plugins.super-table.enabled	true
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.72.0	"staffPortrait"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.72.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.73.0	"postType"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.73.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.74.0	"preferredLanguage"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.74.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.75.0	"publisher"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.75.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.76.0	"publisherDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.76.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.77.0	"publisherId"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.77.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.78.0	"publisherIdDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.78.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.79.0	"quote"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.79.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.80.0	"registrationCloseDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.80.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.81.0	"registrationOpenDate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.81.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.82.0	"representativeAssetVariant"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.82.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.83.0	"richTextDescription"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.83.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.84.0	"school"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.84.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.85.0	"simpleTable"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.85.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.86.0	"slideshowItems"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.86.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.87.0	"startTime"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.87.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.88.0	"state"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.88.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.89.0	"subHeroText"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.89.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.90.0	"subLocation"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.90.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.91.0	"supportersLogos"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.91.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.92.0	"postTags"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.92.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.93.0	"teaser"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.93.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.94.0	"text"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.94.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.95.0	"siteTitle"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.95.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.96.0	"twitter"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.96.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.97.0	"staffType"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.97.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.98.0	"usageTerms"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.98.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.99.0	"usageTermsDefault"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.99.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.100.0	"width"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.100.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.101.0	"youTube"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.101.1	"queryMutate"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.102.0	"metadata"
plugins.graphql-authentication.settings.fieldRestrictions.__assoc__.2.1.__assoc__.102.1	"queryMutate"
plugins.graphql-authentication.settings.forbiddenField	"User doesn't have permission to access requested field(s)"
plugins.graphql-authentication.settings.forbiddenMutation	"User doesn't have permission to perform this mutation"
plugins.graphql-authentication.settings.googleClientId	"$GOOGLE_APP_ID"
plugins.graphql-authentication.settings.googleEmailMismatch	"Email address doesn't match allowed Google domains"
plugins.graphql-authentication.settings.googleTokenIdInvalid	"Invalid Google Token ID"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.0.0	"group-1"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.0.1.__assoc__.0.0	"schemaName"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.0.1.__assoc__.0.1	""
plugins.graphql-authentication.settings.granularSchemas.__assoc__.0.1.__assoc__.1.0	"allowRegistration"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.0.1.__assoc__.1.1	""
plugins.graphql-authentication.settings.granularSchemas.__assoc__.0.1.__assoc__.2.0	"siteId"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.0.1.__assoc__.2.1	""
plugins.graphql-authentication.settings.granularSchemas.__assoc__.1.0	"group-9"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.1.1.__assoc__.0.0	"schemaName"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.1.1.__assoc__.0.1	"Educator Schema"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.1.1.__assoc__.1.0	"allowRegistration"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.1.1.__assoc__.1.1	"1"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.1.1.__assoc__.2.0	"siteId"
fields.acbea415-ee80-409c-90e2-90ac546820a6.settings.initialRows	"4"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.1.1.__assoc__.2.1	""
plugins.graphql-authentication.settings.granularSchemas.__assoc__.2.0	"group-8"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.2.1.__assoc__.0.0	"schemaName"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.2.1.__assoc__.0.1	"Student Schema"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.2.1.__assoc__.1.0	"allowRegistration"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.2.1.__assoc__.1.1	"1"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.2.1.__assoc__.2.0	"siteId"
plugins.graphql-authentication.settings.granularSchemas.__assoc__.2.1.__assoc__.2.1	""
plugins.graphql-authentication.settings.invalidEmailAddress	"Invalid email address"
plugins.graphql-authentication.settings.invalidHeader	"Invalid Authorization Header"
plugins.graphql-authentication.settings.invalidJwtSecretKey	"Invalid JWT Secret Key"
plugins.graphql-authentication.settings.invalidLogin	"We couldn't log you in with the provided details"
plugins.graphql-authentication.settings.invalidOauthToken	"Invalid OAuth Token"
plugins.graphql-authentication.settings.invalidPasswordMatch	"New passwords do not match"
plugins.graphql-authentication.settings.invalidPasswordUpdate	"We couldn't update the password with the provided details"
plugins.graphql-authentication.settings.invalidRefreshToken	"Invalid Refresh Token"
plugins.graphql-authentication.settings.invalidRequest	"Cannot validate request"
plugins.graphql-authentication.settings.invalidSchema	"No schema has been set for this user group"
plugins.graphql-authentication.settings.invalidUserUpdate	"We couldn't update the user with the provided details"
plugins.graphql-authentication.settings.jwtExpiration	"30 minutes"
plugins.graphql-authentication.settings.jwtRefreshExpiration	"3 months"
plugins.graphql-authentication.settings.jwtSecretKey	"D7-h5FVM6i4s9Q5V9Z1EEhggbVy4p9qX"
plugins.graphql-authentication.settings.passwordResetRequired	"Password reset required; please check your email"
plugins.graphql-authentication.settings.passwordResetSent	"You will receive an email if it matches an account in our system"
plugins.graphql-authentication.settings.passwordSaved	"Successfully saved password"
plugins.graphql-authentication.settings.passwordUpdated	"Successfully updated password"
plugins.graphql-authentication.settings.permissionType	"multiple"
plugins.graphql-authentication.settings.sameSitePolicy	"strict"
plugins.graphql-authentication.settings.schemaId	null
plugins.graphql-authentication.settings.schemaName	null
plugins.graphql-authentication.settings.siteId	""
plugins.graphql-authentication.settings.tokenNotFound	"We couldn't find any matching tokens"
plugins.graphql-authentication.settings.twitterApiKey	null
plugins.graphql-authentication.settings.twitterApiKeySecret	null
plugins.graphql-authentication.settings.twitterEmailMismatch	"Email address doesn't match allowed Twitter domains"
plugins.graphql-authentication.settings.twitterRedirectUrl	null
plugins.graphql-authentication.settings.userActivated	"Successfully activated user"
plugins.graphql-authentication.settings.userGroup	null
plugins.graphql-authentication.settings.userNotActivated	"Please activate your account before logging in"
plugins.graphql-authentication.settings.userNotFound	"We couldn't find any matching users"
plugins.graphql-authentication.settings.volumeNotFound	"We couldn't find any matching volumes"
meta.__names__.1a35bfab-6a39-4c03-b273-2d5e3151c335	"Rubin Telescope Education and Public Outreach"
meta.__names__.1e0c12ac-5dd7-4ed2-8cda-3801130b11e1	"Gallery Item"
meta.__names__.1ed94e58-7078-46fb-b590-0692fbdf9c20	"Common Name"
meta.__names__.2c2e1c6a-eb4d-44f1-9a43-8d79b326f354	"ES"
meta.__names__.3df02181-c6a1-4e72-98fb-f91def384206	"Entry"
meta.__names__.3e10dcca-4dd1-4578-8add-708cd9740881	"Homepage"
meta.__names__.4b94ba3d-060c-4a09-b2dc-c519a4c83709	"Cell Content"
meta.__names__.4c977b75-9ee1-4cdb-9d2a-203639f4af84	"Links"
meta.__names__.4fe339ec-7579-46f4-a362-df6ee8de4b3c	"Public Schema"
meta.__names__.5ca18cb3-5a7b-4764-9e18-fc24b4cecc14	"Flag"
meta.__names__.5f0325e0-cdba-4181-a634-bd8ebf451723	"Entry - Page"
meta.__names__.7db205b7-a548-42f1-8c26-416ec51cf3fa	"Text"
meta.__names__.8ccd6c1c-8e9b-44e8-93a9-f62589fb4819	"Site Information"
meta.__names__.8fff3c50-28ba-4af7-8166-e3d82a23ae26	"Title"
meta.__names__.9ad13bcd-637a-4757-9968-cdcc02cfd478	"Table Row"
meta.__names__.9c14ac7e-c466-4c2d-a2fd-e19a68fc706d	"Teaser"
meta.__names__.23eda090-7e8e-401d-ab49-ee4becc34935	"Pages"
meta.__names__.39af5de5-d299-4bc5-965a-af2d128c7f1a	"Alternative Text"
meta.__names__.68ce46bb-bb2f-4e55-8009-fe56a7d4493b	"Header"
plugins.super-table.schemaVersion	"2.2.1"
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.childBlocks	""
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.field	"4c977b75-9ee1-4cdb-9d2a-203639f4af84"
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.fieldLayouts.2652f9f9-85e2-47f9-a54a-74e393426c43.tabs.0.elements.0.fieldUid	"d019727b-a6d5-43d9-a688-f10df985a87e"
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.fieldLayouts.2652f9f9-85e2-47f9-a54a-74e393426c43.tabs.0.elements.0.instructions	null
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.fieldLayouts.2652f9f9-85e2-47f9-a54a-74e393426c43.tabs.0.elements.0.label	null
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.fieldLayouts.2652f9f9-85e2-47f9-a54a-74e393426c43.tabs.0.elements.0.required	false
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.fieldLayouts.2652f9f9-85e2-47f9-a54a-74e393426c43.tabs.0.elements.0.tip	null
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.category.allowCustomQuery	false
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.fieldLayouts.2652f9f9-85e2-47f9-a54a-74e393426c43.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.fieldLayouts.2652f9f9-85e2-47f9-a54a-74e393426c43.tabs.0.elements.0.warning	null
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.fieldLayouts.2652f9f9-85e2-47f9-a54a-74e393426c43.tabs.0.elements.0.width	100
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.fieldLayouts.2652f9f9-85e2-47f9-a54a-74e393426c43.tabs.0.name	"Link"
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.fieldLayouts.2652f9f9-85e2-47f9-a54a-74e393426c43.tabs.0.sortOrder	1
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.handle	"link"
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.maxBlocks	0
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.maxChildBlocks	0
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.maxSiblingBlocks	0
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.name	"Link"
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.sortOrder	1
neoBlockTypes.e24265aa-f05d-42eb-8d44-1ead0005aec1.topLevel	true
plugins.redactor.edition	"standard"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.columnSuffix	null
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.contentColumnType	"text"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.fieldGroup	"9940892d-32f4-4399-acac-ab559ce1c82b"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.handle	"text"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.instructions	""
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.name	"Text"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.searchable	true
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.availableTransforms	"*"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.availableVolumes	"*"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.cleanupHtml	true
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.columnType	"text"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.configSelectionMode	"choose"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.defaultTransform	""
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.manualConfig	""
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.purifierConfig	""
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.purifyHtml	"1"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.redactorConfig	""
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.removeEmptyTags	"1"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.removeInlineStyles	"1"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.removeNbsp	"1"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.showHtmlButtonForNonAdmins	""
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.showUnpermittedFiles	false
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.showUnpermittedVolumes	false
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.settings.uiMode	"enlarged"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.translationKeyFormat	null
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.translationMethod	"site"
fields.7db205b7-a548-42f1-8c26-416ec51cf3fa.type	"craft\\\\redactor\\\\Field"
plugins.redactor.enabled	true
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.columnSuffix	null
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.contentColumnType	"text"
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.fieldGroup	"9940892d-32f4-4399-acac-ab559ce1c82b"
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.handle	"linkText"
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.instructions	"Text for optional link at end of block. Will be populated by the page title if left blank and referencing an internal entry."
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.name	"Link Text"
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.searchable	true
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.settings.byteLimit	null
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.settings.charLimit	null
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.settings.code	""
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.settings.columnType	null
fields.e9726196-f241-49d4-9b6b-9e8d419e6669.settings.initialRows	"4"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.columnSuffix	null
fields.d019727b-a6d5-43d9-a688-f10df985a87e.contentColumnType	"string"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.fieldGroup	"9940892d-32f4-4399-acac-ab559ce1c82b"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.handle	"mixedLink"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.instructions	""
fields.d019727b-a6d5-43d9-a688-f10df985a87e.name	"Link"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.searchable	true
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.allowCustomText	true
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.allowTarget	true
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.autoNoReferrer	true
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.customTextMaxLength	0
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.customTextRequired	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.defaultLinkName	"entry"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.defaultText	""
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.enableAllLinkTypes	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.enableAriaLabel	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.enableElementCache	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.enableTitle	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.asset.allowCrossSiteLink	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.asset.allowCustomQuery	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.asset.enabled	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.asset.sources	"*"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.category.allowCrossSiteLink	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.category.enabled	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.category.sources	"*"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.custom.allowAliases	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.custom.disableValidation	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.custom.enabled	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.email.allowAliases	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.email.disableValidation	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.email.enabled	true
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.entry.allowCrossSiteLink	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.entry.allowCustomQuery	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.entry.enabled	true
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.entry.sources	"*"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.site.enabled	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.site.sites	"*"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.tel.allowAliases	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.tel.disableValidation	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.tel.enabled	true
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.url.allowAliases	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.url.disableValidation	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.url.enabled	true
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.user.allowCrossSiteLink	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.user.allowCustomQuery	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.user.enabled	false
fields.d019727b-a6d5-43d9-a688-f10df985a87e.settings.typeSettings.user.sources	"*"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.translationKeyFormat	null
fields.d019727b-a6d5-43d9-a688-f10df985a87e.translationMethod	"site"
fields.d019727b-a6d5-43d9-a688-f10df985a87e.type	"lenz\\\\linkfield\\\\fields\\\\LinkField"
plugins.redactor.schemaVersion	"2.3.0"
plugins.typedlinkfield.edition	"standard"
plugins.typedlinkfield.enabled	true
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.columnSuffix	null
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.contentColumnType	"string"
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.fieldGroup	"9940892d-32f4-4399-acac-ab559ce1c82b"
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.handle	"pageEntry"
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.instructions	""
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.name	"Entry - Page"
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.searchable	true
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.settings.allowSelfRelations	false
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.settings.limit	""
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.settings.localizeRelations	false
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.settings.selectionLabel	"Add a Page"
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.settings.showSiteMenu	true
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.settings.source	null
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.settings.sources.0	"section:f1b8c943-bc12-4001-9e2a-d531379f1aaf"
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.settings.targetSiteId	null
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.settings.validateRelatedElements	false
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.settings.viewMode	null
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.translationKeyFormat	null
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.translationMethod	"site"
fields.5f0325e0-cdba-4181-a634-bd8ebf451723.type	"craft\\\\fields\\\\Entries"
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.columnSuffix	null
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.contentColumnType	"text"
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.fieldGroup	"cee5c2f8-2801-42c2-a56c-4fe40c85b6f3"
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.handle	"siteTitle"
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.instructions	""
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.name	"Title"
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.searchable	false
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.settings.byteLimit	null
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.settings.charLimit	null
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.settings.code	""
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.settings.columnType	null
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.settings.initialRows	"4"
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.settings.multiline	""
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.settings.placeholder	null
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.settings.uiMode	"normal"
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.translationKeyFormat	null
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.translationMethod	"site"
fields.8fff3c50-28ba-4af7-8166-e3d82a23ae26.type	"craft\\\\fields\\\\PlainText"
fields.acbea415-ee80-409c-90e2-90ac546820a6.columnSuffix	null
fields.acbea415-ee80-409c-90e2-90ac546820a6.contentColumnType	"text"
fields.acbea415-ee80-409c-90e2-90ac546820a6.fieldGroup	"cee5c2f8-2801-42c2-a56c-4fe40c85b6f3"
fields.acbea415-ee80-409c-90e2-90ac546820a6.handle	"siteDescription"
fields.acbea415-ee80-409c-90e2-90ac546820a6.instructions	""
fields.acbea415-ee80-409c-90e2-90ac546820a6.name	"Description"
fields.acbea415-ee80-409c-90e2-90ac546820a6.searchable	false
fields.acbea415-ee80-409c-90e2-90ac546820a6.settings.byteLimit	null
fields.acbea415-ee80-409c-90e2-90ac546820a6.settings.multiline	""
fields.acbea415-ee80-409c-90e2-90ac546820a6.settings.placeholder	null
fields.acbea415-ee80-409c-90e2-90ac546820a6.settings.uiMode	"normal"
fields.acbea415-ee80-409c-90e2-90ac546820a6.translationKeyFormat	null
fields.acbea415-ee80-409c-90e2-90ac546820a6.translationMethod	"site"
fields.acbea415-ee80-409c-90e2-90ac546820a6.type	"craft\\\\fields\\\\PlainText"
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.columnSuffix	null
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.contentColumnType	"text"
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.fieldGroup	"9940892d-32f4-4399-acac-ab559ce1c82b"
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.handle	"plainText"
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.instructions	""
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.name	"Plain Text"
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.searchable	true
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.settings.byteLimit	null
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.settings.charLimit	null
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.settings.code	""
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.settings.columnType	null
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.settings.initialRows	"4"
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.settings.multiline	""
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.settings.placeholder	"Text"
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.settings.uiMode	"normal"
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.translationKeyFormat	null
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.translationMethod	"site"
fields.7970cd65-7a96-418a-8581-d6df4e039e6d.type	"craft\\\\fields\\\\PlainText"
system.edition	"pro"
system.live	true
system.name	"Rubin Telescope Education and Public Outreach"
system.retryDuration	null
system.schemaVersion	"3.7.8"
system.timeZone	"America/Los_Angeles"
email.fromEmail	"$EMAIL_FROM_ADDRESS"
email.fromName	"$EMAIL_SENDER_NAME"
email.replyToEmail	"$EMAIL_REPLY_TO_ADDRESS"
email.template	"$EMAIL_HTML_EMAIL_TEMPLATE"
email.transportSettings.encryptionMethod	"tls"
email.transportSettings.host	"$EMAIL_SMTP_HOST_NAME"
email.transportSettings.password	"$EMAIL_SMTP_PASSWORD"
email.transportSettings.port	"$EMAIL_SMTP_PORT"
email.transportSettings.timeout	"10"
email.transportSettings.useAuthentication	"1"
email.transportSettings.username	"$EMAIL_SMTP_USERNAME"
email.transportType	"craft\\\\mail\\\\transportadapters\\\\Smtp"
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.0.fieldUid	"125d214d-7831-4150-b5bc-1a100bc3149d"
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.0.instructions	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.0.label	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.0.required	false
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.0.tip	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.0.type	"craft\\\\fieldlayoutelements\\\\CustomField"
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.0.warning	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.0.width	100
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.1.fieldUid	"922a7383-2cc6-4a2a-b347-3a41389d7119"
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.1.instructions	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.1.label	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.1.required	false
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.1.tip	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.1.type	"craft\\\\fieldlayoutelements\\\\CustomField"
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.1.warning	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.1.width	100
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.2.fieldUid	"7445fb64-f649-42e7-9751-28d742d27a85"
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.2.instructions	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.2.label	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.2.required	false
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.2.tip	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.2.type	"craft\\\\fieldlayoutelements\\\\CustomField"
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.2.warning	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.2.width	100
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.3.fieldUid	"e6f15692-eb5b-4a33-ad48-7f2b05a7c527"
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.3.instructions	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.3.label	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.3.required	false
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.3.tip	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.3.type	"craft\\\\fieldlayoutelements\\\\CustomField"
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.3.warning	null
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.elements.3.width	100
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.name	"Info"
users.fieldLayouts.cb6d67cc-50a9-41ad-9b81-f54853c2b0da.tabs.0.sortOrder	1
users.defaultGroup	null
users.photoSubpath	""
users.photoVolumeUid	null
users.requireEmailVerification	true
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.columnSuffix	"kxxunrnk"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.contentColumnType	"string"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.fieldGroup	"99f4a28a-48c3-49ca-bb4a-7acbb49fde30"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.handle	"pageType"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.instructions	"Defines the type of page: `Standard` for content pages, `Dynamic` for fully API-driven, `Single` for pages defined as the entry type single, `External` for external pages."
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.name	"Page Type"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.searchable	true
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.0.__assoc__.0.0	"label"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.0.__assoc__.0.1	"Standard"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.0.__assoc__.1.0	"value"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.0.__assoc__.1.1	"standard"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.0.__assoc__.2.0	"default"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.0.__assoc__.2.1	"1"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.1.__assoc__.0.0	"label"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.1.__assoc__.0.1	"Dynamic"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.1.__assoc__.1.0	"value"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.1.__assoc__.1.1	"dynamic"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.1.__assoc__.2.0	"default"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.1.__assoc__.2.1	""
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.2.__assoc__.0.0	"label"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.2.__assoc__.0.1	"Single"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.2.__assoc__.1.0	"value"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.2.__assoc__.1.1	"single"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.2.__assoc__.2.0	"default"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.2.__assoc__.2.1	""
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.3.__assoc__.0.0	"label"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.3.__assoc__.0.1	"External"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.3.__assoc__.1.0	"value"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.3.__assoc__.1.1	"external"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.3.__assoc__.2.0	"default"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.settings.options.3.__assoc__.2.1	""
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.translationKeyFormat	null
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.translationMethod	"none"
fields.641bcbaa-093a-41bc-a403-6696f52ce6a9.type	"craft\\\\fields\\\\RadioButtons"
meta.__names__.641bcbaa-093a-41bc-a403-6696f52ce6a9	"Page Type"
\.


--
-- Data for Name: queue; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.queue (id, channel, job, description, "timePushed", ttr, delay, priority, "dateReserved", "timeUpdated", progress, "progressLabel", attempt, fail, "dateFailed", error) FROM stdin;
\.


--
-- Data for Name: relations; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.relations (id, "fieldId", "sourceId", "sourceSiteId", "targetId", "sortOrder", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: resourcepaths; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.resourcepaths (hash, path) FROM stdin;
8f24e8a5	@craft/web/assets/updateswidget/dist
9f2600ca	@lenz/linkfield/assets/field/resources
ce08405	@craft/web/assets/editsection/dist
570f5a75	@craft/web/assets/updates/dist
a39d817	@craft/web/assets/plugins/dist
d1709bdd	@craft/web/assets/sites/dist
4e78c723	@craft/web/assets/editentry/dist
66f4c98b	@storage/rebrand/logo
3267e814	@app/web/assets/recententries/dist
28881eac	@craft/web/assets/craftsupport/dist
179d23e8	@craft/web/assets/feed/dist
6ede0523	@craft/web/assets/dashboard/dist
c2290fb2	@lib/prismjs
33bb8a9a	@lib/vue
84a93106	@app/web/assets/edituser/dist
955a3134	@craft/web/assets/cp/dist
4d518d08	@app/web/assets/utilities/dist
2f2acf99	@app/web/assets/cp/dist
a6e60882	@lib/timepicker
24f06bb	@app/web/assets/craftsupport/dist
ef9013fd	@craft/web/assets/fields/dist
56318427	@app/web/assets/feed/dist
ec2781d5	@app/web/assets/dashboard/dist
208ea961	@craft/web/assets/login/dist
860bbcfe	@craft/web/assets/generalsettings/dist
1e5029ef	@lib/axios
c9ae19a8	@lib/d3
6431ae8b	@lib/element-resize-detector
aeecccc6	@app/web/assets/plugins/dist
fa130e2e	@lib/garnishjs
4ba1057e	@bower/jquery/dist
c0af053b	@lib/jquery-touch-events
5a2ef203	@lib/velocity
148769a6	@lib/jquery-ui
46095deb	@lib/jquery.payment
53b5a521	@app/web/assets/userpermissions/dist
c70b39f9	@lib/picturefill
9375147d	@lib/selectize
dfe33807	@lib/fileupload
cc8143d5	@app/web/assets/editentry/dist
991950f7	@lib/xregexp
ef55da10	@lib/fabric
d3400710	@lib/iframe-resizer
bfb7606b	@app/web/assets/clearcaches/dist
b7977aca	@storage/rebrand/icon
1c88f845	@app/web/assets/updater/dist
e0955a36	@appicons
cfa809fe	@craft/web/assets/utilities/dist
efb3329b	@craft/web/assets/graphiql/dist
8267cbfc	@craft/web/assets/fieldsettings/dist
eebd6b24	@benf/neo/resources
5a020035	@craft/redactor/assets/field/dist
cf0e2bac	@craft/redactor/assets/redactor/dist
cdc7dfb4	@craft/web/assets/userpermissions/dist
f3da4ea4	@app/web/assets/updates/dist
2b14dae7	@app/web/assets/login/dist
b19eaacb	@craft/web/assets/recententries/dist
e6beeb28	@craft/web/assets/admintable/dist
\.


--
-- Data for Name: revisions; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.revisions (id, "sourceId", "creatorId", num, notes) FROM stdin;
1	5	\N	1	\N
2	8	\N	1	\N
3	10	\N	1	\N
4	14	12	1	
5	10	12	2	\N
6	8	12	2	\N
7	5	12	2	\N
8	5	12	3	\N
9	5	12	4	\N
10	5	12	5	Applied “Draft 1”
11	14	12	2	Applied “Draft 1”
12	5	12	6	Applied “Draft 1”
13	14	12	3	
14	5	12	7	\N
15	5	12	8	Applied “Draft 1”
16	14	12	4	Applied “Draft 1”
17	5	12	9	Applied “Draft 1”
\.


--
-- Data for Name: searchindex; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.searchindex ("elementId", attribute, "fieldId", "siteId", keywords, keywords_vector) FROM stdin;
12	username	0	1	 example 	'example'
12	firstname	0	1		
12	lastname	0	1		
12	fullname	0	1		
12	email	0	1	 epo lsst org 	'epo' 'lsst' 'org'
12	slug	0	1		
2	slug	0	2		
2	slug	0	1		
3	slug	0	2		
3	slug	0	1		
4	slug	0	2		
4	field	54	2		
4	field	14	2		
4	slug	0	1		
4	field	54	1		
4	field	14	1		
13	field	17	2		
13	field	68	2	 standard standard 	'standard'
13	field	28	2	 none none 	'none'
13	field	70	2		
13	slug	0	1	 test page 	'page' 'test'
13	title	0	1	 test page 	'page' 'test'
13	field	27	1	 test page description 	'description' 'page' 'test'
13	slug	0	2	 test page 	'page' 'test'
13	title	0	2	 test page 	'page' 'test'
13	field	27	2	 test page description 	'description' 'page' 'test'
34	slug	0	1		
34	field	103	1	 this is the homepage 	'homepage' 'is' 'the' 'this'
34	slug	0	2		
10	slug	0	1	 user profile page 	'page' 'profile' 'user'
10	title	0	1	 user profile page 	'page' 'profile' 'user'
10	slug	0	2	 user profile page 	'page' 'profile' 'user'
10	title	0	2	 user profile page 	'page' 'profile' 'user'
34	field	103	2	 this is the homepage 	'homepage' 'is' 'the' 'this'
14	slug	0	1	 test 	'test'
8	slug	0	1	 user profile 	'profile' 'user'
8	title	0	1	 user profile 	'profile' 'user'
8	slug	0	2	 user profile 	'profile' 'user'
8	title	0	2	 user profile 	'profile' 'user'
14	title	0	1	 test page title 	'page' 'test' 'title'
14	field	141	1	 this is the test page 	'is' 'page' 'test' 'the' 'this'
7	slug	0	1	 search results 	'results' 'search'
7	title	0	1	 search results 	'results' 'search'
7	slug	0	2	 search results 	'results' 'search'
7	title	0	2	 search results 	'results' 'search'
14	field	140	1	 standard standard 	'standard'
14	slug	0	2	 test page title 	'page' 'test' 'title'
14	title	0	2	 test page title 	'page' 'test' 'title'
1	slug	0	1		
1	slug	0	2		
14	field	141	2	 this is the test page 	'is' 'page' 'test' 'the' 'this'
14	field	140	2	 standard standard 	'standard'
42	slug	0	1		
42	field	103	1	 this is the test page 	'is' 'page' 'test' 'the' 'this'
42	slug	0	2		
42	field	103	2	 this is the test page 	'is' 'page' 'test' 'the' 'this'
5	slug	0	2	 homepage 	'homepage'
5	title	0	2	 spanish homepage 	'homepage' 'spanish'
5	field	141	2	 this is the spanish homepage 	'homepage' 'is' 'spanish' 'the' 'this'
5	field	140	2	 standard standard 	'standard'
5	slug	0	1	 homepage 	'homepage'
5	title	0	1	 homepage 	'homepage'
5	field	141	1	 this is the homepage 	'homepage' 'is' 'the' 'this'
5	field	140	1	 standard standard 	'standard'
47	slug	0	2		
47	field	103	2	 this is the spanish homepage 	'homepage' 'is' 'spanish' 'the' 'this'
47	slug	0	1		
47	field	103	1	 this is the homepage 	'homepage' 'is' 'the' 'this'
\.


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.sections (id, "structureId", name, handle, type, "enableVersioning", "propagationMethod", "defaultPlacement", "previewTargets", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
8	9	Pages	pages	structure	t	all	end	[{"label":"Primary entry page","urlFormat":"@previewUrlFormat","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	\N	f1b8c943-bc12-4001-9e2a-d531379f1aaf
13	\N	Homepage	homepage	single	t	all	end	[{"label":"Primary entry page","urlFormat":"@previewUrlFormat","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	\N	3e10dcca-4dd1-4578-8add-708cd9740881
14	\N	Callouts	callouts	channel	t	all	end	\N	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:48	7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b
1	\N	Events	events	channel	f	all	end	[{"label":"Primary entry page","urlFormat":"@previewUrlFormat","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:53	4305f2e2-40b8-47b2-8b62-135b8b57be7f
3	\N	Gallery	galleryItems	channel	f	all	end	[{"label":"Primary entry page","urlFormat":"@previewUrlFormat","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:19:58	3a8b9653-cdd3-46ce-84b2-d73b5dc4de63
4	\N	Glossary Terms	glossaryTerms	channel	t	all	end	[{"label":"Primary entry page","urlFormat":"{url}","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:20:04	4ffeb743-f02d-42af-8656-a6f9c1363e79
11	\N	Investigations	investigations	channel	t	all	end	[{"label":"Primary entry page","urlFormat":"{url}","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:20:10	546e0c6d-dd32-4997-8487-cc4c2fcc9480
9	\N	Jobs	jobs	channel	f	all	end	[{"label":"Primary entry page","urlFormat":"{url}","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:20:15	59fb5a9e-74f4-4618-adba-601791f42c92
12	\N	News	news	channel	t	all	end	[{"label":"Primary entry page","urlFormat":"@previewUrlFormat","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:20:20	11be7603-f576-4af8-93a6-e285e4ff42c4
6	\N	Slideshows	slideshows	channel	t	all	end	[{"label":"Primary entry page","urlFormat":"{url}","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:20:30	fb3283a6-7286-4b2b-a77a-010783dcee7e
7	\N	Staff Profiles	staffProfiles	channel	f	all	end	[{"label":"Primary entry page","urlFormat":"@previewUrlFormat","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:20:35	78410791-6edc-46c9-a17b-4358dcd545ec
5	\N	Search Results	searchResults	single	f	all	end	[{"label":"Primary entry page","urlFormat":"{url}","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-17 00:32:54	04a48967-eac4-449f-b164-c8ecbb7036d6
2	\N	User Profile	userProfile	single	t	all	end	[{"label":"Primary entry page","urlFormat":"{url}","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-17 00:32:58	89cab4ff-f556-4b7e-bae9-8db545ce38dd
10	\N	User Profile Page	userProfilePage	single	t	all	end	[{"label":"Primary entry page","urlFormat":"{url}","refresh":"1"}]	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-17 00:33:00	1ee32484-2cca-457e-ac23-b3cb13e652d3
\.


--
-- Data for Name: sections_sites; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.sections_sites (id, "sectionId", "siteId", "hasUrls", "uriFormat", template, "enabledByDefault", "dateCreated", "dateUpdated", uid) FROM stdin;
1	1	2	t	es/events/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	b0e0224c-7b3a-4789-a72b-a728d55ca464
2	1	1	t	events/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	b9f229b9-4991-4b29-baff-7156d537f608
3	2	2	t	user-profile	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	749375d4-b451-4f12-8463-f6530f04ae61
4	2	1	t	user-profile	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	e81e0e94-93ff-449e-9f2d-97557af35b80
5	3	2	t	es/gallery/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	f5f40845-165d-42bf-87ac-543df058123e
6	3	1	t	gallery/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	7c98a32b-c40d-4940-97db-1737ab6b160e
7	4	2	t	es/for-educators/glossary/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	d273d7da-beeb-4bd6-a285-b415e93a3b73
8	4	1	t	for-educators/glossary/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	9e67803a-e2e5-45df-a182-78aff48cdc6d
9	5	2	t	es/search	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	a8f75651-1327-40f0-93d8-cf5571b74321
10	5	1	t	search	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	1dad7721-52df-4d1f-af6d-dc61973f3da7
11	6	2	t	es/slideshows/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	f6f079ce-c136-4fa4-826a-dce2d8768c54
12	6	1	t	slideshows/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	e77eb503-3638-4f62-a5ec-8fa8fb48a02e
13	7	2	t	es/explore/staff/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	d5ce8a94-15ea-49e1-85a8-3273b0907e52
14	7	1	t	explore/staff/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	1ec15632-5fe4-4ea1-b8c5-4dbf683f3abf
15	8	2	t	{parent ? parent.uri : 'es'}/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	cea52498-90f3-4cb3-8d49-1b3b3f886780
16	8	1	t	{parent.uri}/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	238c8668-fc7d-4d4b-94b2-5af8d8d95b7e
17	9	2	f	\N	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	be8390d1-9816-4783-922a-98bfb5bf9808
18	9	1	f	\N	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	4b5a9f54-8550-45b7-8b7e-85a71f8f315a
19	10	2	t	es/user-profile	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	5fcbec1f-a3ba-4043-8abc-a7a72f11e140
20	10	1	t	user-profile	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	927487d6-88b6-481a-9649-5023381fbfd3
21	11	2	t	es/for-educators/investigations/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	14123d89-0675-4b3c-acd4-65cc93d57157
22	11	1	t	for-educators/investigations/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	57b0b1af-4e47-4151-af16-9452357ea8f8
23	12	2	t	es/news/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	4fe59bdf-869d-4eb3-bcb8-b025dcf645f9
24	12	1	t	news/{slug}	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	13f72d9b-5f67-491c-a4d1-06a5832c6a7f
25	13	2	t	es	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	72f4e725-d7c5-48ee-9f0d-43bf6406e624
26	13	1	t	__home__	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	f2fc4f1d-b727-42e4-a38b-a5f4931aac21
27	14	2	f	\N	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	1ff4d3fa-71aa-45ca-8dc0-729c7c6d3efc
28	14	1	f	\N	\N	t	2022-04-15 04:01:18	2022-04-15 04:01:18	66406680-18af-4aed-a2db-50b93e3b8b68
\.


--
-- Data for Name: sequences; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.sequences (name, next) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.sessions (id, "userId", token, "dateCreated", "dateUpdated", uid) FROM stdin;
7	12	-dxU4Tuo5e2uTk4sN27bcbLj4XmoPB2dfG_TvY68HINYzHeuoZSLEHacWA_XDcV85HqdPwpSKESP-ytd9eCXrHllp1HBkZexzEet	2022-04-17 17:04:43	2022-04-17 17:05:49	f51b397f-fc80-4dba-bfb9-a513b8091f44
6	12	YBea78qeNwnzQHaVlzcQDtEBsDcXQysiPBXERlDWwR_84-YIvTmrRU6Wf4wbqZnhaksaPoVGwYqKjrs3Q_h4icigyszAKWWe08zj	2022-04-17 17:03:24	2022-04-17 17:04:45	2f851d10-2d2c-4f82-b75f-e564eba32ea1
8	12	pakzlb9mjOgCS6u0JMw_4yJ5AjswdNOfTUH9aM_RpiDdKZgp7YGUiwqQIM48W3xnXx27WypBftOClEcgh8VA3UM2_1WzOKMPHuRO	2022-04-17 17:04:45	2022-04-17 17:04:45	b5714a91-c2f8-4942-9a6a-312918e5cf71
\.


--
-- Data for Name: shunnedmessages; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.shunnedmessages (id, "userId", message, "expiryDate", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: sitegroups; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.sitegroups (id, name, "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
1	Rubin Telescope Education and Public Outreach	2022-04-15 04:01:03	2022-04-15 04:01:03	\N	1a35bfab-6a39-4c03-b273-2d5e3151c335
\.


--
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.sites (id, "groupId", "primary", enabled, name, handle, language, "hasUrls", "baseUrl", "sortOrder", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
1	1	t	t	EN	default	en-US	t	@webBaseUrl	1	2022-04-15 04:01:03	2022-04-15 04:01:03	\N	547128fa-4529-4483-9968-66425996b69f
2	1	f	t	ES	es	es	t	@webBaseUrl	2	2022-04-15 04:01:03	2022-04-15 04:01:03	\N	2c2e1c6a-eb4d-44f1-9a43-8d79b326f354
\.


--
-- Data for Name: structureelements; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.structureelements (id, "structureId", "elementId", root, lft, rgt, level, "dateCreated", "dateUpdated", uid) FROM stdin;
15	14	\N	15	1	2	0	2022-04-17 16:43:41	2022-04-17 16:57:21	6ac8307f-a2f5-4699-83b8-f4f4f3321eae
41	27	\N	41	1	2	0	2022-04-17 16:57:17	2022-04-17 16:57:21	e379ce0c-1091-4323-8e6e-fe563288051f
49	31	\N	49	1	4	0	2022-04-17 16:57:22	2022-04-17 16:57:22	53ba5d17-e2fb-42c7-89d4-95feb6ff7c14
50	31	49	49	2	3	1	2022-04-17 16:57:22	2022-04-17 16:57:22	bb91392b-caa6-4588-8a67-8b1f1c199e9d
13	13	\N	13	1	2	0	2022-04-17 16:43:40	2022-04-17 16:43:41	183a3440-4898-4cc3-a0f1-d32fac1827ea
6	9	24	1	2	3	1	2022-04-17 00:45:33	2022-04-17 00:45:33	a1a414f6-21c6-48ff-b28d-203510967db8
9	11	\N	9	1	2	0	2022-04-17 16:43:36	2022-04-17 16:43:39	b8347157-a1ea-49be-9199-e99a6d3099ae
11	12	\N	11	1	2	0	2022-04-17 16:43:39	2022-04-17 16:43:40	3bc3e3ff-77f6-48f9-9ca5-5ff4e47f9682
17	15	\N	17	1	4	0	2022-04-17 16:43:41	2022-04-17 16:43:41	7668f99e-4dc9-4421-b08a-91ff4986d46c
18	15	33	17	2	3	1	2022-04-17 16:43:41	2022-04-17 16:43:41	1e6923e9-cc04-4859-b7b7-a2174e2565ac
19	16	\N	19	1	4	0	2022-04-17 16:43:41	2022-04-17 16:43:41	5fb29b21-7e7e-4534-8873-94445bd4e189
20	16	33	19	2	3	1	2022-04-17 16:43:41	2022-04-17 16:43:41	d4ba07a9-f1bd-4a81-a2a3-a6126d355840
21	17	\N	21	1	4	0	2022-04-17 16:43:42	2022-04-17 16:43:42	302a1f43-ef59-4799-9333-4528015b0822
22	17	36	21	2	3	1	2022-04-17 16:43:42	2022-04-17 16:43:42	5989f7c2-4fae-496b-9628-75ee47adc0d0
24	19	\N	24	1	2	0	2022-04-17 16:43:46	2022-04-17 16:43:50	9647233a-c642-418d-879a-20c6dd32d34a
26	20	\N	26	1	2	0	2022-04-17 16:43:50	2022-04-17 16:43:52	5f939e25-e3b2-4c18-8657-c79347fc7c22
28	21	\N	28	1	2	0	2022-04-17 16:43:52	2022-04-17 16:43:53	3a594d38-40d4-4a80-a431-051739719e1a
32	23	\N	32	1	4	0	2022-04-17 16:43:54	2022-04-17 16:43:54	53aa5862-62f4-4d9e-bd10-f844003aacee
33	23	42	32	2	3	1	2022-04-17 16:43:54	2022-04-17 16:43:54	0544be9c-611c-4a71-8038-d7f2c0d2324d
34	9	43	1	4	5	1	2022-04-17 16:43:54	2022-04-17 16:44:09	69929a00-fed6-4ce4-b0a4-f9f7b3aa8f51
30	22	\N	30	1	2	0	2022-04-17 16:43:53	2022-04-17 16:44:09	804f3ea4-7431-4ea3-ac08-7924b55c4fed
35	24	\N	35	1	4	0	2022-04-17 16:44:09	2022-04-17 16:44:09	3a5bc959-7ef4-4b14-aba3-2e643a73fdf0
36	24	41	35	2	3	1	2022-04-17 16:44:09	2022-04-17 16:44:09	3871ecdc-6619-455c-8728-3875a9149d07
37	25	\N	37	1	4	0	2022-04-17 16:44:09	2022-04-17 16:44:09	a5774c60-74eb-4950-b1dc-68471063fa12
38	25	41	37	2	3	1	2022-04-17 16:44:09	2022-04-17 16:44:09	26d46a62-a64e-439c-81fc-16b214c7561f
1	9	\N	1	1	12	0	2022-04-15 04:30:24	2022-04-17 16:44:09	f4b3b8c9-2b24-44f7-9692-f82a060ffaf2
8	9	28	1	8	9	1	2022-04-17 01:27:38	2022-04-17 16:44:09	1c605153-fd32-4c1b-b2dd-672463040a33
4	9	15	1	10	11	1	2022-04-15 04:33:21	2022-04-17 16:44:09	f76f0f86-f190-4cfe-a7cf-17a85dfa5f0c
3	9	14	1	6	7	1	2022-04-15 04:33:02	2022-04-17 16:44:09	992b818b-abdb-464f-a240-d48f5c9c4b9e
39	26	\N	39	1	4	0	2022-04-17 16:44:10	2022-04-17 16:44:10	4e021e73-364f-447f-b3fa-b22d72ad8508
40	26	44	39	2	3	1	2022-04-17 16:44:10	2022-04-17 16:44:10	8acfabb1-7a92-475e-97d8-98ccb1fc670e
43	28	\N	43	1	4	0	2022-04-17 16:57:21	2022-04-17 16:57:21	05aee62f-dfb3-44d7-8cd9-5571e171bd1c
44	28	47	43	2	3	1	2022-04-17 16:57:21	2022-04-17 16:57:21	46777234-3948-4884-9ca8-a8730614735a
45	29	\N	45	1	4	0	2022-04-17 16:57:21	2022-04-17 16:57:21	a575ca09-2898-4260-8ca0-8f6f5dc88304
46	29	46	45	2	3	1	2022-04-17 16:57:21	2022-04-17 16:57:21	bdda0c75-3072-4951-8cca-def7d9db01a8
47	30	\N	47	1	4	0	2022-04-17 16:57:21	2022-04-17 16:57:21	2b4c45b2-bd50-4431-a8e4-29680fedb6a2
48	30	46	47	2	3	1	2022-04-17 16:57:21	2022-04-17 16:57:21	b6d0cd87-e453-4c35-ba69-6f79332563c1
\.


--
-- Data for Name: structures; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.structures (id, "maxLevels", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
6	1	2022-04-15 04:01:17	2022-04-15 04:01:17	\N	6499aa74-c14b-4510-b512-8c1eedf7a594
7	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	\N	d4c428f8-5094-4d5c-a6b5-5f3a58a35787
9	\N	2022-04-15 04:01:18	2022-04-15 04:01:18	\N	54619a73-dde0-4ec5-b77a-b6649f3a946b
1	1	2022-04-15 04:01:10	2022-04-15 04:01:10	2022-04-15 04:21:17	bbf2c1a1-7b33-4b69-926e-2c94ae2116e7
5	1	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:21	9f7ba5c0-a9d9-4da3-9418-4b1effe213a5
4	1	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:24	b4b82886-423d-42a0-bf6d-710b2c39efe2
2	\N	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:26	649d0ae6-df70-418d-8b61-d74777deb5ee
3	1	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:29	24982e68-f795-424d-95df-6f06c375b7d6
8	1	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:21:34	8b634ea7-ae09-4f56-a3f3-19f21864776a
10	\N	2022-04-17 16:43:35	2022-04-17 16:43:35	2022-04-17 16:43:36	cb215990-60d2-4cb6-a3f0-cefb9290e7cf
11	\N	2022-04-17 16:43:36	2022-04-17 16:43:36	2022-04-17 16:43:39	d9b4365d-1dd5-4516-a00c-1050cd5e8db7
12	\N	2022-04-17 16:43:39	2022-04-17 16:43:39	2022-04-17 16:43:40	fea5247d-97bc-4dd4-a43d-fb76535ae8c6
15	\N	2022-04-17 16:43:41	2022-04-17 16:43:41	\N	74efb438-6a71-4d6a-917c-573042aaa005
13	\N	2022-04-17 16:43:40	2022-04-17 16:43:40	2022-04-17 16:43:41	f51471b5-1543-425b-90c0-c70f0558508a
16	\N	2022-04-17 16:43:41	2022-04-17 16:43:41	\N	2d854f59-7349-4c73-a1a6-630ec6d25dc6
17	\N	2022-04-17 16:43:42	2022-04-17 16:43:42	\N	f1b4a932-b424-4989-a97e-3a8f05b3d760
18	\N	2022-04-17 16:43:46	2022-04-17 16:43:46	2022-04-17 16:43:46	49b9d51b-f679-4e27-b00a-ec47e8d7c0d5
19	\N	2022-04-17 16:43:46	2022-04-17 16:43:46	2022-04-17 16:43:50	1dbbe169-d685-41ba-9b5c-e378162d4df4
20	\N	2022-04-17 16:43:50	2022-04-17 16:43:50	2022-04-17 16:43:52	34db12fa-3ac3-4874-a9f8-30be183a585c
21	\N	2022-04-17 16:43:52	2022-04-17 16:43:52	2022-04-17 16:43:53	edfc8700-c654-4820-be2a-7274a817dfec
23	\N	2022-04-17 16:43:54	2022-04-17 16:43:54	\N	24ad87e7-91a1-4e61-8c22-c1348add8bbd
24	\N	2022-04-17 16:44:09	2022-04-17 16:44:09	\N	e7f510b4-5a19-4af6-8e06-abfb4091571e
22	\N	2022-04-17 16:43:53	2022-04-17 16:43:53	2022-04-17 16:44:09	eb82e1af-8027-45b0-a8d3-d2e3aedba724
25	\N	2022-04-17 16:44:09	2022-04-17 16:44:09	\N	399f302e-d2e3-4518-9b6b-164817ef95ff
26	\N	2022-04-17 16:44:10	2022-04-17 16:44:10	\N	adc91f6f-2d3d-477f-a398-3a7caa211e8d
28	\N	2022-04-17 16:57:21	2022-04-17 16:57:21	\N	e93d7f89-22ce-41ee-97c5-8bb2c6a8640b
14	\N	2022-04-17 16:43:41	2022-04-17 16:43:41	2022-04-17 16:57:21	895571c9-ab06-4a79-9684-aec6aae6b3b5
29	\N	2022-04-17 16:57:21	2022-04-17 16:57:21	\N	c0b35f9c-bec2-4316-8e5e-73db066fe619
27	\N	2022-04-17 16:57:17	2022-04-17 16:57:17	2022-04-17 16:57:21	06f42011-2a14-4e14-8674-ebe58529a1ff
30	\N	2022-04-17 16:57:21	2022-04-17 16:57:21	\N	0dc3e903-47b9-43b1-bd4f-9abfac71c2dd
31	\N	2022-04-17 16:57:22	2022-04-17 16:57:22	\N	4f35c22d-468c-4006-a193-f8b6a0a5fc27
\.


--
-- Data for Name: supertableblocks; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.supertableblocks (id, "ownerId", "fieldId", "typeId", "sortOrder", "deletedWithOwner", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: supertableblocktypes; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.supertableblocktypes (id, "fieldId", "fieldLayoutId", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: systemmessages; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.systemmessages (id, language, key, subject, body, "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: taggroups; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.taggroups (id, name, handle, "fieldLayoutId", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
2	Gallery Item Tags	galleryItemTags	64	2022-04-15 04:01:18	2022-04-15 04:01:18	2022-04-15 04:28:32	c30bad12-1372-49fe-ab6c-a9c33b2860bb
1	News Tags	newsTags	21	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:28:33	0d02fdfb-053c-4d46-a5f8-0abf2542a5d2
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.tags (id, "groupId", "deletedWithGroup", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: templatecacheelements; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.templatecacheelements (id, "cacheId", "elementId") FROM stdin;
\.


--
-- Data for Name: templatecachequeries; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.templatecachequeries (id, "cacheId", type, query) FROM stdin;
\.


--
-- Data for Name: templatecaches; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.templatecaches (id, "siteId", "cacheKey", path, "expiryDate", body) FROM stdin;
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.tokens (id, token, route, "usageLimit", "usageCount", "expiryDate", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: universaldamintegrator_asset_metadata; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.universaldamintegrator_asset_metadata (id, "dateCreated", "dateUpdated", uid, "assetId", dam_meta_key, dam_meta_value) FROM stdin;
\.


--
-- Data for Name: usergroups; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.usergroups (id, name, handle, description, "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: usergroups_users; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.usergroups_users (id, "groupId", "userId", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: userpermissions; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.userpermissions (id, name, "dateCreated", "dateUpdated", uid) FROM stdin;
1	accesssitewhensystemisoff	2022-04-15 04:01:18	2022-04-15 04:01:18	092afeb8-9568-4145-b1d1-47d34d83f513
2	accesscpwhensystemisoff	2022-04-15 04:01:18	2022-04-15 04:01:18	167667ae-0eda-4a73-9795-5cac2853d351
3	accesscp	2022-04-15 04:01:18	2022-04-15 04:01:18	17ef4e11-1451-4414-8058-7ed5453c32f1
4	editsite:547128fa-4529-4483-9968-66425996b69f	2022-04-15 04:01:18	2022-04-15 04:01:18	3a8b961f-31b6-441d-85ff-259d3ed59b84
5	editsite:2c2e1c6a-eb4d-44f1-9a43-8d79b326f354	2022-04-15 04:01:18	2022-04-15 04:01:18	c8419806-0b6a-4449-b91d-82a8dc7302ce
6	createentries:7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b	2022-04-15 04:01:18	2022-04-15 04:01:18	4e185dc6-8f87-482a-a6df-04b64d1d3ecc
7	publishentries:7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b	2022-04-15 04:01:18	2022-04-15 04:01:18	39f7b9fe-96cf-447a-a852-38bf5cb8b78c
8	deleteentries:7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b	2022-04-15 04:01:18	2022-04-15 04:01:18	209b453b-5554-44ba-9ba5-691bc88b4289
9	publishpeerentries:7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b	2022-04-15 04:01:18	2022-04-15 04:01:18	7de9b3e1-606c-446b-b2ab-c5d9aaf65297
10	deletepeerentries:7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b	2022-04-15 04:01:18	2022-04-15 04:01:18	bcafc0ac-92e5-4710-911c-abcc84808af7
11	editpeerentries:7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b	2022-04-15 04:01:18	2022-04-15 04:01:18	597672d9-b06b-42d0-8773-fac670ee1ff8
12	publishpeerentrydrafts:7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b	2022-04-15 04:01:18	2022-04-15 04:01:18	186df81f-abe0-4995-b6e0-c99194fec10d
13	deletepeerentrydrafts:7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b	2022-04-15 04:01:18	2022-04-15 04:01:18	113c3a94-8db2-4b09-a481-e7f4bd411505
14	editpeerentrydrafts:7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b	2022-04-15 04:01:18	2022-04-15 04:01:18	00fd194c-de3b-4efa-af1c-b9ebcfe31ec1
15	editentries:7cad6f4e-cc7b-45cf-ac7b-6f383e77bc1b	2022-04-15 04:01:18	2022-04-15 04:01:18	56ca1dfb-e71d-48eb-af5c-5898892a4646
16	createentries:4305f2e2-40b8-47b2-8b62-135b8b57be7f	2022-04-15 04:01:18	2022-04-15 04:01:18	c262a46e-30a5-47bc-8252-8d1e47a4f644
17	publishentries:4305f2e2-40b8-47b2-8b62-135b8b57be7f	2022-04-15 04:01:18	2022-04-15 04:01:18	abcc4d0b-dd4b-4b34-a8f5-5beed92599c5
18	deleteentries:4305f2e2-40b8-47b2-8b62-135b8b57be7f	2022-04-15 04:01:18	2022-04-15 04:01:18	ba2e49b3-55a7-48a6-8b90-4f9a59af26fd
19	publishpeerentries:4305f2e2-40b8-47b2-8b62-135b8b57be7f	2022-04-15 04:01:18	2022-04-15 04:01:18	66a7a98a-eed6-433c-9aed-2e627cf9d31f
20	deletepeerentries:4305f2e2-40b8-47b2-8b62-135b8b57be7f	2022-04-15 04:01:18	2022-04-15 04:01:18	820fc8fd-06ab-4fe4-991e-44341b9dfcf2
21	editpeerentries:4305f2e2-40b8-47b2-8b62-135b8b57be7f	2022-04-15 04:01:18	2022-04-15 04:01:18	7b4e946c-a8ae-4fba-94ed-1cb585cda9dc
22	publishpeerentrydrafts:4305f2e2-40b8-47b2-8b62-135b8b57be7f	2022-04-15 04:01:18	2022-04-15 04:01:18	253400af-3704-4b8a-b97d-c68fcb72a8d2
23	deletepeerentrydrafts:4305f2e2-40b8-47b2-8b62-135b8b57be7f	2022-04-15 04:01:18	2022-04-15 04:01:18	bb59869e-e941-4c95-8642-db9ab85e562a
24	editpeerentrydrafts:4305f2e2-40b8-47b2-8b62-135b8b57be7f	2022-04-15 04:01:18	2022-04-15 04:01:18	fc9b8261-4f26-4672-b000-446238ebb2a1
25	editentries:4305f2e2-40b8-47b2-8b62-135b8b57be7f	2022-04-15 04:01:18	2022-04-15 04:01:18	44877efe-71f2-45e6-922a-deaf1fc44dfc
26	createentries:3a8b9653-cdd3-46ce-84b2-d73b5dc4de63	2022-04-15 04:01:18	2022-04-15 04:01:18	7c5a22ba-6e80-4000-935f-84b02eb64f51
27	publishentries:3a8b9653-cdd3-46ce-84b2-d73b5dc4de63	2022-04-15 04:01:18	2022-04-15 04:01:18	c2bf36e5-c876-4ca6-8492-a40c8507f5ad
28	deleteentries:3a8b9653-cdd3-46ce-84b2-d73b5dc4de63	2022-04-15 04:01:18	2022-04-15 04:01:18	c1755be8-01cc-466d-ab76-40734bb8bd54
29	publishpeerentries:3a8b9653-cdd3-46ce-84b2-d73b5dc4de63	2022-04-15 04:01:18	2022-04-15 04:01:18	7ef10ae0-aab8-4547-9e18-e3ae39b6cea8
30	deletepeerentries:3a8b9653-cdd3-46ce-84b2-d73b5dc4de63	2022-04-15 04:01:18	2022-04-15 04:01:18	9cb0aa6c-5bbd-48bd-bded-28fb603e1f08
31	editpeerentries:3a8b9653-cdd3-46ce-84b2-d73b5dc4de63	2022-04-15 04:01:18	2022-04-15 04:01:18	5f2e9644-9210-4427-8ec8-65119f1e5a4a
32	publishpeerentrydrafts:3a8b9653-cdd3-46ce-84b2-d73b5dc4de63	2022-04-15 04:01:18	2022-04-15 04:01:18	1fac0be1-0600-4a9f-aa66-0e48db2407a1
33	deletepeerentrydrafts:3a8b9653-cdd3-46ce-84b2-d73b5dc4de63	2022-04-15 04:01:18	2022-04-15 04:01:18	3954d6b1-139a-4634-8334-9643d6d61125
34	editpeerentrydrafts:3a8b9653-cdd3-46ce-84b2-d73b5dc4de63	2022-04-15 04:01:18	2022-04-15 04:01:18	a66ba0f6-dbe6-45d6-93d7-78398e3bbc1e
35	editentries:3a8b9653-cdd3-46ce-84b2-d73b5dc4de63	2022-04-15 04:01:18	2022-04-15 04:01:18	1ec4a0a8-ba12-463c-8cda-af9a4d634509
36	publishentries:3e10dcca-4dd1-4578-8add-708cd9740881	2022-04-15 04:01:18	2022-04-15 04:01:18	3651453e-72c9-4ee9-acab-5a96e159e6e3
37	publishpeerentrydrafts:3e10dcca-4dd1-4578-8add-708cd9740881	2022-04-15 04:01:18	2022-04-15 04:01:18	517eefe7-f687-4ad0-8750-fe673576960f
38	deletepeerentrydrafts:3e10dcca-4dd1-4578-8add-708cd9740881	2022-04-15 04:01:18	2022-04-15 04:01:18	c55efb12-9ef5-4a61-a216-71a6dfddb665
39	editpeerentrydrafts:3e10dcca-4dd1-4578-8add-708cd9740881	2022-04-15 04:01:18	2022-04-15 04:01:18	362bc55b-f303-4729-87d2-1a4712f5fddb
40	editentries:3e10dcca-4dd1-4578-8add-708cd9740881	2022-04-15 04:01:18	2022-04-15 04:01:18	1c2dc80a-a6c6-4942-afdb-6bfe46e3929c
41	createentries:59fb5a9e-74f4-4618-adba-601791f42c92	2022-04-15 04:01:18	2022-04-15 04:01:18	ea70f31d-ad22-40e2-9bb0-1528409bee6d
42	publishentries:59fb5a9e-74f4-4618-adba-601791f42c92	2022-04-15 04:01:18	2022-04-15 04:01:18	e6bc1d0c-d436-4c4b-906c-7ddf8da7213f
43	deleteentries:59fb5a9e-74f4-4618-adba-601791f42c92	2022-04-15 04:01:18	2022-04-15 04:01:18	6d69f2ff-9a0d-4afe-8c0d-1b3d16d811b1
44	publishpeerentries:59fb5a9e-74f4-4618-adba-601791f42c92	2022-04-15 04:01:18	2022-04-15 04:01:18	3c47182d-387f-44db-8ea2-0c3f0884067f
45	deletepeerentries:59fb5a9e-74f4-4618-adba-601791f42c92	2022-04-15 04:01:18	2022-04-15 04:01:18	6daa8813-efe2-441e-94de-87829e4420ed
46	editpeerentries:59fb5a9e-74f4-4618-adba-601791f42c92	2022-04-15 04:01:18	2022-04-15 04:01:18	52ef4b84-7744-419f-bf42-a154b356f0de
47	publishpeerentrydrafts:59fb5a9e-74f4-4618-adba-601791f42c92	2022-04-15 04:01:18	2022-04-15 04:01:18	dfbac189-e282-40f9-a954-5a4826203303
48	deletepeerentrydrafts:59fb5a9e-74f4-4618-adba-601791f42c92	2022-04-15 04:01:18	2022-04-15 04:01:18	7bba5f2a-a2c5-4276-bff9-ce3fa1eb42ec
49	editpeerentrydrafts:59fb5a9e-74f4-4618-adba-601791f42c92	2022-04-15 04:01:18	2022-04-15 04:01:18	e5072598-bce1-4684-95ce-d183da62a0cf
50	editentries:59fb5a9e-74f4-4618-adba-601791f42c92	2022-04-15 04:01:18	2022-04-15 04:01:18	4b02e39a-a48b-40d6-be28-40183cfb93ab
51	createentries:11be7603-f576-4af8-93a6-e285e4ff42c4	2022-04-15 04:01:18	2022-04-15 04:01:18	85b2841a-60e5-4ca0-a261-65d1fc6028fa
52	publishentries:11be7603-f576-4af8-93a6-e285e4ff42c4	2022-04-15 04:01:18	2022-04-15 04:01:18	43794873-638d-44dc-9192-064815ccc01a
53	deleteentries:11be7603-f576-4af8-93a6-e285e4ff42c4	2022-04-15 04:01:18	2022-04-15 04:01:18	9418947f-3dd6-40e0-86e6-66ac5d6896f0
54	publishpeerentries:11be7603-f576-4af8-93a6-e285e4ff42c4	2022-04-15 04:01:18	2022-04-15 04:01:18	0cc82ea5-010f-411b-9a32-7bf33112cdec
55	deletepeerentries:11be7603-f576-4af8-93a6-e285e4ff42c4	2022-04-15 04:01:18	2022-04-15 04:01:18	85208207-b540-428c-acf7-4b68f1d9f3b5
56	editpeerentries:11be7603-f576-4af8-93a6-e285e4ff42c4	2022-04-15 04:01:18	2022-04-15 04:01:18	faca7f65-16a7-4171-8b9c-94cd1c3e8836
57	publishpeerentrydrafts:11be7603-f576-4af8-93a6-e285e4ff42c4	2022-04-15 04:01:18	2022-04-15 04:01:18	272c210a-821a-4c8e-b4ac-fbd5c7b4e3b8
58	deletepeerentrydrafts:11be7603-f576-4af8-93a6-e285e4ff42c4	2022-04-15 04:01:18	2022-04-15 04:01:18	62eb682b-5d4d-49c5-994c-fdf168e38e6f
59	editpeerentrydrafts:11be7603-f576-4af8-93a6-e285e4ff42c4	2022-04-15 04:01:18	2022-04-15 04:01:18	78e3e1e9-cb75-41f8-9a45-edff6aa68da1
60	editentries:11be7603-f576-4af8-93a6-e285e4ff42c4	2022-04-15 04:01:18	2022-04-15 04:01:18	ded11123-00cb-4cc0-a206-c1e5443acfa9
61	createentries:f1b8c943-bc12-4001-9e2a-d531379f1aaf	2022-04-15 04:01:18	2022-04-15 04:01:18	0dbaee53-f2f9-4a13-bdff-3edf2b26c58b
62	publishentries:f1b8c943-bc12-4001-9e2a-d531379f1aaf	2022-04-15 04:01:18	2022-04-15 04:01:18	304f12dd-d454-4890-8f23-0025262ae4cf
63	deleteentries:f1b8c943-bc12-4001-9e2a-d531379f1aaf	2022-04-15 04:01:18	2022-04-15 04:01:18	28213b02-f934-428c-b39a-8f013ff50798
64	publishpeerentries:f1b8c943-bc12-4001-9e2a-d531379f1aaf	2022-04-15 04:01:18	2022-04-15 04:01:18	bd8fcfc8-d236-4803-9b02-b22ebde97b2d
65	deletepeerentries:f1b8c943-bc12-4001-9e2a-d531379f1aaf	2022-04-15 04:01:18	2022-04-15 04:01:18	e539fa0a-dcb7-4620-86a7-3ec3544e6fec
66	editpeerentries:f1b8c943-bc12-4001-9e2a-d531379f1aaf	2022-04-15 04:01:18	2022-04-15 04:01:18	d424e520-a7fb-4fe1-8188-1a6d75dead5f
67	publishpeerentrydrafts:f1b8c943-bc12-4001-9e2a-d531379f1aaf	2022-04-15 04:01:18	2022-04-15 04:01:18	efe82acd-dfbb-4afc-88a9-926f10df8d57
68	deletepeerentrydrafts:f1b8c943-bc12-4001-9e2a-d531379f1aaf	2022-04-15 04:01:18	2022-04-15 04:01:18	696d5d56-3b65-4a70-acbb-0fab4034b108
69	editpeerentrydrafts:f1b8c943-bc12-4001-9e2a-d531379f1aaf	2022-04-15 04:01:18	2022-04-15 04:01:18	9d57f74a-c360-4071-a0dc-c4a20f8d9b6f
70	editentries:f1b8c943-bc12-4001-9e2a-d531379f1aaf	2022-04-15 04:01:18	2022-04-15 04:01:18	4b2835aa-97af-4eea-9682-679b625dd002
71	createentries:78410791-6edc-46c9-a17b-4358dcd545ec	2022-04-15 04:01:18	2022-04-15 04:01:18	2beeab60-c09e-4e5a-857f-a9614f6ec04d
72	publishentries:78410791-6edc-46c9-a17b-4358dcd545ec	2022-04-15 04:01:18	2022-04-15 04:01:18	3bf63a67-855b-48e4-8149-946f1aa807a3
73	deleteentries:78410791-6edc-46c9-a17b-4358dcd545ec	2022-04-15 04:01:18	2022-04-15 04:01:18	55707762-e35c-491c-983a-2dad49a2c979
74	publishpeerentries:78410791-6edc-46c9-a17b-4358dcd545ec	2022-04-15 04:01:18	2022-04-15 04:01:18	146f1381-6e07-42d5-8c0a-d57096976aed
75	deletepeerentries:78410791-6edc-46c9-a17b-4358dcd545ec	2022-04-15 04:01:18	2022-04-15 04:01:18	6f111a3b-8d9d-43d6-9c0a-b67417bb5085
76	editpeerentries:78410791-6edc-46c9-a17b-4358dcd545ec	2022-04-15 04:01:18	2022-04-15 04:01:18	517370ad-57ac-4ab2-8e4f-b05c08ad7652
77	publishpeerentrydrafts:78410791-6edc-46c9-a17b-4358dcd545ec	2022-04-15 04:01:18	2022-04-15 04:01:18	e8b59d0a-b3dd-48ee-9e64-0fae8f63c461
78	deletepeerentrydrafts:78410791-6edc-46c9-a17b-4358dcd545ec	2022-04-15 04:01:18	2022-04-15 04:01:18	381c7819-8a60-4880-a88e-27d4beca47cc
79	editpeerentrydrafts:78410791-6edc-46c9-a17b-4358dcd545ec	2022-04-15 04:01:18	2022-04-15 04:01:18	d5561e85-7b92-4b9e-b158-f685e108fbdc
80	editentries:78410791-6edc-46c9-a17b-4358dcd545ec	2022-04-15 04:01:18	2022-04-15 04:01:18	5d3b5c9c-49e7-45c8-b852-72e4c7357a23
81	editglobalset:1a2ba41a-3949-4982-9cb3-f8b03863bcfd	2022-04-15 04:01:18	2022-04-15 04:01:18	24145355-0775-4051-a86f-668f8d65e280
82	editglobalset:b8393df9-fb81-4d70-9ccb-6d030c818580	2022-04-15 04:01:18	2022-04-15 04:01:18	93e870f4-8405-448a-9deb-0da8ea432f84
83	editglobalset:994d5664-f056-4969-b2cc-c62660f069af	2022-04-15 04:01:18	2022-04-15 04:01:18	807666d9-d6b1-46ac-b9e8-21f9b5d3841d
84	editglobalset:8ccd6c1c-8e9b-44e8-93a9-f62589fb4819	2022-04-15 04:01:18	2022-04-15 04:01:18	22656e81-8433-4021-ad4b-194a2b1c17cd
85	editcategories:3a3af2ab-b037-455a-ba95-bc3be89efdb0	2022-04-15 04:01:18	2022-04-15 04:01:18	e9ad6a8c-a01b-4a20-b04c-a503ed837478
86	editcategories:cc8c47f0-3dec-44db-a47f-7ca6c984864a	2022-04-15 04:01:18	2022-04-15 04:01:18	743170cf-f1af-4e9d-bd07-438224238afe
87	editcategories:df7f4ec2-58b2-4c3a-afff-b07f4764fa4b	2022-04-15 04:01:18	2022-04-15 04:01:18	435ac2c9-c171-4ea6-92c2-4b7e71890ee2
88	editcategories:7cb3bc06-c4c4-4017-8c0c-fa6aad7cbd8e	2022-04-15 04:01:18	2022-04-15 04:01:18	77dae3fe-1d52-4833-aa5f-4fb12b55cefe
89	editcategories:70ff59dd-8280-4bea-bef6-cfdf9ea4f0c2	2022-04-15 04:01:18	2022-04-15 04:01:18	00eb0461-60fc-4b9d-8d42-933ec33435ed
90	editcategories:aa60fd40-45d4-48bb-8b81-8ec736456687	2022-04-15 04:01:18	2022-04-15 04:01:18	ed72518b-ef21-468a-a462-05e67006cf9e
91	saveassetinvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	88c96305-f0d3-4cf3-b589-82ac871293b1
92	createfoldersinvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	6d90b450-6180-4ae3-98eb-098a49f59529
93	deletefilesandfoldersinvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	086c09f5-4359-4bec-9af9-0768a61d5601
94	replacefilesinvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	eaea7b7a-6c8e-4815-a9ed-f919f17e0d01
95	editimagesinvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	863154bf-0e8c-4faa-8ad6-c4ea6d4cf8ea
96	editpeerfilesinvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	76109589-66b2-4854-9568-357499e913af
97	replacepeerfilesinvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	81f75b6f-4ef8-47b6-b9ae-2d415fa792ae
98	deletepeerfilesinvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	4f39449d-bcab-407b-827c-67e7d09dd847
99	editpeerimagesinvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	f0479387-52e9-4005-a4bd-fdb1a4e61d48
100	viewpeerfilesinvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	d387a509-ccc1-4c50-ad53-75e69abe8df1
101	viewvolume:8e9ec71e-2cf0-4f6a-b856-8976de0ce100	2022-04-15 04:01:18	2022-04-15 04:01:18	201a0727-f739-420c-8eb1-f5e254005ecb
102	saveassetinvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	63a162bc-7fb4-4a03-b349-44f36b7d2b74
103	createfoldersinvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	3178c65f-5403-4579-905b-ca86ad2f161e
104	deletefilesandfoldersinvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	e87a38df-519c-4e34-9d31-120d1a28a37d
105	replacefilesinvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	06fbc67d-fac7-4e09-a3e2-5b5ffaaab3e8
106	editimagesinvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	855eb80b-b92f-4aaf-9e85-90bdfe0d2a36
107	editpeerfilesinvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	56d3c064-62e2-441e-a9f6-54751955cf39
108	replacepeerfilesinvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	6d7f9eac-32b1-43fd-9106-07f88c653339
109	deletepeerfilesinvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	4186f7e9-0339-4911-ba47-54fcb849abd3
110	editpeerimagesinvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	142106a6-c0e7-4389-8734-96fd3c7893a8
111	viewpeerfilesinvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	d8c2e1c0-fce2-446f-95bd-63c608d8267a
112	viewvolume:cd6f2275-4f9b-4ba4-aa4c-7c7468366172	2022-04-15 04:01:18	2022-04-15 04:01:18	5d15c470-7d83-4415-91b1-e67ad3d43c82
113	saveassetinvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	f58bb074-b099-4928-a8eb-6608fd5eba7f
114	createfoldersinvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	0063bc4b-5bd5-4992-92f6-5b626d75dc95
115	deletefilesandfoldersinvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	5dd43701-a715-4d81-812a-36131094d575
116	replacefilesinvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	a83f7452-1073-455b-86b9-3e2c4c2fe246
117	editimagesinvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	40329151-1b73-446b-83ef-fe1d0ec3e8dd
118	editpeerfilesinvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	5dcd7eea-4d9d-4283-a2b7-cbc2f899c38f
119	replacepeerfilesinvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	0b969513-f09f-4502-b7ab-8544ec90795d
120	deletepeerfilesinvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	054f5791-0e4b-42fc-b122-30105eeee89e
121	editpeerimagesinvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	e565364f-1c66-49e4-bd9e-cef93530f9c3
122	viewpeerfilesinvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	c7dffd74-ded1-44cb-95cc-ba8302da3c44
123	viewvolume:f944dd79-91a6-443d-b09a-de2597c7557f	2022-04-15 04:01:18	2022-04-15 04:01:18	ccee84b0-4ee6-4f9a-a3e9-b63aa9fe8cf2
124	saveassetinvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	8d3c4d6a-2872-4718-a7b9-9ce98d778c40
125	createfoldersinvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	0fd95af2-5faa-4721-bd9d-dcced722b852
126	deletefilesandfoldersinvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	90f770aa-dd28-43fd-ba38-b6566e28544f
127	replacefilesinvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	5e2bfb83-8983-4c09-8d27-e6b8c2207c54
128	editimagesinvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	a005089f-3f0d-41ff-81de-230b6d7923a8
129	editpeerfilesinvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	1dad5999-ea4d-4a91-ad17-329e7223e8eb
130	replacepeerfilesinvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	6793d42f-6a74-4149-8748-b4bc940bcd23
131	deletepeerfilesinvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	71222315-7167-4cfd-b36b-0f220b039432
132	editpeerimagesinvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	5dabef0f-e092-462e-944b-345052560b15
133	viewpeerfilesinvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	d8fa6126-45a0-446a-9361-dca1e8672980
134	viewvolume:f52f3e9c-434e-43b5-89eb-a5776e6bc4a6	2022-04-15 04:01:18	2022-04-15 04:01:18	2e07ee8c-0951-4d2e-a6e5-e9af3a586315
135	saveassetinvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	4f953aa7-c49a-4fe6-9a70-3ab894c6eca6
136	createfoldersinvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	bd3b2eb6-aaf0-4b31-b6ef-85b12110d9e3
137	deletefilesandfoldersinvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	cc588d6a-eaec-4bf4-bf82-0e65b2aa0a0a
138	replacefilesinvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	152de425-e4e5-4714-aa7b-ec0208b75fc5
139	editimagesinvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	95d3fc5c-9691-4b6e-be6d-e6f550338728
140	editpeerfilesinvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	eb9cb66d-283d-4d1e-be4d-2e213d4062ee
141	replacepeerfilesinvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	45bf9117-ea40-4373-9f28-555d38003178
142	deletepeerfilesinvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	ccc19313-d428-42c0-b716-a0b44ee9c42b
143	editpeerimagesinvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	f7f8f484-fc7e-4ef0-8493-d5c9ff2c3fc5
144	viewpeerfilesinvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	c159d291-f7cf-4658-a40f-4bc85a983c53
145	viewvolume:18a75c63-648f-4145-9cc3-386e7c8a0106	2022-04-15 04:01:18	2022-04-15 04:01:18	7b9e144e-3e86-4aef-9735-7746ad2ecdd5
146	saveassetinvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	a0c030d2-f7ba-4bd3-a37d-bd7e194577cf
147	createfoldersinvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	b24cf14a-7b0a-4baf-9e0b-caf09206d744
148	deletefilesandfoldersinvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	198f76fd-42a4-45c1-93de-bf8a1eedc8da
149	replacefilesinvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	613771fd-8378-48e3-bc4f-6cbbc9d9de66
150	editimagesinvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	952dd444-fa7c-48a8-b497-402c9e91d661
151	editpeerfilesinvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	ffc1c14f-d680-4178-8033-012a23d87597
152	replacepeerfilesinvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	ba55ad77-bb73-4fda-badc-7690630bcef0
153	deletepeerfilesinvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	28c65fff-b990-4f8c-b200-c317a013b48b
154	editpeerimagesinvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	28b8f9fc-6181-4528-999d-9c3beefabe4a
155	viewpeerfilesinvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	66d8b0bc-8f1a-4496-892c-0391c5391b8e
156	viewvolume:c3d1c243-1703-4117-abc7-88487a1f8f24	2022-04-15 04:01:18	2022-04-15 04:01:18	89934e8c-7cf5-49fa-ab5b-efcfba675f17
157	saveassetinvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	47d26ddc-2030-4e00-8894-f4eb1e1df995
158	createfoldersinvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	e4a7b18a-8bba-4887-91bf-673b6fd240e1
159	deletefilesandfoldersinvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	3d3488bc-a221-4a00-af65-b03579b8d615
160	replacefilesinvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	ac4e9391-0e52-4d5b-acd6-8c4a561d53ae
161	editimagesinvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	375695fc-4d99-4281-b344-eec6348408ac
162	editpeerfilesinvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	c32dfbe6-2593-49b0-985b-c79a7a58dac8
163	replacepeerfilesinvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	37f3be1e-044b-4fd8-8d28-dfdcef832daa
164	deletepeerfilesinvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	085f8ac2-2c26-45bb-aa1d-8eecbb2c8257
165	editpeerimagesinvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	24337f5c-0b4c-4894-a33c-4d045dff7554
166	viewpeerfilesinvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	65d2995e-a076-481c-8387-8317be4aeb3d
167	viewvolume:d41cc960-99a4-41a8-a7a6-7891a22e4a93	2022-04-15 04:01:18	2022-04-15 04:01:18	de04102e-5a61-4cbd-9153-b02b46ac8b82
\.


--
-- Data for Name: userpermissions_usergroups; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.userpermissions_usergroups (id, "permissionId", "groupId", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: userpermissions_users; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.userpermissions_users (id, "permissionId", "userId", "dateCreated", "dateUpdated", uid) FROM stdin;
\.


--
-- Data for Name: userpreferences; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.userpreferences ("userId", preferences) FROM stdin;
12	{"language":"en-US","locale":null,"weekStartDay":"1","alwaysShowFocusRings":false,"useShapes":false,"underlineLinks":false,"showFieldHandles":false,"enableDebugToolbarForSite":false,"enableDebugToolbarForCp":false,"showExceptionView":false,"profileTemplates":false}
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.users (id, username, "photoId", "firstName", "lastName", email, password, admin, locked, suspended, pending, "lastLoginDate", "lastLoginAttemptIp", "invalidLoginWindowStart", "invalidLoginCount", "lastInvalidLoginDate", "lockoutDate", "hasDashboard", "verificationCode", "verificationCodeIssuedDate", "unverifiedEmail", "passwordResetRequired", "lastPasswordChangeDate", "dateCreated", "dateUpdated", uid) FROM stdin;
12	example	\N			epo@lsst.org	$2y$13$4K1JypTMtl3ZENkWz8DdU.o6ojCA9QYDQb1yBGlBduS4YP/foiaFC	t	f	f	f	2022-04-17 17:04:45	\N	\N	\N	\N	\N	t	\N	\N	\N	f	2022-04-17 17:03:17	2022-04-15 04:01:35	2022-04-17 17:04:46	efcd02a6-1737-4c93-903e-e027e38ec3e7
\.


--
-- Data for Name: volumefolders; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.volumefolders (id, "parentId", "volumeId", name, path, "dateCreated", "dateUpdated", uid) FROM stdin;
1	\N	1	Asset Variants		2022-04-15 04:01:08	2022-04-15 04:01:08	1111111f-c47f-40d2-afdb-82f50fe956d0
2	\N	2	Callout Images		2022-04-15 04:01:09	2022-04-15 04:01:09	15561953-c552-4a54-a052-2aa082927938
3	\N	3	Content Images		2022-04-15 04:01:17	2022-04-15 04:01:17	1fc61ec4-eda5-4949-a868-b91f5e7b75b3
4	\N	4	Heroes		2022-04-15 04:01:17	2022-04-15 04:01:17	ce18150c-2a80-4e8e-949c-6259b4db1613
5	\N	5	General		2022-04-15 04:01:17	2022-04-15 04:01:17	8a1e741e-e737-42d6-9ad5-1508cad44927
6	\N	6	Staff Profiles		2022-04-15 04:01:17	2022-04-15 04:01:17	ab8c0bca-5b7e-4ce4-9cdf-e454414cbd82
7	\N	7	Canto DAM		2022-04-15 04:01:18	2022-04-15 04:01:18	44e0ebd9-9dc0-4eab-a1b7-447268a1d630
8	\N	\N	Temporary source	\N	2022-04-15 04:06:00	2022-04-15 04:06:00	7947e054-105e-46b3-9b46-abd35692eda1
9	8	\N	user_12	user_12/	2022-04-15 04:06:00	2022-04-15 04:06:00	d269e792-1c12-454c-bbf4-f8f023cfd9ae
\.


--
-- Data for Name: volumes; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.volumes (id, "fieldLayoutId", name, handle, type, "hasUrls", url, "titleTranslationMethod", "titleTranslationKeyFormat", settings, "sortOrder", "dateCreated", "dateUpdated", "dateDeleted", uid) FROM stdin;
7	59	Canto DAM	cantoDam	rosas\\dam\\volumes\\DAMVolume	t	$CANTO_ASSET_BASEURL	site	\N	{"quickTest":"eric"}	9	2022-04-15 04:01:18	2022-04-15 04:01:18	\N	7754bae8-c6eb-4fbe-882b-236621e35f2d
4	35	Heroes	heroes	craft\\googlecloud\\Volume	t	@assetsHeroesBaseURL	site	\N	{"bucket":"rubin-obs-api_assets_heroes","bucketSelectionMode":"choose","expires":"5 minutes","keyFileContents":"","projectId":"$GCP_PROJECT_ID","subfolder":""}	1	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:06:47	8e9ec71e-2cf0-4f6a-b856-8976de0ce100
3	33	Content Images	contentImages	craft\\googlecloud\\Volume	t	@assetsContentBaseURL	site	\N	{"bucket":"rubin-obs-api_assets_content","bucketSelectionMode":"choose","expires":"5 minutes","keyFileContents":"","projectId":"$GCP_PROJECT_ID","subfolder":""}	2	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:06:53	cd6f2275-4f9b-4ba4-aa4c-7c7468366172
2	6	Callout Images	calloutImages	craft\\googlecloud\\Volume	t	https://storage.googleapis.com/rubin-obs-api_assets_callouts/	site	\N	{"bucket":"rubin-obs-api_assets_callouts","bucketSelectionMode":"choose","expires":"","keyFileContents":"","projectId":"$GCP_PROJECT_ID","subfolder":""}	5	2022-04-15 04:01:09	2022-04-15 04:01:09	2022-04-15 04:06:58	f52f3e9c-434e-43b5-89eb-a5776e6bc4a6
5	37	General	generalImages	craft\\googlecloud\\Volume	t	@assetsGeneralBaseURL	site	\N	{"bucket":"rubin-obs-api_assets_general","bucketSelectionMode":"choose","expires":"5 minutes","keyFileContents":"","projectId":"$GCP_PROJECT_ID","subfolder":""}	6	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:07:02	18a75c63-648f-4145-9cc3-386e7c8a0106
6	39	Staff Profiles	staffProfiles	craft\\googlecloud\\Volume	t	@assetsStaffBaseURL	site	\N	{"bucket":"rubin-obs-api_assets_staff_profiles","bucketSelectionMode":"choose","expires":"5 minutes","keyFileContents":"","projectId":"$GCP_PROJECT_ID","subfolder":""}	7	2022-04-15 04:01:17	2022-04-15 04:01:17	2022-04-15 04:07:06	c3d1c243-1703-4117-abc7-88487a1f8f24
1	1	Asset Variants	assetVariants	craft\\awss3\\Volume	t	@assetsAssetVariantBaseURL	site	\N	{"addSubfolderToRootUrl":"1","autoFocalPoint":"","bucket":"$AWS_ASSET_S3_BUCKET","bucketSelectionMode":"manual","cfDistributionId":"","cfPrefix":"","expires":"","keyId":"$AWS_ASSET_KEY_ID","makeUploadsPublic":"1","region":"$AWS_ASSET_S3_REGION","secret":"$AWS_ASSET_SECRET_KEY","storageClass":"","subfolder":"$AWS_ASSET_S3_ASSET_VARIANT_SUBFOLDER"}	8	2022-04-15 04:01:08	2022-04-15 04:01:08	2022-04-15 04:07:17	d41cc960-99a4-41a8-a7a6-7891a22e4a93
\.


--
-- Data for Name: widgets; Type: TABLE DATA; Schema: public; Owner: craft
--

COPY public.widgets (id, "userId", type, "sortOrder", colspan, settings, enabled, "dateCreated", "dateUpdated", uid) FROM stdin;
1	12	craft\\widgets\\RecentEntries	1	\N	{"siteId":1,"section":"*","limit":10}	t	2022-04-15 04:19:15	2022-04-15 04:19:15	eb7e3111-6d5d-4797-b94f-da849b16cd3a
2	12	craft\\widgets\\CraftSupport	2	\N	[]	t	2022-04-15 04:19:15	2022-04-15 04:19:15	54376e78-d95d-4693-a142-62a45c3342f5
3	12	craft\\widgets\\Updates	3	\N	[]	t	2022-04-15 04:19:15	2022-04-15 04:19:15	e99d2173-39a9-405d-88c0-64d84b1776c7
4	12	craft\\widgets\\Feed	4	\N	{"url":"https://craftcms.com/news.rss","title":"Craft News","limit":5}	t	2022-04-15 04:19:15	2022-04-15 04:19:15	e8206578-2dcd-407b-a79d-e0951d415787
\.


--
-- Name: announcements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.announcements_id_seq', 1, false);


--
-- Name: assetindexdata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.assetindexdata_id_seq', 1, false);


--
-- Name: assettransformindex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.assettransformindex_id_seq', 1, false);


--
-- Name: assettransforms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.assettransforms_id_seq', 1, false);


--
-- Name: categorygroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.categorygroups_id_seq', 8, true);


--
-- Name: categorygroups_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.categorygroups_sites_id_seq', 16, true);


--
-- Name: content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.content_id_seq', 97, true);


--
-- Name: craftidtokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.craftidtokens_id_seq', 1, false);


--
-- Name: deprecationerrors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.deprecationerrors_id_seq', 34, true);


--
-- Name: drafts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.drafts_id_seq', 9, true);


--
-- Name: elementindexsettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.elementindexsettings_id_seq', 1, false);


--
-- Name: elements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.elements_id_seq', 49, true);


--
-- Name: elements_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.elements_sites_id_seq', 97, true);


--
-- Name: entrytypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.entrytypes_id_seq', 18, true);


--
-- Name: fieldgroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.fieldgroups_id_seq', 11, true);


--
-- Name: fieldlayoutfields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.fieldlayoutfields_id_seq', 524, true);


--
-- Name: fieldlayouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.fieldlayouts_id_seq', 89, true);


--
-- Name: fieldlayouttabs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.fieldlayouttabs_id_seq', 267, true);


--
-- Name: fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.fields_id_seq', 141, true);


--
-- Name: globalsets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.globalsets_id_seq', 1, false);


--
-- Name: gqlschemas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.gqlschemas_id_seq', 3, true);


--
-- Name: gqltokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.gqltokens_id_seq', 1, true);


--
-- Name: info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.info_id_seq', 1, false);


--
-- Name: lenz_linkfield_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.lenz_linkfield_id_seq', 1, false);


--
-- Name: matrixblocktypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.matrixblocktypes_id_seq', 14, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.migrations_id_seq', 228, true);


--
-- Name: neoblockstructures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.neoblockstructures_id_seq', 38, true);


--
-- Name: neoblocktypegroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.neoblocktypegroups_id_seq', 1, false);


--
-- Name: neoblocktypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.neoblocktypes_id_seq', 35, true);


--
-- Name: plugins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.plugins_id_seq', 11, true);


--
-- Name: queue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.queue_id_seq', 179, true);


--
-- Name: relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.relations_id_seq', 1, false);


--
-- Name: revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.revisions_id_seq', 17, true);


--
-- Name: sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.sections_id_seq', 14, true);


--
-- Name: sections_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.sections_sites_id_seq', 28, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.sessions_id_seq', 8, true);


--
-- Name: shunnedmessages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.shunnedmessages_id_seq', 1, false);


--
-- Name: sitegroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.sitegroups_id_seq', 1, true);


--
-- Name: sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.sites_id_seq', 2, true);


--
-- Name: structureelements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.structureelements_id_seq', 50, true);


--
-- Name: structures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.structures_id_seq', 31, true);


--
-- Name: supertableblocktypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.supertableblocktypes_id_seq', 1, true);


--
-- Name: systemmessages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.systemmessages_id_seq', 1, false);


--
-- Name: taggroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.taggroups_id_seq', 2, true);


--
-- Name: templatecacheelements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.templatecacheelements_id_seq', 1, false);


--
-- Name: templatecachequeries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.templatecachequeries_id_seq', 1, false);


--
-- Name: templatecaches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.templatecaches_id_seq', 1, false);


--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.tokens_id_seq', 1, false);


--
-- Name: universaldamintegrator_asset_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.universaldamintegrator_asset_metadata_id_seq', 1, false);


--
-- Name: usergroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.usergroups_id_seq', 3, true);


--
-- Name: usergroups_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.usergroups_users_id_seq', 1, false);


--
-- Name: userpermissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.userpermissions_id_seq', 167, true);


--
-- Name: userpermissions_usergroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.userpermissions_usergroups_id_seq', 167, true);


--
-- Name: userpermissions_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.userpermissions_users_id_seq', 1, false);


--
-- Name: userpreferences_userId_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public."userpreferences_userId_seq"', 1, false);


--
-- Name: volumefolders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.volumefolders_id_seq', 9, true);


--
-- Name: volumes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.volumes_id_seq', 7, true);


--
-- Name: widgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: craft
--

SELECT pg_catalog.setval('public.widgets_id_seq', 4, true);


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: assetindexdata assetindexdata_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assetindexdata
    ADD CONSTRAINT assetindexdata_pkey PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: assettransformindex assettransformindex_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assettransformindex
    ADD CONSTRAINT assettransformindex_pkey PRIMARY KEY (id);


--
-- Name: assettransforms assettransforms_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assettransforms
    ADD CONSTRAINT assettransforms_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categorygroups categorygroups_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categorygroups
    ADD CONSTRAINT categorygroups_pkey PRIMARY KEY (id);


--
-- Name: categorygroups_sites categorygroups_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categorygroups_sites
    ADD CONSTRAINT categorygroups_sites_pkey PRIMARY KEY (id);


--
-- Name: changedattributes changedattributes_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.changedattributes
    ADD CONSTRAINT changedattributes_pkey PRIMARY KEY ("elementId", "siteId", attribute);


--
-- Name: changedfields changedfields_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.changedfields
    ADD CONSTRAINT changedfields_pkey PRIMARY KEY ("elementId", "siteId", "fieldId");


--
-- Name: content content_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_pkey PRIMARY KEY (id);


--
-- Name: craftidtokens craftidtokens_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.craftidtokens
    ADD CONSTRAINT craftidtokens_pkey PRIMARY KEY (id);


--
-- Name: deprecationerrors deprecationerrors_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.deprecationerrors
    ADD CONSTRAINT deprecationerrors_pkey PRIMARY KEY (id);


--
-- Name: drafts drafts_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT drafts_pkey PRIMARY KEY (id);


--
-- Name: elementindexsettings elementindexsettings_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elementindexsettings
    ADD CONSTRAINT elementindexsettings_pkey PRIMARY KEY (id);


--
-- Name: elements elements_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT elements_pkey PRIMARY KEY (id);


--
-- Name: elements_sites elements_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elements_sites
    ADD CONSTRAINT elements_sites_pkey PRIMARY KEY (id);


--
-- Name: entries entries_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT entries_pkey PRIMARY KEY (id);


--
-- Name: entrytypes entrytypes_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.entrytypes
    ADD CONSTRAINT entrytypes_pkey PRIMARY KEY (id);


--
-- Name: fieldgroups fieldgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldgroups
    ADD CONSTRAINT fieldgroups_pkey PRIMARY KEY (id);


--
-- Name: fieldlayoutfields fieldlayoutfields_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldlayoutfields
    ADD CONSTRAINT fieldlayoutfields_pkey PRIMARY KEY (id);


--
-- Name: fieldlayouts fieldlayouts_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldlayouts
    ADD CONSTRAINT fieldlayouts_pkey PRIMARY KEY (id);


--
-- Name: fieldlayouttabs fieldlayouttabs_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldlayouttabs
    ADD CONSTRAINT fieldlayouttabs_pkey PRIMARY KEY (id);


--
-- Name: fields fields_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_pkey PRIMARY KEY (id);


--
-- Name: globalsets globalsets_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.globalsets
    ADD CONSTRAINT globalsets_pkey PRIMARY KEY (id);


--
-- Name: gql_refresh_tokens gql_refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.gql_refresh_tokens
    ADD CONSTRAINT gql_refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: gqlschemas gqlschemas_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.gqlschemas
    ADD CONSTRAINT gqlschemas_pkey PRIMARY KEY (id);


--
-- Name: gqltokens gqltokens_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.gqltokens
    ADD CONSTRAINT gqltokens_pkey PRIMARY KEY (id);


--
-- Name: info info_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.info
    ADD CONSTRAINT info_pkey PRIMARY KEY (id);


--
-- Name: lenz_linkfield lenz_linkfield_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.lenz_linkfield
    ADD CONSTRAINT lenz_linkfield_pkey PRIMARY KEY (id);


--
-- Name: matrixblocks matrixblocks_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.matrixblocks
    ADD CONSTRAINT matrixblocks_pkey PRIMARY KEY (id);


--
-- Name: matrixblocktypes matrixblocktypes_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.matrixblocktypes
    ADD CONSTRAINT matrixblocktypes_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: neoblocks neoblocks_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocks
    ADD CONSTRAINT neoblocks_pkey PRIMARY KEY (id);


--
-- Name: neoblockstructures neoblockstructures_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblockstructures
    ADD CONSTRAINT neoblockstructures_pkey PRIMARY KEY (id);


--
-- Name: neoblocktypegroups neoblocktypegroups_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocktypegroups
    ADD CONSTRAINT neoblocktypegroups_pkey PRIMARY KEY (id);


--
-- Name: neoblocktypes neoblocktypes_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocktypes
    ADD CONSTRAINT neoblocktypes_pkey PRIMARY KEY (id);


--
-- Name: searchindex pk_ibdvuzkyzuxcvdkouevqkpydxaxjrzqunexv; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.searchindex
    ADD CONSTRAINT pk_ibdvuzkyzuxcvdkouevqkpydxaxjrzqunexv PRIMARY KEY ("elementId", attribute, "fieldId", "siteId");


--
-- Name: plugins plugins_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_pkey PRIMARY KEY (id);


--
-- Name: projectconfig projectconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.projectconfig
    ADD CONSTRAINT projectconfig_pkey PRIMARY KEY (path);


--
-- Name: queue queue_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.queue
    ADD CONSTRAINT queue_pkey PRIMARY KEY (id);


--
-- Name: relations relations_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT relations_pkey PRIMARY KEY (id);


--
-- Name: resourcepaths resourcepaths_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.resourcepaths
    ADD CONSTRAINT resourcepaths_pkey PRIMARY KEY (hash);


--
-- Name: revisions revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT revisions_pkey PRIMARY KEY (id);


--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: sections_sites sections_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sections_sites
    ADD CONSTRAINT sections_sites_pkey PRIMARY KEY (id);


--
-- Name: sequences sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sequences
    ADD CONSTRAINT sequences_pkey PRIMARY KEY (name);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: shunnedmessages shunnedmessages_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.shunnedmessages
    ADD CONSTRAINT shunnedmessages_pkey PRIMARY KEY (id);


--
-- Name: sitegroups sitegroups_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sitegroups
    ADD CONSTRAINT sitegroups_pkey PRIMARY KEY (id);


--
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);


--
-- Name: structureelements structureelements_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.structureelements
    ADD CONSTRAINT structureelements_pkey PRIMARY KEY (id);


--
-- Name: structures structures_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.structures
    ADD CONSTRAINT structures_pkey PRIMARY KEY (id);


--
-- Name: supertableblocks supertableblocks_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.supertableblocks
    ADD CONSTRAINT supertableblocks_pkey PRIMARY KEY (id);


--
-- Name: supertableblocktypes supertableblocktypes_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.supertableblocktypes
    ADD CONSTRAINT supertableblocktypes_pkey PRIMARY KEY (id);


--
-- Name: systemmessages systemmessages_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.systemmessages
    ADD CONSTRAINT systemmessages_pkey PRIMARY KEY (id);


--
-- Name: taggroups taggroups_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.taggroups
    ADD CONSTRAINT taggroups_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: templatecacheelements templatecacheelements_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.templatecacheelements
    ADD CONSTRAINT templatecacheelements_pkey PRIMARY KEY (id);


--
-- Name: templatecachequeries templatecachequeries_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.templatecachequeries
    ADD CONSTRAINT templatecachequeries_pkey PRIMARY KEY (id);


--
-- Name: templatecaches templatecaches_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.templatecaches
    ADD CONSTRAINT templatecaches_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: universaldamintegrator_asset_metadata universaldamintegrator_asset_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.universaldamintegrator_asset_metadata
    ADD CONSTRAINT universaldamintegrator_asset_metadata_pkey PRIMARY KEY (id);


--
-- Name: usergroups usergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_pkey PRIMARY KEY (id);


--
-- Name: usergroups_users usergroups_users_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.usergroups_users
    ADD CONSTRAINT usergroups_users_pkey PRIMARY KEY (id);


--
-- Name: userpermissions userpermissions_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpermissions
    ADD CONSTRAINT userpermissions_pkey PRIMARY KEY (id);


--
-- Name: userpermissions_usergroups userpermissions_usergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpermissions_usergroups
    ADD CONSTRAINT userpermissions_usergroups_pkey PRIMARY KEY (id);


--
-- Name: userpermissions_users userpermissions_users_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpermissions_users
    ADD CONSTRAINT userpermissions_users_pkey PRIMARY KEY (id);


--
-- Name: userpreferences userpreferences_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpreferences
    ADD CONSTRAINT userpreferences_pkey PRIMARY KEY ("userId");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: volumefolders volumefolders_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.volumefolders
    ADD CONSTRAINT volumefolders_pkey PRIMARY KEY (id);


--
-- Name: volumes volumes_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.volumes
    ADD CONSTRAINT volumes_pkey PRIMARY KEY (id);


--
-- Name: widgets widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.widgets
    ADD CONSTRAINT widgets_pkey PRIMARY KEY (id);


--
-- Name: idx_acpewvmvqtrncmqmkafkcdgsicdrogaznnkb; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_acpewvmvqtrncmqmkafkcdgsicdrogaznnkb ON public.sections USING btree ("structureId");


--
-- Name: idx_anmyagpokaszlgklcsvcpckwevvirkcdnqof; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_anmyagpokaszlgklcsvcpckwevvirkcdnqof ON public.universaldamintegrator_asset_metadata USING btree ("assetId");


--
-- Name: idx_aobttxjtwxtwvypuosrlmvjsgulnuglunomw; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_aobttxjtwxtwvypuosrlmvjsgulnuglunomw ON public.categorygroups USING btree ("fieldLayoutId");


--
-- Name: idx_apjopwfoyerqmoxwzpaqqselbvssddkhkuto; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_apjopwfoyerqmoxwzpaqqselbvssddkhkuto ON public.templatecachequeries USING btree (type);


--
-- Name: idx_aynwpbnatefdrucruxfnnnouxnxlmscvpepx; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_aynwpbnatefdrucruxfnnnouxnxlmscvpepx ON public.structures USING btree ("dateDeleted");


--
-- Name: idx_bmsrrlpkxlkafeiegiecivuayjcnzvwizvro; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_bmsrrlpkxlkafeiegiecivuayjcnzvwizvro ON public.gqltokens USING btree ("accessToken");


--
-- Name: idx_botlpdqfoixxplrbtnvlxcxsgrtndtughlxy; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_botlpdqfoixxplrbtnvlxcxsgrtndtughlxy ON public.structureelements USING btree (lft);


--
-- Name: idx_brjulzedlzqmpwyxotbhfxwhxprzzxvahupn; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_brjulzedlzqmpwyxotbhfxwhxprzzxvahupn ON public.volumes USING btree (handle);


--
-- Name: idx_btsbxvljehoejbddmtdvzqhzidfnudrmnunh; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_btsbxvljehoejbddmtdvzqhzidfnudrmnunh ON public.neoblocktypes USING btree ("fieldLayoutId");


--
-- Name: idx_bxuwarwfepcbkuekucpfspjoiwzggwuqrpan; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_bxuwarwfepcbkuekucpfspjoiwzggwuqrpan ON public.fieldlayouts USING btree (type);


--
-- Name: idx_cijkhsnvmkduzttedknjvvcjocqtvopvdvhv; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_cijkhsnvmkduzttedknjvvcjocqtvopvdvhv ON public.relations USING btree ("fieldId", "sourceId", "sourceSiteId", "targetId");


--
-- Name: idx_clolibrsynmmtjgyfwalxvmkwrztqapnvcjb; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_clolibrsynmmtjgyfwalxvmkwrztqapnvcjb ON public.lenz_linkfield USING btree ("fieldId");


--
-- Name: idx_cpnurwkskqjmsvmcjgfilktvdmqznwrrrtvz; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_cpnurwkskqjmsvmcjgfilktvdmqznwrrrtvz ON public.assets USING btree ("volumeId");


--
-- Name: idx_cqivhmoqpxdexswvyoiuldxyodxvempeioha; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_cqivhmoqpxdexswvyoiuldxyodxvempeioha ON public.elements USING btree ("dateDeleted");


--
-- Name: idx_csmjdaxvezgkexfpeamyowvcodbcdpaovcqw; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_csmjdaxvezgkexfpeamyowvcodbcdpaovcqw ON public.supertableblocks USING btree ("ownerId");


--
-- Name: idx_cstslcanwyglrszyebmjaxylbazdyrdtqbzf; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_cstslcanwyglrszyebmjaxylbazdyrdtqbzf ON public.queue USING btree (channel, fail, "timeUpdated", "timePushed");


--
-- Name: idx_czxnbtkgmeejbmzvcybuuuglbjkzvilujhis; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_czxnbtkgmeejbmzvcybuuuglbjkzvilujhis ON public.elements USING btree (type);


--
-- Name: idx_dajphvqulaewzcvvvuymofhwiicrebqhqput; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_dajphvqulaewzcvvvuymofhwiicrebqhqput ON public.categorygroups USING btree ("dateDeleted");


--
-- Name: idx_dauewmrjbhppberkgogkzauqexlndeobclnx; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_dauewmrjbhppberkgogkzauqexlndeobclnx ON public.structureelements USING btree ("structureId", "elementId");


--
-- Name: idx_dbbbdsghycrelaanmjsiqjkukrzbyhtzmgzx; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_dbbbdsghycrelaanmjsiqjkukrzbyhtzmgzx ON public.sites USING btree ("sortOrder");


--
-- Name: idx_dfibckrrazfahdosjjhudwmenhcmxmsdiwgj; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_dfibckrrazfahdosjjhudwmenhcmxmsdiwgj ON public.neoblocks USING btree ("typeId");


--
-- Name: idx_dfnxxgfjxlmzhibesshftfzyznuyhijyinbj; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_dfnxxgfjxlmzhibesshftfzyznuyhijyinbj ON public.tags USING btree ("groupId");


--
-- Name: idx_djcazdzqyyfqsdusicgwavrveidacrgbzczt; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_djcazdzqyyfqsdusicgwavrveidacrgbzczt ON public.fieldlayoutfields USING btree ("layoutId", "fieldId");


--
-- Name: idx_dljyonuhaturyowcstkumclkrmlonghyuwjo; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_dljyonuhaturyowcstkumclkrmlonghyuwjo ON public.neoblockstructures USING btree ("ownerSiteId");


--
-- Name: idx_dsagwbsrtigvsaianiwpbxumiapbiwdmmkda; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_dsagwbsrtigvsaianiwpbxumiapbiwdmmkda ON public.sections USING btree (name);


--
-- Name: idx_ecrtchvlwhaaokfrqgknshqeqtacnpplutzq; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ecrtchvlwhaaokfrqgknshqeqtacnpplutzq ON public.sessions USING btree ("dateUpdated");


--
-- Name: idx_ectvmvhgbyocvheamwiqowbyyzbfgxkxbtel; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_ectvmvhgbyocvheamwiqowbyyzbfgxkxbtel ON public.userpermissions USING btree (name);


--
-- Name: idx_eeonpfmrinoljxhpvrzvmhgvzzmactdjhnva; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_eeonpfmrinoljxhpvrzvmhgvzzmactdjhnva ON public.globalsets USING btree (handle);


--
-- Name: idx_efmlwchowiiumwjhzndgpbrfjfsuawhgjfss; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_efmlwchowiiumwjhzndgpbrfjfsuawhgjfss ON public.templatecachequeries USING btree ("cacheId");


--
-- Name: idx_ehbdatbimngfvjltijizxbexkrbyvhnsqrbt; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ehbdatbimngfvjltijizxbexkrbyvhnsqrbt ON public.relations USING btree ("sourceId");


--
-- Name: idx_eiuolkmhyatpqtgjdybasxovpqiwuosshgnw; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_eiuolkmhyatpqtgjdybasxovpqiwuosshgnw ON public.shunnedmessages USING btree ("userId", message);


--
-- Name: idx_elzbttgpkmfhhsbaqwbodfayzvbhpzmyvqve; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_elzbttgpkmfhhsbaqwbodfayzvbhpzmyvqve ON public.usergroups USING btree (name);


--
-- Name: idx_etmtjgekbcjgmzwdjsmsrbkjcgdrnxfbfexq; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_etmtjgekbcjgmzwdjsmsrbkjcgdrnxfbfexq ON public.plugins USING btree (handle);


--
-- Name: idx_euksyrzfvsmjwwfokzjgqzodyitglqofpxkb; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_euksyrzfvsmjwwfokzjgqzodyitglqofpxkb ON public.volumefolders USING btree ("parentId");


--
-- Name: idx_evgmbcvvzmniknkyakdzgpkktegvhaevwxkq; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_evgmbcvvzmniknkyakdzgpkktegvhaevwxkq ON public.usergroups_users USING btree ("groupId", "userId");


--
-- Name: idx_ezpypoxoxbkywhfdnbghgixyjqplvjhpyozv; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ezpypoxoxbkywhfdnbghgixyjqplvjhpyozv ON public.users USING btree (lower((email)::text));


--
-- Name: idx_famipuvullxbbqsmgmimacgdqcjnrgpxiovx; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_famipuvullxbbqsmgmimacgdqcjnrgpxiovx ON public.globalsets USING btree ("sortOrder");


--
-- Name: idx_fcdlpvicvsfptqjfcezviyexxmahgzwvumnz; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_fcdlpvicvsfptqjfcezviyexxmahgzwvumnz ON public.fields USING btree (context);


--
-- Name: idx_fdvkcjynrbrbsqzgfjrffpjzyjaettbrmjgf; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_fdvkcjynrbrbsqzgfjrffpjzyjaettbrmjgf ON public.assetindexdata USING btree ("sessionId", "volumeId");


--
-- Name: idx_fdzblaskuzkccdyazzuubppuiscehvawqsgt; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_fdzblaskuzkccdyazzuubppuiscehvawqsgt ON public.widgets USING btree ("userId");


--
-- Name: idx_fnkieidfqtrcmhiyrcphyjthwhhzpluclzor; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_fnkieidfqtrcmhiyrcphyjthwhhzpluclzor ON public.structureelements USING btree (rgt);


--
-- Name: idx_ftgtbmtczmqhykdcuxxybropykawwpuszmcu; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ftgtbmtczmqhykdcuxxybropykawwpuszmcu ON public.templatecaches USING btree ("siteId");


--
-- Name: idx_fzkwhobnrhcyjattlgjqtqnnxkrpphuknvfl; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_fzkwhobnrhcyjattlgjqtqnnxkrpphuknvfl ON public.queue USING btree (channel, fail, "timeUpdated", delay);


--
-- Name: idx_gakbngefwhpuwvokllwaxkgzitwnxdqqfsel; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_gakbngefwhpuwvokllwaxkgzitwnxdqqfsel ON public.userpermissions_usergroups USING btree ("groupId");


--
-- Name: idx_gegzntmqkwqlxueestiithntzlccqfgirqxr; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_gegzntmqkwqlxueestiithntzlccqfgirqxr ON public.sites USING btree (handle);


--
-- Name: idx_gidinqoofaesphtzqwdnlfvaebhopzekjhmn; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_gidinqoofaesphtzqwdnlfvaebhopzekjhmn ON public.sitegroups USING btree (name);


--
-- Name: idx_gljmiscbnvmyftvrixjpnhwijujwdmhndoow; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_gljmiscbnvmyftvrixjpnhwijujwdmhndoow ON public.elements_sites USING btree (slug, "siteId");


--
-- Name: idx_gpilhzhytoezoggaqzhtgjdgxnarkgwvwhhc; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_gpilhzhytoezoggaqzhtgjdgxnarkgwvwhhc ON public.elements_sites USING btree (enabled);


--
-- Name: idx_gqnzbkcvosohtwfbeflsbktxkkdjlynxctve; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_gqnzbkcvosohtwfbeflsbktxkkdjlynxctve ON public.tokens USING btree ("expiryDate");


--
-- Name: idx_hlvqgmxqnrdgwbyikxrddglbdwgviajebvln; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_hlvqgmxqnrdgwbyikxrddglbdwgviajebvln ON public.entrytypes USING btree ("fieldLayoutId");


--
-- Name: idx_hmwtnisshceudkbtyfamhkucolsjcplghsol; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_hmwtnisshceudkbtyfamhkucolsjcplghsol ON public.templatecacheelements USING btree ("elementId");


--
-- Name: idx_hntcxauojypciyitpfjrdtznpoekfsqgtzjz; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_hntcxauojypciyitpfjrdtznpoekfsqgtzjz ON public.drafts USING btree ("creatorId", provisional);


--
-- Name: idx_hqcixztjrbewkwvqvkxvnzxnyskiqfxwbnvu; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_hqcixztjrbewkwvqvkxvnzxnyskiqfxwbnvu ON public.elements USING btree (archived, "dateDeleted", "draftId", "revisionId", "canonicalId");


--
-- Name: idx_hswqabqrbowdhjxemntxmmfvexirnxvvrupp; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_hswqabqrbowdhjxemntxmmfvexirnxvvrupp ON public.entries USING btree ("authorId");


--
-- Name: idx_iewaiistkjakbywyoxvfrbiajykmcceozfxi; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_iewaiistkjakbywyoxvfrbiajykmcceozfxi ON public.matrixblocks USING btree ("sortOrder");


--
-- Name: idx_jbifrijxjdskjxkwsjwgddvlhajsrzafsore; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_jbifrijxjdskjxkwsjwgddvlhajsrzafsore ON public.lenz_linkfield USING btree ("siteId");


--
-- Name: idx_jboyelzpfvqixdvvkugbzrjiwfutjjkxazng; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_jboyelzpfvqixdvvkugbzrjiwfutjjkxazng ON public.entries USING btree ("expiryDate");


--
-- Name: idx_jjyqhfgmwmzwnrzrdjtflhmtdrhcozygwvcd; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_jjyqhfgmwmzwnrzrdjtflhmtdrhcozygwvcd ON public.userpermissions_usergroups USING btree ("permissionId", "groupId");


--
-- Name: idx_jpzxlmgdaxpokuvrnoycirrpyprlgtajzwzi; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_jpzxlmgdaxpokuvrnoycirrpyprlgtajzwzi ON public.fieldgroups USING btree (name);


--
-- Name: idx_jspgyjevjaoruokljdmdyhzpedwvxyprdcyk; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_jspgyjevjaoruokljdmdyhzpedwvxyprdcyk ON public.fieldlayouttabs USING btree ("layoutId");


--
-- Name: idx_jtcavztwbosfcofvbbcpnatipxdexkrvazif; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_jtcavztwbosfcofvbbcpnatipxdexkrvazif ON public.userpermissions_users USING btree ("permissionId", "userId");


--
-- Name: idx_jtkyutozaintnwcawsalwassahjuhdnbdtwl; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_jtkyutozaintnwcawsalwassahjuhdnbdtwl ON public.volumes USING btree ("fieldLayoutId");


--
-- Name: idx_kabwakjubeldqvqjukalblqayvtpksmvutma; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_kabwakjubeldqvqjukalblqayvtpksmvutma ON public.templatecaches USING btree ("cacheKey", "siteId", "expiryDate", path);


--
-- Name: idx_kjnguqfddqcqrmbiobyumwxpofyjmptgandh; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_kjnguqfddqcqrmbiobyumwxpofyjmptgandh ON public.matrixblocks USING btree ("typeId");


--
-- Name: idx_klgoguijqsjstlvscivydbxngvhvvnceghze; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_klgoguijqsjstlvscivydbxngvhvvnceghze ON public.assets USING btree ("folderId");


--
-- Name: idx_ksnfqhazsuxbihdxjzggnlglhlwfzgvrhhlx; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ksnfqhazsuxbihdxjzggnlglhlwfzgvrhhlx ON public.elements_sites USING btree (lower((uri)::text), "siteId");


--
-- Name: idx_kzseuwbsrpshkobtcanpsjsizithgjyoqrjs; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_kzseuwbsrpshkobtcanpsjsizithgjyoqrjs ON public.taggroups USING btree (handle);


--
-- Name: idx_lbrmwxmkbxowwrohvrdowoxccuiqnizoittc; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_lbrmwxmkbxowwrohvrdowoxccuiqnizoittc ON public.fields USING btree (handle, context);


--
-- Name: idx_lbsnwkpauzluilnoqocrquibfkxknjersqvo; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_lbsnwkpauzluilnoqocrquibfkxknjersqvo ON public.structureelements USING btree (root);


--
-- Name: idx_lcpelwvazmkduohiagwykauvtphnigjqgglz; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_lcpelwvazmkduohiagwykauvtphnigjqgglz ON public.categorygroups_sites USING btree ("siteId");


--
-- Name: idx_likazteoxcenvjzqqqxhahcdhzknadnjfgwm; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_likazteoxcenvjzqqqxhahcdhzknadnjfgwm ON public.announcements USING btree ("userId", unread, "dateRead", "dateCreated");


--
-- Name: idx_lrhyfnfeopdytvfomqimjjutvnfeocyajftp; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_lrhyfnfeopdytvfomqimjjutvnfeocyajftp ON public.deprecationerrors USING btree (key, fingerprint);


--
-- Name: idx_mcyqdvoxidcietzufkdvrvewyjmamzwrbkfi; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_mcyqdvoxidcietzufkdvrvewyjmamzwrbkfi ON public.neoblocktypegroups USING btree ("fieldId");


--
-- Name: idx_mdpbzwutpkdvaniubbkkcwtxaqcyevvoiuno; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_mdpbzwutpkdvaniubbkkcwtxaqcyevvoiuno ON public.globalsets USING btree (name);


--
-- Name: idx_mglakjxpnrzsrcfhwovigrdsidcmxfozqsbt; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_mglakjxpnrzsrcfhwovigrdsidcmxfozqsbt ON public.systemmessages USING btree (language);


--
-- Name: idx_mlbtxhrgzgsbzjuygkmpebjkswujqcdrconx; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_mlbtxhrgzgsbzjuygkmpebjkswujqcdrconx ON public.supertableblocktypes USING btree ("fieldId");


--
-- Name: idx_mmwdnooqafwbpmsdxhohyzuxdaoiljijswuk; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_mmwdnooqafwbpmsdxhohyzuxdaoiljijswuk ON public.neoblockstructures USING btree ("structureId");


--
-- Name: idx_mpvfphbqjcbopotnzasrrdvtqhwdgisoljvj; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_mpvfphbqjcbopotnzasrrdvtqhwdgisoljvj ON public.elementindexsettings USING btree (type);


--
-- Name: idx_mrehhbqnagqofhwswefshgfqqmhucvoaflqo; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_mrehhbqnagqofhwswefshgfqqmhucvoaflqo ON public.matrixblocktypes USING btree (name, "fieldId");


--
-- Name: idx_msrdflupaaijijpmzepqcjsmacedjjvhkkow; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_msrdflupaaijijpmzepqcjsmacedjjvhkkow ON public.sections_sites USING btree ("siteId");


--
-- Name: idx_mueuylfyuwfeoilwsmtvexwnyrblfnwubkxt; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_mueuylfyuwfeoilwsmtvexwnyrblfnwubkxt ON public.migrations USING btree (track, name);


--
-- Name: idx_ncjgfczxdgauntzvxhdomzuzozomfyaiwizf; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ncjgfczxdgauntzvxhdomzuzozomfyaiwizf ON public.fields USING btree ("groupId");


--
-- Name: idx_nmsyjslqnfsjctucdstdrxehfdkpuuknrhrq; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_nmsyjslqnfsjctucdstdrxehfdkpuuknrhrq ON public.drafts USING btree (saved);


--
-- Name: idx_nnnlxxqdioucsddufichpteewvtcnjormsfj; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_nnnlxxqdioucsddufichpteewvtcnjormsfj ON public.users USING btree (lower((username)::text));


--
-- Name: idx_nqckbyccyagjbyeuywzazjdsosnjixbfmomw; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_nqckbyccyagjbyeuywzazjdsosnjixbfmomw ON public.gqltokens USING btree (name);


--
-- Name: idx_nxtbrptfuizvjizfhbujvxkngfklahmoqsuf; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_nxtbrptfuizvjizfhbujvxkngfklahmoqsuf ON public.elements_sites USING btree ("siteId");


--
-- Name: idx_ocxwyqhmjajwgbuodxgzseblrwtbfozmwnnf; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ocxwyqhmjajwgbuodxgzseblrwtbfozmwnnf ON public.fieldlayoutfields USING btree ("tabId");


--
-- Name: idx_oihercuquaaecpqtufxxjscubfbbiqmfngga; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_oihercuquaaecpqtufxxjscubfbbiqmfngga ON public.users USING btree (uid);


--
-- Name: idx_ouxvkmlkorhxgfqxubkvprrukbfwxpwvuntu; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_ouxvkmlkorhxgfqxubkvprrukbfwxpwvuntu ON public.neoblocktypes USING btree (handle, "fieldId");


--
-- Name: idx_owdlzjfjebnqnsvokwniccrnkbyhixwobbjg; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_owdlzjfjebnqnsvokwniccrnkbyhixwobbjg ON public.searchindex USING btree (keywords);


--
-- Name: idx_owwivbcbmqoxuuyszfziobzqegppbpoflkqr; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_owwivbcbmqoxuuyszfziobzqegppbpoflkqr ON public.tokens USING btree (token);


--
-- Name: idx_paiekhbcvfnoxoikroceuhzzmsscuplxualo; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_paiekhbcvfnoxoikroceuhzzmsscuplxualo ON public.fieldgroups USING btree ("dateDeleted", name);


--
-- Name: idx_pasiumzwgzhaclxhtduzflizwdqgxpcdpdrd; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_pasiumzwgzhaclxhtduzflizwdqgxpcdpdrd ON public.matrixblocks USING btree ("ownerId");


--
-- Name: idx_pciieehwdwhzzoqzsukolhkbkrjaoffrjfds; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_pciieehwdwhzzoqzsukolhkbkrjaoffrjfds ON public.globalsets USING btree ("fieldLayoutId");


--
-- Name: idx_pjorvlnnjqkpckminudzvzsshtvswulqxwod; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_pjorvlnnjqkpckminudzvzsshtvswulqxwod ON public.structureelements USING btree (level);


--
-- Name: idx_pqzvjokmuxnuakuivfsymlshhfhcyglkbxqf; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_pqzvjokmuxnuakuivfsymlshhfhcyglkbxqf ON public.assetindexdata USING btree ("volumeId");


--
-- Name: idx_ptpgofijdvcpcpqubmcngydxhcscllakxydc; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ptpgofijdvcpcpqubmcngydxhcscllakxydc ON public.supertableblocks USING btree ("fieldId");


--
-- Name: idx_pvaxqahoofedaxbbpnlhwshzrsqfqifqitkp; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_pvaxqahoofedaxbbpnlhwshzrsqfqifqitkp ON public.sessions USING btree (token);


--
-- Name: idx_pxjwpgcqtnjdzmkjocoyxylazajwhpoignju; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_pxjwpgcqtnjdzmkjocoyxylazajwhpoignju ON public.neoblocktypes USING btree (name, "fieldId");


--
-- Name: idx_pymwsqajspbyvmxtskohmvviamexsoyibrhv; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_pymwsqajspbyvmxtskohmvviamexsoyibrhv ON public.assettransforms USING btree (handle);


--
-- Name: idx_qgacllcqlkloywooniyrpthpodsxvgfumupj; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_qgacllcqlkloywooniyrpthpodsxvgfumupj ON public.matrixblocks USING btree ("fieldId");


--
-- Name: idx_qjifdquydhqkdktgmpgyxirhscsoqohmjcub; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_qjifdquydhqkdktgmpgyxirhscsoqohmjcub ON public.fieldlayouts USING btree ("dateDeleted");


--
-- Name: idx_rfaxruygwlrkqhjmnnypftvzrqfhkcdqqtkh; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_rfaxruygwlrkqhjmnnypftvzrqfhkcdqqtkh ON public.matrixblocktypes USING btree (handle, "fieldId");


--
-- Name: idx_rhgvifdcielurqgaqgmsornrfywpeockhgyq; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_rhgvifdcielurqgaqgmsornrfywpeockhgyq ON public.elements USING btree ("fieldLayoutId");


--
-- Name: idx_rlqshpwjemjgvtqqiokvewfzrehniyeihmop; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_rlqshpwjemjgvtqqiokvewfzrehniyeihmop ON public.content USING btree (title);


--
-- Name: idx_rpodtkendbcukmulyfcxgcnuaeryraybjrec; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_rpodtkendbcukmulyfcxgcnuaeryraybjrec ON public.neoblockstructures USING btree ("fieldId");


--
-- Name: idx_rqnlncdlutotlmnrbgmyzazpyhpprhdhnzll; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_rqnlncdlutotlmnrbgmyzazpyhpprhdhnzll ON public.volumefolders USING btree (name, "parentId", "volumeId");


--
-- Name: idx_rsfjpmidluchqctxoptfoggekgufdultgaps; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_rsfjpmidluchqctxoptfoggekgufdultgaps ON public.entries USING btree ("sectionId");


--
-- Name: idx_rsgjorvzuoyjhqthhisrcdgagjkbpzxhvklx; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_rsgjorvzuoyjhqthhisrcdgagjkbpzxhvklx ON public.changedattributes USING btree ("elementId", "siteId", "dateUpdated");


--
-- Name: idx_rsjnuvtesilgljkvlyvbnwgcfntvrgayzspj; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_rsjnuvtesilgljkvlyvbnwgcfntvrgayzspj ON public.userpermissions_users USING btree ("userId");


--
-- Name: idx_rwtmnlmulsujdslugcgbzphijfxzosdusfoq; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_rwtmnlmulsujdslugcgbzphijfxzosdusfoq ON public.fieldlayoutfields USING btree ("sortOrder");


--
-- Name: idx_rxtjrbrzxauhmxiwzxcyptmqxwaxgnvofrsb; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_rxtjrbrzxauhmxiwzxcyptmqxwaxgnvofrsb ON public.sessions USING btree (uid);


--
-- Name: idx_scjqjxmfisauupsadbuxuowfuxdmhfkadfth; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_scjqjxmfisauupsadbuxuowfuxdmhfkadfth ON public.users USING btree ("verificationCode");


--
-- Name: idx_sdjnsewsgaxyvsmpvuqhwaukffvoskuilmiu; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_sdjnsewsgaxyvsmpvuqhwaukffvoskuilmiu ON public.neoblocks USING btree ("ownerSiteId");


--
-- Name: idx_sfdcyscihytptmnnzkekpherabtktmxklafz; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_sfdcyscihytptmnnzkekpherabtktmxklafz ON public.sites USING btree ("dateDeleted");


--
-- Name: idx_sigplngterpebjoyrwyhqpwshlhbwlpruqqf; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_sigplngterpebjoyrwyhqpwshlhbwlpruqqf ON public.announcements USING btree ("dateRead");


--
-- Name: idx_skwmqndtjovpfgclbbgorhgvmppycqzevpgu; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_skwmqndtjovpfgclbbgorhgvmppycqzevpgu ON public.taggroups USING btree ("dateDeleted");


--
-- Name: idx_smxluinwvqdpapygkctcwecdxqtyoxhcuvtz; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_smxluinwvqdpapygkctcwecdxqtyoxhcuvtz ON public.taggroups USING btree (name);


--
-- Name: idx_snljvwcwuvcxvnguoxtcopfixrvpptskwhua; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_snljvwcwuvcxvnguoxtcopfixrvpptskwhua ON public.templatecacheelements USING btree ("cacheId");


--
-- Name: idx_srbkhmorlubeliphsfjhqnjnuleprdqtftbz; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_srbkhmorlubeliphsfjhqnjnuleprdqtftbz ON public.entries USING btree ("postDate");


--
-- Name: idx_ssdwogtaznnbmkdhiftlwzqwomaxubgefcmj; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ssdwogtaznnbmkdhiftlwzqwomaxubgefcmj ON public.categorygroups USING btree (name);


--
-- Name: idx_svopdtivaqsypanduvqsbrmauelafazuicwg; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_svopdtivaqsypanduvqsbrmauelafazuicwg ON public.volumes USING btree (name);


--
-- Name: idx_syqpsoukpeghusjgvbfjgzwxjrpjappcnrkn; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_syqpsoukpeghusjgvbfjgzwxjrpjappcnrkn ON public.categories USING btree ("groupId");


--
-- Name: idx_tcemyzrhmwxlyrcizvhhziqoeqffoatxsone; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_tcemyzrhmwxlyrcizvhhziqoeqffoatxsone ON public.supertableblocks USING btree ("sortOrder");


--
-- Name: idx_tdnfokvwcgkvpuuxgrxrlvvdlbhfxpjufqtn; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_tdnfokvwcgkvpuuxgrxrlvvdlbhfxpjufqtn ON public.fieldlayoutfields USING btree ("fieldId");


--
-- Name: idx_tkexhbqsiirrkyxuzuouzgjjverfjztmegoc; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_tkexhbqsiirrkyxuzuouzgjjverfjztmegoc ON public.matrixblocktypes USING btree ("fieldLayoutId");


--
-- Name: idx_tvtpolcwfssiiwlnkadvtedujipzrazqwsag; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_tvtpolcwfssiiwlnkadvtedujipzrazqwsag ON public.structureelements USING btree ("elementId");


--
-- Name: idx_tysquqdrnujxfpmjofatsefzvhufsakqjlow; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_tysquqdrnujxfpmjofatsefzvhufsakqjlow ON public.neoblocktypegroups USING btree (name, "fieldId");


--
-- Name: idx_uagbpieaavftepidqpcxgqfltfeugvoulllc; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_uagbpieaavftepidqpcxgqfltfeugvoulllc ON public.neoblocktypes USING btree ("fieldId");


--
-- Name: idx_uiijvcjsfynfebycjcamynjmhtghdzfaptwc; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_uiijvcjsfynfebycjcamynjmhtghdzfaptwc ON public.systemmessages USING btree (key, language);


--
-- Name: idx_uitpqqtjqqonxiltemuzcwzfmdztpvaxhpgo; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_uitpqqtjqqonxiltemuzcwzfmdztpvaxhpgo ON public.volumes USING btree ("dateDeleted");


--
-- Name: idx_uknyfufrdnxbbfozqhgquxxmfkkmwfoghifm; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_uknyfufrdnxbbfozqhgquxxmfkkmwfoghifm ON public.relations USING btree ("targetId");


--
-- Name: idx_vdpgvycsnuegtbaihurnbdmaiqnmolvhysti; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_vdpgvycsnuegtbaihurnbdmaiqnmolvhysti ON public.supertableblocks USING btree ("typeId");


--
-- Name: idx_vgbmbatiwljmhtpfwcapuopjxqilvufvujqz; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_vgbmbatiwljmhtpfwcapuopjxqilvufvujqz ON public.entries USING btree ("typeId");


--
-- Name: idx_vjmovsufinrthglocugvrzvvgjauwydhjpbt; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_vjmovsufinrthglocugvrzvvgjauwydhjpbt ON public.assets USING btree (filename, "folderId");


--
-- Name: idx_vktewwwgcntwzibbazpookfsnvebpxbqwrmp; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_vktewwwgcntwzibbazpookfsnvebpxbqwrmp ON public.neoblocks USING btree ("ownerId");


--
-- Name: idx_vqlwobkfffdibcoefdsmlrgsjnlcxbbkfydc; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_vqlwobkfffdibcoefdsmlrgsjnlcxbbkfydc ON public.changedfields USING btree ("elementId", "siteId", "dateUpdated");


--
-- Name: idx_vuwpwkrkocxdyrtjvdcddntrqfbwpghjsldb; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_vuwpwkrkocxdyrtjvdcddntrqfbwpghjsldb ON public.entrytypes USING btree (handle, "sectionId");


--
-- Name: idx_vwfjtkvdafnjblqrkmastkdrnfzdrapjtfbu; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_vwfjtkvdafnjblqrkmastkdrnfzdrapjtfbu ON public.sessions USING btree ("userId");


--
-- Name: idx_wboccbutfcpprwtyraayuappwwkyfihjsffg; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_wboccbutfcpprwtyraayuappwwkyfihjsffg ON public.content USING btree ("elementId", "siteId");


--
-- Name: idx_wjngseeydkzuaewyhqurqidhglsdmmchuema; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_wjngseeydkzuaewyhqurqidhglsdmmchuema ON public.templatecaches USING btree ("cacheKey", "siteId", "expiryDate");


--
-- Name: idx_wqtbgzfxjhhfyvtbwvxubccccrodmmtghpas; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_wqtbgzfxjhhfyvtbwvxubccccrodmmtghpas ON public.assettransformindex USING btree ("volumeId", "assetId", location);


--
-- Name: idx_wrqmnqhdpfohuaxstofccskvanhjwwawfglh; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_wrqmnqhdpfohuaxstofccskvanhjwwawfglh ON public.usergroups_users USING btree ("userId");


--
-- Name: idx_wsebbizuzjaupmwgmtwsspkdiweachxufdqe; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_wsebbizuzjaupmwgmtwsspkdiweachxufdqe ON public.searchindex USING gin (keywords_vector) WITH (fastupdate=yes);


--
-- Name: idx_wsforyethmcyvyrmqiavhohjwlytemxhvwxw; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_wsforyethmcyvyrmqiavhohjwlytemxhvwxw ON public.content USING btree ("siteId");


--
-- Name: idx_wtoryjnghzkfwmkdppwzpdpramljpowlkwit; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_wtoryjnghzkfwmkdppwzpdpramljpowlkwit ON public.categorygroups USING btree (handle);


--
-- Name: idx_wyfylkzsozqyosnjvmwsnnyfmzifrghnenss; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_wyfylkzsozqyosnjvmwsnnyfmzifrghnenss ON public.sections USING btree (handle);


--
-- Name: idx_wzrefuvgluhudzmdpgqgkqlkmwexjlmlhggi; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_wzrefuvgluhudzmdpgqgkqlkmwexjlmlhggi ON public.matrixblocktypes USING btree ("fieldId");


--
-- Name: idx_xarfuhteuyhqnjfeiwwuememmsmaztiyztxk; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_xarfuhteuyhqnjfeiwwuememmsmaztiyztxk ON public.supertableblocktypes USING btree ("fieldLayoutId");


--
-- Name: idx_xddbcdoainjycdjwyrcqhhwtgjogcygejweb; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_xddbcdoainjycdjwyrcqhhwtgjogcygejweb ON public.volumefolders USING btree ("volumeId");


--
-- Name: idx_xiwgabqwxwrysbijdqboolcihrpxdtqucvqe; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_xiwgabqwxwrysbijdqboolcihrpxdtqucvqe ON public.categorygroups USING btree ("structureId");


--
-- Name: idx_xjdegxaoirtgtdcwvzrcisdqqonsivcxnayk; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_xjdegxaoirtgtdcwvzrcisdqqonsivcxnayk ON public.neoblocks USING btree ("fieldId");


--
-- Name: idx_xkukytyrlnvankxtspfgngxhlnkakvgkccqe; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_xkukytyrlnvankxtspfgngxhlnkakvgkccqe ON public.entrytypes USING btree ("sectionId");


--
-- Name: idx_xltiuqhucbyrwhzhgjfnmrwtilamyengmjzd; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_xltiuqhucbyrwhzhgjfnmrwtilamyengmjzd ON public.categorygroups_sites USING btree ("groupId", "siteId");


--
-- Name: idx_xmsigumvikgkxjyzfmwrsdrlgliqcgnnsxid; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_xmsigumvikgkxjyzfmwrsdrlgliqcgnnsxid ON public.sections USING btree ("dateDeleted");


--
-- Name: idx_xnqpouaizaztlwlbmeulyacahrnseghqqcso; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_xnqpouaizaztlwlbmeulyacahrnseghqqcso ON public.elements USING btree (archived, "dateCreated");


--
-- Name: idx_xqvfqwqjsycyxzjadqjeyqgouiejfdtlgjak; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_xqvfqwqjsycyxzjadqjeyqgouiejfdtlgjak ON public.entrytypes USING btree (name, "sectionId");


--
-- Name: idx_xxvsxzkhvfqxbrecbcvnawmhfbrvgpnrtkzc; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_xxvsxzkhvfqxbrecbcvnawmhfbrvgpnrtkzc ON public.neoblockstructures USING btree ("ownerId");


--
-- Name: idx_xytsayfgxrlwkfpqllqanfhwalhqueewmxzy; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_xytsayfgxrlwkfpqllqanfhwalhqueewmxzy ON public.fieldlayouttabs USING btree ("sortOrder");


--
-- Name: idx_yrhoxpkeaqelvbljcvywphwqyigtorqtikku; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_yrhoxpkeaqelvbljcvywphwqyigtorqtikku ON public.elements_sites USING btree ("elementId", "siteId");


--
-- Name: idx_yrofblnjshuiskxcpndvnqviuknqvohpbrjj; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_yrofblnjshuiskxcpndvnqviuknqvohpbrjj ON public.usergroups USING btree (handle);


--
-- Name: idx_ysiquoerbukbrxaaaswcuhrdkchzlnhktrua; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ysiquoerbukbrxaaaswcuhrdkchzlnhktrua ON public.entrytypes USING btree ("dateDeleted");


--
-- Name: idx_zbdejhftotbnqyutmqzkraryfdbadxziyepg; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_zbdejhftotbnqyutmqzkraryfdbadxziyepg ON public.elements USING btree (enabled);


--
-- Name: idx_zbliulpdnjshpnmfmrlezivzfphnnqqrasff; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_zbliulpdnjshpnmfmrlezivzfphnnqqrasff ON public.sections_sites USING btree ("sectionId", "siteId");


--
-- Name: idx_zddruzvzubvkpumftghsdodnndbuloormert; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_zddruzvzubvkpumftghsdodnndbuloormert ON public.lenz_linkfield USING btree ("elementId", "siteId", "fieldId");


--
-- Name: idx_zimnxavsbvvabqwfsrginhamdseacydvflfa; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_zimnxavsbvvabqwfsrginhamdseacydvflfa ON public.assettransforms USING btree (name);


--
-- Name: idx_znzszwolxhgcdijsvmlsrtovmfpmibukihmy; Type: INDEX; Schema: public; Owner: craft
--

CREATE UNIQUE INDEX idx_znzszwolxhgcdijsvmlsrtovmfpmibukihmy ON public.revisions USING btree ("sourceId", num);


--
-- Name: idx_ztwytsfvulkpoyqygnhyhniqmdvaxmyocmui; Type: INDEX; Schema: public; Owner: craft
--

CREATE INDEX idx_ztwytsfvulkpoyqygnhyhniqmdvaxmyocmui ON public.relations USING btree ("sourceSiteId");


--
-- Name: neoblocks fk_abjirvohsfdzlampgdrfvdzuurhdxdkolgwn; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocks
    ADD CONSTRAINT fk_abjirvohsfdzlampgdrfvdzuurhdxdkolgwn FOREIGN KEY ("ownerId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: entries fk_aomnibqmxoqycwoskgygezjmzrwakuvntohv; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT fk_aomnibqmxoqycwoskgygezjmzrwakuvntohv FOREIGN KEY ("typeId") REFERENCES public.entrytypes(id) ON DELETE CASCADE;


--
-- Name: content fk_bgvmtktglfijfmsrjhhycvgzhzdvwlqxoect; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT fk_bgvmtktglfijfmsrjhhycvgzhzdvwlqxoect FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: content fk_bnjvtrgfjygkhorpvlztrlvsxcifekbigjev; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT fk_bnjvtrgfjygkhorpvlztrlvsxcifekbigjev FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: fieldlayoutfields fk_bweuxbbjjkxjrstwpydjmchvmztlsxqjekvt; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldlayoutfields
    ADD CONSTRAINT fk_bweuxbbjjkxjrstwpydjmchvmztlsxqjekvt FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: globalsets fk_calsgericeokllkkflgbymlygkqusnmheopx; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.globalsets
    ADD CONSTRAINT fk_calsgericeokllkkflgbymlygkqusnmheopx FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: sites fk_cisytxweusuygqshoolidyogwbmkfhaabkom; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT fk_cisytxweusuygqshoolidyogwbmkfhaabkom FOREIGN KEY ("groupId") REFERENCES public.sitegroups(id) ON DELETE CASCADE;


--
-- Name: matrixblocks fk_cltsgcxexewqibduxgerywdgzcwzusmhbatv; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.matrixblocks
    ADD CONSTRAINT fk_cltsgcxexewqibduxgerywdgzcwzusmhbatv FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: categories fk_cwnjtdhxdrxkjuxxgnvrvqucgjdcybknnznt; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_cwnjtdhxdrxkjuxxgnvrvqucgjdcybknnznt FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: entries fk_cxrvwrilatdgmqhzaqqelabfosgevfanxiyv; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT fk_cxrvwrilatdgmqhzaqqelabfosgevfanxiyv FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: tags fk_dbsolekbavfxlcbalfdqftprjsfwitgmxbxb; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT fk_dbsolekbavfxlcbalfdqftprjsfwitgmxbxb FOREIGN KEY ("groupId") REFERENCES public.taggroups(id) ON DELETE CASCADE;


--
-- Name: categories fk_ddoomxmuakwlobxjioinizsgisxiwmjopggc; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_ddoomxmuakwlobxjioinizsgisxiwmjopggc FOREIGN KEY ("parentId") REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: categorygroups fk_ecringotdqsbrboayglkrezmkvioolsdunax; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categorygroups
    ADD CONSTRAINT fk_ecringotdqsbrboayglkrezmkvioolsdunax FOREIGN KEY ("structureId") REFERENCES public.structures(id) ON DELETE CASCADE;


--
-- Name: structureelements fk_ehrrwbsxixutboaeqalbnapmxfyowlhcjjni; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.structureelements
    ADD CONSTRAINT fk_ehrrwbsxixutboaeqalbnapmxfyowlhcjjni FOREIGN KEY ("structureId") REFERENCES public.structures(id) ON DELETE CASCADE;


--
-- Name: matrixblocks fk_falpgfqzraphzfouzglsgodwehpleqjlqmjq; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.matrixblocks
    ADD CONSTRAINT fk_falpgfqzraphzfouzglsgodwehpleqjlqmjq FOREIGN KEY ("ownerId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: elements_sites fk_fhwhqirkfouisswuidwozrydigtlowosbspz; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elements_sites
    ADD CONSTRAINT fk_fhwhqirkfouisswuidwozrydigtlowosbspz FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: elements_sites fk_fnxleivhnlwiztmztnumsvolawuhbuqjhcfx; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elements_sites
    ADD CONSTRAINT fk_fnxleivhnlwiztmztnumsvolawuhbuqjhcfx FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: volumefolders fk_fpdglggzetsnrupqocsbbhezbxntfxhyyzkh; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.volumefolders
    ADD CONSTRAINT fk_fpdglggzetsnrupqocsbbhezbxntfxhyyzkh FOREIGN KEY ("volumeId") REFERENCES public.volumes(id) ON DELETE CASCADE;


--
-- Name: entries fk_fpzdjbxkiphweznwqrvrmvgthhsvinhhvbxc; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT fk_fpzdjbxkiphweznwqrvrmvgthhsvinhhvbxc FOREIGN KEY ("authorId") REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: assetindexdata fk_fypjhwgqitxwbzhwkuxlajtxwifchznygnsc; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assetindexdata
    ADD CONSTRAINT fk_fypjhwgqitxwbzhwkuxlajtxwifchznygnsc FOREIGN KEY ("volumeId") REFERENCES public.volumes(id) ON DELETE CASCADE;


--
-- Name: neoblocks fk_gejtlhcugewrcfhwdbczzkqcguivsqlnsoha; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocks
    ADD CONSTRAINT fk_gejtlhcugewrcfhwdbczzkqcguivsqlnsoha FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: entrytypes fk_ghbuscankspfcnklsohedquydnfsubyzipda; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.entrytypes
    ADD CONSTRAINT fk_ghbuscankspfcnklsohedquydnfsubyzipda FOREIGN KEY ("sectionId") REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: matrixblocks fk_gjceswcfvkoatqzpkslixjpagyaziatlepyh; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.matrixblocks
    ADD CONSTRAINT fk_gjceswcfvkoatqzpkslixjpagyaziatlepyh FOREIGN KEY ("typeId") REFERENCES public.matrixblocktypes(id) ON DELETE CASCADE;


--
-- Name: neoblockstructures fk_gjckkaucdtpsixyoompdcuwocfxkvpklwciq; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblockstructures
    ADD CONSTRAINT fk_gjckkaucdtpsixyoompdcuwocfxkvpklwciq FOREIGN KEY ("ownerSiteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: volumefolders fk_grywzhkxmnykcnlzoaasiyfbbjgowzqzvbbj; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.volumefolders
    ADD CONSTRAINT fk_grywzhkxmnykcnlzoaasiyfbbjgowzqzvbbj FOREIGN KEY ("parentId") REFERENCES public.volumefolders(id) ON DELETE CASCADE;


--
-- Name: supertableblocktypes fk_gurfqbtkblslzptnenrpxozjkczqjlnsgokn; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.supertableblocktypes
    ADD CONSTRAINT fk_gurfqbtkblslzptnenrpxozjkczqjlnsgokn FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: changedfields fk_gxmailhiseblxunthvofejjdkyfkdtdvartb; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.changedfields
    ADD CONSTRAINT fk_gxmailhiseblxunthvofejjdkyfkdtdvartb FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: changedattributes fk_gynitexrqfmdnqzxmazbgxjkenscgussqqsk; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.changedattributes
    ADD CONSTRAINT fk_gynitexrqfmdnqzxmazbgxjkenscgussqqsk FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: neoblocks fk_hbbhtmeipkxqgtdplorfnoadyaokrnddzhij; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocks
    ADD CONSTRAINT fk_hbbhtmeipkxqgtdplorfnoadyaokrnddzhij FOREIGN KEY ("typeId") REFERENCES public.neoblocktypes(id) ON DELETE CASCADE;


--
-- Name: announcements fk_heqqmgmqfaavnrshronygprbwztzrjxcqqhi; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT fk_heqqmgmqfaavnrshronygprbwztzrjxcqqhi FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: matrixblocks fk_hfovcufbtexfcknwbtolppyhchxejbbyqwhx; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.matrixblocks
    ADD CONSTRAINT fk_hfovcufbtexfcknwbtolppyhchxejbbyqwhx FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: entries fk_hhljkiirhrwqfzyshkbmwqpdzpofvvtwnjem; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT fk_hhljkiirhrwqfzyshkbmwqpdzpofvvtwnjem FOREIGN KEY ("parentId") REFERENCES public.entries(id) ON DELETE SET NULL;


--
-- Name: assets fk_hlptenocdazzacbdfdqdjyyuuvfesxsgcigy; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT fk_hlptenocdazzacbdfdqdjyyuuvfesxsgcigy FOREIGN KEY ("uploaderId") REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: matrixblocktypes fk_hrqmudwmqgfasuzluhergfhdifsvfavtupja; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.matrixblocktypes
    ADD CONSTRAINT fk_hrqmudwmqgfasuzluhergfhdifsvfavtupja FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: usergroups_users fk_hxhilulnqzmqrwphscxqkodfrqyrxlpnmxay; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.usergroups_users
    ADD CONSTRAINT fk_hxhilulnqzmqrwphscxqkodfrqyrxlpnmxay FOREIGN KEY ("groupId") REFERENCES public.usergroups(id) ON DELETE CASCADE;


--
-- Name: revisions fk_ihydhogvhrequcktbzrceckfrxcoajcckoju; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT fk_ihydhogvhrequcktbzrceckfrxcoajcckoju FOREIGN KEY ("creatorId") REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: usergroups_users fk_ikgyqzwrzzqrafwdeflwnrbexbrxymjtxioi; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.usergroups_users
    ADD CONSTRAINT fk_ikgyqzwrzzqrafwdeflwnrbexbrxymjtxioi FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: templatecacheelements fk_ioopuakgezmzhltqrrhhwoiamkowzbzepqbw; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.templatecacheelements
    ADD CONSTRAINT fk_ioopuakgezmzhltqrrhhwoiamkowzbzepqbw FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: supertableblocks fk_izelfihcapcdldbzhocddtvesjpatjlnrnpi; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.supertableblocks
    ADD CONSTRAINT fk_izelfihcapcdldbzhocddtvesjpatjlnrnpi FOREIGN KEY ("ownerId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: craftidtokens fk_jbrvcicrqicsuogoqrokxtxgegxhdeyirlex; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.craftidtokens
    ADD CONSTRAINT fk_jbrvcicrqicsuogoqrokxtxgegxhdeyirlex FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: lenz_linkfield fk_jijwkoxfumwhhtspqkkhkaseonchhlltpbvz; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.lenz_linkfield
    ADD CONSTRAINT fk_jijwkoxfumwhhtspqkkhkaseonchhlltpbvz FOREIGN KEY ("linkedSiteId") REFERENCES public.sites(id) ON UPDATE SET NULL ON DELETE SET NULL;


--
-- Name: userpermissions_usergroups fk_jrdmslsqyrymwxtljiobtrshosflnrhwfdvw; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpermissions_usergroups
    ADD CONSTRAINT fk_jrdmslsqyrymwxtljiobtrshosflnrhwfdvw FOREIGN KEY ("groupId") REFERENCES public.usergroups(id) ON DELETE CASCADE;


--
-- Name: sections_sites fk_jrhwmdimxhofpmcdvzycfpjqlbkukytwxbvx; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sections_sites
    ADD CONSTRAINT fk_jrhwmdimxhofpmcdvzycfpjqlbkukytwxbvx FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: matrixblocktypes fk_kckjmlistbwykwbewzpdtvategiyigxzqjna; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.matrixblocktypes
    ADD CONSTRAINT fk_kckjmlistbwykwbewzpdtvategiyigxzqjna FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: shunnedmessages fk_kihznwzogmfmqpzrovurmcywrxczhaktztll; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.shunnedmessages
    ADD CONSTRAINT fk_kihznwzogmfmqpzrovurmcywrxczhaktztll FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: lenz_linkfield fk_kmsqzubjibfftxmtuatxnteeamvnrwxpafwl; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.lenz_linkfield
    ADD CONSTRAINT fk_kmsqzubjibfftxmtuatxnteeamvnrwxpafwl FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: lenz_linkfield fk_knfdioqyqnbrfjfrnpdyfmmhfbdhjhoighfn; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.lenz_linkfield
    ADD CONSTRAINT fk_knfdioqyqnbrfjfrnpdyfmmhfbdhjhoighfn FOREIGN KEY ("linkedId") REFERENCES public.elements(id) ON UPDATE SET NULL ON DELETE SET NULL;


--
-- Name: changedfields fk_kuaifyfmcoaoyundawntjyvgxhmewgapajpp; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.changedfields
    ADD CONSTRAINT fk_kuaifyfmcoaoyundawntjyvgxhmewgapajpp FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: templatecaches fk_lagrqeoadzfbkvuunwzmprcgdhomrharidav; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.templatecaches
    ADD CONSTRAINT fk_lagrqeoadzfbkvuunwzmprcgdhomrharidav FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: templatecachequeries fk_lcuqgdxwpaliuvhtxwvpettlftrqamzotzzz; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.templatecachequeries
    ADD CONSTRAINT fk_lcuqgdxwpaliuvhtxwvpettlftrqamzotzzz FOREIGN KEY ("cacheId") REFERENCES public.templatecaches(id) ON DELETE CASCADE;


--
-- Name: announcements fk_lhetinzgqzpzpthfolrautbgvkgzdhjdifya; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT fk_lhetinzgqzpzpthfolrautbgvkgzdhjdifya FOREIGN KEY ("pluginId") REFERENCES public.plugins(id) ON DELETE CASCADE;


--
-- Name: sessions fk_lizmjhydldirwcbsnlwzyamzqeduxdlzbtbb; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_lizmjhydldirwcbsnlwzyamzqeduxdlzbtbb FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: widgets fk_ljsaoypcshxyjuswcdutpojzqojavxufriae; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.widgets
    ADD CONSTRAINT fk_ljsaoypcshxyjuswcdutpojzqojavxufriae FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: drafts fk_lowsirjuqkxkmrthnmlmfgcdpwxpsaofrgbm; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT fk_lowsirjuqkxkmrthnmlmfgcdpwxpsaofrgbm FOREIGN KEY ("sourceId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: neoblocks fk_lutqytzfjxltdpnjgsqiuoxwucbcssvtuneb; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocks
    ADD CONSTRAINT fk_lutqytzfjxltdpnjgsqiuoxwucbcssvtuneb FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: tags fk_mopsnkaytonvdjiqwmvumccrwlfxecpsdwet; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT fk_mopsnkaytonvdjiqwmvumccrwlfxecpsdwet FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: sections_sites fk_mtsgtnqgtdchimulmuorfbbtncdskcdcbzom; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sections_sites
    ADD CONSTRAINT fk_mtsgtnqgtdchimulmuorfbbtncdskcdcbzom FOREIGN KEY ("sectionId") REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: assets fk_ncoyrduacyehemuwkyvluzojnzuzsechaxan; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT fk_ncoyrduacyehemuwkyvluzojnzuzsechaxan FOREIGN KEY ("folderId") REFERENCES public.volumefolders(id) ON DELETE CASCADE;


--
-- Name: structureelements fk_neuegtoiyqvxgkjbwdqzlryxjekekvxbsmlq; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.structureelements
    ADD CONSTRAINT fk_neuegtoiyqvxgkjbwdqzlryxjekekvxbsmlq FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: neoblocks fk_ngdhomtyplzxkcqktzisdosjcllwqucatydh; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocks
    ADD CONSTRAINT fk_ngdhomtyplzxkcqktzisdosjcllwqucatydh FOREIGN KEY ("ownerSiteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: categorygroups fk_ntnglycuctxfswifccmyfemwoqfntppmlpwk; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categorygroups
    ADD CONSTRAINT fk_ntnglycuctxfswifccmyfemwoqfntppmlpwk FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: relations fk_nupjucrykcvvbdfselvwrkqefqscuauhbcdp; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT fk_nupjucrykcvvbdfselvwrkqefqscuauhbcdp FOREIGN KEY ("targetId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: universaldamintegrator_asset_metadata fk_ocnkdwirguzzhadkvajvyiwdwbbnynkbhkfy; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.universaldamintegrator_asset_metadata
    ADD CONSTRAINT fk_ocnkdwirguzzhadkvajvyiwdwbbnynkbhkfy FOREIGN KEY ("assetId") REFERENCES public.assets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: neoblockstructures fk_olodzxdhftfmadjhswdufytxqlbfhriemkay; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblockstructures
    ADD CONSTRAINT fk_olodzxdhftfmadjhswdufytxqlbfhriemkay FOREIGN KEY ("ownerId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: assets fk_omxaaniulcdngbbajuklztutfhlrsfodtqjn; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT fk_omxaaniulcdngbbajuklztutfhlrsfodtqjn FOREIGN KEY ("volumeId") REFERENCES public.volumes(id) ON DELETE CASCADE;


--
-- Name: userpermissions_users fk_opaljwmxdvhlryhynkiipqzioqsksrsffyqo; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpermissions_users
    ADD CONSTRAINT fk_opaljwmxdvhlryhynkiipqzioqsksrsffyqo FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: globalsets fk_orazboranzgvojyrrnzyfzoxejqorznfncyh; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.globalsets
    ADD CONSTRAINT fk_orazboranzgvojyrrnzyfzoxejqorznfncyh FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: categorygroups_sites fk_oyaxenrxccbjegzbzcmsrzfwqgspctiokldi; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categorygroups_sites
    ADD CONSTRAINT fk_oyaxenrxccbjegzbzcmsrzfwqgspctiokldi FOREIGN KEY ("siteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gql_refresh_tokens fk_pbprhixxzzvvppmyczvbvxglncbujgdhapfd; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.gql_refresh_tokens
    ADD CONSTRAINT fk_pbprhixxzzvvppmyczvbvxglncbujgdhapfd FOREIGN KEY ("userId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: lenz_linkfield fk_pmovhsrcdmbwhictkxhoktpbdtzgoobpkgrm; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.lenz_linkfield
    ADD CONSTRAINT fk_pmovhsrcdmbwhictkxhoktpbdtzgoobpkgrm FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: categories fk_puaknwhtfvwkfoybrkhjfaebprhfrbleunlk; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_puaknwhtfvwkfoybrkhjfaebprhfrbleunlk FOREIGN KEY ("groupId") REFERENCES public.categorygroups(id) ON DELETE CASCADE;


--
-- Name: userpermissions_users fk_qqemwrrqmiwxakfzfhyppnllmwpatrzueddn; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpermissions_users
    ADD CONSTRAINT fk_qqemwrrqmiwxakfzfhyppnllmwpatrzueddn FOREIGN KEY ("permissionId") REFERENCES public.userpermissions(id) ON DELETE CASCADE;


--
-- Name: changedattributes fk_qsgdfoheuckrrhehhczfbkwrgxblrzwwheal; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.changedattributes
    ADD CONSTRAINT fk_qsgdfoheuckrrhehhczfbkwrgxblrzwwheal FOREIGN KEY ("elementId") REFERENCES public.elements(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gql_refresh_tokens fk_rhhtrfqasirxitjqdmddlztyyegdguoautez; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.gql_refresh_tokens
    ADD CONSTRAINT fk_rhhtrfqasirxitjqdmddlztyyegdguoautez FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: supertableblocks fk_rpovuzfmwridfniwikyxokllwzpgrmjijmvi; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.supertableblocks
    ADD CONSTRAINT fk_rpovuzfmwridfniwikyxokllwzpgrmjijmvi FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: taggroups fk_rtwmvuxvfvpixjyqrjcqciunkmanhxuotian; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.taggroups
    ADD CONSTRAINT fk_rtwmvuxvfvpixjyqrjcqciunkmanhxuotian FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: changedfields fk_rzdqgvqrgbypcdnaauvdtvtvbkozkprzqlel; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.changedfields
    ADD CONSTRAINT fk_rzdqgvqrgbypcdnaauvdtvtvbkozkprzqlel FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: neoblockstructures fk_rzmfahcugbkpkgnmtxslxkjkykuwjnpqblhi; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblockstructures
    ADD CONSTRAINT fk_rzmfahcugbkpkgnmtxslxkjkykuwjnpqblhi FOREIGN KEY ("structureId") REFERENCES public.structures(id) ON DELETE CASCADE;


--
-- Name: entrytypes fk_sgwhoyodfghxzlsubxdflyxabhiwhlvrqgmc; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.entrytypes
    ADD CONSTRAINT fk_sgwhoyodfghxzlsubxdflyxabhiwhlvrqgmc FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: fieldlayouttabs fk_snczleofmruozblpyxuanaukywyyqeignwju; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldlayouttabs
    ADD CONSTRAINT fk_snczleofmruozblpyxuanaukywyyqeignwju FOREIGN KEY ("layoutId") REFERENCES public.fieldlayouts(id) ON DELETE CASCADE;


--
-- Name: elements fk_tgwgmefqarrvswvfrdsryymndpukmmskksfi; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT fk_tgwgmefqarrvswvfrdsryymndpukmmskksfi FOREIGN KEY ("revisionId") REFERENCES public.revisions(id) ON DELETE CASCADE;


--
-- Name: fieldlayoutfields fk_tvxaeugjnqqlytvbynfxobmtyebdrazgdejh; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldlayoutfields
    ADD CONSTRAINT fk_tvxaeugjnqqlytvbynfxobmtyebdrazgdejh FOREIGN KEY ("layoutId") REFERENCES public.fieldlayouts(id) ON DELETE CASCADE;


--
-- Name: relations fk_txhrkjxqnihilsinsejbduymoafqwtllsdyl; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT fk_txhrkjxqnihilsinsejbduymoafqwtllsdyl FOREIGN KEY ("sourceSiteId") REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fieldlayoutfields fk_uwtpzltdwhhymgovmafkwucalvnbvvyfojml; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fieldlayoutfields
    ADD CONSTRAINT fk_uwtpzltdwhhymgovmafkwucalvnbvvyfojml FOREIGN KEY ("tabId") REFERENCES public.fieldlayouttabs(id) ON DELETE CASCADE;


--
-- Name: changedfields fk_uzxtfbwyxppsiztonmsgatabsndeehjcfqbu; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.changedfields
    ADD CONSTRAINT fk_uzxtfbwyxppsiztonmsgatabsndeehjcfqbu FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: assets fk_vjjinivqylmiqxtxmurezkruswjrjkaczxpj; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT fk_vjjinivqylmiqxtxmurezkruswjrjkaczxpj FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: changedattributes fk_vpatvepbgzdefczcvirnxjcvvnbvspzwzvwb; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.changedattributes
    ADD CONSTRAINT fk_vpatvepbgzdefczcvirnxjcvvnbvspzwzvwb FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: neoblocktypegroups fk_vsbgzmilxfwohzxofwlubajtpioneyhsqdal; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocktypegroups
    ADD CONSTRAINT fk_vsbgzmilxfwohzxofwlubajtpioneyhsqdal FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: fields fk_vtugnhaowfmvrbrgvktdwzjbiovfmbrapdtf; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fk_vtugnhaowfmvrbrgvktdwzjbiovfmbrapdtf FOREIGN KEY ("groupId") REFERENCES public.fieldgroups(id) ON DELETE CASCADE;


--
-- Name: relations fk_vxwunlasumjleglkekdbktpemsbcfzmfofqw; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT fk_vxwunlasumjleglkekdbktpemsbcfzmfofqw FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: elements fk_vyvxzvjjxwomoifsptnivqmrliduehrjodba; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT fk_vyvxzvjjxwomoifsptnivqmrliduehrjodba FOREIGN KEY ("canonicalId") REFERENCES public.elements(id) ON DELETE SET NULL;


--
-- Name: templatecacheelements fk_wdavbovnisfpclwfcxwhooprxwdmdaqnddsk; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.templatecacheelements
    ADD CONSTRAINT fk_wdavbovnisfpclwfcxwhooprxwdmdaqnddsk FOREIGN KEY ("cacheId") REFERENCES public.templatecaches(id) ON DELETE CASCADE;


--
-- Name: elements fk_wdnqxqwvaeztvavgwjvjbpvskewubwxwngjp; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT fk_wdnqxqwvaeztvavgwjvjbpvskewubwxwngjp FOREIGN KEY ("draftId") REFERENCES public.drafts(id) ON DELETE CASCADE;


--
-- Name: supertableblocktypes fk_wipszjxtaocfwwdmiljgpxnksddrlfadixfu; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.supertableblocktypes
    ADD CONSTRAINT fk_wipszjxtaocfwwdmiljgpxnksddrlfadixfu FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: categorygroups_sites fk_wqwdmpddznhkgztpqslxmjiwzhkvmxflaekt; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.categorygroups_sites
    ADD CONSTRAINT fk_wqwdmpddznhkgztpqslxmjiwzhkvmxflaekt FOREIGN KEY ("groupId") REFERENCES public.categorygroups(id) ON DELETE CASCADE;


--
-- Name: neoblocktypes fk_wusjxtczygdibukkuqgruyapfcttdcyzsxly; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocktypes
    ADD CONSTRAINT fk_wusjxtczygdibukkuqgruyapfcttdcyzsxly FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: drafts fk_xfqszditorwvjsbsfxowtsyvkfbvtirirjyq; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT fk_xfqszditorwvjsbsfxowtsyvkfbvtirirjyq FOREIGN KEY ("creatorId") REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: supertableblocks fk_xhfelyuvnidnbphypatwavqktxhccoktvfrs; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.supertableblocks
    ADD CONSTRAINT fk_xhfelyuvnidnbphypatwavqktxhccoktvfrs FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: relations fk_xhtoapotefmujlzhksxidgclznhcfwmfpzsx; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT fk_xhtoapotefmujlzhksxidgclznhcfwmfpzsx FOREIGN KEY ("sourceId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: sections fk_xjikclftwzauzpxwxlsjhwxjimoasfimfobt; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT fk_xjikclftwzauzpxwxlsjhwxjimoasfimfobt FOREIGN KEY ("structureId") REFERENCES public.structures(id) ON DELETE SET NULL;


--
-- Name: revisions fk_xlrcccckzxyfqqbxhtaeqeqakfzedaqfttij; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT fk_xlrcccckzxyfqqbxhtaeqeqakfzedaqfttij FOREIGN KEY ("sourceId") REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: users fk_xoyjudqkrshmsohkkrdtvyxzqjvymamwprfs; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_xoyjudqkrshmsohkkrdtvyxzqjvymamwprfs FOREIGN KEY ("photoId") REFERENCES public.assets(id) ON DELETE SET NULL;


--
-- Name: neoblocktypes fk_xoymkxsvdzjdhbgijzbuhljxrmstfakaiaxo; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblocktypes
    ADD CONSTRAINT fk_xoymkxsvdzjdhbgijzbuhljxrmstfakaiaxo FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: neoblockstructures fk_xsroztojqesnpvooukvljehcvrwmdvsvqnmr; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.neoblockstructures
    ADD CONSTRAINT fk_xsroztojqesnpvooukvljehcvrwmdvsvqnmr FOREIGN KEY ("fieldId") REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: userpermissions_usergroups fk_xxajvhzvvdhtuluhxgzilboszgjmzwaqffqf; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpermissions_usergroups
    ADD CONSTRAINT fk_xxajvhzvvdhtuluhxgzilboszgjmzwaqffqf FOREIGN KEY ("permissionId") REFERENCES public.userpermissions(id) ON DELETE CASCADE;


--
-- Name: elements fk_xzdioqyepowaxhpfxubknsttymamgouvzmxm; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.elements
    ADD CONSTRAINT fk_xzdioqyepowaxhpfxubknsttymamgouvzmxm FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- Name: entries fk_ybztlpvwfvucvzdcdbljgsfoltmkdgauknov; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT fk_ybztlpvwfvucvzdcdbljgsfoltmkdgauknov FOREIGN KEY ("sectionId") REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: supertableblocks fk_ydrsesauqotxdhyfnmehuxjihpeqsxemtnqp; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.supertableblocks
    ADD CONSTRAINT fk_ydrsesauqotxdhyfnmehuxjihpeqsxemtnqp FOREIGN KEY ("typeId") REFERENCES public.supertableblocktypes(id) ON DELETE CASCADE;


--
-- Name: users fk_zcjsebordmkssutqlekmuazhhntiyocyqhlx; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_zcjsebordmkssutqlekmuazhhntiyocyqhlx FOREIGN KEY (id) REFERENCES public.elements(id) ON DELETE CASCADE;


--
-- Name: gqltokens fk_zdrdauqtfdzqngceikbdinxrzfkajtzmgfvu; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.gqltokens
    ADD CONSTRAINT fk_zdrdauqtfdzqngceikbdinxrzfkajtzmgfvu FOREIGN KEY ("schemaId") REFERENCES public.gqlschemas(id) ON DELETE SET NULL;


--
-- Name: userpreferences fk_zyhfbyswklwpswuyzcyrosqplvkhetackoml; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.userpreferences
    ADD CONSTRAINT fk_zyhfbyswklwpswuyzcyrosqplvkhetackoml FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: volumes fk_zznoeggmgblhxyzbyvrtyhlwfssddtnwrnkn; Type: FK CONSTRAINT; Schema: public; Owner: craft
--

ALTER TABLE ONLY public.volumes
    ADD CONSTRAINT fk_zznoeggmgblhxyzbyvrtyhlwfssddtnwrnkn FOREIGN KEY ("fieldLayoutId") REFERENCES public.fieldlayouts(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

