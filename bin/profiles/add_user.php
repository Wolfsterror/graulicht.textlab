<?php

	header('Content-type: text/plain');

	$project = $_POST['project'];
	$nick = $_POST['nick'];
	$email = $_POST['email'];
	$password = $_POST['password'];

	// TODO: check stuff here

	$filename = "$project/$nick/user.json";
	if(file_exists($filename)) {
		$data = array("status" => false);
	} else {
		mkdir("$project/$nick", 0777, true);

		touch($filename);
		$user_data = array(
			"name" => $nick,
			"email" => $email,
			"pass" => $password
		);
		file_put_contents($filename, json_encode($user_data));
		$data = array(
			"status" => true,
			"user" => array(
				"name" => $nick,
				"email" => $email,
				"pass" => $password
			)
		);
	}
	
	echo json_encode($data);
