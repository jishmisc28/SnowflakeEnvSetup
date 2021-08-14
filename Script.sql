ALTER WAREHOUSE "COMPUTE_WH" SET WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 60 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 SCALING_POLICY = 'STANDARD' COMMENT = '';

CREATE OR REPLACE DATABASE ENTITY1_DWH;

--CREATE OR REPLACE DATABASE ENTITY2_DWH;
--CREATE OR REPLACE DATABASE ENTITY3_DWH;

// ENTITY3ant role to user
ENTITY3ANT ROLE "DATA_ENGINEER_ROLE" TO USER USER1;

ENTITY3ANT ROLE "BI_TABLEAU_ROLE" TO USER TABLEAU_MYORG;


ENTITY3ant role BI_ADHOC_ROLE to user SNOW_MKT_ADHOC_JG;
alter user SNOW_MKT_ADHOC_JG set default_role = BI_ADHOC_ROLE;
alter user SNOW_MKT_ADHOC_JG set disabled=false;
revoke role MKT_ADHOC_ROLE from user SNOW_MKT_ADHOC_JG;


ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.RAF_SERVICE TO BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA ENTITY1_DWH.RAF_SERVICE TO ROLE BI_TABLEAU_ROLE;

create schema RAF_SERVICE

ENTITY3ANT USAGE ON DATABASE ENTITY1_DWH TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT USAGE ON SCHEMA ENTITY1_DWH.RAF_SERVICE TO ROLE BI_TABLEAU_ROLE;

// ENTITY3ant privileges on object to role
ENTITY3ANT ALL ON DATABASE ENTITY1_DWH TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON SCHEMA ENTITY1_DWH.PUBLIC TO ROLE DATA_ENGINEER_ROLE;
USE ROLE SECURITYADMIN;

ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.PUBLIC TO DATA_ENGINEER_ROLE;

ENTITY3ANT CREATE TABLE ON SCHEMA ENTITY1_DWH.PUBLIC TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT CREATE STAGE ON SCHEMA ENTITY1_DWH.PUBLIC TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT CREATE PIPE ON SCHEMA ENTITY1_DWH.PUBLIC TO ROLE DATA_ENGINEER_ROLE;

USE ROLE SYSADMIN;
ENTITY3ANT MODIFY, MONITOR, OPERATE, USAGE ON WAREHOUSE "COMPUTE_WH" TO ROLE "DATA_ENGINEER_ROLE";

REVOKE MODIFY ON WAREHOUSE "COMPUTE_WH" FROM ROLE "DATA_ENGINEER_ROLE";

ENTITY3ANT USAGE ON DATABASE ENTITY1_DWH TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT USAGE, ON SCHEMA ENTITY1_DWH.RAF_SERVICE TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA ENTITY1_DWH.RAF_SERVICE TO ROLE DATA_ENGINEER_ROLE;

ENTITY3ANT USAGE ON DATABASE ENTITY1_DWH TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT USAGE ON SCHEMA ENTITY1_DWH.RAF_SERVICE TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT MONITOR, OPERATE, USAGE ON WAREHOUSE "COMPUTE_WH" TO ROLE "BI_TABLEAU_ROLE";

// ENTITY3ant read only usage on WH, DB and Schema
ENTITY3ANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE BI_ADHOC_ROLE;

ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA ENTITY1_DWH.PUBLIC TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON SCHEMA ENTITY1_DWH.PUBLIC TO ROLE BI_TABLEAU_ROLE;

// TODO: SSO and InteENTITY3ation setup for S3

USE ROLE ACCOUNTADMIN;

ENTITY3ANT ROLE ACCOUNTADMIN TO USER ADMIN_GOPAL;
ENTITY3ANT ROLE ACCOUNTADMIN TO USER ADMIN_SUNIL;

ENTITY3ANT ROLE SYSADMIN TO ROLE DE_SYSADMIN;

USAGE ON STAGE UTIL_DB.PUBLIC.DL_JG_ENTITY1_STG_S3_EXT TO ROLE DATA_ENGINEER_ROLE;

CREATE WAREHOUSE REPORTING_WH WITH WAREHOUSE_SIZE = 'XSMALL' WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 50 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 SCALING_POLICY = 'STANDARD';

// BI_ADHOC_ROLE Rights
CREATE WAREHOUSE ANALYSIS_WH WITH WAREHOUSE_SIZE = 'XSMALL' WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 50 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 SCALING_POLICY = 'STANDARD';

ENTITY3ANT MONITOR, OPERATE, USAGE ON WAREHOUSE "ANALYSIS_WH" TO ROLE "BI_ADHOC_ROLE";

ENTITY3ANT USAGE ON DATABASE ENTITY1_DWH TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA ENTITY1_DWH.RAF_SERVICE TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.PUBLIC TO BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA ENTITY1_DWH.RAF_SERVICE TO ROLE BI_ADHOC_ROLE;

