# HPC Gateway

##Rack F07:

* Noeud 1:
    1. cuivre 1gb -> 130.223.30.77/22 -> uranium1.unil.ch 
    2. fibre 10gb -> VLAN privé (10.8.103/24)

## Rack F09:
* Noeud 2:
    1. cuivre 1gb -> 130.223.30.79/22 -> uranium2.unil.ch
    2. fibre 10gb -> VLAN privé (10.8.103/24)


# Storage 

##Rack B07:

* Synology:
    1. fibre 10gb -> VLAN privé (10.8.103/24)
    2. fibre 10gb -> 130.223.30.94/22 -> urnanium-syn.unil.ch

* Dell R720 (Gateway SAN VNX):
    1. cuivre 1gb -> 130.223.30.87/22 -> uranium-san.unil.ch (management)
    2. fibre 10gb -> VLAN privé (10.8.103/24)

* VNX5400 (management):
    1. cuivre 1gb -> 130.223.30.88/22 -> uranium-spa.unil.ch (management A)
    2. cuivre 1gb -> 130.223.30.89/22 -> uranium-spa.unil.ch (management B)

* Isilon 1:
    1. cuivre 1gb -> 130.223.30.90/22 -> uranium-isi1.unil.ch (management)
    2. fibre 10gb -> VLAN privé (10.8.103/24)

* Isilon 2:
    1. cuivre 1gb -> 130.223.30.91/22 -> uranium-isi2.unil.ch (management)
    2. fibre 10gb -> VLAN privé (10.8.103/24)

* Isilon 3:
    1. cuivre 1gb -> 130.223.30.92/22 -> uranium-isi3.unil.ch (management)
    2. fibre 10gb -> VLAN privé (10.8.103/24)

* Isilon 4:
    1. cuivre 1gb -> 130.223.30.93/22 -> uranium-isi4.unil.ch (management)
    2. fibre 10gb -> VLAN privé (10.8.103/24)
    
    
## Summary

| Addresses | Name |    RACK    |   DNS |
|:-----:|:--------:|:--------:|:--------:|
|   130.223.30.77/22  |   gw1 (HPC)    |    F07    | uranium1.unil.ch   |
|   130.223.30.78/22  |   gw2 (HPC)   | F09 |uranium1.unil.ch   |
|   130.223.30.79/22  |   Virtual Address    |    F07-F09    | uranium.unil.ch  |
|   10.8.103.2/24  |   gw1 (Data)  |    F07 |   -   |
|   10.8.103.3/24  |   gw2 (Data)   |   F09 |   -   |
|   Storage Synology  |    |    |     |
|   130.223.30.94/22  |   uranium-syn   |   B07 |   uranium-syn.unil.ch    |
|   10.8.103/24  |   syn   |   B07 |   -    |
|   Storage Gateway SAN VNX  |    |    |     |
|   130.223.30.87/22  |   uranium-san   |   B07 |   uranium-san.unil.ch    |
|   10.8.103/24  |   san   |   B07 |   -    |
|   Storage VNX5400 (management)  |    |    |     |
|   130.223.30.88/22  |   uranium-spa   |   B07 |   uranium-spa.unil.ch    |
|   130.223.30.89/22  |   uranium-spa   |   B07 |   uranium-spa.unil.ch    |
|   Storage ISILONS  |    |    |     |
|   130.223.30.90/22  |   uranium-isi1   |   B07 |   uranium-isi1.unil.ch    |
|   10.8.103.2/24  |   isi1 (Data)  |    B07 |   -   |
|   130.223.30.91/22  |   uranium-isi2   |   B07 |   uranium-isi2.unil.ch    |
|   10.8.103.2/24  |   isi2 (Data)  |    B07 |   -   |
|   130.223.30.92/22  |   uranium-isi3   |   B07 |   uranium-isi3.unil.ch    |
|   10.8.103.2/24  |   isi3 (Data)  |    B07 |   -   |
|   130.223.30.93/22  |   uranium-isi4   |   B07 |   uranium-isi4.unil.ch    |
|   10.8.103.2/24  |   isi4 (Data)  |    B07 |   -   |