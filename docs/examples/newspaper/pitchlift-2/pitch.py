import web
import random

db = web.database(dbn='sqlite', db='pitch.sqlite3')

def new_session(tropo_call_id, caller_network, caller_channel, caller_id):
    db.insert('sessions', **locals())

def session_info(tropo_call_id):
    return db.select('sessions', where='tropo_call_id=$tropo_call_id', vars=locals())[0]

### @export "random-pitch"
def random_pitch():
    pitches = get_pitches()
    count = count_pitches()
    if count > 0:
        r = random.randint(0, count-1)
        return pitches[r]
    else:
        return None

### @export "count-pitches"
def count_pitches():
    results = db.query('SELECT COUNT(*) AS count_pitches FROM pitches where state="confirmed"')
    count = results[0].count_pitches
    return count

### @export "get-pitches"
def get_pitches():
    return db.select('pitches', where='state="confirmed"')

### @export "end"
def is_key(key):
    results = db.query('SELECT COUNT(*) AS count_keys FROM pitches where key=$key and state="confirmed"', vars=locals())
    count = results[0].count_keys
    if count == 0:
        return False
    elif count == 1:
        return True
    else:
        raise Exception("More than one pitch with key %s" % key)

def is_pitch(pitch_id):
    results = db.query('SELECT COUNT(*) AS count_pitches FROM pitches where pitch_id=$pitch_id and state="confirmed"', vars=locals())
    count = results[0].count_pitches
    if count == 0:
        return False
    elif count == 1:
        return True
    else:
        raise Exception("More than one pitch with id %s" % pitch_id)

def get_pitch_by_key(key):
    return db.select('pitches', where='key=$key', vars=locals())[0]

def get_pitch(pitch_id):
    return db.select('pitches', where='pitch_id=$pitch_id', vars=locals())[0]

def new_pitch(pitch_id, pin, key, state):
    db.insert('pitches', **locals())

def delete_pitch(pitch_id):
    db.delete('pitches', where='pitch_id=$pitch_id', vars=locals())

def confirm_pitch(pitch_id):
    db.update('pitches', where='pitch_id=$pitch_id', vars=locals(), state="confirmed")

def cancel_pitch(pitch_id):
    db.update('pitches', where='pitch_id=$pitch_id', vars=locals(), state="cancelled")

def save_transcription(pitch_id, transcription):
    db.update('pitches', where='pitch_id=$pitch_id', vars=locals(), transcription=transcription)
