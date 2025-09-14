# Build gstreamer and some depends for termux glibc

# Step 1

### clone gstreamer source code

# 如果你不需要x265编解码，可以不用```gpl=enabled```和libde265和x265
# 如果使用，请遵守**GPL3.0**协议

```bash
meson setup builddir --buildtype=release --strip -Dgst-full-target-type=shared_library -Dintrospection=disabled -Dgst-full-libraries=app,video,player -Dbase=enabled -Dgood=enabled -Dbad=enabled -Dugly=enabled -Dlibav=enabled -Dtests=disabled -Dexamples=disabled -Dges=disabled -Dpython=disabled -Ddevtools=disabled -Dgstreamer:check=disabled -Dgstreamer:benchmarks=disabled -Dgstreamer:libunwind=disabled -Dgstreamer:libdw=disabled -Dgstreamer:bash-completion=enabled  -Dgst-plugins-good:cairo=disabled -Dgst-plugins-good:gdk-pixbuf=disabled -Dgst-plugins-good:oss=disabled -Dgst-plugins-good:oss4=disabled -Dgst-plugins-good:v4l2=disabled -Dgst-plugins-good:aalib=disabled -Dgst-plugins-good:jack=disabled -Dgst-plugins-good:pulse=enabled -Dgst-plugins-good:adaptivedemux2=disabled -Dgst-plugins-good:v4l2=disabled -Dgst-plugins-good:libcaca=enabled -Dgst-plugins-base:examples=disabled -Dgst-plugins-base:alsa=enabled -Dgst-plugins-base:pango=disabled -Dgst-plugins-base:x11=enabled -Dgst-plugins-bad:gpl=enabled -Dgst-plugins-bad:androidmedia=disabled -Dgst-plugins-bad:rtmp=disabled -Dgst-plugins-bad:shm=disabled -Dgst-plugins-bad:zbar=disabled -Dgst-plugins-bad:webp=disabled -Dgst-plugins-bad:hls-crypto=openssl -Dgst-plugins-bad:kms=disabled -Dgst-plugins-bad:vulkan=enabled -Dgst-plugins-bad:vulkan-windowing=x11 -Dgst-plugins-bad:vulkan-video=enabled -Dgst-plugins-bad:dash=disabled -Dgst-plugins-bad:analyticsoverlay=disabled -Dgst-plugins-bad:nvcodec=disabled -Dgst-plugins-bad:uvch264=disabled -Dgst-plugins-bad:v4l2codecs=disabled -Dgst-plugins-bad:udev=disabled -Dgst-plugins-bad:libde265=enabled -Dgst-plugins-bad:x265=enabled -Dgst-plugins-bad:smoothstreaming=disabled -Dgst-plugins-bad:fluidsynth=enabled -Dffmpeg=vulkan:enabled -Dpackage-origin="[gstremaer-termux] (https://github.com/Waim908/gstreamer-termux)  ᗜˬᗜ" --prefix=/root/gst
```

```-Dintrospection=disabled```<== must

```-Dpackage-origin```<== Custom

# Step 2

```bash
meson compile -C builddir && meson install -C builddir
```

# Step 3

patchelf

# Thanks

[gstreamer](https://gitlab.freedesktop.org/gstreamer/gstreamer)

x265

de265

libxml2

fluidsynth

[部分构建参数参考(不需要管那些gir xml文件)](https://github.com/termux/termux-packages)