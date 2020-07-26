#!/bin/bash
read -p 'Nom du repo : ' project_name
## Le nom du repo sera aussi le nom du projet
read -p 'adresse repo : ' repo_link
git clone $repo_link $project_name

if [ -e $project_name ]; then
	cd $project_name
	mkdir src src/Controllers src/Models src/Views
	touch index.php
	echo -e "
	<?php \n
	require_once __DIR__ . '/vendor/autoload.php';" > index.php
	curl -sS https://getcomposer.org/installer | php
	php composer.phar install 

	#if [ -e composer.json ]; then
	#composer dump-autoload -o
	#else
		touch composer.json
		echo -e '
{
	"name":' '"'"$project_name"'"'',
	"require": {

	},
	"autoload": {
		"psr-4": {
			' '"'"$project_name"\\'\\''":' '"src/"
		}
	},
	"authors": [
		{
			"name": "FEREGOTTO Romain",
			"email": "romain.feregotto@gmail.com"
		}
	]
}
		' > composer.json

		composer dump-autoload -o
	#fi
else
echo "L'adresse du repo ne permet pas de git clone"
exit
fi

rm composer.phar
echo "Success ! Enjoy"
exit

