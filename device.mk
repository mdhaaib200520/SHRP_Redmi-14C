
#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2014-2023 The Team Win LLC
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/pond

# ==================================================
# Base product configuration
# ==================================================

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# GSI verification keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# ==================================================
# Virtual A/B
# ==================================================

$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

PRODUCT_USE_DYNAMIC_PARTITIONS := true

ENABLE_VIRTUAL_AB := true
AB_OTA_UPDATER := true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true

# ==================================================
# OTA / update-engine support
# Retain only if supported by the selected SHRP base.
# ==================================================

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# ==================================================
# Device API level
# ==================================================

PRODUCT_SHIPPING_API_LEVEL := 32

# ==================================================
# MediaTek boot control
# Keep modules that exist in your SHRP manifest.
# ==================================================

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.0-impl-1.2-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery \
    bootctrl.mt6768

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

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
# Device-specific partition utility
# Verify these modules exist before building.
# ==================================================

PRODUCT_PACKAGES += \
    create_pl_dev \
    create_pl_dev.recovery

# ==================================================
# Crypto / Keymaster
# Keep these dependencies for FBE only if required
# by your working recovery and present in the source.
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
# Recovery init scripts
# Keep these paths if the files exist and are
# compatible with the SHRP recovery ramdisk.
# ==================================================

PRODUCT_PACKAGES += \
    init.recovery.mt6768.rc \
    init.recovery.usb.rc \
    init.recovery.mt6768.rc.recovery

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/fox/init.recovery.mt6768.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mt6768.rc \
    $(LOCAL_PATH)/recovery/fox/init.recovery.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.usb.rc \
    $(LOCAL_PATH)/recovery/fox/init.recovery.mt6768.rc.recovery:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mt6768.rc.recovery
