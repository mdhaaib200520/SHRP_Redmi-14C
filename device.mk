#
# Copyright (C) 2025 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/pond

# ==================================================
# Base product configuration
# ==================================================
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# ==================================================
# Virtual A/B (ramdisk layout only — NO OTA stack)
# ==================================================
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true

# ==================================================
# Device API level
# ==================================================
PRODUCT_SHIPPING_API_LEVEL := 32

# ==================================================
# MediaTek boot control
# ==================================================
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.0-impl-1.2-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery \
    bootctrl.mt6768

# ==================================================
# Fastbootd
# ==================================================
TW_INCLUDE_FASTBOOTD := true

PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# ==================================================
# Health HAL
# ==================================================
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service.rc

# ==================================================
# Soong namespace
# ==================================================
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# ==================================================
# Crypto / Keymaster
# ==================================================
TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libkeymaster41 \
    libpuresoftkeymasterdevice \
    libkeymaster_messages.vendor

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster41.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_messages.so

# ==================================================
# Recovery init scripts — CORRECT PATH (recovery/root, not recovery/fox)
# ==================================================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.mt6768.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mt6768.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.usb.rc
