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

do-build:
	cd ${WRKSRC} && ${LOCALBASE}/bin/jpm --tree=${WRKSRC}/jpm_tree "install"

# TODO: while this does copy over manifest to /usr/local/lib/janet/.manifests/spork.jdn
#       it has incorrect build paths. can't assume /usr/local though so I may need
#       to just stage it.
do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/lib/janet
	cd ${WRKSRC}/jpm_tree/bin && ${COPYTREE_BIN} . ${STAGEDIR}${PREFIX}/bin
	cd ${WRKSRC}/jpm_tree/lib && ${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/lib/janet "! -name *\.h"
	cd ${WRKSRC}/jpm_tree/lib && ${COPYTREE_SHARE} .  ${STAGEDIR}${PREFIX}/include/janet
	${INSTALL_MAN} ${WRKSRC}/jpm_tree/man/janet-pm.1 ${STAGEDIR}${PREFIX}/share/man/man1

do-test:
	cd ${WRKSRC} && jpm test -l

.include <bsd.port.mk>
