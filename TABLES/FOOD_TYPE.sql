CREATE TABLE "DEV"."FOOD_TYPE"
   ("TYPE_ID" NUMBER,
	"TYPE_NAME" VARCHAR2(100) NOT NULL ENABLE,
	"PARENT_ID" NUMBER,
	"IS_SELECTABLE" NUMBER(1,0),
	"TYPE_CODE" VARCHAR2(100),
	 PRIMARY KEY ("TYPE_ID")
      USING INDEX  ENABLE,
	 CONSTRAINT "UNIQUE_TYPE_NAME" UNIQUE ("TYPE_NAME")
      USING INDEX  ENABLE,
	 FOREIGN KEY ("PARENT_ID")
	  REFERENCES "DEV"."FOOD_TYPE" ("TYPE_ID") ENABLE
   );
   
   CREATE INDEX "DEV"."I_PARENTID$FOOD_TYPE" ON "DEV"."FOOD_TYPE" ("PARENT_ID");
   CREATE UNIQUE INDEX "DEV"."UNIQUE_TYPE_NAME" ON "DEV"."FOOD_TYPE" ("TYPE_NAME");
   
   COMMENT ON COLUMN "DEV"."FOOD_TYPE"."TYPE_ID" IS 'Food type identifier';
   COMMENT ON COLUMN "DEV"."FOOD_TYPE"."TYPE_NAME" IS 'Food type name';
   COMMENT ON COLUMN "DEV"."FOOD_TYPE"."PARENT_ID" IS 'Parent type';
   COMMENT ON COLUMN "DEV"."FOOD_TYPE"."IS_SELECTABLE" IS '0 - not selectable, 1 - selectable';
   COMMENT ON COLUMN "DEV"."FOOD_TYPE"."TYPE_CODE" IS 'Food type code';