ENTITY3ANT ROLE "BI_ADHOC_ROLE" TO USER TEST_BI_USER;
ENTITY3ANT ROLE "DATA_ENGINEER_ROLE" TO USER TEST_BI_USER;
ENTITY3ANT ROLE "BI_TABLEAU_ROLE" TO USER TEST_BI_USER;
ENTITY3ANT ROLE "DATASCIENCE_ADHOC_ROLE" TO USER TEST_BI_USER;

ENTITY3ANT USAGE ON SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA ENTITY1_DWH.RAW_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT USAGE ON SCHEMA ENTITY1_DWH.RAW_SCHEMA TO ROLE BI_TABLEAU_ROLE;

ENTITY3ANT CREATE VIEW ON SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE BI_ADHOC_ROLE;

ENTITY3ANT SELECT VIEWS ON SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON ALL VIEWS IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON FUTURE VIEWS IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE BI_TABLEAU_ROLE;

ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA ENTITY1_DWH.RAW_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.RAW_SCHEMA TO BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO BI_TABLEAU_ROLE;

ENTITY3ANT USAGE ON SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT USAGE,MODIFY ON SCHEMA ENTITY1_DWH.RAW_SCHEMA TO ROLE DATA_ENGINEER_ROLE;

ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA ENTITY1_DWH.RAW_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.RAW_SCHEMA TO ROLE BI_ADHOC_ROLE;

ENTITY3ANT USAGE ON DATABASE JENTITY3_DWH TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON DATABASE JENTITY2_DWH TO ROLE BI_ADHOC_ROLE;

// DE ARTEFACTS
ENTITY3ANT ALL ON SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO ROLE DATA_ENGINEER_ROLE;



// FUTURE ENTITY3ANTS
ENTITY3ANT ALL ON FUTURE SCHEMAS IN DATABASE UTIL_DB TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE EXTERNAL TABLES IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE VIEWS IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE MATERIALIZED VIEWS IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE STAGES IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE FILE FORMATS IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE FUNCTIONS IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE PROCEDURES IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE SEQUENCES IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE STREAMS IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE TASKS IN SCHEMA UTIL_DB.DE_ARTEFACTS_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ant execute task on account to role DATA_ENGINEER_ROLE;

// USER SPECIFIC ROLE ACCESS to DATA_ENGINEER_ROLE
ENTITY3ANT ALL ON SCHEMA ENTITY1_DWH.RAW_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE SCHEMAS IN DATABASE ENTITY1_DWH TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.RAF_SERVICE TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE EXTERNAL TABLES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE VIEWS IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE MATERIALIZED VIEWS IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
--ENTITY3ANT ALL ON FUTURE STAGES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
--ENTITY3ANT ALL ON FUTURE FILE FORMATS IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
--ENTITY3ANT ALL ON FUTURE FUNCTIONS IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
--ENTITY3ANT ALL ON FUTURE PROCEDURES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
--ENTITY3ANT ALL ON FUTURE SEQUENCES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
--ENTITY3ANT ALL ON FUTURE STREAMS IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
--ENTITY3ANT ALL ON FUTURE TASKS IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO DATA_ENGINEER_ROLE;

SHOW ENTITY3ANTS of DATA_ENGINEER_ROLE;
show ENTITY3ants to role DATA_ENGINEER_ROLE;

// SETUP

CREATE OR REPLACE DATABASE CLICKSTREAM_DB;

create schema ENTITY1_SCHEMA;
ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;

ENTITY3ANT USAGE ON DATABASE CLICKSTREAM_DB TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON DATABASE CLICKSTREAM_DB TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT SELECT,MODIFY,INSERT,DELETE ON TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE DATA_ENGINEER_ROLE;

ENTITY3ANT USAGE ON SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT USAGE ON SCHEMA CLICKSTREAM_DB.PUBLIC TO ROLE DATA_ENGINEER_ROLE;


ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA CLICKSTREAM_DB.PUBLIC TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE BI_TABLEAU_ROLE;

ENTITY3ANT ALL ON FUTURE SCHEMAS IN DATABASE CLICKSTREAM_DB TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE EXTERNAL TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE VIEWS IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE MATERIALIZED VIEWS IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE STAGES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE FILE FORMATS IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE FUNCTIONS IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE PROCEDURES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE SEQUENCES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE STREAMS IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE TASKS IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO DATA_ENGINEER_ROLE;

//CLICKSTREAM_DB Roles
ENTITY3ANT ALL ON ALL SCHEMAS IN DATABASE CLICKSTREAM_DB TO DATA_ENGINEER_ROLE;


ENTITY3ANT USAGE ON DATABASE CLICKSTREAM_DB TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT USAGE ON SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT USAGE ON SCHEMA CLICKSTREAM_DB.PUBLIC TO ROLE BI_TABLEAU_ROLE;

ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA CLICKSTREAM_DB.PUBLIC TO ROLE BI_TABLEAU_ROLE;

ENTITY3ANT USAGE ON DATABASE CLICKSTREAM_DB TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA CLICKSTREAM_DB.PUBLIC TO ROLE BI_ADHOC_ROLE;

ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA CLICKSTREAM_DB.PUBLIC TO ROLE BI_ADHOC_ROLE;


// ** SETUP - DATASCIENCE_ADHOC_ROLE ** //

