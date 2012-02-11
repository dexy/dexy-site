record "Please leave your message at the beep.", {
    :beep => true,
    :timeout => 10,
    :silenceTimeout => 7,
    :maxTime => 60,
    :terminator => "#",
    :recordURI => "http://example.com/recording.rb",
    :transcriptionOutURI => "mailto:you@example.com"
    :onRecord => lambda { |event|
        say "You said " + event.recordURI}
}
