
BREW_PREFIX="$(brew --prefix)"
PKG_CONFIG_PATH+="${BREW_PREFIX}/opt/qt5/lib/pkgconfig"
export PKG_CONFIG_PATH

export PATH="${BREW_PREFIX}/opt/qt5/bin:$PATH"
export Qt5_DIR="${BREW_PREFIX}/opt/qt5/"
