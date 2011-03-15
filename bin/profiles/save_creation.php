<?php

	header('Content-type: text/plain');

	if(TRUE == function_exists('get_magic_quotes_gpc') && 1 == get_magic_quotes_gpc()) {
		$project = stripslashes($_POST['project']);
		$nick = stripslashes($_POST['nick']);
		$password = stripslashes($_POST['password']);
		$machine = stripslashes($_POST['machine']);
		$machine_name = stripslashes($_POST['filename']);
	} else {
		$project = $_POST['project'];
		$nick = $_POST['nick'];
		$password = $_POST['password'];
		$machine = $_POST['machine'];
		$machine_name = $_POST['filename'];
	}

	// TODO: check stuff here

	$user_filename = "$project/$nick/user.json";
	if(!file_exists($user_filename)) {
		$data = array("status" => false, "message" => "no user with name $nick");
	} else {
		$user_data = json_decode(file_get_contents($user_filename));
		if($user_data->pass != $password) {
			$data = array("status" => false, "message" => "$password is no hash for a mighty warrior");
		} else {
			$creation_filename = "$project/$nick/creations/$machine_name.json";
			if(!file_exists($creation_filename)) {
				file_put_contents($creation_filename, $machine);
				$data = array(
					"status" => true,
					"message" => "$creation_filename created"
				);
			} else {
				$data = array("status" => false, "message" => "there is already a file with that name: $creation_filename");
			}
		}
	}

	echo json_encode($data);
