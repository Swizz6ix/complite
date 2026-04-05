CREATE TABLE event_queue (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  type TEXT,
  payload TEXT,
  created_at INTEGER
);