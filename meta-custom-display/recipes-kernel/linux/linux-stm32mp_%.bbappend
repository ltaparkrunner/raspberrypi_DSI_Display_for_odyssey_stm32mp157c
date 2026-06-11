FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://0001-rpi-display-drivers.patch \
    file://rpi-display.cfg \
    file://stm32mp157c-odyssey-rpi.dts \
"

do_configure:prepend() {
    # 1. Копируем ваш DTS в исходники ядра
    cp ${WORKDIR}/stm32mp157c-odyssey-rpi.dts ${S}/arch/arm/boot/dts/
    
    # 2. Безопасно добавляем ваш DTB в Makefile ядра, если его там еще нет
    if ! grep -q "stm32mp157c-odyssey-rpi.dtb" ${S}/arch/arm/boot/dts/Makefile; then
        sed -i '/stm32mp157c-ev1.dtb/a \\tstm32mp157c-odyssey-rpi.dtb \\\\' ${S}/arch/arm/boot/dts/Makefile
    fi
}

KERNEL_DEVICETREE:append = " stm32mp157c-odyssey-rpi.dtb"
