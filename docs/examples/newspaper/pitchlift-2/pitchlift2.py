from hashlib import md5
from tropo import Tropo, Choices, Result
import boto
import json
import pitch
import random
import re
import web

urls = (
        '/listen', 'ListenTropo',
        '/menu/(initial|index|cont)', 'MenuTropo',
        '/record/([0-9a-f]+)', 'RecordPitchTropo',
        '/record/after/([0-9]+)', 'AfterRecordPitchTropo',
        '/record/after/cont/([0-9]+)', 'AfterRecordPitchContTropo',
        '/sms.json', 'SmsTropo',
        '/transcription/([0-9a-f]+)', 'TranscriptionTropo',
        '/(.*)', 'Index'
        )

render = web.template.render('templates/')

class BaseTropo(object):
    """
    Defines some convenience methods.
    """
    S3_BUCKET_NAME="pitchlift"
    S3_URL_TIMEOUT=120
    MAIN_MENU="/menu/index"

    def get_result(self):
        return Result(web.data())

    ### @export "get-answer"
    def get_answer(self):
        """
        Retrieves the user-supplied value after an 'ask'
        """
        r = self.get_result()
        try:
            return r.getValue()
        except KeyError:
            return None

    ### @export "do-bad-choice"
    def do_bad_choice(self, goto=MAIN_MENU):
        t = Tropo()
        t.say("Sorry, I don't understand.")
        t.on(event = "continue", next=goto)
        return t.RenderJson()

    def s3_bucket(self):
        conn = boto.connect_s3()
        return boto.s3.bucket.Bucket(conn, name=self.S3_BUCKET_NAME)

    def s3_key_name(self, pitch_id):
        return "%s.wav" % pitch_id

    def s3_key(self, pitch_id):
        """
        Fetches an existing S3 key based on the pitch id.
        """
        bucket = self.s3_bucket()
        key = self.s3_key_name(pitch_id)
        return bucket.get_key(key)

    def s3_upload(self, pitch_id, data):
        """
        Creates a new S3 key for the pitch id and populates with the passed data.
        """
        bucket = self.s3_bucket()
        key = boto.s3.key.Key(bucket)
        key.key = self.s3_key_name(pitch_id)
        key.set_contents_from_string(data)
        key.set_acl('public-read')

    def s3_url(self, pitch_id):
        return "http://s3.amazonaws.com/pitchlift/%s.wav" % pitch_id

### @export "transcription-tropo"
class TranscriptionTropo(BaseTropo):
    def POST(self, pitch_key):
        p = pitch.get_pitch_by_key(pitch_key)
        storage = web.input()
        transcription = storage["result[transcription]"]
        pitch.save_transcription(p['pitch_id'], transcription)

### @export "listen"
class ListenTropo(BaseTropo):
    def POST(self):
        t = Tropo()

        answer = self.get_answer()

        if re.match("[0-9]{5}", answer):
            pitch_id = answer

            # test that the pitch exists...
            pitch.get_pitch(pitch_id)

            t.say("You want to hear pitch")
            for c in pitch_id:
                t.say(c)

        elif answer in ("0", "random"):
            pitch_id = pitch.random_pitch()['pitch_id']
            if pitch_id:
                # test that the pitch exists...
                pitch.get_pitch(pitch_id)

                t.say("Your random pitch is pitch number")
                for c in pitch_id:
                    t.say(c)
            else:
                t.say("Sorry, no pitches are available yet.")

        elif answer == None:
            return self.do_bad_choice()

        else:
            raise Exception("unexpected answer %s" % answer)

        if pitch_id:
            url = self.s3_url(pitch_id)
            t.say(url)

        t.on(event="continue", next=self.MAIN_MENU)
        return t.RenderJson()

### @export "after-record-pitch-tropo"
class AfterRecordPitchTropo(BaseTropo):
    def POST(self, pitch_id):
        t = Tropo()

        t.say("here is your pitch")
        print self.s3_url(pitch_id)
        url = self.s3_url(pitch_id)
        t.say(url)

        choices = Choices("happy (1, happy), redo (2, redo)")
        prompt = "If you are happy with this pitch"
        prompt += "press 1 or say happy now."
        prompt += "If you would like to redo this pitch,"
        prompt += "press 2 or say redo now."
        t.ask(choices, say=prompt)

        t.on(event="continue", next="/record/after/cont/%s" % pitch_id)
        return t.RenderJson()

