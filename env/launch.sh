#!/bin/bash
# usage: ./launch.sh 
#
# issue with executable? try running first /C/Programmes/DockerToolbox/start.sh
# start.sh: GIT BASH HACK
#		DOCKER_MACHINE="/C/Programmes/DockerToolbox/docker-machine.exe"
#		VBOXMANAGE="/C/Programmes/VirtualBox/VBoxManage.exe"
#
MACHINE=gkfront
COMPOSE_FILE="docker-compose-draft.yml"
WIN_COMPOSE_FILE="win-$COMPOSE_FILE"

DOCKERMACHINE_VERSION=$(docker-machine -version)

function dockerNeeded {
	echo "requirements: docker-toolbox (version 18 or sup)"
	echo "   This script rely on docker-toolbox to create docker container: docker-machine docker-compose binaries should be in your PATH"
	echo "   windows user could get msi file from https://docs.docker.com/toolbox/toolbox_install_windows/ (recommended), or (using powershell admin)'choco install docker-toolbox'"
	exit 1
}

#	+ handle 0.13.0 scp issue ( https://github.com/docker/machine/issues/4302 )
function alternate_scp {
	echo " o Hum... seems 'docker-machine scp' doesn't work ($DOCKERMACHINE_VERSION), try alternate way.."
	# retrieve docker default machine SSH PORT
	# cat ~/.docker/machine/machines/default/default/default.vbox|grep Forwarding
	# using grep regexp to isolate forwarded port number only
	SSHPORT=`cat ~/.docker/machine/machines/$MACHINE/$MACHINE/$MACHINE.vbox|grep Forwarding| grep -oP "hostport=\"\K\d+"`
	echo " * retrieve ssh forwarded port: $SSHPORT"
	# using generated pk
	SSHIDFILE="~/.docker/machine/machines/$MACHINE/id_rsa"
	echo "   using identity: $SSHIDFILE"

	SSHOPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet -3 -o IdentitiesOnly=yes "
	echo " * Copy resources (alternate way)"
	scp.exe $SSHOPTS -o Port=$SSHPORT -o IdentityFile="$SSHIDFILE" -r exposed/www/* docker@127.0.0.1:/app || die "Unable to scp machine $MACHINE"
}

function die(){
   echo ${1:=Something terrible wrong happen}
   exit 1
}

docker-machine -version || dockerNeeded
docker-compose -version || dockerNeeded

if ! docker-machine ls | grep --quiet $MACHINE; then
	echo " * Create docker machine"
    docker-machine create $MACHINE || die "Unable to create machine $MACHINE"
fi

if ! docker-machine ls | grep -i Running | grep --quiet $MACHINE ; then
	echo " * Start docker machine $MACHINE"
	docker-machine start $MACHINE
else
	echo " * docker machine $MACHINE already started"
fi

echo " * Load env for $MACHINE docker machine"
eval $(docker-machine env $MACHINE) || die "Unable to set machine $MACHINE env"

export GKFRONT_IP=$(docker-machine ip $MACHINE)
export COMPOSE_CONVERT_WINDOWS_PATHS=1

PROTODIR=/app
echo " * docker-machine create $MACHINE:$PROTODIR"
docker-machine ssh $MACHINE "sudo mkdir -p $PROTODIR && sudo chown docker $PROTODIR && sudo chmod 777 $PROTODIR" || die "Unable to create $MACHINE $PROTODIR"
docker-machine scp -r exposed/www/* $MACHINE:/app 2>/dev/null 1>/dev/null || alternate_scp

echo " * Docker compose ($COMPOSE_FILE)"
docker-compose -f $COMPOSE_FILE up -d --force-recreate || die "compose error"

echo "serving ./exposed/ as http://${GKFRONT_IP}:80/"
explorer "http://${GKFRONT_IP}:80/"