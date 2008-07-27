AC_DEFUN([AC_NRN_BLUEGENE],[

AC_ARG_ENABLE([bluegene],
	AC_HELP_STRING([--enable-bluegene],[For BlueGene/L, supplies many extra configuration options]),[
	if test "$enable_bluegene" = "yes" ; then
		with_x="no"
		with_memacs="no"
		enable_shared="no"
		with_readline="no"
		java_dlopen="no"
		linux_nrnmech="no"
		if test x$with_nmodl_only != xyes ; then
			nmodl_build="no"
			if test "$BGLSYS" = "" ; then
				BGLSYS=/bgl/BlueLight/ppcfloor/bglsys
			fi
			if test "$CC" = "" ; then
				CC=blrts_xlc
			fi
			if test "$CXX" = "" ; then
				CXX=blrts_xlc++
			fi
			if test "$MPICC" = "" ; then
				MPICC=$CC
			fi
			if test "$MPICXX" = "" ; then
				MPICXX=$CXX
			fi
			if test "$OPTFLAGS" = "" ; then
				OPTFLAGS="-qarch=440d -qtune=440 -O3 -qstrict -qhot"
			fi
			if test "$CFLAGS" = "" ; then
				CFLAGS="$OPTFLAGS -g -I$BGLSYS/include"
			fi
			if test "$CXXFLAGS" = "" ; then
				CXXFLAGS=$CFLAGS
			fi
			if test "$BGL_LIBS" = "" ; then
				BGL_LIBS="-lmpich.rts -lmsglayer.rts -lrts.rts -ldevices.rts -ldevices.rts -L/opt/ibmcmp/xlmass/bg/4.3/blrts_lib -lmass"
			fi
			if test "$BG_CHECKPOINT" = "yes" ; then
                        	NRN_DEFINE(BLUEGENE_CHECKPOINT,1,[enable the checkpointing on BlueGene hardware])
                        	BGL_LIBS = "-lchkpt.rts $BGL_LIBS"
                	fi
			if test "$LIBS" = "" ; then
				LIBS="-L$BGLSYS/lib $BGL_LIBS"
			fi
			am_cv_CC_dependencies_compiler_type=xlc
			am_cv_CXX_dependencies_compiler_type=xlc
		else
			nmodl_build="yes"
		fi
		always_call_mpi_init=yes
		if test "$file_open_retry" = "" ; then
			file_open_retry=1
		fi
		NRN_DEFINE(BLUEGENE,1,[define if cross compiling for IBM BlueGene])
	fi
])

AC_ARG_ENABLE([bluegeneP],
	AC_HELP_STRING([--enable-bluegeneP],[For BlueGene/P, supplies many extra configuration options]),[
	if test "$enable_bluegeneP" = "yes" ; then
		with_x="no"
		with_memacs="no"
		enable_shared="no"
		with_readline="no"
		java_dlopen="no"
		linux_nrnmech="no"
		if test x$with_nmodl_only != xyes ; then
			nmodl_build="no"
			BG_BASE="/bgsys/drivers/ppcfloor"
			BG_INCLUDE="-I$BG_BASE/comm/include -I$BG_BASE/arch/include"
			if test "$PYINCDIR" = "" ; then
				PYINCDIR='/bgsys/drivers/ppcfloor/gnu-linux/include/python2.5'
			fi
			if test "$PYLIB" = "" ; then
				PYLIB='-L/bgsys/drivers/ppcfloor/gnu-linux/lib -lpython2.5'
				PYLIBDIR='/bgsys/drivers/ppcfloor/gnu-linux/lib'
				PYLIBLINK='-L/bgsys/drivers/ppcfloor/gnu-linux/lib -lpython2.5'
			fi
			if test "$LDFLAGS" = "" ; then
				LDFLAGS=-qnostaticlink
			fi
			if test "$with_multisend" = "" ; then
				with_multisend=yes
			fi
			if test "$CC" = "" ; then
				CC=mpixlc_r
			fi
			if test "$CXX" = "" ; then
				CXX=mpixlcxx_r
			fi
			if test "$MPICC" = "" ; then
				MPICC=$CC
			fi
			if test "$MPICXX" = "" ; then
				MPICXX=$CXX
			fi
			if test "$OPTFLAGS" = "" ; then
				OPTFLAGS="-O3 -qarch=450 $BG_INCLUDE"
			fi
			if test "$CFLAGS" = "" ; then
				CFLAGS="$OPTFLAGS"
			fi
			if test "$CXXFLAGS" = "" ; then
				CXXFLAGS=$CFLAGS
			fi
			if test "$BG_CHECKPOINT" = "yes" ; then
                        	NRN_DEFINE(BLUEGENE_CHECKPOINT,1,[enable the checkpointing on BlueGene hardware])
                        	BGL_LIBS = "-lchkpt.rts $BGL_LIBS"
                	fi
			am_cv_CC_dependencies_compiler_type=xlc
			am_cv_CXX_dependencies_compiler_type=xlc
		else
			nmodl_build="yes"
		fi
		always_call_mpi_init=yes
		if test "$file_open_retry" = "" ; then
			file_open_retry=1
		fi
		NRN_DEFINE(BLUEGENE,1,[define if cross compiling for IBM BlueGene L or P])
		NRN_DEFINE(BLUEGENEP,1,[define if cross compiling for IBM BlueGene/P])
	fi
])

]) dnl end of AC_NRN_BLUEGENE