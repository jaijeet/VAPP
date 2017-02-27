AC_INIT([.])
SHELL=/bin/bash
host_os=$(uname -a);
case $host_os in

	*Cygwin*) CYGWINPREFIX=$SYSTEMDRIVE/cygwin;
		  echo "Detected Cygwin environment";
		  echo "  OS: '$host_os'";
		  echo "  using CYGWINPREFIX=$CYGWINPREFIX";
		  ;;

	*) 	  CYGWINPREFIX="";
		  #echo "Cygwin environment NOT detected: $host_os";
		  ;;
esac

dnl need to also check for basic unix utilities: rm chmod mkdir find etc
dnl see http://www.edwardrosten.com/code/autoconf/ for tips

dnl find and test make utils
AC_PROG_MAKE_SET

dnl find and test the C compiler
AC_PROG_CC
AC_LANG_C
AC_PROG_CXX
AC_HEADER_STDC

AC_PATH_PROG(CAT,cat,AC_MSG_ERROR([echo cat not found - is this a Unix installation?]))
AC_PATH_PROG(CHMOD,chmod,AC_MSG_ERROR([echo chmod not found - is this a Unix installation?]))
AC_PATH_PROG(CP,cp,AC_MSG_ERROR([echo cp not found - is this a Unix installation?]))
AC_PATH_PROG(MV,mv,AC_MSG_ERROR([echo mv not found - is this a Unix installation?]))
AC_PATH_PROG(INSTALL,install,AC_MSG_ERROR([echo mv not found - is this a Unix installation?]))
AC_PATH_PROG(HEAD,head,AC_MSG_ERROR([echo head not found - is this a Unix installation?]))
AC_PATH_PROG(TAR,tar,AC_MSG_ERROR([echo tar not found - is this a Unix installation?]))
AC_PROG_SED(sed)
dnl find perl
#AC_PATH_PROG(PERL,perl,AC_MSG_ERROR([echo perl not found - is this a Unix installation?]))
dnl find python
dnl AC_PATH_PROG(PYTHON,python,AC_MSG_ERROR([echo python not found - is this a Unix installation?]))
dnl find make
AC_PATH_PROG(MAKE,make,AC_MSG_ERROR([echo make not found - is this a Unix installation?]))

dnl find matlab
AC_PATH_PROG(MATLAB,matlab,AC_MSG_ERROR([echo Matlab not found. Please install it first!]))
AC_PATH_PROG(MEX,mex,AC_MSG_WARN([echo mex not found - check your MATLAB installation.]))

# set version and user
GITVERSION=$(git log -n 1 --pretty=format:'%h')
BRANCHNAME=$(git symbolic-ref --short HEAD)
#echo GITVERSION=$GITVERSION
THEVERSION=`head -n 1 ./00-VERSION | sed -e "s/GETVERSIONFROMGIT/$GITVERSION/" -e "s/GETBRANCHNAMEFROMGIT/$BRANCHNAME/" -e "s/USER/$USER/" -e 's/ /_/g'`
#echo THEVERSION=$THEVERSION

# set up installation directories

with_VAPPlocalLinksDir="$(pwd)/$THEVERSION"

AC_PREFIX_DEFAULT("--prefix is NOT USED by VAPP")
#THE_PREFIX=`test "$prefix" = NONE && prefix=$ac_default_prefix; eval echo "${prefix}"` # "hairy", because ac_default_prefix undocumented

AC_SUBST(VAPPVERSION, $THEVERSION)
AC_SUBST(BRANCHNAME, $BRANCHNAME)
AC_SUBST(CYGWINPREFIX, $CYGWINPREFIX)
AC_SUBST(VAPPLOCALLINKSDIR, $with_VAPPlocalLinksDir)
AC_SUBST(THEVERSION, $THEVERSION)
AC_SUBST(VAPP, $VAPP)
AC_SUBST(VAPPTOP, `pwd`)

dnl read <each file below>.in and write <each file below>
AC_OUTPUT(Makefile setuppaths_VAPP.m start_VAPP.m)

echo "--------------------------------------------------------------------"
echo "$THEVERSION configured."
echo ""
echo "Local installation (soft links into the git working copy) will be in:"
echo "	${with_VAPPlocalLinksDir}"
echo ""
echo "Next steps:"
echo "	$ make"
echo ""
echo "--------------------------------------------------------------------"
