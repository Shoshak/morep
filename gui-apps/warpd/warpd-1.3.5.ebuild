# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A modal keyboard-driven virtual pointer"
HOMEPAGE="https://github.com/rvaiya/warpd"

if [[  ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rvaiya/${PN}.git"
else
	SRC_URI="https://github.com/rvaiya/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="X wayland"

RDEPEND="
	X? (
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXft
		x11-libs/libXfixes
		x11-libs/libXtst
		x11-libs/libX11
	)
	wayland? (
		dev-libs/wayland
		x11-libs/cairo
		x11-libs/libxkbcommon
	)
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-makefile-prefix.patch"
)

pkg_setup() {
	use X || export DISABLE_X=1
	use wayland || export DISABLE_WAYLAND=1
}

src_install() {
	emake DESTDIR="${D}" install
	docompress -x /usr/share/man
	einstalldocs
}
