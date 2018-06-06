
CREATE SEQUENCE  "SQ_LSF_JOB"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 500 CACHE 20 NOORDER  NOCYCLE ;
 
CREATE TABLE "JOB_LSF" 
   (	
    "INTERNAL_JOB_ID" NUMBER(19,0) NOT NULL ENABLE, 
	"WORKING_DIRECTORY" VARCHAR2(512 BYTE), 
	"INPUT_FILENAME" VARCHAR2(512 BYTE), 
	"OUTPUT_FILENAME" VARCHAR2(512 BYTE), 
	"ERROR_FILENAME" VARCHAR2(512 BYTE), 
	"JOB_NAME" VARCHAR2(512 BYTE), 
	"QUEUE" VARCHAR2(512 BYTE), 
	"PROJECT" VARCHAR2(512 BYTE), 
	"LSF_JOB_STATUS" VARCHAR2(255 BYTE), 
	"LSF_JOB_ID" VARCHAR2(255 BYTE), 
	"STANDARD_OUTPUT" CLOB, 
	"ERROR_OUTPUT" CLOB, 
	"LISTENER_CLASS_NAME" VARCHAR2(256 BYTE), 
	"GAP_SERVER_ID" VARCHAR2(256 BYTE) NOT NULL ENABLE, 
	"COMMAND" CLOB, 
	"UPDATED_DATE" DATE, 
	 CONSTRAINT "CK_JOB_LSF_COMMAND" CHECK (command IS NOT NULL) ENABLE, 
	 PRIMARY KEY ("INTERNAL_JOB_ID") , 
	 UNIQUE ("LSF_JOB_ID")
   ) ;
 

  COMMENT ON COLUMN "JOB_LSF"."COMMAND" IS 'Command string to be run by LSF';
 
  CREATE INDEX "LSF_JOB_INDEX1_STATUS" ON "JOB_LSF" ("LSF_JOB_STATUS");