### @export "after-record-pitch-cont-tropo"
class AfterRecordPitchContTropo(BaseTropo):
    def POST(self, pitch_id):
        answer = self.get_answer()

        if answer == "happy":
            return self.do_happy(pitch_id)
        elif answer == "redo":
            return self.do_redo(pitch_id)
        elif answer == None:
            return self.do_bad_choice("/record/after/cont/%s" % pitch_id)
        else:
            raise Exception("unexpected answer %s" % answer)

    ### @export "do-happy"
    def do_happy(self, pitch_id):
        t = Tropo()
        pitch.confirm_pitch(pitch_id)
        t.say("Great, your pitch has been saved.")

        p = pitch.get_pitch(pitch_id)

        ### @export "send-info-sms"
        call_id = json.loads(web.data())['result']['callId']
        session = pitch.session_info(call_id)

        is_sip = session['caller_network'] == 'SIP'
        is_number = re.match("^(\+)?[0-9]+$", session['caller_id'])

        if is_sip and is_number:
            t.message(
                    """Thank you for using pitchlift!
                    Your Pitch ID is %s.
                    Your PIN is %s.""" % (pitch_id, p['pin']),
                    to=session['caller_id'],
                    channel='TEXT'
                    )

        ### @export "say-info-aloud"
        t.say("Your pitch eye dee is")
        for c in pitch_id:
            t.say(c)
        t.say("Your pin is")
        for c in "%s" % p['pin']:
            t.say(c)
        t.say("once again")
        t.say("Your pitch eye dee is")
        for c in pitch_id:
            t.say(c)
        t.say("Your pin is")
        for c in "%s" % p['pin']:
            t.say(c)

        ### @export "finish"
        t.on(event="continue", next=self.MAIN_MENU)
        return t.RenderJson()

    ### @export "do-redo"
    def do_redo(self, pitch_id):
        t = Tropo()
        pitch.cancel_pitch(pitch_id)
        t.say("Ok, you can start over and make a new pitch.")
        t.on(event="continue", next=self.MAIN_MENU)
        return t.RenderJson()

### @export "record-pitch-tropo"
class RecordPitchTropo(BaseTropo):
    def POST(self, pitch_key):
        p = pitch.get_pitch_by_key(pitch_key)
        recording = web.input()['filename']
        self.s3_upload(p['pitch_id'], recording)

### @export "index"
class Index(BaseTropo):
    def GET(self, name):
        return render.index(name, pitch, self.s3_url)

