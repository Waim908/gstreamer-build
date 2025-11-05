# Build gstreamer and some depends for Glibc

# dpends

## 因为libde265本身支持编解码这里就先不考虑使用x265

#### libde265 => 1.0.16  
#### 启用编码支持"默认关闭"

```./configure --enable-encoder --prefix=/root/buildde265/``` <= 头文件找不到的bug，用cmake构建

```cmake .. -DENABLE_ENCODER=on -DENABLE_SDL=off -DCMAKE_INSTALL_PREFIX=/root/buildde265/```

~~#### depend(libde265)~~ <= 实际使用压根不会调用这个进行解码而是libav，包括h264解码不会使用openh264是一样的道理

  libgfxvideo(decoder support) [GPL2.0] <= 手动构建，*构建用的系统需要*

  ## libde265的configure可能没办法找到libgfxvideo导致不构建解码程序

  ## *解决方案* ```export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH```

无法使用midi音频支持，此方案暂时禁用


~~#### depend(fluidsynth)~~ <= 不支持MIDI，此方法暂时无效

  应用此仓库的配置文件修复补丁
  ```fluidsynth/config_path.patch```

  gcem.hpp not found ？ <= 克隆的时候没有克隆gcem仓库，cd到fluidsynth项目文件夹,你会发现gcem文件夹完全就是空的克隆一遍gcem项目到此就行了 [gcem](https://github.com/kthohr/gcem)

```cmake .. -Denable-pulseaudio=on -Denable-alsa=on -Denable-oss=off -Denable-opensles=off -Denable-jack=off  -Denable-sdl3=off -Denable-systemd=disabled -Denable-pipewire=off -Denable-portaudio=off -Denable-libinstpatch=off -Denable-network=off -Denable-libinstpatch=off -DCMAKE_INSTALL_PREFIX=/root/buildfluidsynth```
~~
# Step 1

### 一个干净的系统，clone gstreamer source code

# LITE
```bash
meson setup builddir \
  --buildtype=release \
  --strip \
  -Dgst-full-target-type=shared_library \
  -Dintrospection=disabled \
  -Dgst-full-libraries=app,video,player \
  -Dbase=enabled \
  -Dgood=enabled \
  -Dbad=enabled \
  -Dugly=enabled \
  -Dlibav=enabled \
  -Dtests=disabled \
  -Dexamples=disabled \
  -Ddoc=disabled \
  -Dges=disabled \
  -Dpython=disabled \
  -Ddevtools=disabled \
  -Dgstreamer:check=disabled \
  -Dgstreamer:benchmarks=disabled \
  -Dgstreamer:libunwind=disabled \
  -Dgstreamer:libdw=disabled \
  -Dgstreamer:bash-completion=disabled \
  -Dgst-plugins-good:cairo=disabled \
  -Dgst-plugins-good:gdk-pixbuf=disabled \
  -Dgst-plugins-good:oss=disabled \
  -Dgst-plugins-good:oss4=disabled \
  -Dgst-plugins-good:v4l2=disabled \
  -Dgst-plugins-good:aalib=disabled \
  -Dgst-plugins-good:jack=disabled \
  -Dgst-plugins-good:pulse=enabled \
  -Dgst-plugins-good:adaptivedemux2=disabled \
  -Dgst-plugins-good:v4l2=disabled \
  -Dgst-plugins-good:libcaca=disabled \
  -Dgst-plugins-good:mpg123=enabled \
  -Dgst-plugins-base:examples=disabled \
  -Dgst-plugins-base:alsa=enabled \
  -Dgst-plugins-base:pango=disabled \
  -Dgst-plugins-base:x11=enabled \
  -Dgst-plugins-bad:gpl=enabled \
  -Dgst-plugins-bad:androidmedia=disabled \
  -Dgst-plugins-bad:rtmp=disabled \
  -Dgst-plugins-bad:shm=disabled \
  -Dgst-plugins-bad:zbar=disabled \
  -Dgst-plugins-bad:webp=disabled \
  -Dgst-plugins-bad:hls-crypto=openssl \
  -Dgst-plugins-bad:kms=disabled \
  -Dgst-plugins-bad:vulkan=enabled \
  -Dgst-plugins-bad:vulkan-windowing=x11 \
  -Dgst-plugins-bad:vulkan-video=enabled \
  -Dgst-plugins-bad:dash=disabled \
  -Dgst-plugins-bad:analyticsoverlay=disabled \
  -Dgst-plugins-bad:nvcodec=disabled \
  -Dgst-plugins-bad:uvch264=disabled \
  -Dgst-plugins-bad:v4l2codecs=disabled \
  -Dgst-plugins-bad:udev=disabled \
  -Dgst-plugins-bad:libde265=enabled \
  -Dgst-plugins-bad:smoothstreaming=disabled \
  -Dgst-plugins-bad:fluidsynth=disabled \
  -Dgst-plugins-bad:inter=disabled \
  -Dgst-plugins-bad:x11=enabled \
  -Dgst-plugins-bad:gl=diabled \
  -Dgst-plugins-bad:wayland=disabled \
  -Dgst-plugins-bad:openh264=disabled \
  -Dgst-plugins-bad:hip=disabled \
  -Dgst-plugins-bad:aja=diabled \
  -Dgst-plugins-bad:aes=diabled \
  -Dgst-plugins-bad:dtls=diabled \
  -Dgst-plugins-bad:hls=diabled \

  -Dpackage-origin="[gstremaer-build] (https://github.com/Waim908/gstreamer-build)  ᗜˬᗜ" \
  --prefix=/root/gst
```

# FULL
```bash
meson setup builddir \
  --buildtype=release \
  --strip \
  -Dgst-full-target-type=shared_library \
  -Dintrospection=disabled \
  -Dgst-full-libraries=app,video,player \
  -Dbase=enabled \
  -Dgood=enabled \
  -Dbad=enabled \
  -Dugly=enabled \
  -Dlibav=enabled \
  -Dtests=disabled \
  -Dexamples=disabled \
  -Ddoc=disabled \
  -Dges=disabled \
  -Dpython=disabled \
  -Ddevtools=disabled \
  -Dgstreamer:check=disabled \
  -Dgstreamer:benchmarks=disabled \
  -Dgstreamer:libunwind=disabled \
  -Dgstreamer:libdw=disabled \
  -Dgstreamer:bash-completion=disabled \
  -Dgst-plugins-good:cairo=disabled \
  -Dgst-plugins-good:gdk-pixbuf=disabled \
  -Dgst-plugins-good:oss=disabled \
  -Dgst-plugins-good:oss4=disabled \
  -Dgst-plugins-good:v4l2=disabled \
  -Dgst-plugins-good:aalib=disabled \
  -Dgst-plugins-good:jack=disabled \
  -Dgst-plugins-good:pulse=enabled \
  -Dgst-plugins-good:adaptivedemux2=disabled \
  -Dgst-plugins-good:v4l2=disabled \
  -Dgst-plugins-good:libcaca=disabled \
  -Dgst-plugins-good:mpg123=enabled \
  -Dgst-plugins-base:examples=disabled \
  -Dgst-plugins-base:alsa=enabled \
  -Dgst-plugins-base:pango=disabled \
  -Dgst-plugins-base:x11=enabled \
  -Dgst-plugins-base:gl=disabled \
  -Dgst-plugins-bad:gpl=enabled \
  -Dgst-plugins-bad:androidmedia=disabled \
  -Dgst-plugins-bad:rtmp=disabled \
  -Dgst-plugins-bad:shm=disabled \
  -Dgst-plugins-bad:zbar=disabled \
  -Dgst-plugins-bad:webp=disabled \
  -Dgst-plugins-bad:hls-crypto=openssl \
  -Dgst-plugins-bad:kms=disabled \
  -Dgst-plugins-bad:vulkan=disabled \
  -Dgst-plugins-bad:dash=disabled \
  -Dgst-plugins-bad:analyticsoverlay=disabled \
  -Dgst-plugins-bad:nvcodec=disabled \
  -Dgst-plugins-bad:uvch264=disabled \
  -Dgst-plugins-bad:v4l2codecs=disabled \
  -Dgst-plugins-bad:udev=disabled \
  -Dgst-plugins-bad:libde265=enabled \
  -Dgst-plugins-bad:smoothstreaming=disabled \
  -Dgst-plugins-bad:fluidsynth=disabled \
  -Dgst-plugins-bad:inter=disabled \
  -Dgst-plugins-bad:x11=enabled \
  -Dgst-plugins-bad:wayland=disabled \
  -Dgst-plugins-bad:openh264=disabled \
  -Dpackage-origin="[gstremaer-build] (https://github.com/Waim908/gstreamer-build)  ᗜˬᗜ" \
  --prefix=/root/gst
```

```-Dintrospection=disabled```<== must

```-Dpackage-origin```<== 自定义版本信息（比如```gst-play-1.0 --version``` 最后一行输出的信息）

# Step 2

```bash
meson compile -C builddir && meson install -C builddir
```

# Step 3

patchelf

# Thanks

[gstreamer](https://gitlab.freedesktop.org/gstreamer/gstreamer)

~~[libde265]~~

~~[fluidsynth]~~

[部分构建参数参考(不需要管那些gir xml文件)](https://github.com/termux/termux-packages)