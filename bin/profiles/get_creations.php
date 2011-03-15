<?php

	header('Content-type: text/plain');

	$project = $_POST['project'];
	$nick = $_POST['nick'];
	$password = $_POST['password'];

	// TODO: check stuff here

	$user_filename = "$project/$nick/user.json";
	if(!file_exists($user_filename)) {
		$data = array("status" => false, "message" => "no user with name $nick");
	} else {
		$user_data = json_decode(file_get_contents($user_filename));
		if($user_data->pass != $password) {
			$data = array("status" => false, "message" => "$password is no hash for a mighty warrior");
		} else {
			$creations = array();
			if ($handle = opendir("$project/$nick/creations")) {
				while (false !== ($file = readdir($handle))) {
					if ($file != "." && $file != "..") {
						array_push($creations, "$project/$nick/creations/$file");
					}
				}
				closedir($handle);
			}
			$data = array(
				"status" => true,
				"creations" => $creations
			);
		}
	}
	
	echo json_encode($data);
