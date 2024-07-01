<?php
define('DB_NAME', getenv('DB_NAME'));
define('DB_USER', getenv('DB_USER'));
define('DB_USER_PASSWORD', getenv('DB_USER_PASSWORD'));
define('DB_HOST', getenv('DB_HOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         '|]G[PJdMzb)=#u;R/Rr;a}LhXMu97bvj]b}e!?R[W6^-)+QlwZH$JMG<69|S+s<M');
define('SECURE_AUTH_KEY',  '1QXGxYuE6Zv|0*(|mZ%yER9_kr2!@6$Ln@j)<nU`-CMu^2O?+Ii(z<G R.6J3U8+');
define('LOGGED_IN_KEY',    '}&ThX?3b08ox3|-#a|&w3-}!5<x&Ls$%%b3U3h=`*jV+W?nyuy*puJWl/-Re*w-A');
define('NONCE_KEY',        'U}QQ;~QeM[e-xsH5&w_:3^/NWD(Gu [u`e9mq,XqSp5J4,ynBcLM%Q1(Tx(iG9qX');
define('AUTH_SALT',        'j+JzCdX0Ix|=[(+=Rh6zYy9a]YRUG#N@Q{86r{!UMRPNEN9BP.(bxN`]RJ,!$Z<I');
define('SECURE_AUTH_SALT', '|(.zPmQY#=Ejr9sDtr]|=U!OlehZkJ{Nw5!5jMtk?QLVK,[cA*AAe]^}6j5<aXy6');
define('LOGGED_IN_SALT',   'J9FES2~.|etq5E<+TEDuV5iAWk|LYnf}QN#|q})#W;%OCLY+$}(9yDkfaMI}38VE');
define('NONCE_SALT',       '@vd+L>6Us_YjG?<3s-O<u7_-qpq?8&(aS%+TEOa-O/a$+Q1J&:QFh34[&1t|:IoW');

$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
