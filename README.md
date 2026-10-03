[01]: https://github.com/janet-lang/spork
[02]: https://janet-lang.org/spork/index.html
[03]: https://freebsd.free.org/ports
[04]: https://github.com/dmarker/bagatto.port

# FreeBSD port for Janet's spork library

This is not the actual [code][01], or [manual][02]. This is just a drop in
[port][03]:

```
# cd /usr/ports/lang
# git clone https://github.com/dmarker/janet-spork.port janet-spork
# cd janet-spork
# make install clean
```

## Why?

Looking to see what it would take to package spork as it now has the future
project management tool `janet-pm` as well as `janet-netrepl` and `janet-format`.

This is a really common library to be part of Janet projects. Fortunately the
way Janet does local builds (see [bagatto.port][04] for example) it need not
necessarily interfere.

Anyway just kicking the tires...

