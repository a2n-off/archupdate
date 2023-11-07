# Maintainer: Bouteiller a2n Alan <a2n.dev@pm.me>

# git rev-parse tagName
_tag=7529bc6e829cc9ea7cc6e60f0b1662c430a74e06

pkgname=
pkgver=1.0.0
pkgrel=1
pkgdesc=""
arch=('any')
url="https://github.com/bouteillerAlan/archupdate"
license=('MIT')
source=("git+${url}/tree/${_tag}")
depends=("konsole: for launching the update command"
         "pacman-contrib: for checking updates on the main arch repository"
         "yay: for checking updates on another arch repositories and doing the update")
optdepends=("paru: if you want to replace yay with paru")

pkgver() {
  cd "${pkgname}"
  git describe --tags
}

package() {
  cd "${pkgname}-v${pkgver}"
  install -Dm 644 50numlock/module-setup.sh "${pkgdir}"/usr/lib/dracut/modules.d/50numlock/module-setup.sh
  install -Dm 644 50numlock/numlock.sh "${pkgdir}"/usr/lib/dracut/modules.d/50numlock/numlock.sh
  install -D LICENSE "${pkgdir}"/usr/share/licenses/"${pkgname}"/LICENSE
}

