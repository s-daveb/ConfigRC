
export PATH="/opt/homebrew/opt/cups/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/cups/lib:${LDFLAGS}"
export CPPFLAGS="-I/opt/homebrew/opt/cups/include:${LDFLAGS}"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/opt/homebrew/opt/cups/lib/pkgconfig"
