<?php
if (isset($argv[1])) {
	$files = [
	    "docker-compose.yaml",
        "docker-compose-dev.yaml",
        "docker-compose-dev.local.yaml",
        "docker-compose-stage.yaml",
        "docker-compose-prod.yaml",
        "install.sh",
        "Makefile",
        "docker/nginx/nginx.conf",
        "docker/php-fpm/Dockerfile"
    ];
	foreach ($files as $file) {

        $str=file_get_contents($file);

        $str=str_replace("appName", $argv[1],$str);

        file_put_contents($file, $str);
    }
} else {
	echo "Example: php new_project.php project_name \n";
}

