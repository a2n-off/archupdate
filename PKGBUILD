# Maintainer: Bouteiller a2n Alan <a2n.dev@pm.me>

# git rev-parse tagName
_tag=ddaf9d2d3e0b75c4ba3c39d1060cbc30190990b7
_plasmoidName="a2n.archupdate.plasmoid"
_souceName="archupdate"

pkgname="kdeplasma-arch-update-notifier-git"
# pkgver is updated automatically by the pkgver step
pkgver=4.2.1
pkgrel=1
pkgdesc="KDE plasmoid that lets you know when arch updates are required. Takes all repo's into account (core, extra, aur, ...)."
arch=("any")
url="https://github.com/bouteillerAlan/archupdate"
license=("GPL3")
source=("git+${url}.git#tag=${_tag}?signed")
depends=("konsole" "pacman-contrib" "yay" "kdialog")
makedepends=("git")
optdepends=("paru: paru support")
sha256sums=("SKIP")
validpgpkeys=(
  6A2ECC8A396F8A943A109A1E0F11C2A6BF79111E # Bouteiller a2n Alan <a2n.dev@pm.me>, retrieved from https://github.com/bouteillerAlan.gpg
)

pkgver() {
  cd "${_souceName}"
  git describe --tags | sed 's/^v//'
}

package() {
  cd "${_souceName}"
  install -Dm 644 LICENSE -t "${pkgdir}"/usr/share/licenses/"${pkgname}"/
  find "${_plasmoidName}" -type f -exec install -Dm 644 "{}" "${pkgdir}/usr/share/plasma/plasmoids/{}" \;
}

