<?php
record("Please leave your message at the beep.", array(
    "beep"=>true,
    "timeout"=>10,
    "silenceTimeout"=>7,
    "maxTime"=>60,
    "terminator" => "#",
    "recordURI" => "http://www.example.com/recording.php",
    "transcriptionOutURI" => "mailto:you@example.com",
    "onRecord"=>"recordFCN"
)
                                                                                            );
function recordFCN($event) {
    say("You said" . $event->recordURI);
}
?>
