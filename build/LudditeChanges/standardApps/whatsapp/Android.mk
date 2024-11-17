LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := Whatsapp
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := Whatsapp.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_PRODUCT_MODULE := true
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_DEX_PREOPT := false
LOCAL_ENFORCE_USES_LIBRARIES := false
LOCAL_OPTIONAL_USES_LIBRARIES := com.sec.android.app.multiwindow org.apache.http.legacy androidx.window.extensions androidx.window.sidecar
include $(BUILD_PREBUILT)
