-- Enable uuid-ossp extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE "users" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "name" varchar NOT NULL,
  "email" varchar UNIQUE,
  "password" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "deleted_at" timestamptz
);

CREATE TABLE "kanbans" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "name" varchar NOT NULL,
  "description" text,
  "creator_id" uuid NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "deleted_at" timestamptz
);

CREATE TABLE "kanban_users" (
  "user_id" uuid NOT NULL,
  "kanban_id" uuid NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  PRIMARY KEY ("user_id", "kanban_id")
);

CREATE TABLE "boards" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "name" varchar NOT NULL,
  "description" text,
  "order" int NOT NULL,
  "kanban_id" uuid NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "deleted_at" timestamptz
);

CREATE TABLE "items" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "name" varchar NOT NULL,
  "description" text,
  "order" int NOT NULL CHECK ("order" >= 0),
  "due_date" timestamptz,
  "board_id" uuid NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "deleted_at" timestamptz
);

CREATE TABLE "labels" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "name" varchar UNIQUE NOT NULL,
  "color" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "item_labels" (
  "item_id" uuid NOT NULL,
  "label_id" uuid NOT NULL,
  PRIMARY KEY ("item_id", "label_id")
);

CREATE INDEX ON "users" ("email");

CREATE INDEX ON "kanbans" ("creator_id");

CREATE INDEX ON "kanban_users" ("kanban_id");

CREATE INDEX ON "boards" ("kanban_id");

CREATE INDEX ON "items" ("board_id");
CREATE INDEX ON "items" ("board_id", "order");

CREATE INDEX ON "item_labels" ("item_id");

ALTER TABLE "kanbans" ADD FOREIGN KEY ("creator_id") REFERENCES "users" ("id");

ALTER TABLE "kanban_users" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;
ALTER TABLE "kanban_users" ADD FOREIGN KEY ("kanban_id") REFERENCES "kanbans" ("id") ON DELETE CASCADE;

ALTER TABLE "boards" ADD FOREIGN KEY ("kanban_id") REFERENCES "kanbans" ("id") ON DELETE CASCADE;

ALTER TABLE "items" ADD FOREIGN KEY ("board_id") REFERENCES "boards" ("id") ON DELETE CASCADE;
