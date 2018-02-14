## USB Key Bootable mac os X to Centos 7

1 Visit Centos’ web page, https://www.centos.org/download/, and download the iso image you’d like to boot from.

2 When the download has completed, open up terminal and use ‘hditutil’ to convert the *.iso to an *.img file (specifically, a UDIF read/write image).

```bash

cbovigny@wl5s-80-124:~/Downloads$ hdiutil convert -format UDRW -o target.img CentOS-7-x86_64-DVD-1708.iso 
	
	Reading Master Boot Record (MBR : 0)…
	Reading CentOS 7 x86_64                  (Apple_ISO : 1)…
	Reading  (Type EF : 2)…
	Reading CentOS 7 x86_64                  (Apple_ISO : 3)…
	............................................................................................................................................................................................
	Elapsed Time:  8.961s
	Speed: 481.1Mbytes/sec
	Savings: 0.0%
	created: /Users/cbovigny/Downloads/target.img.dmg
```

3 Use the ‘dd’ utility to copy the iso to your USB drive:

```
cbovigny@wl5s-80-124:~/Downloads$ diskutil list
/dev/disk0 (internal):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                         500.3 GB   disk0
   1:                        EFI EFI                     314.6 MB   disk0s1
   2:                 Apple_APFS Container disk1         500.0 GB   disk0s2

/dev/disk1 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +500.0 GB   disk1
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            369.4 GB   disk1s1
   2:                APFS Volume Preboot                 20.2 MB    disk1s2
   3:                APFS Volume Recovery                509.8 MB   disk1s3
   4:                APFS Volume VM                      4.3 GB     disk1s4

/dev/disk2 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *125.8 GB   disk2
   1:                 DOS_FAT_32 UNTITLED                125.8 GB   disk2s1

cbovigny@wl5s-80-124:~/Downloads$ diskutil unmountDisk disk2
Unmount of all volumes on disk2 was successful

cbovigny@wl5s-80-124:~/Downloads$ time sudo dd if=target.img.dmg of=/dev/disk2 bs=1m
```

4 You should be done! Boot from the USB drive on your target machine.
