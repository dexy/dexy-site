CREATE TABLE pitches (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pitch_id INTEGER,
    pin INTEGER,
    key TEXT,
    callerid TEXT,
    transcription TEXT,
    state TEXT
);

CREATE TABLE sessions (
    tropo_call_id TEXT,
    caller_network TEXT,
    caller_channel TEXT,
    caller_id TEXT
);