### @export "main-menu"
class MenuTropo(BaseTropo):
    MENU_OPTIONS =(
    (
        "pitch",
        "If you would like to make an elevator pitch that other people can listen to",
        "you want to record a pitch"
    ),
    (
        "listen",
        "If you would like to listen to other people's elevator pitches",
        "you want to listen to pitches"
    ),
    (
        "remove",
        "If you would like to remove an elevator pitch you recorded earlier",
        "you want to remove a pitch"
    )
)

    ### @export "main-menu-prompt"
    def prompt(self):
        """
        Returns prompt based on MENU_OPTIONS
        """
        prompts = []
        for i, option_array in enumerate(self.MENU_OPTIONS):
            args = {
                    "name" : option_array[0],
                    "prompt" : option_array[1],
                    "response" : option_array[2],
                    "number" : i+1
                    }
            prompts.append("%(prompt)s, please press %(number)s or say %(name)s" % args)
        return " ".join(prompts)

    ### @export "main-menu-choices"
    def choices(self):
        """
        Returns a dict of valid choices and the name of the  choice they correspond to.
        """
        choices = []
        for i, option_array in enumerate(self.MENU_OPTIONS):
            args = {
                    "name" : option_array[0],
                    "prompt" : option_array[1],
                    "response" : option_array[2],
                    "number" : i+1
                    }
            choices.append("%(name)s (%(number)s, %(name)s)" % args)
        return ",".join(choices)

    ### @export "main-menu-initial"
    def initial(self):
        # save session info for this call
        session_info = json.loads(web.data())['session']

        tropo_call_id = session_info['callId']
        caller_network = session_info['from']['network']
        caller_channel = session_info['from']['channel']
        caller_id = session_info['from']['id']

        pitch.new_session(
                tropo_call_id,
                caller_network,
                caller_channel,
                caller_id)

        # now do main menu
        return self.index()

    ### @export "main-menu-index"
    def index(self):
        t = Tropo()
        t.say("Welcome to Pitchlift")
        choices = Choices(self.choices())
        t.ask(choices, say=self.prompt())
        t.on(event="continue", next="/menu/cont")
        return t.RenderJson()

    ### @export "main-menu-cont"
    def cont(self):
        answer = self.get_answer()

        if answer == "listen":
            return self.do_listen()
        elif answer == "pitch":
            return self.do_pitch()
        elif answer == "remove":
            return self.do_remove()
        elif answer == None:
            return self.do_bad_choice()
        else:
            raise Exception("unexpected answer %s" % answer)

    ### @export "generate-pitch-id"
    def generate_pitch_id(self):
        while True:
            pitch_id = random.randint(10000, 99999)
            is_already_used = pitch.is_pitch(pitch_id)

            if not is_already_used:
                break

        return pitch_id

    ### @export "generate-pitch-pin"
    def generate_pitch_pin(self):
        return random.randint(1000, 9999)

    ### @export "generate-pitch-key"
    def generate_pitch_key(self):
        """
        Generate a unique secret key which will be used to authenticate
        postings of recordings.
        """
        while True:
            random_string = "%s" % random.random()
            key = md5(random_string).hexdigest()
            is_already_used = pitch.is_key(key)

            if not is_already_used:
                break
        return key

    ### @export "do-pitch"
    def do_pitch(self):
        pitch_id = self.generate_pitch_id()
        pitch_pin = self.generate_pitch_pin()
        pitch_key = self.generate_pitch_key()

        pitch.new_pitch(pitch_id, pitch_pin, pitch_key, "pending")

        ### @export "recording-instructions"
        t = Tropo()
        t.say("You will soon be prompted to record your elevator pitch")
        t.say("Please have pen and paper ready")
        t.say("Please start making your pitch when you hear the beep")

        ### @export "make-recording"
        t_url = "http://50.17.37.57:8081/transcription/%s" % pitch_key
        t.record(
            beep = True,
            choices = '#',
            maxTime = 120,
            say = """Press pound when finished
            to listen to your recording.""",
            silenceTimeout = 7,
            timeout = 10,
            transcription = {
              "url" : t_url
            },
            url = "http://50.17.37.57:8081/record/%s" % pitch_key
            )

        ### @export "finish"
        t.on(event="continue", next="/record/after/%s" % pitch_id)
        return t.RenderJson()

    ### @export "do-listen"
    def do_listen(self):
        prompt = """
        If you know the five digit pitch eye dee
        you want to listen to, please enter it now.
        If you want to hear a random pitch,
        press zero or say random"""

        t = Tropo()
        choices = Choices("0, random, [5 DIGITS]")
        t.ask(choices, say=prompt)
        t.on(event="continue", next="/listen")
        return t.RenderJson()

    ### @export "do-remove"
    def do_remove(self):
        t = Tropo()
        raise Exception("todo implement")
        t.say("removing")
        t.on(event="continue", next=self.MAIN_MENU)
        return t.RenderJson()

    ### @export "main-menu-post"
    def POST(self, name):
        if name == 'index':
            return self.index()
        elif name == 'cont':
            return self.cont()
        elif name == 'initial':
            return self.initial()
        else:
            raise Exception("unexpected page %s" % name)

### @end
class SmsTropo:
    def POST(self):
        t = Tropo()
        t.say("This is an SMS from Pitchlift")
        return t.RenderJson()

app = web.application(urls, globals())

if __name__ == '__main__':
    app.run()
