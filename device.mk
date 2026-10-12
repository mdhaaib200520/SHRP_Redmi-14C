#
# Copyright (C) 2025 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common AOSP product config
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit device-specific configuration
$(call inherit-product, device/xiaomi/pond/device.mk)

# Inherit SHRP common configuration.
$(call inherit-product, vendor/shrp/config/common.mk)

# Device identifier
PRODUCT_DEVICE := pond
PRODUCT_NAME := shrp_pond
PRODUCT_DEVICE_PATH := device/xiaomi/pond
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi 14C
PRODUCT_MANUFACTURER := Xiaomi

# Ensure these are set for recovery
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.product=pond \
    ro.product.device=pond
