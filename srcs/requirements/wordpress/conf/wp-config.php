<?php
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('SQL_DATABASE') );

/** MySQL database username */
define( 'DB_USER', getenv('SQL_USER') );

/** MySQL database password */
define( 'DB_PASSWORD', getenv('SQL_PASSWORD') );

/** MySQL hostname */
define( 'DB_HOST', getenv('WORDPRESS_DB_HOST') );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );