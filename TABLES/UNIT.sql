CREATE TABLE "DEV"."UNIT"
   ("UNIT_ID" NUMBER,
	"UNIT_NAME" VARCHAR2(100) NOT NULL ENABLE,
	"PARENT_ID" NUMBER,
	"FACTOR" NUMBER,
	 PRIMARY KEY ("UNIT_ID")
      USING INDEX  ENABLE,
	 UNIQUE ("UNIT_NAME")
      USING INDEX  ENABLE,
	 FOREIGN KEY ("PARENT_ID")
	  REFERENCES "DEV"."UNIT" ("UNIT_ID") ENABLE
   );
   
   CREATE INDEX "DEV"."I_PARENTID$UNIT" ON "DEV"."UNIT" ("PARENT_ID");
   
   COMMENT ON COLUMN "DEV"."UNIT"."UNIT_ID" IS 'Unit identifier';
   COMMENT ON COLUMN "DEV"."UNIT"."UNIT_NAME" IS 'Unit name';
   COMMENT ON COLUMN "DEV"."UNIT"."PARENT_ID" IS 'Parent unit';
   COMMENT ON COLUMN "DEV"."UNIT"."FACTOR" IS 'Unit factor';