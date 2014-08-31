#!/usr/bin/expect
#to ssh as root user when have no password for root

set timeout 20
#log_user 0

if { $argc != 3 } {
	send_user "\n$argv0 <user> <ip> <passwd>\n\n"
	exit 1
}

set user [lindex $argv 0]
set ip [lindex $argv 1]
set passwd [lindex $argv 2]
set sendpasswd 0

spawn ssh $user@$ip
expect {
	"$user" {
		send "sudo more /root/.ssh/authorized_keys > ./authorized_keys\r"
	}
}
expect {
	"password for $user" {
		send "$passwd\r"
	}
}
expect {
	"$user" {
		send "sudo more ~/.ssh/authorized_keys >> ./authorized_keys\r"
	}
}
expect {
	"$user" {
		send "sudo cp ./authorized_keys /root/.ssh/authorized_keys\r"
	}
}
expect {
	"$user" {
		send "sudo chmod 600 /root/.ssh/authorized_keys\r"
	}
}
expect {
	"$user" {
		send "sudo rm ./authorized_keys\r"
	}
}
expect {
	"$user" {
		send "exit\r"
	}
}