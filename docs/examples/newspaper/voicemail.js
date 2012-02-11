record("Please leave your message at the beep.", {
    beep:true,
    timeout:10,
    silenceTimeout:7,
    maxTime:60,
    terminator:'#',
    recordURI:"http://example.com/recording.js",
    transcriptionOutURI: "mailto:you@example.com",
    onRecord: function(event) {
                   say("You said " + event.recordURI);
                       }
});
