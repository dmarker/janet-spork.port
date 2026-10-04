PORTNAME=	janet-spork
DISTVERSION=	1.2.0
DISTVERSIONPREFIX=	v
CATEGORIES=	lang

MAINTAINER=	dave@freedave.net
COMMENT=	Janet Utilities (not quite stdlib)
WWW=		https://github.com/janet-lang/spork

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	janet>=1.38.0:lang/janet
RUN_DEPENDS=	janet>=1.38.0:lang/janet \
		git:devel/git

USE_GITHUB=	yes
GH_ACCOUNT=	janet-lang
GH_PROJECT=	spork
# shamelessly advancing to hash with my fix for `make test`.
GH_TAGNAME=	a444546

# OK this works, and the file is much easier to deal with, keep eye out for:
# 	${WRKSRC}/jpm_tree/bin/* ! *.h -> ${PREFIX}/bin/*
# 	${WRKSRC}/jpm_tree/*.h -> ${PREFIX}/include/*.h
# 	${WRKSRC}/jpm_tree/bundle/* -> ${PREFIX}/lib/janet/bundle/*
# 	${WRKSRC}/jpm_tree/spork/* -> ${PREFIX}/lib/janet/spork/*
# 	${WRKSRC}/jpm_tree/man/*.1 -> ${PREFIX}/share/man/man1/*.1.gz
#
# Notice the build system gzipped the man page too :)
SUB_FILES=	manifest.jdn

do-build:
	${MKDIR} ${WRKSRC}/jpm_tree
	cd ${WRKSRC} && JANET_PATH=jpm_tree ${LOCALBASE}/bin/janet --install .


do-install:
	cd ${WRKSRC}/jpm_tree && ${COPYTREE_BIN} . ${STAGEDIR}${PREFIX}/include/janet "-name *\.h"
	cd ${WRKSRC}/jpm_tree/bin && ${COPYTREE_BIN} . ${STAGEDIR}${PREFIX}/bin
	cd ${WRKSRC}/jpm_tree/bundle && ${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/lib/janet/bundle
	cd ${WRKSRC}/jpm_tree/spork && ${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/lib/janet/spork
	${INSTALL_MAN} ${WRKSRC}/jpm_tree/man/man1/janet-pm.1 ${STAGEDIR}${PREFIX}/share/man/man1
	${INSTALL_DATA} ${WRKDIR}/manifest.jdn ${STAGEDIR}${PREFIX}/lib/janet/bundle/spork

do-test:
	cd ${WRKSRC} && JANET_PATH=jpm_tree janet -l ./bundle -e '(check)'

.include <bsd.port.mk>
