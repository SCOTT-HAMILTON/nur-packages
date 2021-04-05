{ lib
, stdenv
, jdk11
, gradle
, gcc
}:

stdenv.mkDerivation {
  pname = "geogebra";
  version = "5.0.630.0";

  src = /home/scott/.tmp/tmp.vPo3Aqv2Zq/geogebra;

  buildPhase = ''
    rm -rf /tmp/gradle &> /dev/null
    mkdir /tmp/gradle 
    export GRADLE_USER_HOME="/tmp/gradle" 
    echo "org.gradle.java.home=${jdk11}/lib/openjdk" > /tmp/gradle/gradle.properties
    ./gradlew build --help
  '';

  dontUnpack = true;


}
