# OZMZVPN

OpenVPN installer for Debian, Ubuntu, Fedora, CentOS and Arch Linux.

This script will let you setup your own secure VPN server in just a few seconds.

Execute this first to avoid errors
```bash
mkdir vpn
cd vpn
mkdir OZMZVPN
cd OZMZVPN
mkdir accounts
wget https://raw.githubusercontent.com/jaydee9296/OZMZVPN/master/OZMZVPN-OpenVPN.sh
chmod +x OZMZVPN-OpenVPN.sh
```

Then run it:
```sh
./OZMZVPN-OpenVPN.sh
```

You need to run the script as root and have the TUN module enabled.

The first time you run it, you'll have to follow the assistant and answer a few questions to setup your VPN server.

When OpenVPN is installed, you can run the script again, and you will get the choice to :

- Add a client
- Remove a client
- Uninstall OpenVPN

In your home directory, you will have `.ovpn` files. These are the client configuration files. Download them from your server and connect using your favorite OpenVPN client.

If you have any question, head to the [FAQ](#faq) first.

## Features

- Installs and configures a ready-to-use OpenVPN server
- Iptables rules and forwarding managed in a seamless way
- If needed, the script can cleanly remove OpenVPN, including configuration and iptables rules
- Customisable encryption settings, enhanced default settings (see [Security and Encryption](#security-and-encryption) below)
- OpenVPN 2.4 features, mainly encryption improvements (see [Security and Encryption](#security-and-encryption) below)
- Variety of DNS resolvers to be pushed to the clients
- Choice to use a self-hosted resolver with Unbound (supports already existing Unbound installations)
- Choice between TCP and UDP
- NATed IPv6 support
- Compression disabled by default to prevent VORACLE. LZ4 (v1/v2) and LZ0 algorithms available otherwise.
- Unprivileged mode: run as `nobody`/`nogroup`
- Block DNS leaks on Windows 10
- Randomised server certificate name
- Choice to protect clients with a password (private key encryption)
- Many other little things!

## Compatibility

The script supports these OS and architectures:

|                | i386 | amd64 | armhf | arm64 |
| -------------- | ---- | ----- | ----- | ----- |
| Amazon Linux 2 |  ❔  |  ✅  |   ❔  |   ❔  |
|  Arch Linux    |  ❔  |  ✅  |   ❔  |   ✅  |
|   CentOS 7     |  ❔  |  ✅  |   ❌  |   ✅  |
|   Debian 8     |  ✅  |  ✅  |   ❌  |   ❌  |
|   Debian 9     |  ❌  |  ✅  |   ✅  |   ✅  |
|   Debian 10    |  ❔  |  ✅  |   ✅  |   ❔  |
|   Fedora 27    |  ❔  |  ✅  |   ❔  |   ❔  |
|   Fedora 28    |  ❔  |  ✅  |   ❔  |   ❔  |
| Ubuntu 16.04   |  ✅  |  ✅  |   ❌  |   ❌  |
| Ubuntu 18.04   |  ❌  |  ✅  |   ✅  |   ✅  |
| Ubuntu 19.04   |  ❌  |  ✅  |   ✅  |   ✅  |

To be noted:

- It should work on Debian 8+ and Ubuntu 16.04+. But versions not in the table above are not officially supported.
- The script requires `systemd`.
- The script is regularly tested against `amd64` only.
