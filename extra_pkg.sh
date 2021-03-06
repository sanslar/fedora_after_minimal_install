CMD="sudo dnf -y install"

# RPMFUSION
echo "Enable rpmfusion..."
${CMD} redhat-lsb-core
if [ `rpm -qv rpmfusion-free-release rpmfusion-nonfree-release | grep -v "is not " | wc -l` -ne 2 ]
then
	${CMD} \
	http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-`lsb_release -r -s`.noarch.rpm \
	http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-`lsb_release -r -s`.noarch.rpm
fi
echo ""

# X-Server
echo "Install X-Server..."
sudo dnf -y groupinstall base-x
${CMD} mesa-dri-drivers \
       mesa-dri-drivers.i686 \
       mesa-filesystem \
       mesa-filesystem.i686 \
       mesa-libEGL \
       mesa-libEGL.i686 \
       mesa-libGL \
       mesa-libGL.i686 \
       mesa-libGLU \
       mesa-libGLU.i686 \
       mesa-libgbm \
       mesa-libgbm.i686 \
       mesa-libglapi \
       mesa-libglapi.i686 \
       ibglvnd-opengl \
       libglvnd-core-devel \
       libglvnd-devel
echo ""

# LIB ZIP
echo "Install Archive Library..."
${CMD} tar \
       zip \
       unzip \
       cabextract \
       bzip2 \
       lzip \
       p7zip \
       p7zip-plugins \
       unrar \
       arj \
       unace
echo ""

# LIB CODEC
echo "Install Codec..."
${CMD} gstreamer1-libav \
       gstreamer1-plugins-bad-free \
       gstreamer1-plugins-bad-freeworld \
       gstreamer1-plugins-bad-free-extras \
       gstreamer1-plugins-base \
       gstreamer1-plugins-good \
       gstreamer1-plugins-ugly \
       gstreamer-ffmpeg \
       gstreamer-plugins-bad \
       gstreamer-plugins-bad-free \
       gstreamer-plugins-bad-nonfree \
       gstreamer-plugins-base \
       gstreamer-plugins-espeak \
       gstreamer-plugins-fc \
       gstreamer-plugins-good \
       gstreamer-plugins-ugly \
       gstreamer-rtsp \
       alsa-plugins-pulseaudio \
       amrnb \
       amrwb \
       faac \
       faad2 \
       flac \
       lame \
       libdca \
       libmad \
       libmatroska \
       x264 \
       x265 \
       xvidcore
echo ""

# DESKTOP
echo "Select Desktop Environment... Input Number or Name [Default: gnome]"
echo "Enabled Desktop Environment:
	1.gnome
	2.kde
	3.mate
	4.xfce
	5.cinnamon"
echo -n "select(10s): "
read -t 10 TARGET
if [ z${TARGET} == "z" ]
then
	TARGET="1"
fi	
case $TARGET in
	1|gnome)
		echo "Install GNOME Desktop Environment..."
		${CMD} gdm \
		       NetworkManager-wifi \
		       libevent \
		       ibus-hangul \
		       gnome-shell \
		       gnome-shell-extension-common \
		       nautilus \
		       gnome-terminal \
		       gnome-terminal-nautilus \
		       file-roller \
		       gnome-software \
		       xdg-user-dirs-gtk \
		       gvfs-mtp \
		       gvfs-smb \
		       gvfs-fuse
		       sudo systemctl enable gdm
	;;
	2|kde)
		echo "Install KDE Desktop Environment..."
		${CMD} kdm \
		       plasma-nm \
		       NetworkManager-wifi \
		       libevent \
		       ibus-hangul \
		       plasma-desktop \
		       dolphin \
		       ark \
		       apper \
		       xdg-user-dirs \
		       gvfs-mtp \
		       gvfs-smb \
		       gvfs-fuse
		       sudo systemctl enable kdm
		;;
	3|mate)
		echo "Install MATE Desktop Environment..."
		${CMD} lightdm \
		       NetworkManager-wifi \
		       libevent \
		       ibus-hangul \
		       network-manager-applet \
		       imsettings-mate \
		       mate-themes \
		       mate-desktop \
		       gtk2-engines \
		       metacity \
		       marco \
		       caja \
		       mate-terminal \
		       engrampa \
		       yumex-dnf \
		       xdg-user-dirs-gtk \
		       gvfs-mtp \
		       gvfs-smb \
		       gvfs-fuse
		       sudo systemctl enable lightdm
	;;
	4|xfce)
		echo "Install XFCE Desktop Environment..."
		${CMD} lightdm \
		       NetworkManager-wifi \
		       libevent \
		       ibus-hangul \
		       network-manager-applet \
		       imsettings-xfce \
		       xfce4-session \
		       xfce4-panel \
		       xfce4-settings \
		       xfwm4 \
		       xfdesktop \
		       fedora-icon-theme \
		       xfce4-terminal \
		       xarchiver \
		       yumex-dnf \
		       xdg-user-dirs-gtk \
		       gvfs-mtp \
		       gvfs-smb \
		       gvfs-fuse
		       sudo systemctl enable lightdm
	;;
	5|cinnamon)
		echo "Install CINNAMON Desktop Environment..."
		${CMD} lightdm \
		       NetworkManager-wifi \
		       libevent \
		       ibus-hangul \
		       network-manager-applet \
		       imsettings-cinnamon \
		       cinnamon \
		       nemo \
		       nemo-fileroller \
		       gnome-terminal \
		       file-roller \
		       yumex-dnf \
		       xdg-user-dirs-gtk \
		       gvfs-mtp \
		       gvfs-smb \
		       gvfs-fuse
		       sudo systemctl enable lightdm
	;;
	*)
		echo "skip..."
	;;
esac
echo ""

# APP
echo "Install Application..."
${CMD} flatpak \
       snapd \
       vim \
       firewall-config \
       PackageKit-gstreamer-plugin \
       PackageKit-command-not-found \
       wireless-tools \
       net-tools \
       drpm \
       tuned \
       bind-utils \
       gcc \
       cpp \
       make \
       irqbalance \
       pciutils \
       lsof
echo ""

# BOOT GRAPHCAL
if [ `sudo systemctl get-default` != "graphical.target" ]
then
	echo "Change Graphical boot..."
	sudo systemctl set-default graphical.target
	echo ""
fi

# END
echo "Complite Jobs.."
