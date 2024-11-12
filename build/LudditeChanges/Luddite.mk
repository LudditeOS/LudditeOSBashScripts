# vendor/yoursystem/config/common.mk

# Inherit base configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

# Your system name and version
PRODUCT_NAME := YourSystem
PRODUCT_VERSION := 1.0

# Include your prebuilt apps
$(call inherit-product-if-exists, vendor/yoursystem/prebuilt/apps/Android.mk)

# Your standard package list
PRODUCT_PACKAGES += \
    FocusLauncher

# Any other common configurations
PRODUCT_PROPERTY_OVERRIDES += \
    ro.yoursystem.version=$(PRODUCT_VERSION)