  keytool -genkey -v -keystore %userprofile%\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
  keytool -importkeystore -srckeystore D:\data\hitrip\keystore\upload-keystore.jks -destkeystore D:\data\hitrip\keystore\upload-keystore.jks -deststoretype pkcs12
