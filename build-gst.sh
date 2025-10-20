cd /tmp

echo "libde2654 ${libde265Ver}"
echo "gstreamer ${gstVer}"

# 下载 libde265


# CMake编译下不再需要
# mkdir libvideogfx-src/
# cd libvideogfx-src/
# echo "Downloading libvideogfx ${libvideogfxVer}"
# wget -O libvideogfx.tar.gz "https://github.com/farindk/libvideogfx/archive/refs/tags/${libvideogfxVer}.tar.gz"
# tar --strip-components=1 -xzf libvideogfx.tar.gz -C .

# 克隆 gstreamer

mkdir -p /data/data/com.termux/files/usr/glibc

cd /tmp/libde265-src/
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
mkdir build
cd build
if ! cmake .. -DENABLE_ENCODER=on -DENABLE_SDL=off -DCMAKE_INSTALL_PREFIX=/data/data/com.termux/files/usr/glibc/; then
	echo "构建失败"
	exit 1
fi
if ! make -j$(nproc); then
	echo "编译失败"
	exit 1
fi
make install

cd /tmp/gstreamer-src

if ! meson setup builddir --buildtype=release --strip -Dgst-full-target-type=shared_library -Dintrospection=disabled -Dgst-full-libraries=app,video,player -Dbase=enabled -Dgood=enabled -Dbad=enabled -Dugly=enabled -Dlibav=enabled -Dtests=disabled -Dexamples=disabled -Ddoc=disabled -Dges=disabled -Dpython=disabled -Ddevtools=disabled -Dgstreamer:check=disabled -Dgstreamer:benchmarks=disabled -Dgstreamer:libunwind=disabled -Dgstreamer:libdw=disabled -Dgstreamer:bash-completion=disabled -Dgst-plugins-good:cairo=disabled -Dgst-plugins-good:gdk-pixbuf=disabled -Dgst-plugins-good:oss=disabled -Dgst-plugins-good:oss4=disabled -Dgst-plugins-good:v4l2=disabled -Dgst-plugins-good:aalib=disabled -Dgst-plugins-good:jack=disabled -Dgst-plugins-good:pulse=enabled -Dgst-plugins-good:adaptivedemux2=disabled -Dgst-plugins-good:libcaca=disabled -Dgst-plugins-good:mpg123=enabled -Dgst-plugins-base:examples=disabled -Dgst-plugins-base:alsa=enabled -Dgst-plugins-base:pango=disabled -Dgst-plugins-base:x11=enabled -Dgst-plugins-base:gl_winsys=x11 -Dgst-plugins-base:gl=enabled -Dgst-plugins-bad:gpl=enabled -Dgst-plugins-bad:androidmedia=disabled -Dgst-plugins-bad:rtmp=disabled -Dgst-plugins-bad:shm=disabled -Dgst-plugins-bad:zbar=disabled -Dgst-plugins-bad:webp=disabled -Dgst-plugins-bad:hls-crypto=openssl -Dgst-plugins-bad:kms=disabled -Dgst-plugins-bad:vulkan=enabled -Dgst-plugins-bad:vulkan-windowing=x11 -Dgst-plugins-bad:vulkan-video=enabled -Dgst-plugins-bad:dash=disabled -Dgst-plugins-bad:analyticsoverlay=disabled -Dgst-plugins-bad:nvcodec=disabled -Dgst-plugins-bad:uvch264=disabled -Dgst-plugins-bad:v4l2codecs=disabled -Dgst-plugins-bad:udev=disabled -Dgst-plugins-bad:libde265=enabled -Dgst-plugins-bad:smoothstreaming=disabled -Dgst-plugins-bad:fluidsynth=disabled -Dgst-plugins-bad:inter=disabled -Dgst-plugins-bad:x11=enabled -Dgst-plugins-bad:wayland=disabled -Dgst-plugins-bad:openh264=enabled -Dpackage-origin="[gstreamer-termux] (https://github.com/Waim908/gstreamer-termux) ᗜˬᗜ" --prefix=/data/data/com.termux/files/usr/glibc; then
	echo "构建失败"
	exit 1
fi
if ! meson compile -C builddir; then
	echo "编译失败"
	exit 1
fi
meson install -C builddir
cd /data/data/com.termux/files/usr/glibc
export LD_RPATH=/data/data/com.termux/files/usr/glibc
export LD_FILE=ld-linux-aarch64.so.1
find . -type f -exec file {} + | grep -E ":.*ELF" | cut -d: -f1 | while read -r elf_file; do
	echo "Patching $elf_file..."
	patchelf --set-rpath "$LD_RPATH" --set-interpreter "$LD_FILE" "$elf_file" || {
		echo "Failed to patch $elf_file" >&2
		continue
	}
done
exit 0
