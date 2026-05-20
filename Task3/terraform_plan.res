
Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  ~ update in-place
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_instance.centos_server must be replaced
-/+ resource "aws_instance" "centos_server" {
      ~ ami                                  = "ami-02b2c1b57c5105166" -> "ami-0236922087fa98b6e" # forces replacement
      ~ arn                                  = "arn:aws:ec2:us-east-1:334455667670:instance/i-062f558d09305ea28" -> (known after apply)
      ~ associate_public_ip_address          = true -> (known after apply)
      ~ availability_zone                    = "us-east-1c" -> (known after apply)
      ~ cpu_core_count                       = 1 -> (known after apply)
      ~ cpu_threads_per_core                 = 2 -> (known after apply)
      ~ disable_api_stop                     = false -> (known after apply)
      ~ disable_api_termination              = false -> (known after apply)
      ~ ebs_optimized                        = false -> (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      - hibernation                          = false -> null
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      ~ id                                   = "i-062f558d09305ea28" -> (known after apply)
      ~ instance_initiated_shutdown_behavior = "stop" -> (known after apply)
      + instance_lifecycle                   = (known after apply)
      ~ instance_state                       = "running" -> (known after apply)
      ~ ipv6_address_count                   = 0 -> (known after apply)
      ~ ipv6_addresses                       = [] -> (known after apply)
      ~ monitoring                           = false -> (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      ~ placement_partition_number           = 0 -> (known after apply)
      ~ primary_network_interface_id         = "eni-0039bb24e8c711f1c" -> (known after apply)
      ~ private_dns                          = "ip-10-0-1-232.ec2.internal" -> (known after apply)
      ~ private_ip                           = "10.0.1.232" -> (known after apply)
      ~ public_dns                           = "ec2-54-81-76-59.compute-1.amazonaws.com" -> (known after apply)
      ~ public_ip                            = "54.81.76.59" -> (known after apply)
      ~ secondary_private_ips                = [] -> (known after apply)
      ~ security_groups                      = [] -> (known after apply)
      + spot_instance_request_id             = (known after apply)
        tags                                 = {
            "Name" = "CentOS"
        }
      ~ tenancy                              = "default" -> (known after apply)
      + user_data                            = "7fdb29420fdf6a6c86a91d7107ca83d28898c5c3"
      + user_data_base64                     = (known after apply)
      ~ vpc_security_group_ids               = [
          - "sg-02348ed325e319871",
        ] -> (known after apply)
        # (7 unchanged attributes hidden)

      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }

      - cpu_options {
          - core_count       = 1 -> null
          - threads_per_core = 2 -> null
        }

      - credit_specification {
          - cpu_credits = "unlimited" -> null
        }

      - enclave_options {
          - enabled = false -> null
        }

      - maintenance_options {
          - auto_recovery = "default" -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_protocol_ipv6          = "disabled" -> null
          - http_put_response_hop_limit = 2 -> null
          - http_tokens                 = "required" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      - private_dns_name_options {
          - enable_resource_name_dns_a_record    = false -> null
          - enable_resource_name_dns_aaaa_record = false -> null
          - hostname_type                        = "ip-name" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/xvda" -> null
          - encrypted             = false -> null
          - iops                  = 3000 -> null
          - tags                  = {} -> null
          - tags_all              = {} -> null
          - throughput            = 125 -> null
          - volume_id             = "vol-01c82cd2d83572617" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp3" -> null
        }
    }

  # aws_instance.ubuntu_server will be updated in-place
  ~ resource "aws_instance" "ubuntu_server" {
        id                                   = "i-047f7e952e97ae87c"
      ~ public_dns                           = "ec2-100-27-190-78.compute-1.amazonaws.com" -> (known after apply)
      ~ public_ip                            = "100.27.190.78" -> (known after apply)
        tags                                 = {
            "Name" = "Ubuntu"
        }
      ~ user_data                            = "5e2539a2b5a5251c0e9393ba1e4b8b3185533b35" -> "c334f97eb148966f2f389d480fab25209c275238"
        # (30 unchanged attributes hidden)

        # (8 unchanged blocks hidden)
    }

  # aws_security_group.centos_sg must be replaced
-/+ resource "aws_security_group" "centos_sg" {
      ~ arn                    = "arn:aws:ec2:us-east-1:334455667670:security-group/sg-02348ed325e319871" -> (known after apply)
      ~ description            = "Inbound: ICMP, 22, 80, 443 - Outbound: Only Local VPC" -> "Inbound: ICMP, 22, 80, 443 - Outbound: Only to Ubuntu SG" # forces replacement
      ~ egress                 = [
          - {
              - cidr_blocks      = [
                  - "10.0.0.0/16",
                ]
              - description      = ""
              - from_port        = -1
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "icmp"
              - security_groups  = []
              - self             = false
              - to_port          = -1
            },
          - {
              - cidr_blocks      = [
                  - "10.0.0.0/16",
                ]
              - description      = ""
              - from_port        = 22
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 22
            },
          - {
              - cidr_blocks      = [
                  - "10.0.0.0/16",
                ]
              - description      = ""
              - from_port        = 443
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 443
            },
          - {
              - cidr_blocks      = [
                  - "10.0.0.0/16",
                ]
              - description      = ""
              - from_port        = 80
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 80
            },
          + {
              + cidr_blocks      = []
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = [
                  + "sg-0508d36cf0372a155",
                ]
              + self             = false
              + to_port          = 0
            },
        ]
      ~ id                     = "sg-02348ed325e319871" -> (known after apply)
        name                   = "devops-sg-centos"
      + name_prefix            = (known after apply)
      ~ owner_id               = "334455667670" -> (known after apply)
        tags                   = {
            "Name" = "devops-sg-centos"
        }
        # (4 unchanged attributes hidden)
    }

Plan: 2 to add, 1 to change, 2 to destroy.

Changes to Outputs:
  ~ centos_public_ip  = "54.81.76.59" -> (known after apply)
  ~ ubuntu_public_ip  = "100.27.190.78" -> (known after apply)
