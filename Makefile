PORTNAME=	janet-spork
DISTVERSION=	1.2.0
DISTVERSIONPREFIX=	v
CATEGORIES=	lang

MAINTAINER=	dave@freedave.net
COMMENT=	Janet Utilities (not quite stdlib)
WWW=		https://github.com/janet-lang/spork

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	jpm>=1.2.0:lang/jpm
RUN_DEPENDS=	janet>=1.17.2:lang/janet \
		git:devel/git

USE_GITHUB=	yes
GH_ACCOUNT=	janet-lang
GH_PROJECT=	spork
# shamelessly advancing to hash with my fix for `make test`.
GH_TAGNAME=	a444546

# OK this works, but its highly unmaintainable. I have to take and fix paths:
# 	${WRKSRC}/jpm_tree/bin/* ! *.h -> ${PREFIX}/bin/*
# 	${WRKSRC}/jpm_tree/lib/*.h -> ${PREFIX}/include/*.h
# 	${WRKSRC}/jpm_tree/lib/* -> ${PREFIX}/lib/janet/*
# 	${WRKSRC}/jpm_tree/man/*.1 -> ${PREFIX}/share/man/man1/*.1.gz
#
# Notice the build system gzipped the man page too :)
SUB_FILES=	spork.jdn

do-build:
	cd ${WRKSRC} && ${LOCALBASE}/bin/jpm --tree=${WRKSRC}/jpm_tree "install"

do-install:
	cd ${WRKSRC}/jpm_tree/bin && ${COPYTREE_BIN} . ${STAGEDIR}${PREFIX}/bin
	cd ${WRKSRC}/jpm_tree/lib && ${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/lib/janet "! -name *\.h"
	cd ${WRKSRC}/jpm_tree/lib && ${COPYTREE_SHARE} .  ${STAGEDIR}${PREFIX}/include/janet "-name *\.h"
	${INSTALL_MAN} ${WRKSRC}/jpm_tree/man/janet-pm.1 ${STAGEDIR}${PREFIX}/share/man/man1
	${INSTALL_DATA} ${WRKDIR}/spork.jdn ${STAGEDIR}${PREFIX}/lib/janet/.manifests

do-test:
	cd ${WRKSRC} && jpm test -l

.include <bsd.port.mk>
