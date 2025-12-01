FROM ubuntu:22.04

RUN <<-'EOF'
	set -eux
	apt-get update
	apt-get install -y wine64 python3 msitools ca-certificates --no-install-recommends
	apt-get clean -y
	rm -rf /var/lib/apt/lists/*
EOF

# Initialize the wine environment. Wait until the wineserver process has
# exited before closing the session, to avoid corrupting the wine prefix.
RUN <<-'EOF'
	set -eux
	wine64 wineboot -u
	/usr/lib/wine/wineserver64 -w
EOF

WORKDIR /opt/msvc

COPY lowercase fixinclude install.sh vsdownload.py msvctricks.cpp ./
COPY wrappers/* ./wrappers/

RUN <<-'EOF'
	set -eux
	PYTHONUNBUFFERED=1 ./vsdownload.py --accept-license --dest /opt/msvc
	./install.sh /opt/msvc
	rm lowercase fixinclude install.sh vsdownload.py
	rm -rf wrappers
EOF

# Later stages which actually uses MSVC can ideally start a persistent
# wine server like this:
# RUN <<-'EOF'
# 	wineserver -p
# 	wine64 wineboot
# 	...
# EOF
