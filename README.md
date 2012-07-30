lpc2012
=======

Our entry for the Liberated Pixel Cup.




Starting the game
======
As this is relying on manasource technology, which is highly flexible,
some things need to be wired. The following commands can be run as a script
to get a first impression, i.e. the judges of the LPC may use it.
If you want to setup a server 'on the internet' you'd need to go through
the config files more detailed.

This script works on an amd64 machine using both Ubuntu 12.04
and a current Debian testing as operating systems.

    sudo apt-get install --yes sqlite3 screen git cmake make gcc libxml2-dev liblua5.1-0-dev libphysfs-dev libsqlite3-dev libsdl-gfx1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-net1.2-dev libsdl-pango-dev libsdl-ttf2.0-dev libsdl1.2-dev libguichan-dev libphysfs-dev libenet1a libcurl4-openssl-dev libcurl3 zlib1g-dev

    mkdir -p manalpc2012
    cd manalpc2012

    # setup the server
    git clone git://github.com/mana/manaserv.git
    cd manaserv
    git checkout lpc2012
    cmake .
    make
    mkdir -p ~/bin
    export PATH="$HOME/bin:$PATH"
    cp src/manaserv-account ~/bin
    cp src/manaserv-game ~/bin
    cd ..


    # setup client
    git clone git://github.com/mana/mana.git
    cd mana
    git checkout lpc2012
    cmake .
    make
    cd ..

    # get the actual lpc entry
    git clone git://github.com/mana/lpc2012.git
    cd lpc2012
    # prepare the configuration for the servers.
    cp manaserv.xml.example manaserv.xml
    # create a database which holds all useraccounts.
    cat ../manaserv/src/sql/sqlite/createTables.sql | sqlite3 mana.db
    cd ..

    # now start the game servers:
    cd lpc2012
    # run the servers in the background, so don't block the script here.
    screen -d -m manaserv-account
    sleep 5
    screen -d -m manaserv-game
    sleep 5
    cd ..

    # The client lets you actually play
    cd mana
    # -u tell the mana client software to not download the game content,
    # but use the content as provided in the -d directory
    # the last parameter is a path to a branding file, which can be
    # omitted, but it pre-dials the connection to the localhost server.
    src/mana -u -d ../lpc2012 docs/lpc2012.mana

Now you should see the mana client started.

It is ready to register an account at your local server, so click on
'Register' and provide a username, password and an email address.
The emailaddress is not needed for local testing, but it is intended
to be used for password reset, but unfortunatly you need to provide an
email address which looks reasonable.

After registering, you'll be redirected to the character creation
screen, which lets you create a character and
then exploring the world we created as the lpc2012 entry.

Once you are done playing, you can quit the client by pressing ESCape
and confirming the quit.

The game servers keep running, so you can later join again. In case you
want to stop them as well:

    killall manaserv-game
    sleep5
    killall manaserv-account




