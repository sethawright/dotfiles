# Deliberately empty. Homebrew ships a file with this exact name in its
# vendor_conf.d that activates mise, and fish only loads the first file it
# finds for a given name, so this one wins and that one never runs.
#
# Why bother: conf.d loads before config.fish, and config.fish rebuilds PATH
# with homebrew and /usr/bin in front. Activating there would bury mise's tool
# paths. config.fish activates mise itself, last.
