            <?php
//If the form is submitted
if(isset($_POST['submit'])) {

	//Check to make sure that the name field is not empty
	if(trim($_POST['name']) == '') {
		$hasError = true;
	} else {
		$name_field = trim($_POST['name']);
	}


	//Check to make sure sure that a valid email address is submitted
	if(trim($_POST['email']) == '')  {
		$hasError = true;
	} else if (!eregi("^[A-Z0-9._%-]+@[A-Z0-9._%-]+\.[A-Z]{2,4}$", trim($_POST['email']))) {
		$hasError = true;
	} else {
		$email = trim($_POST['email']);
	}

	//Check to make sure comments were entered
	if(trim($_POST['message']) == '') {
		$hasError = true;
	} else {
		if(function_exists('stripslashes')) {
			$message = stripslashes(trim($_POST['message']));
		} else {
			$message = trim($_POST['message']);
		}
	}

	//If there is no error, send the email
	if(!isset($hasError)) {
		$emailTo = 'ana@ananelson.com'; //Put your own email address here
		$body = "From: $name_field\n\nE-Mail: $email\n\nMessage:\n\n$message";
		$headers = 'From: My Site <'.$emailTo.'>' . "\r\n" . 'Reply-To: ' . $email;
		$subject = 'Contact From Your Site';

		mail($emailTo, $subject, $body, $headers);
		$emailSent = true;
	} 
}
	
	
?>
            <?php if(isset($hasError)) { //If errors are found 
echo "<h2>Oops! There was a problem!</h2><p>Please check if you've filled all the fields with valid information. Thank you.</p>";?>
            <?php } ?>
            <?php if(isset($emailSent) && $emailSent == true) { //If email is sent ?>
            <h2>Email Successfully Sent!</h2>
            <p>Thank you <strong><?php echo $name_field;?></strong> for using my contact form! Your email was successfully sent and I will be in touch with you soon.</p>
            <?php } ?>
