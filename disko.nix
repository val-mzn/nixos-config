{
    device ? throw "device is required",
    ...
}: {
    disko.devices = {
        disk.main = {
            inherit device;
            type = "disk";
            content = {
                type = "gpt";
                partitions = {
                    boot = {
                        name = "boot";
                        size = "1M";
                        type = "EF02";
                    };
                    ESP = {
                        type = "EF00";
                        size = "500M";
                        content = {
                            type = "filesystem";
                            format = "vfat";
                            mountpoint = "/boot";
                        };
                    };
                    swap = {
                        size = "4G";
                        content = {
                            type = "swap";
                            resumeDevice = true;
                        };
                    };
                    root = {
                        size = "100%";
                        content = {
                            type = "filesystem";
                            format = "btrfs";
                            mountpoint = "/";
                        };
                    };
                };
            };
        };
    };
};