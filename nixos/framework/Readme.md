# Framework

My dailydriver laptop

## Running a test VM

```bash
nixos-rebuild build-vm --flake .#framework
result/bin/run-framework-vm

# Remove disk image after you are done
rm framework.qcow2
```
