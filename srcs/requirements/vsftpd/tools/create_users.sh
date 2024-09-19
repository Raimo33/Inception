#!/bin/ash

create_ftp_user()
{
	user=$1
	password=$2

	if id "$user" >/dev/null 2>&1; then
		echo "User $user already exists"
		return
	fi

	adduser -D $user
	echo "$user:$password" | chpasswd
	
	home_dir="/home/$user"
	mkdir -p $home_dir/files
	chown -R $user:$user $home_dir/files

	chmod 555 $home_dir
	chmod 775 $home_dir/files

	echo "User $user created with writable subdirectory $home_dir/files"
}

create_ftp_user "$FTP_USER" "$FTP_USER_PASSWORD"

create_ftp_user "$FTP_WP_USER" "$FTP_WP_USER_PASSWORD"
addgroup "$FTP_WP_USER" wordpress-group