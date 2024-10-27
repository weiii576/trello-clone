-- Drop soft delete triggers
DROP TRIGGER IF EXISTS soft_delete_users ON users;
DROP TRIGGER IF EXISTS soft_delete_kanbans ON kanbans;
DROP TRIGGER IF EXISTS soft_delete_boards ON boards;
DROP TRIGGER IF EXISTS soft_delete_items ON items;
DROP TRIGGER IF EXISTS soft_delete_labels ON labels;
DROP TRIGGER IF EXISTS soft_delete_item_labels ON item_labels;
DROP TRIGGER IF EXISTS soft_delete_comments ON comments;
DROP TRIGGER IF EXISTS soft_delete_attachments ON attachments;

-- Drop the soft_delete function
DROP FUNCTION IF EXISTS soft_delete();

-- Drop foreign key constraints
ALTER TABLE IF EXISTS "attachments" DROP CONSTRAINT IF EXISTS attachments_user_id_fkey;
ALTER TABLE IF EXISTS "attachments" DROP CONSTRAINT IF EXISTS attachments_item_id_fkey;
ALTER TABLE IF EXISTS "comments" DROP CONSTRAINT IF EXISTS comments_item_id_fkey;
ALTER TABLE IF EXISTS "comments" DROP CONSTRAINT IF EXISTS comments_user_id_fkey;
ALTER TABLE IF EXISTS "items" DROP CONSTRAINT IF EXISTS items_board_id_fkey;
ALTER TABLE IF EXISTS "items" DROP CONSTRAINT IF EXISTS items_label_id_fkey;
ALTER TABLE IF EXISTS "boards" DROP CONSTRAINT IF EXISTS boards_kanban_id_fkey;
ALTER TABLE IF EXISTS "kanban_users" DROP CONSTRAINT IF EXISTS kanban_users_kanban_id_fkey;
ALTER TABLE IF EXISTS "kanban_users" DROP CONSTRAINT IF EXISTS kanban_users_user_id_fkey;
ALTER TABLE IF EXISTS "kanbans" DROP CONSTRAINT IF EXISTS kanbans_creator_id_fkey;

-- Drop indexes
DROP INDEX IF EXISTS idx_attachments_user_id;
DROP INDEX IF EXISTS idx_attachments_item_id;
DROP INDEX IF EXISTS idx_comments_user_id;
DROP INDEX IF EXISTS idx_comments_item_id;
DROP INDEX IF EXISTS idx_items_board_id_order;
DROP INDEX IF EXISTS idx_items_board_id;
DROP INDEX IF EXISTS idx_item_labels_item_id;
DROP INDEX IF EXISTS idx_boards_kanban_id;
DROP INDEX IF EXISTS idx_kanban_users_kanban_id;
DROP INDEX IF EXISTS idx_kanban_users_kanban_id_user_id;
DROP INDEX IF EXISTS idx_kanbans_creator_id;
DROP INDEX IF EXISTS idx_users_email;

-- Drop tables
DROP TABLE IF EXISTS "attachments";
DROP TABLE IF EXISTS "comments";
DROP TABLE IF EXISTS "item_labels";
DROP TABLE IF EXISTS "labels";
DROP TABLE IF EXISTS "items";
DROP TABLE IF EXISTS "boards";
DROP TABLE IF EXISTS "kanban_users";
DROP TABLE IF EXISTS "kanbans";
DROP TABLE IF EXISTS "users";

-- Disable uuid-ossp extension
DROP EXTENSION IF EXISTS "uuid-ossp";

