import boto3

def cleanup_orphaned_resources():
    # initialize the ec2 client
    ec2 = boto3.client('ec2', region_name='us-east-1')
    
    print("--- Starting pranavissam Cost Optimization Scan ---")

    #  Find Unattached Elastic IPs (EIPs)
    # AWS charges you hourly for EIPs that are NOT associated with a running instance!
    addresses = ec2.describe_addresses()
    for addr in addresses['Addresses']:
        if 'InstanceId' not in addr:
            print(f"[!] Found Orphaned EIP: {addr['PublicIp']} - Suggest Deletion")
            # To actually delete: ec2.release_address(AllocationId=addr['AllocationId'])
        else:
            print(f"[OK] EIP {addr['PublicIp']} is attached to {addr['InstanceId']}")

    #  Find "Available" (Unused) EBS Volumes
    volumes = ec2.describe_volumes(
        Filters=[{'Name': 'status', 'Values': ['available']}]
    )
    
    for vol in volumes['Volumes']:
        print(f"[!] Found Unused Volume: {vol['VolumeId']} ({vol['Size']}GB) - Suggest Deletion")
        # to actually delete ec2.delete_volume(VolumeId=vol['VolumeId'])

    print("--- Scan Complete ---")

if __name__ == "__main__":
    cleanup_orphaned_resources()