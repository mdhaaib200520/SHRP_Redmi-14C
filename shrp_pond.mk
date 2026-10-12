
#
# Copyright (C) 2025 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit device-specific configuration
$(call inherit-product, device/xiaomi/pond/device.mk)

# Inherit SHRP common configuration.
# Uncomment only if this file exists in your SHRP source.
# $(call inherit-product, vendor/shrp/config/common.mk)

# Device identifier
PRODUCT_DEVICE := pond
PRODUCT_NAME := shrp_pond
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi 14C
PRODUCT_MANUFACTURER := Xiaomi
