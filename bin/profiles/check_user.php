<?php

	header('Content-type: text/plain');

	$project = $_POST['project'];
	$nick = $_POST['nick'];
	$password = $_POST['password'];

	// TODO: check stuff here

	$filename = "$project/$nick/user.json";
	if(!file_exists($filename)) {
		$data = array("status" => false);
	} else {
		$user_data = json_decode(file_get_contents($filename));
		if($user_data->pass != $password) {
			$data = array("status" => false);
		} else {
			$data = array(
				"status" => true,
				"user" => $user_data
			);
		}
	}

	echo json_encode($data);
