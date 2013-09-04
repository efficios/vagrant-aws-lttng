vagrant-aws-lttng
=================

This is a provisioning utility for [LTTng](http://www.lttng.org) developers and users.

**NOTE:** This utility requires Vagrant 1.2+,

## Quick Start

You will need to install [Vagrant](http://www.vagrantup.com) and the [Vagrant AWS provider
plugin](https://github.com/mitchellh/vagrant-aws). 


Installing vagrant-aws plugin:
```
$ vagrant plugin install vagrant-aws
```

Once you have installed Vagrant and the AWS plugin, you will need to configure
your AWS account credentials. You can add them to the relevant Vagrantfile or
in a global way in the ~/.vagrant.d/Vagrantfile:

```
Vagrant.configure("2") do |config|
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = "ACCESS_KEY_ID"
    aws.secret_access_key = "SECRET_ACCESS_KEY"
    aws.keypair_name = "somekeypair"
    aws.region = "us-west-2"
    aws.security_groups = [ 'some security group' ]

    override.ssh.private_key_path = "/path/to/your/key"
  end
end
```

You can now run the launch script and follow the on-screen instruction:

```
scripts/launch.sh
[...] Follow the on-screen instruction for configuration options

                                   ';cloddddddol:,.                             
                            .',;:coddooooooooooooddl:,.                         
                      .',:codooooooooooooooooooooooooodl:,.                     
                   .;ldooooooooooooooooooooooooooooooooooodc.                   
                 .coooooooooooooooooooooooooooooooooooooooooo:.                 
               'cdooooooooooooooooooooooooooooooooooooooooooooo,                
             .cdooooooooooooooooooooooooooooooooooooooooooooooodc.              
           .:ooooooooooooooooooooooooooooooooooooooooooooooooooood,             
          'oooooooooooooddddddddddooooooooooooooooooooooooooooooood,            
         ;doooooooodxxkkkkkOkxxddoooooooooooooooooooooooooooooooooox.           
        .dooooooodxxxxxxxxkOxxxxxxdddoooooooooooooooooooooooooooooox:           
   .':lodoooooodxxodxxxxxxkkOkxxxxxdoooooooddoooooooooooooooooooooodd,.....     
.cONMMW0dooooddkkdodxxxxxxkOOkxxxxxxxddddxxdooooooooooooooooooooooooxddkxddx;   
0MMMMMXxooooddxkxoodxxxxxkO000kxxxxxxxxxxxxdddooooooooooooodkOkxdoookXo:c;.cNc  
XMMMMM0oooddxxxkkoddxxxxxxkkOO0kxxxxxxxxxxxxdddddooooooood00kddOKkdxKk;:do';Xx. 
.ckXWNkodddxxxxxkxdddxxxxxxxxkOOOOkkxxxxxxxxxxxdddooooooxKkloo:,xWKOXkoo:,k0;..
    .;:lokkkkxxxxkxddxxxxdol:;::lxO0OkxxxxxxxxxodxddddddKO:lodc,xNxoxKOxxxOd'...
         ..,;:clxO0Oxxdo;'.......,lddOOkOOOkkkxxoxxxdxddK0codlcdKkooodkOxc,.....
               .:xOOkxc.............'okkxOxxlxdkdxkxxxdod00kxk0Kxoooooooxc....  
                .,oOkxc..............';.,:,;...,...,codocldOOkdooooool:;,cl'... 
                   .',,'.......''.....,,....'....     .';;cddxxddddoo;.....'.   
                            '..'.',...'......'...          .';codkkxdo;....,,   
                            ....  ...... ......                  .';:oo:;,,.    
                             ...   .....  .....                        ..       
                              .     .....  ....    .:: LTTng ::.
                                     ...                                        
                                      '.                                       

[+] Acquiring mole power ... done.
[+] Vagrant AWS LTTng setup ... done.
[+] Configuration summary:
    Distro: Ubuntu 12.04 LTS (Precise Pangolin)
    Instance: t1.micro
    Architecture: amd64
Bringing machine 'default' up with 'aws' provider...
[...]
[+] Box location: boxes/ubuntu/12.04/

--> If for some reason the provisioning fails, you can retry with: 
    cd boxes/ubuntu/12.04/ && vagrant provision

--> To SSH into the AWS instance: 
    cd boxes/ubuntu/12.04/ && vagrant ssh

--> To shutdown the AWS instance: 
    cd boxes/ubuntu/12.04/ && vagrant destroy && cd -
```