ALTER WAREHOUSE "DATATSCIENCE_WH" SET WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 59 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 SCALING_POLICY = 'STANDARD' COMMENT = '';

ENTITY3ANT OPERATE, USAGE ON WAREHOUSE "DATATSCIENCE_WH" TO ROLE "DATASCIENCE_ADHOC_ROLE";

ENTITY3ANT USAGE ON DATABASE CLICKSTREAM_DB TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT USAGE ON DATABASE ENTITY1_DWH TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT USAGE ON DATABASE JENTITY3_DWH TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT USAGE ON DATABASE JENTITY2_DWH TO ROLE DATASCIENCE_ADHOC_ROLE;

ENTITY3ANT USAGE ON SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA CLICKSTREAM_DB.PUBLIC TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA ENTITY1_DWH.RAW_SCHEMA TO ROLE DATASCIENCE_ADHOC_ROLE;

ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA ENTITY1_DWH.RAW_SCHEMA TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.ETL_SCHEMA TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA ENTITY1_DWH.RAW_SCHEMA TO ROLE DATASCIENCE_ADHOC_ROLE;

ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA CLICKSTREAM_DB.PUBLIC TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA CLICKSTREAM_DB.ENTITY1_SCHEMA TO ROLE DATASCIENCE_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA CLICKSTREAM_DB.PUBLIC TO ROLE DATASCIENCE_ADHOC_ROLE;

ENTITY3ANT USAGE ON DATABASE DS_WRITER_DB TO ROLE DATA_ENGINEER_ROLE;

// ENTITY2 database RBAC
create schema ETL_SCHEMA;
create schema RAW_SCHEMA;


ENTITY3ANT ALL ON ALL SCHEMAS IN DATABASE JENTITY2_DWH TO DATA_ENGINEER_ROLE;

ENTITY3ANT USAGE ON DATABASE JENTITY2_DWH TO ROLE DATA_ENGINEER_ROLE;

ENTITY3ANT USAGE ON SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT USAGE ON SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE DATA_ENGINEER_ROLE;

ENTITY3ANT ALL ON ALL TABLES IN SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON ALL TABLES IN SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE DATA_ENGINEER_ROLE;

ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
// BI-ADHOC-ROLE
ENTITY3ANT ALL ON ALL SCHEMAS IN DATABASE JENTITY2_DWH TO BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON DATABASE JENTITY2_DWH TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE BI_ADHOC_ROLE;
// BI_TABLEAU_ROLE
ENTITY3ANT ALL ON ALL SCHEMAS IN DATABASE JENTITY2_DWH TO BI_TABLEAU_ROLE;
ENTITY3ANT USAGE ON DATABASE JENTITY2_DWH TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT USAGE ON SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT USAGE ON SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON ALL TABLES IN SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA JENTITY2_DWH.ETL_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA JENTITY2_DWH.RAW_SCHEMA TO ROLE BI_TABLEAU_ROLE;


/* AUDIENCE_DB SETUP */
CREATE OR REPLACE DATABASE AUDIENCE_DB;

create schema ETL_SCHEMA;
create schema RAW_SCHEMA;

ENTITY3ANT USAGE ON DATABASE AUDIENCE_DB TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT USAGE ON DATABASE AUDIENCE_DB TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON DATABASE AUDIENCE_DB TO ROLE BI_TABLEAU_ROLE;

ENTITY3ANT USAGE ON SCHEMA AUDIENCE_DB.ETL_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT USAGE ON SCHEMA AUDIENCE_DB.RAW_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT USAGE ON SCHEMA AUDIENCE_DB.ETL_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA AUDIENCE_DB.RAW_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT USAGE ON SCHEMA AUDIENCE_DB.ETL_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT USAGE ON SCHEMA AUDIENCE_DB.RAW_SCHEMA TO ROLE BI_TABLEAU_ROLE;

ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA AUDIENCE_DB.ETL_SCHEMA TO DATA_ENGINEER_ROLE;
ENTITY3ANT ALL ON FUTURE TABLES IN SCHEMA AUDIENCE_DB.RAW_SCHEMA TO DATA_ENGINEER_ROLE;

ENTITY3ANT SELECT,MODIFY,INSERT,DELETE ON TABLES IN SCHEMA AUDIENCE_DB.ETL_SCHEMA TO ROLE DATA_ENGINEER_ROLE;
ENTITY3ANT SELECT,MODIFY,INSERT,DELETE ON TABLES IN SCHEMA AUDIENCE_DB.RAW_SCHEMA TO ROLE DATA_ENGINEER_ROLE;

ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA AUDIENCE_DB.ETL_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA AUDIENCE_DB.RAW_SCHEMA TO ROLE BI_ADHOC_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA AUDIENCE_DB.ETL_SCHEMA TO ROLE BI_TABLEAU_ROLE;
ENTITY3ANT SELECT ON FUTURE TABLES IN SCHEMA AUDIENCE_DB.RAW_SCHEMA TO ROLE BI_TABLEAU_ROLE;


create schema ENTITY2_SCHEMA;

SHOW ENTITY3ANTS ON ETL_SCHEMA;
