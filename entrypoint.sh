#!/bin/sh
set -e

DOCKER_USER='dockeruser'
DOCKER_GROUP='dockergroup'

if ! id "$DOCKER_USER" >/dev/null 2>&1; then
    echo "First start of the docker container, start initialization process."

    USER_ID=${PUID:-9001}
    GROUP_ID=${PGID:-9001}
    echo "Starting with $USER_ID:$GROUP_ID (UID:GID)"

    addgroup --gid $GROUP_ID $DOCKER_GROUP
    adduser $DOCKER_USER --shell /bin/sh --uid $USER_ID --ingroup $DOCKER_GROUP --disabled-password --gecos ""

    chown -vR $USER_ID:$GROUP_ID /opt/minecraft
    chmod -vR ug+rwx /opt/minecraft

    if [ "$SKIP_PERM_CHECK" != "true" ]
    then
        chown -vR $USER_ID:$GROUP_ID /data
    fi
fi

export HOME=/home/$DOCKER_USER

java -Xms$MEMORYSIZE -Xmx$MEMORYSIZE $JAVAFLAGS @/opt/minecraft/libraries/net/minecraftforge/forge/1.20.1-47.2.23/unix_args.txt nogui"$@"
#exec gosu $DOCKER_USER:$DOCKER_GROUP java -jar -Xms$MEMORYSIZE -Xmx$MEMORYSIZE $JAVAFLAGS -p libraries/cpw/mods/bootstraplauncher/1.1.2/bootstraplauncher-1.1.2.jar:libraries/cpw/mods/securejarhandler/2.1.10/securejarhandler-2.1.10.jar:libraries/org/ow2/asm/asm-commons/9.5/asm-commons-9.5.jar:libraries/org/ow2/asm/asm-util/9.5/asm-util-9.5.jar:libraries/org/ow2/asm/asm-analysis/9.5/asm-analysis-9.5.jar:libraries/org/ow2/asm/asm-tree/9.5/asm-tree-9.5.jar:libraries/org/ow2/asm/asm/9.5/asm-9.5.jar:libraries/net/minecraftforge/JarJarFileSystems/0.3.19/JarJarFileSystems-0.3.19.jar --add-modules ALL-MODULE-PATH --add-opens java.base/java.util.jar=cpw.mods.securejarhandler --add-opens java.base/java.lang.invoke=cpw.mods.securejarhandler --add-exports java.base/sun.security.util=cpw.mods.securejarhandler --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djava.net.preferIPv6Addresses=system -DignoreList=bootstraplauncher-1.1.2.jar,securejarhandler-2.1.10.jar,asm-commons-9.5.jar,asm-util-9.5.jar,asm-analysis-9.5.jar,asm-tree-9.5.jar,asm-9.5.jar,JarJarFileSystems-0.3.19.jar-DlibraryDirectory=libraries -DlegacyClassPath=libraries/cpw/mods/securejarhandler/2.1.10/securejarhandler-2.1.10.jar:libraries/org/ow2/asm/asm/9.5/asm-9.5.jar:libraries/org/ow2/asm/asm-commons/9.5/asm-commons-9.5.jar:libraries/org/ow2/asm/asm-tree/9.5/asm-tree-9.5.jar:libraries/org/ow2/asm/asm-util/9.5/asm-util-9.5.jar:libraries/org/ow2/asm/asm-analysis/9.5/asm-analysis-9.5.jar:libraries/net/minecraftforge/accesstransformers/8.0.4/accesstransformers-8.0.4.jar:libraries/org/antlr/antlr4-runtime/4.9.1/antlr4-runtime-4.9.1.jar:libraries/net/minecraftforge/eventbus/6.0.5/eventbus-6.0.5.jar:libraries/net/minecraftforge/forgespi/7.0.1/forgespi-7.0.1.jar:libraries/net/minecraftforge/coremods/5.0.1/coremods-5.0.1.jar:libraries/cpw/mods/modlauncher/10.0.9/modlauncher-10.0.9.jar:libraries/net/minecraftforge/unsafe/0.2.0/unsafe-0.2.0.jar:libraries/net/minecraftforge/mergetool/1.1.5/mergetool-1.1.5-api.jar:libraries/com/electronwill/night-config/core/3.6.4/core-3.6.4.jar:libraries/com/electronwill/night-config/toml/3.6.4/toml-3.6.4.jar:libraries/org/apache/maven/maven-artifact/3.8.5/maven-artifact-3.8.5.jar:libraries/net/jodah/typetools/0.6.3/typetools-0.6.3.jar:libraries/net/minecrell/terminalconsoleappender/1.2.0/terminalconsoleappender-1.2.0.jar:libraries/org/jline/jline-reader/3.12.1/jline-reader-3.12.1.jar:libraries/org/jline/jline-terminal/3.12.1/jline-terminal-3.12.1.jar:libraries/org/spongepowered/mixin/0.8.5/mixin-0.8.5.jar:libraries/org/openjdk/nashorn/nashorn-core/15.3/nashorn-core-15.3.jar:libraries/net/minecraftforge/JarJarSelector/0.3.19/JarJarSelector-0.3.19.jar:libraries/net/minecraftforge/JarJarMetadata/0.3.19/JarJarMetadata-0.3.19.jar:libraries/net/minecraftforge/fmlloader/1.20.1-47.2.0/fmlloader-1.20.1-47.2.0.jar:libraries/net/minecraft/server/1.20.1-20230612.114412/server-1.20.1-20230612.114412-extra.jar:libraries/com/github/oshi/oshi-core/6.2.2/oshi-core-6.2.2.jar:libraries/com/google/code/gson/gson/2.10/gson-2.10.jar:libraries/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar:libraries/com/google/guava/guava/31.1-jre/guava-31.1-jre.jar:libraries/com/mojang/authlib/4.0.43/authlib-4.0.43.jar:libraries/com/mojang/brigadier/1.1.8/brigadier-1.1.8.jar:libraries/com/mojang/datafixerupper/6.0.8/datafixerupper-6.0.8.jar:libraries/com/mojang/logging/1.1.1/logging-1.1.1.jar:libraries/commons-io/commons-io/2.11.0/commons-io-2.11.0.jar:libraries/io/netty/netty-buffer/4.1.82.Final/netty-buffer-4.1.82.Final.jar:libraries/io/netty/netty-codec/4.1.82.Final/netty-codec-4.1.82.Final.jar:libraries/io/netty/netty-common/4.1.82.Final/netty-common-4.1.82.Final.jar:libraries/io/netty/netty-handler/4.1.82.Final/netty-handler-4.1.82.Final.jar:libraries/io/netty/netty-resolver/4.1.82.Final/netty-resolver-4.1.82.Final.jar:libraries/io/netty/netty-transport/4.1.82.Final/netty-transport-4.1.82.Final.jar:libraries/io/netty/netty-transport-classes-epoll/4.1.82.Final/netty-transport-classes-epoll-4.1.82.Final.jar:libraries/io/netty/netty-transport-native-epoll/4.1.82.Final/netty-transport-native-epoll-4.1.82.Final-linux-x86_64.jar:libraries/io/netty/netty-transport-native-epoll/4.1.82.Final/netty-transport-native-epoll-4.1.82.Final-linux-aarch_64.jar:libraries/io/netty/netty-transport-native-unix-common/4.1.82.Final/netty-transport-native-unix-common-4.1.82.Final.jar:libraries/it/unimi/dsi/fastutil/8.5.9/fastutil-8.5.9.jar:libraries/net/java/dev/jna/jna/5.12.1/jna-5.12.1.jar:libraries/net/java/dev/jna/jna-platform/5.12.1/jna-platform-5.12.1.jar:libraries/net/sf/jopt-simple/jopt-simple/5.0.4/jopt-simple-5.0.4.jar:libraries/org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar:libraries/org/apache/logging/log4j/log4j-api/2.19.0/log4j-api-2.19.0.jar:libraries/org/apache/logging/log4j/log4j-core/2.19.0/log4j-core-2.19.0.jar:libraries/org/apache/logging/log4j/log4j-slf4j2-impl/2.19.0/log4j-slf4j2-impl-2.19.0.jar:libraries/org/joml/joml/1.10.5/joml-1.10.5.jar:libraries/org/slf4j/slf4j-api/2.0.1/slf4j-api-2.0.1.jar cpw.mods.bootstraplauncher.BootstrapLauncher --launchTarget forgeserver --fml.forgeVersion 47.2.0 --fml.mcVersion 1.20.1 --fml.forgeGroup net.minecraftforge --fml.mcpVersion 20230612.114412


#@/opt/minecraft/libraries/net/minecraftforge/forge/1.20.4-49.0.39/unix_args.txt nogui