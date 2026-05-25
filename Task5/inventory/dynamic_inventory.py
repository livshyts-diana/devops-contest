#!/usr/bin/env python3
import json
import os
import sys

def main():
    target2 = os.environ.get("TARGET2_IP", "54.166.161.183")
    
    inventory = {
        "all": {
            "hosts": ["target_node_2"]
        },
        "_meta": {
            "hostvars": {
                "target_node_2": {
                    "ansible_host": target2,
                    "ansible_user": "ec2-user"
                }
            }
        }
    }
    
    print(json.dumps(inventory, indent=2))

if __name__ == "__main__":
    main()
