#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/amlogic/gx-common

## Architecture
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

## BUILD_BROKEN_*
# Needed for systemcontrol blobs copy-files to recovery via TARGET_RECOVERY_DEVICE_DIRS
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

## Kernel
BOARD_KERNEL_CMDLINE := use_uvm=1
ifeq ($(TARGET_BOOTDEVICE),usb)
  BOARD_KERNEL_CMDLINE += androidboot.boot_devices=c9000000.dwc3
else ifeq ($(TARGET_BOOTDEVICE),sdcard)
  BOARD_KERNEL_CMDLINE += androidboot.boot_devices=d0072000.sd
else
  BOARD_KERNEL_CMDLINE += androidboot.boot_devices=d0074000.emmc
endif

ifeq ($(WITH_CONSOLE),true)
  BOARD_KERNEL_CMDLINE += console=ttyS0,115200 no_console_suspend ignore_loglevel printk.devkmsg=on
  BOARD_KERNEL_CMDLINE += earlycon=aml_uart,0xc81004c0
endif

TARGET_KERNEL_VERSION ?= 5.15

## Partitions
SSI_PARTITIONS := system
TREBLE_PARTITIONS := odm vendor
ALL_PARTITIONS := $(SSI_PARTITIONS) $(TREBLE_PARTITIONS)

BOARD_ODMIMAGE_PARTITION_SIZE ?= 134217728
BOARD_SYSTEMIMAGE_PARTITION_SIZE ?= 1656750080
BOARD_VENDORIMAGE_PARTITION_SIZE ?= 335544320

## Properties
TARGET_SYSTEM_EXT_PROP += $(COMMON_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(COMMON_PATH)/vendor.prop

## Recovery
TARGET_RECOVERY_DEVICE_DIRS += vendor/amlogic/gx-common/proprietary
ifneq ($(strip $(TARGET_BOOTDEVICE)),)
  TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/init/fstab.$(TARGET_BOOTDEVICE).amlogic
else
  TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/init/fstab.amlogic
endif

## Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(COMMON_PATH)/releasetools

## Updater
AB_OTA_UPDATER := false

## Vendor SPL
VENDOR_SECURITY_PATCH := 2026-03-01

## Include the main common tree BoardConfig makefile
include device/amlogic/common/BoardConfigAmlogic.mk

## Include the common proprietary BoardConfig makefile
include vendor/amlogic/gx-common/BoardConfigVendor.mk
