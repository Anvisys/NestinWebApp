  <?php
		
		 if(isSet($_POST['submitbtn']))
			{
				$fullName = $_POST['name'];
				$emailId = $_POST['email_address'];
				$message = $_POST['query'];

	
                              $body = "
				Full Name : $fullName
				Email Id : $emailId
				Message : $message
				";
				$tos =   "791jha@gmail.com";
				
				$subject = "Enquiry  Mail from Doctor website !";

                                $headers = "From: enquiry@nestin.online" . "\r\n" .
                                
			      
				mail($tos, $subject ,$body , $headers);

				}
	          ?>
</html>
