{ home-manager
, modules
, pkgs
, nixpkgs
, sync-database
, android-platform-tools }:
let
  sshKeys = import "${nixpkgs}/nixos/tests/ssh-keys.nix" pkgs;
    ssh-config = builtins.toFile "ssh.conf" ''
      UserKnownHostsFile=/dev/null
      StrictHostKeyChecking=no
    '';
in
import "${nixpkgs}/nixos/tests/make-test-python.nix" ({ pkgs, ...}: {
    system = "x86_64-linux";

    nodes = let
      usersConfig = { ... }: {
        users.users.bob =
        { isNormalUser = true;
          description = "Bob Foobar";
          password = "foobar";
        };
      };
    in {
      client =
        { ... }: {
          imports = [ "${home-manager}/nixos" usersConfig ];
          environment.systemPackages = with pkgs; [
            android-platform-tools
          ];
          home-manager.users.bob = { pkgs, ... }: {
            imports = [ modules.hmModules.sync-database ];
            sync-database = {
              enable = true;
              passwords_directory = "~/passwords";
              backup_history_directory = "~/passwords/history_backup";
              hosts = {
                server1 = {
                  user = "bob";
                  port = 22;
                };
              };
            };
          };

        };
      server1 =
        { ... }:

        {
          imports = [ usersConfig ]; 
          services.openssh.enable = true;
          security.pam.services.sshd.limits =
            [ { domain = "*"; item = "memlock"; type = "-"; value = 1024; } ];
          users.users.bob.openssh.authorizedKeys.keys = [
            sshKeys.snakeOilPublicKey
          ];
        };
    };

    testScript = let
      clientDb1 = ./dbs/db1-client.kdbx;
      server1Db1 = ./dbs/db1-server1.kdbx;
      runAsBob = cmd: "sudo -u bob ${cmd}";
    in ''
      start_all()

      server1.wait_for_unit("sshd")

      with subtest("manual-authkey"):
        client.succeed("${runAsBob "mkdir -m 700 /home/bob/.ssh"}")
        client.succeed(
            '${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f /home/bob/.ssh/id_ed25519 -N ""'
        )
        public_key = client.succeed(
            "${pkgs.openssh}/bin/ssh-keygen -y -f /home/bob/.ssh/id_ed25519"
        )
        public_key = public_key.strip()
        client.succeed("chmod 600 /home/bob/.ssh/id_ed25519")

        server1.succeed("mkdir -m 700 /home/bob/.ssh")
        server1.succeed("echo '{}' > /home/bob/.ssh/authorized_keys".format(public_key))


        client.succeed("cat ${ssh-config} > /home/bob/.ssh/config")
        server1.succeed("cat ${ssh-config} > /home/bob/.ssh/config")

        client.succeed(
          "cat ${sshKeys.snakeOilPrivateKey} > /home/bob/.ssh/id_ecdsa"
        )
        client.succeed("chmod 600 /home/bob/.ssh/id_ecdsa")

        client.succeed("chown -R bob /home/bob/.ssh")
        server1.succeed("chown -R bob /home/bob/.ssh")

        client.wait_for_unit("network.target")

      with subtest("Setup sync-database"):
        client.succeed("${runAsBob "mkdir -p /home/bob/passwords/history_backup"}")
        client.succeed("${runAsBob "cp ${clientDb1} /home/bob/passwords/db1.kdbx"}")
        client.succeed("chown bob /home/bob/passwords/db1.kdbx")
        client.succeed("chmod +w  /home/bob/passwords/db1.kdbx")
        server1.succeed("${runAsBob "mkdir -p /home/bob/passwords/history_backup"}")
        server1.succeed("${runAsBob "cp ${server1Db1} /home/bob/passwords/db1.kdbx"}")
        server1.succeed("chown bob /home/bob/passwords/db1.kdbx")
        server1.succeed("chmod +w  /home/bob/passwords/db1.kdbx")

      client.succeed("touch /home/bob/.ssh/known_hosts 1>&2")
      client.succeed("${runAsBob "ssh server1 'true' 1>&2"}")
      client.succeed("systemctl restart home-manager-bob.service -l 1>&2")
      client.succeed("${runAsBob "systemctl status home-manager-bob.service -l"} 1>&2")
      client.succeed("${runAsBob "cat /home/bob/.config/sync-database.conf"} 1>&2")
      client.succeed(
        "${runAsBob "HOME=/home/bob ${sync-database}/bin/sync_database -m test -t 200 1>&2"}"
      )
    '';
})
