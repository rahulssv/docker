# Image based on:
# https://github.com/dotnet/dotnet-docker/blob/main/src/runtime-deps/3.1/alpine3.16
# https://github.com/dotnet/dotnet-docker/blob/main/src/runtime/6.0/alpine3.16
# https://github.com/dotnet/dotnet-docker/blob/main/src/aspnet/6.0/alpine3.16

FROM alpine:3.16

RUN apk add --update --no-cache \
        ca-certificates \
        \
        # .NET Core dependencies
        krb5-libs \
        libgcc \
        libintl \
        libssl1.1 \
        libstdc++ \
        zlib

ENV \
    # Configure web servers to bind to port 80 when present
    ASPNETCORE_URLS=http://+:80 \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true \
    # Set the invariant mode since ICU package isn't included (see https://github.com/dotnet/announcements/issues/20)
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

# .NET Runtime version
ENV DOTNET_VERSION=6.0.10

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64)  binArch='x64'; checksum='0277e5f81ee0b28b262ee4b0de5e62d4599acf95f65dba12a562ad682675e9aa9d1d4fb5b6d3a49bac481afc405fa2596a48407ba5225093e5d6effd69aa0105' ;; \
		armv7)   binArch='arm'; checksum='cac7100cab3eb35e76867fb6a7a2b7b361355d634205f2d6669757c9091d844a332b74c184f0ce566457d1548c2a490563dceefc584d64c2db3fd9d2c9b58797' ;; \
		aarch64) binArch='arm64'; checksum='4f00918771c56856231c715ad9f1febcdc39127ac0265c97da76375ba20cbc7109ee696dae72e5f5d8fa1998588e697a4a6785c919e96a7bda7408a500cc59e1' ;; \
		*) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
	esac; \
	wget -O dotnet.tar.gz "https://dotnetcli.azureedge.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-musl-${binArch}.tar.gz"; \
	echo "$checksum  dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -oxzf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# ASP.NET Core version
ENV ASPNET_VERSION=6.0.10

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64)  binArch='x64'; checksum='55cfa0419965dc15127fca3da0f567dd64dc4ca3981f5e3366e01f88c670f91b361548be99c507fcf9fdc51078387a230c3d09d399d7b0345ae4b6e60ae2615f' ;; \
		armv7)   binArch='arm'; checksum='56a8b2ee654ca040d448a7c0ef09a310d713a892de90df1146d1748db87f6aca86ec95f1db182937b2b99186a2bd3ce14d9d37e172d68552720b149041b4051b' ;; \
		aarch64) binArch='arm64'; checksum='1cc24cf179bf391945fa78ed1311e90d06451c9ba918d742f3e0338d3a0aab1374a167e781c40c8e421be8369c55936c051ab59459298dcdeaf91df6643b35cc' ;; \
		*) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
	esac; \
    wget -O aspnetcore.tar.gz "https://dotnetcli.azureedge.net/dotnet/aspnetcore/Runtime/$ASPNET_VERSION/aspnetcore-runtime-$ASPNET_VERSION-linux-musl-${binArch}.tar.gz"; \	
    echo "$checksum  aspnetcore.tar.gz" | sha512sum -c - \
    && tar -oxzf aspnetcore.tar.gz -C /usr/share/dotnet ./shared/Microsoft.AspNetCore.App \
    && rm aspnetcore.tar.gz
