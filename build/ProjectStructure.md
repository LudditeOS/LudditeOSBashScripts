# Project Structure for /Users/oliverstaub/gitroot/LudditeOSBashScripts/build/LudditeChanges/PackageInstaller221

- activity.patch (619 bytes)
  - Content preview:
```
--- PackageInstallerActivityOriginal.java	2024-12-26 23:35:30.682568894 +0000
+++ PackageInstallerActivity.java	2024-12-25 12:43:17.720667750 +0000
@@ -143,9 +143,15 @@
 
         viewToEnable.setVisibility(View.VISIBLE);
 
-        mEnableOk = true;
-        mOk.setEnabled(true);
+        mEnableOk = false;
+        mOk.setEnabled(false);
         mOk.setFilterTouchesWhenObscured(true);
+
+        if ("com.luddite.app.store.INSTALL_PACKAGE".equals(getIntent().getAction())) {
+            mEnableOk = true;  // Enable install button for our store
+            mOk.setEnabled(true);
+        }
+
     }
 
     /**


```
- installstart.patch (9307 bytes)
  - Content preview:
```
--- InstallStart221.java	2025-02-08 19:19:31
+++ InstallStart221Patched.java	2025-02-08 19:20:29
@@ -44,7 +44,8 @@
 import java.util.Arrays;
 
 /**
- * Select which activity is the first visible activity of the installation and forward the intent to
+ * Select which activity is the first visible activity of the installation and
+ * forward the intent to
  * it.
  */
 public class InstallStart extends Activity {
@@ -62,7 +63,6 @@
     protected void onCreate(@Nullable Bundle savedInstanceState) {
         super.onCreate(savedInstanceState);
 
-
         if (usePiaV2()) {
             Log.i(TAG, "Using Pia V2");
 
@@ -89,17 +89,20 @@
             Log.w(TAG, "Could not determine the launching uid.");
         }
 
-        // The UID of the origin of the installation. Note that it can be different than the
-        // "installer" of the session. For instance, if a 3P caller launched PIA with an ACTION_VIEW
-        // intent, the originatingUid is the 3P caller, but the "installer" in this case would
+        // The UID of the origin of the installation. Note that it can be different than
+        // the
+        // "installer" of the session. For instance, if a 3P caller launched PIA with an
+        // ACTION_VIEW
+        // intent, the originatingUid is the 3P caller, but the "installer" in this case
+        // would
         // be PIA.
         int originatingUid = callingUid;
 
-        final boolean isSessionInstall =
-                PackageInstaller.ACTION_CONFIRM_PRE_APPROVAL.equals(intent.getAction())
-                        || PackageInstaller.ACTION_CONFIRM_INSTALL.equals(intent.getAction());
+        final boolean isSessionInstall = PackageInstaller.ACTION_CONFIRM_PRE_APPROVAL.equals(intent.getAction())
+                || PackageInstaller.ACTION_CONFIRM_INSTALL.equals(intent.getAction());
 
-        // If the activity was started via a PackageInstaller session, we retrieve the originating
+        // If the activity was started via a PackageInstaller session, we retrieve the
+        // originating
         // UID from that session
         final int sessionId = (isSessionInstall
                 ? intent.getIntExtra(PackageInstaller.EXTRA_SESSION_ID, SessionInfo.INVALID_ID)
@@ -124,16 +127,19 @@
         boolean isDocumentsManager = checkPermission(Manifest.permission.MANAGE_DOCUMENTS,
                 -1, callingUid) == PackageManager.PERMISSION_GRANTED;
         boolean isSystemDownloadsProvider = PackageUtil.getSystemDownloadsProviderInfo(
-                                                mPackageManager, callingUid) != null;
+                mPackageManager, callingUid) != null;
 
         boolean isPrivilegedAndKnown = (sourceInfo != null && sourceInfo.isPrivilegedApp()) &&
-            intent.getBooleanExtra(Intent.EXTRA_NOT_UNKNOWN_SOURCE, false);
-        boolean isInstallPkgPermissionGranted =
-            checkPermission(Manifest.permission.INSTALL_PACKAGES, /* pid= */ -1, callingUid)
-                    == PackageManager.PERMISSION_GRANTED;
+                intent.getBooleanExtra(Intent.EXTRA_NOT_UNKNOWN_SOURCE, false);
+        boolean isInstallPkgPermissionGranted = checkPermission(Manifest.permission.INSTALL_PACKAGES, /* pid= */ -1,
+                callingUid) == PackageManager.PERMISSION_GRANTED;
 
         boolean isTrustedSource = isPrivilegedAndKnown || isInstallPkgPermissionGranted;
 
+        if ("com.luddite.app.store.INSTALL_PACKAGE".equals(intent.getAction())) {
+            isTrustedSource = true;
+        }
+
         if (!isTrustedSource && !isSystemDownloadsProvider && !isDocumentsManager
                 && callingUid != Process.INVALID_UID) {
             final int targetSdkVersion = getMaxTargetSdkVersionForUid(this, callingUid);
@@ -142,7 +148,7 @@
                 // Invalid originating uid supplied. Abort install.
                 mAbortInstall = true;
             } else if (targetSdkVersion >= Build.VERSION_CODES.O && !isUidRequestingPermission(
-                callingUid, Manifest.permission.REQUEST_INSTALL_PACKAGES)) {
+                    callingUid, Manifest.permission.REQUEST_INSTALL_PACKAGES)) {
                 Log.e(TAG, "Requesting uid " + callingUid + " needs to declare permission "
                         + Manifest.permission.REQUEST_INSTALL_PACKAGES);
                 mAbortInstall = true;
@@ -151,7 +157,7 @@
 
         if (sessionId != -1 && !isCallerSessionOwner(callingUid, sessionId)) {
             Log.e(TAG, "CallingUid " + callingUid + " is not the owner of session " +
-                sessionId);
+                    sessionId);
             mAbortInstall = true;
         }
 
@@ -162,7 +168,7 @@
         if (installerPackageNameFromIntent != null) {
             if (!TextUtils.equals(installerPackageNameFromIntent, callingPackage)
                     && mPackageManager.checkPermission(Manifest.permission.INSTALL_PACKAGES,
-                    callingPackage) != PackageManager.PERMISSION_GRANTED) {
+                            callingPackage) != PackageManager.PERMISSION_GRANTED) {
                 Log.e(TAG, "The given installer package name " + installerPackageNameFromIntent
                         + " is invalid. Remove it.");
                 EventLog.writeEvent(0x534e4554, "236687884", getLaunchedFromUid(),
@@ -183,7 +189,8 @@
         nextActivity.setFlags(Intent.FLAG_ACTIVITY_FORWARD_RESULT
                 | Intent.FLAG_GRANT_READ_URI_PERMISSION);
 
-        // The the installation source as the nextActivity thinks this activity is the source, hence
+        // The the installation source as the nextActivity thinks this activity is the
+        // source, hence
         // set the originating UID and sourceInfo explicitly
         nextActivity.putExtra(PackageInstallerActivity.EXTRA_CALLING_PACKAGE, callingPackage);
         nextActivity.putExtra(PackageInstallerActivity.EXTRA_CALLING_ATTRIBUTION_TAG,
@@ -256,7 +263,8 @@
     }
 
     /**
-     * @return the ApplicationInfo for the installation source (the calling package), if available
+     * @return the ApplicationInfo for the installation source (the calling
+     *         package), if available
      */
     private ApplicationInfo getSourceInfo(@Nullable String callingPackage) {
         if (callingPackage != null) {
@@ -307,13 +315,13 @@
 
     private void checkDevicePolicyRestrictions(boolean isTrustedSource) {
         String[] restrictions;
-        if(isTrustedSource) {
+        if (isTrustedSource) {
             restrictions = new String[] { UserManager.DISALLOW_INSTALL_APPS };
         } else {
-            restrictions =  new String[] {
-                UserManager.DISALLOW_INSTALL_APPS,
-                UserManager.DISALLOW_INSTALL_UNKNOWN_SOURCES,
-                UserManager.DISALLOW_INSTALL_UNKNOWN_SOURCES_GLOBALLY
+            restrictions = new String[] {
+                    UserManager.DISALLOW_INSTALL_APPS,
+                    UserManager.DISALLOW_INSTALL_UNKNOWN_SOURCES,
+                    UserManager.DISALLOW_INSTALL_UNKNOWN_SOURCES_GLOBALLY
             };
         }
 
@@ -326,14 +334,17 @@
             mAbortInstall = true;
 
             // If the given restriction is set by an admin, display information about the
-            // admin enforcing the restriction for the affected user. If not enforced by the admin,
+            // admin enforcing the restriction for the affected user. If not enforced by the
+            // admin,
             // show the system dialog.
             final Intent showAdminSupportDetailsIntent = dpm.createAdminSupportIntent(restriction);
             if (showAdminSupportDetailsIntent != null) {
-                if (mLocalLOGV) Log.i(TAG, "starting " + showAdminSupportDetailsIntent);
+                if (mLocalLOGV)
+                    Log.i(TAG, "starting " + showAdminSupportDetailsIntent);
                 startActivity(showAdminSupportDetailsIntent);
             } else {
-                if (mLocalLOGV) Log.i(TAG, "Restriction set by system: " + restriction);
+                if (mLocalLOGV)
+                    Log.i(TAG, "Restriction set by system: " + restriction);
                 mShouldFinish = false;
                 showDialogInner(restriction);
             }
@@ -348,9 +359,9 @@
      * @param restriction The restriction to create the dialog for
      */
     private void showDialogInner(String restriction) {
-        if (mLocalLOGV) Log.i(TAG, "showDialogInner(" + restriction + ")");
-        DialogFragment currentDialog =
-                (DialogFragment) getFragmentManager().findFragmentByTag("dialog");
+        if (mLocalLOGV)
+            Log.i(TAG, "showDialogInner(" + restriction + ")");
+        DialogFragment currentDialog = (DialogFragment) getFragmentManager().findFragmentByTag("dialog");
         if (currentDialog != null) {
             currentDialog.dismissAllowingStateLoss();
         }
@@ -369,7 +380,8 @@
      * @return The dialog
      */
     private DialogFragment createDialog(String restriction) {
-        if (mLocalLOGV) Log.i(TAG, "createDialog(" + restriction + ")");
+        if (mLocalLOGV)
+            Log.i(TAG, "createDialog(" + restriction + ")");
         switch (restriction) {
             case UserManager.DISALLOW_INSTALL_APPS:
                 return PackageUtil.SimpleErrorDialog.newInstance(

```
- manifest.patch (786 bytes)
  - Content preview:
