<?php
define('DB_NAME', getenv('DB_NAME'));
define('DB_USER', getenv('DB_USER'));
define('DB_PASSWORD', getenv('DB_PASSWORD'));
define('DB_HOST', getenv('DB_HOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         'ajDWn-Xo@DShIDXbKSxmdp0s?z+5vnO]Yz&+HMuqMz0M@@Q!ekxuYc X||*#3=?J');
define('SECURE_AUTH_KEY',  'pixK-!HE,/s: HEXS,EcbnfbLaf1IK?K(!=7mOfj*p!NMh4t7DPj%jU*}gJq}5|.');
define('LOGGED_IN_KEY',    'oF|-7[Q{W9GtFLz?s9VQBP3Xy54O+/a<7kV<.[(uy`>~#g|1jya*Pkx|? 6m|nG<');
define('NONCE_KEY',        '>o%X[,qa>.n(1X5EWr>|^m{i 9DIeTjtz-B01(bCtVpSHT<x^c7*F(F#HYqJodK!');
define('AUTH_SALT',        'h!KnV6>o#d8jH9:8sB5S|ULP^8Pn/fXBGl&J._?#-^9&AJj^k]G1aAnL;8zK+t6]');
define('SECURE_AUTH_SALT', 'w#%!3r^t(Rhd}ed|W9EX=fV3sJiuqaPC}=/e+fe5lQ3MI >]>72ZroyEV,L}Qr(0');
define('LOGGED_IN_SALT',   '}4Vt 5?aOb+oe?[07{RE.L%M3:]3d+7-Q6y/dUU|s/-v8)6PN|uSJgYrBF2:fb$p');
define('NONCE_SALT',       '8:(%P2pE#jc.kI-CXzndqV8,B-u xy*$x|hFpUXWBnvgN&074rLQX-+00Sz^S|cU');

$table_prefix = 'wp_';

if (!defined('ABSPATH')) {
	define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';