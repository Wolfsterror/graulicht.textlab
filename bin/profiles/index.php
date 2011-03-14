<?php

	header('Content-type: text/plain');

	$data = array('message' => "Hello world.", 'version' => 0.1);
	echo json_encode($data);