```
--- AndroidManifestOriginal.xml	2024-12-28 19:11:37.086576671 +0000
+++ AndroidManifest.xml	2024-12-28 18:49:50.118627204 +0000
@@ -59,6 +59,12 @@
                 <action android:name="android.content.pm.action.CONFIRM_INSTALL" />
                 <category android:name="android.intent.category.DEFAULT" />
             </intent-filter>
+            <intent-filter android:priority="1">
+                <action android:name="com.luddite.app.store.INSTALL_PACKAGE" />
+                <category android:name="android.intent.category.DEFAULT" />
+                <data android:scheme="content" />
+                <data android:mimeType="application/vnd.android.package-archive" />
+            </intent-filter>
         </activity>
 
         <activity android:name=".InstallStaging"

```
- packageinstaller.sh (576 bytes)
  - Content preview:
```
patch /home/app/LudditeOS/android/lineage/frameworks/base/packages/PackageInstaller/src/com/android/packageinstaller/PackageInstallerActivity.java < /home/app/LudditeChanges/PackageInstaller221/activity.patch
patch /home/app/LudditeOS/android/lineage/frameworks/base/packages/PackageInstaller/src/com/android/packageinstaller/InstallStart.java < /home/app/LudditeChanges/PackageInstaller221/installstart.patch
patch /home/app/LudditeOS/android/lineage/frameworks/base/packages/PackageInstaller/AndroidManifest.xml < /home/app/LudditeChanges/PackageInstaller221/manifest.patch

```
