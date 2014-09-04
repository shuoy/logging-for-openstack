#!/usr/bin/expect
#to generate ssh-key

set timeout 20
log_user 0

spawn ssh-keygen

expect "Enter file in which to save the key"
send "\r"

expect {
	"Overwrite" {
		send "n\r"
		send_user "\[INFO\]The key has already been generated and we don't need to repeat.\n"
		exit
	}
	"Enter passphrase" {
		send "\r"
		expect "Enter same passphrase again"
		send "\r"
		expect "fingerprint"
		send_user "\[INFO\]The key is generated successfully!\n"
	}
}

expect eof