LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := Nextcloud
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := Nextcloud.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_OPTIONAL_USES_LIBRARIES := org.apache.http.legacy
include $(BUILD_PREBUILT)
include $(PREBUILT_SHARED_LIBRARY)
