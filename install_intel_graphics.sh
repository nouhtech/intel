#!/bin/bash

# تأكد من تحديث النظام
echo "تحديث النظام..."
sudo pacman -Syu --noconfirm

# تثبيت حزمة تعريف الرسوميات Intel
echo "تثبيت حزمة xf86-video-intel..."
sudo pacman -S xf86-video-intel --noconfirm

# تثبيت الحزم الضرورية
echo "تثبيت الحزم الضرورية..."
sudo pacman -S mesa libva-intel-driver --noconfirm

# تثبيت برامج إضافية لتحسين الأداء
echo "تثبيت برامج إضافية..."
sudo pacman -S intel-media-driver intel-media-sdk --noconfirm

# إنشاء ملف إعداد Xorg إذا لم يكن موجودًا
echo "تكوين إعدادات الرسوميات..."
if [ ! -f /etc/X11/xorg.conf.d/20-intel.conf ]; then
    sudo mkdir -p /etc/X11/xorg.conf.d
    echo 'Section "Device"
    Identifier "Intel Graphics"
    Driver "intel"
    Option "AccelMethod" "sna"
    Option "TearFree" "true"
EndSection' | sudo tee /etc/X11/xorg.conf.d/20-intel.conf > /dev/null
fi

# تثبيت أدوات المراقبة
echo "تثبيت أدوات المراقبة..."
sudo pacman -S mesa-utils --noconfirm

# عرض معلومات OpenGL
echo "التحقق من دعم OpenGL..."
glxinfo | grep "OpenGL"

# إعادة تشغيل النظام
echo "إعادة تشغيل النظام..."
sudo reboot
