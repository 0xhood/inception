<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '{{DB-NAME}}' );

/** Database username */
define( 'DB_USER', '{{DB-USER}}' );

/** Database password */
define( 'DB_PASSWORD', '{{DB-PASS}}' );

/** Database hostname */
define( 'DB_HOST', '{{DB-HOST}}' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          'qE.Ui792y*?=c+V}O/ZwYyM[N}hSGi|70`?`eqL/,N^g]B9bsjd~Zh~&be!W Ss{' );
define( 'SECURE_AUTH_KEY',   'O5@L%FVJ@E=p@C1PLSmCEM?YUJ^~zP}Vgu[$Ef3Vl=nCGlZpqj#(gH^0^K$:Dt1[' );
define( 'LOGGED_IN_KEY',     'kZ~(4 XlBRa]kN?B~ql3`-5,,e`foMe5X=lQ8#v1T%YxGd-D/ZI/Y/<]=s%txppg' );
define( 'NONCE_KEY',         '[LPEPy,x;%jx9!kN=[1R,@;n^$xkS7^yN[LsI$y-0{!:bH 7_zpueIQ@Rpw5gmn*' );
define( 'AUTH_SALT',         'sv]4uf-=j=>u#hWoia{],^=u].[tpl<x6,UoUh^3oRROQeR ;)YlJ1Fe+ qR5Uo?' );
define( 'SECURE_AUTH_SALT',  ',aERQ2BV^C$n:d$cgp^`thj|L&Z4$B&wlB845.GID>{=beGuo$w&p>UeWh4AcT?:' );
define( 'LOGGED_IN_SALT',    ',y*|2U>9N=j=HynptkvXKUMX]#D&%nZ?j5B9bV(B}hI!`Q>m}/!*X*FYebz*%$lo' );
define( 'NONCE_SALT',        '=w}yS^MKa5bv@Y$h.0v2`NV&!t)lLx]m]N,W|h`V*;O6<fB1G^He_HYY5GMD37) ' );
define( 'WP_CACHE_KEY_SALT', 'O3?<||DM4{$cVs0se5.%&@p.x*w^9I:^l,@Bffg~mfQ_zJ,DwBPtQJJE%Ey^m4l8' );

define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define('WP_CACHE', true);

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
        define( 'W P_DEBUG', true );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';