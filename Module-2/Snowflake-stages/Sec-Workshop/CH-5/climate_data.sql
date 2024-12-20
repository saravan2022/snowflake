/********************************************/

CREATE OR REPLACE STAGE NOAA_GSOD
URL = 's3://noaa-gsod-pds/';


CREATE OR REPLACE EXTERNAL TABLE NOAAGSOD_2023
WITH LOCATION = @NOAA_GSOD/2023/
--PATTERN = ".*(72287493134).csv"
AUTO_REFRESH = true
FILE_FORMAT = (TYPE=CSV, COMPRESSION=NONE, SKIP_HEADER=1, FIELD_OPTIONALLY_ENCLOSED_BY='"');

select * from NOAAGSOD_2023 limit 100;

c1  --> STATION
c2  --> DATE
c3  --> LATITUDE
c4  --> LONGITUDE
c6  --> NAME
c7  --> TEMP_AVG
c23 --> TEMP_MIN
c21 --> TEMP_MAX
c17 --> WDSP
c19 --> MXSPD
c25 --> PRCP
c9  --> DEWP
c15 --> VISIB


CREATE OR REPLACE VIEW NOAAGSOD_202301_view AS
SELECT DISTINCT
  CAST(value:c1  AS STRING)   AS STATION
, CAST(value:c2  AS DATE)     AS DATE
, CAST(value:c3  AS FLOAT)    AS LATITUDE
, CAST(value:c4  AS FLOAT)    AS LONGITUDE
, CAST(value:c6  AS STRING)   AS NAME
, CAST(value:c7  AS FLOAT)    AS TEMP_AVG
, CAST(value:c23 AS FLOAT)    AS TEMP_MIN
, CAST(value:c21 AS FLOAT)    AS TEMP_MAX
, CAST(value:c17 AS FLOAT)    AS WDSP
, CAST(value:c19 AS FLOAT)    AS MXSPD
, CAST(value:c25 AS FLOAT)    AS PRCP
, CAST(value:c9  AS FLOAT)    AS DEWP
, CAST(value:c15 AS FLOAT)    AS VISIB
FROM    NOAAGSOD_2023
--WHERE   DATE >= '2023-01-01' AND DATE < '2023-02-01';

select * from NOAAGSOD_202301_view limit 100