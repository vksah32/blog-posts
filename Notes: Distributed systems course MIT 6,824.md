# MIT's distributed systems course/Spring 2020

- Mapreduce
- GFS
- vmWare fault tolerant systems
  - only one replica, need external testAndSet server to decide primary (single point of falilure)
  - lot of dependence of hypervisor/virtual machine's network stack to do fault-tolerance
- Raft:
  - Based on majority vote, unlike vmWare FT, dont need external server
  - More here