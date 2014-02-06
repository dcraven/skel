# Convenience function for unpacking archives using atool.
# Unpacks archive into it's own directory, then enters that directory.
aunpack () {
   TMP=$(mktemp /tmp/aunpack.XXXXXXXXXX);
   atool -x --save-outdir=$TMP "$@"
   DIR="$(cat $TMP)"
   [ "$DIR" != "" -a -d "$DIR" ] && cd "$DIR"
   /bin/rm -f $TMP
}

# Used for importing gpg key from a PPA into apt.
ppakey () {
   gpg --no-default-keyring --keyring /tmp/tmp.keyring --keyserver keyserver.ubuntu.com --recv  $1 && \
   gpg --no-default-keyring --keyring /tmp/tmp.keyring --export --armor $1 |  \
   sudo apt-key add - && rm /tmp/tmp.keyring
}

# Make a log of all installed packages to use on another machine.
installed-log () {
   dpkg --get-selections > $1
}

install-bulk-packages () {
   sudo dpkg --set-selections < $1 && \
   sudo aptitude install deselect  && \
   sudo deselect
}

gnome-git-clone () {
   if [ "" == $GIT_SRC_DIR ]; then
      echo "The env variable $GIT_SRC_DIR is not set. Set that to use this command."
      return
   else
      PROJECT=$1
      echo "Cloning project $PROJECT in $GIT_SRC_DIR..."
      cd $GIT_SRC_DIR && git clone git://git.gnome.org/$PROJECT && cd $PROJECT
   fi
}

calc () {
   awk "BEGIN{ print $* }" ;
}

debuild-unsigned-bin () {
   debuild -i -us -uc -b
}

debuild-unsigned-src () {
   debuild -i -us -uc -S
}

b() {
   ARTIST=`banshee --query-artist`
   TITLE=`banshee --query-title`
   echo "\"${TITLE#* }\" by ${ARTIST#* }"
}

spell () {
   echo $1 | ispell -a
}

pidgin-search () {
   grep -Ri $1  ~/.purple/logs/*  | sed -e 's/<[^>]*>//g' | sed -e 's/^.*\(20[0-9]*-[0-9]*-[0-9]*\).*html:\(.*\)/\1:\2/g'
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}

function parse_git_branch {
    FOO=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    if [ -n "$FOO" ]; then
        echo "($FOO$(parse_git_dirty))"
    fi
}

function git-svn-diff {
    git diff --no-color --no-prefix $1 $2 | sed -e "s/^diff --git [^[:space:]]*/Index:/" -e "s/^index.*/===================================================================/"
}

function topten {
    FOO=$(history | awk '{print $2}' | sort | uniq -c | sort -rn | head -10)
    echo $FOO
}

function note {
    mvim ~/Documents/Notes/${1}.md
}

