# Raft Consensus

## Overview

- consensus algorithm for managing a replicated log
- more understandable than Paxos
- inspired from ViewStamped Replication
- uses majority voting concept/ available as long as majority of servers are available

#### What are replicated state machines?

collection of state machines  in a cluster which can survive machine failure. Eg: HDFS uses zookeeper (replicated state machine) to manage cluster. Typically implemented using replicated log

![Screen Shot 2020-05-30 at 11.57.19 AM](https://raw.githubusercontent.com/vksah32/screenshots/master/Screen_Shot_2020-05-30_at_11.57.19_AM.png)

The consensus algorithm (Paxos, Raft) keeps the log synced among the servers

