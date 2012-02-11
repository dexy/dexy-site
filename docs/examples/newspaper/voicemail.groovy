record("Please leave your message at the beep.", [
    beep: true,
    timeout: 10,
    silenceTimeout: 7,
    maxTime: 60,
    terminator: "#",
    recordURI: "http://www.example.com/recording.groovy",
    transcriptionOutURI: "mailto:you@example.com",
    onRecord: { event->
               say("You said " + event.recordURI)}
   ])
