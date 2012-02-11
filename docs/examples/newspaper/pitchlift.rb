FTP_USERNAME = "ananelson"
FTP_PASSWORD = "RgHxvqakmfRv7"

### @export "say-welcome"
say "Welcome to Pitchlift."

### @export "construct-pitch-files-list"
$pitch_files = {}

require 'net/ftp'
Net::FTP.open('ftp.tropo.com', FTP_USERNAME, FTP_PASSWORD) do |ftp|
    ftp.chdir('www/pitchlift')
    files = ftp.nlst()
    files.each do |f|
        if f =~ /^pitchlift\-([0-9]{5})\-([0-9]{4})-([0-9\+]+)\.mp3/
            $pitch_files[$1] = {
            :pin => $2,
            :callerid => $3,
            :filename => $~
        }
        end
    end
end

say "There are currently #{$pitch_files.length} pitches to listen to."

### @export random-pitch-id
def random_pitch_id
    begin
        pitch_id = rand(100_000)

        is_5_digits = pitch_id < 100_000 and pitch_id > 10_000
        is_already_used = $pitch_files.keys.include?(pitch_id)
    end until (is_5_digits and not is_already_used)
    return pitch_id
end

### @export random-pin
def random_pin
    begin
        random_pin = rand(10_000)
    end until (random_pin < 10_000 and random_pin > 1_000)
    random_pin
end

### @export is-valid-caller-id
is_sip = $currentCall.network === "SIP"
is_number = $currentCall.callerID =~ /^(\+)?[0-9]+$/
is_valid_caller_id = is_sip and is_number

### @export "uri-helper-methods"
def ftp_uri_for_pitch(pitch_id, pin, caller_id)
    "ftp://ftp.tropo.com/www/pitchlift/pitchlift-#{pitch_id}-#{pin}-#{caller_id}.mp3"
end

def http_uri_for_filename(filename)
    "http://hosting.tropo.com/44819/www/pitchlift/#{filename}"
end

### @export "do-record"
def do_record
    pitch_id = random_pitch_id()
    pin = random_pin()

    if is_valid_caller_id
        caller_id = $currentCall.callerID
    else
        caller_id = "0"
    end

    ### @export "recording-instructions"
    say "You will be prompted to record your elevator pitch."
    say "Please start making your pitch when you hear the beep."

    ### @export "record-pitch"
    record "Press pound when finished to listen to your recording.", {
        :beep => true,
        :timeout => 10,
        :silenceTimeout => 7,
        :maxTime => 120,
        :terminator => "#",
        :recordFormat => "audio/mp3",
        :recordURI => "/record"
    }

    say "Your pitch eye dee is #{pitch_id}.
    You can share this eye dee with anyone
    who wants to listen to your pitch.
    Your private PIN is #{pin}, please keep this secret."

    if is_valid_caller_id
        say "We will text you a copy of your pitch eye dee and pin."
        # send a text message
        message "Thank you for using pitchlift!
        Your pitch id is #{pitch_id}. Your PIN is #{pin}", {
            :to => caller_id,
            :network => 'SMS'
        }
    end
end

### @export "do-listen"
def do_listen
    result = ask "If you know the five digit pitch eye dee you want to listen to, please enter it now. If you want to hear a random pitch, press zero or say random", { :choices => "0, random, [5 DIGIT]" }
    if ["0", "random"].include? result.value
        # select a random pitch id
        number_of_pitches = $pitch_files.length
        if number_of_pitches == 0
            say "Sorry, there are no available pitches to listen to."
        else
            pitch_id = $pitch_files.keys[rand(number_of_pitches)]
            log "randomly chose " + pitch_id
        end
    else
        pitch_id = result.value
    end
    say "You will now hear pitch #{pitch_id}"
    say http_uri_for_filename($pitch_files[pitch_id][:filename])
end

### @export "do-remove"
def do_remove
    say "removing..."
end

# Main menu loop will automatically read out prompt and give the valid choices,
# which should be in the form of a number to press (first) or a word to say
# (second).
menu_options = [
    [
        "pitch",
        "If you would like to make an elevator pitch that other people can listen to",
        "you want to record a pitch"
    ],
    [
        "listen",
        "If you would like to listen to other people's elevator pitches",
        "you want to listen to pitches"
    ],
    [
        "remove",
        "If you would like to remove an elevator pitch you recorded earlier",
        "you want to remove a pitch"
    ]
]

prompts = []
choices = {}
responses = {}

menu_options.each_with_index do |option_array, i|
    option_number = i+1
    option_name, option_prompt, option_response = option_array
    prompts << "#{option_prompt}, please press #{option_number} or say #{option_name}. "

    # set up choices hash so we can look up option name by name or number.
    choices[option_number.to_s] = option_name
    choices[option_name] = option_name

    # make it easy to get the appropriate response later
    responses[option_name] = option_response
end

prompt = prompts.join(" ")
valid_choices = choices.keys().join(",")

# main menu loop
10.times do
    result = ask prompt, { :choices => valid_choices, :bargein => false }
    choice = choices[result.value]

    if !choice.nil?
        # read the acknowledgement
        say responses[choice]

        # run the method that implements this choice
        send("do_#{choice}")

        say "returning to main menu. you can hang up any time to end this call."
    else
        say "sorry, I don't understand"
    end
end

say "Thank you, goodbye. Please call back any time."

