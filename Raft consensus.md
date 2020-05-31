# Raft Consensus

Context: I am implementing Raft in lab 2 of MIT's distributed system's course. 

## Overview

- consensus algorithm for managing a replicated log
- more understandable than Paxos
- inspired from ViewStamped Replication
- uses majority voting concept/ available as long as majority of servers are available
- decomposition of problems: separated leader election, log replication, safety, and membership changes.

#### What are replicated state machines?

collection of state machines  in a cluster which can survive machine failure. Eg: HDFS uses zookeeper (replicated state machine) to manage cluster. Typically implemented using replicated log

![Screen Shot 2020-05-30 at 11.57.19 AM](https://raw.githubusercontent.com/vksah32/screenshots/master/Screen_Shot_2020-05-30_at_11.57.19_AM.png)

The consensus algorithm (Paxos, Raft) keeps the log consistent among the servers. Follow the steps in the figure above to get the feel of how it works.



#### Problems with Paxos

- Hard to understand, built into two phases which are not intuitive; 
- No standard agreed upon algorithm, even Lamport didn't fully describe multi-paxos ; Chubby implements some version of Paxos but isnt published

> Does zookeper use Paxos? => *No, it uses ZAB (Zookeper Atomic Broadcast)*
>
> Why does zookeper not use Raft? => *Timing, zookeper started in 2007, raft in 2013*

Read this [blog post from Alibaba-cloud]( https://www.alibabacloud.com/blog/a-brief-analysis-of-consensus-protocol-from-logical-clock-to-raft_594675) for overview of paxos and ZAB (and raft too)

#### Raft Algorithm

Please refer to figure 2 of Extended raft paper for detailed overview.

- Distinguished leader approach -> only leader accepts log entries from clients,  decides how to write to logs, replicates to other servers
- Concept of term -> each term starts with an election for a leader; serves as logical clock and represneted by sequential intergers
- Leader election
  - when a follower doesnt get heartbeat from leader, it starts an election; promotes itself to *candidate* and requests vote from other servers; if it receives majority, then it promotes itself to leader and sends heartbeat to tell others who's the boss; if no leader selection; election will continue; use of random election timeouts to prevent split voting; each server uses first come first serve to asign votes.
- Log replication
  - Leader accepts log entry from client
  - leader replicates it to majority of servers
  - then, it applies it to its own state machine=> *committed*
  - It sends message to all followers that it has committed certain log entries; then the followers apply those log entries to their own state machine.    
- Safety 
  - Restrictions on which server maybe elected eg: maybe not servers which have lagged
  - achieves this during election; a server can only vote if the candidate's log is at least up-to-date as the server's; notice that if the candidate were to get majority of the vote, it will reach at least one server which has all entries from previous term (this is because there is at least one common item if you look at majority from two terms).

Its worth going over the proofs [ in Section 5.4.3 of the paper] of **Leader Completeness Property** (which states a new leader stores all log entries from a previous leader) and **State Machine Safety Property** ( which states that if a server has applied a log entry at a given index to its state machine, no other server will ever apply a different log entry for the same index.)





Useful links:

- [Student's guide to Raft](https://thesquareplanet.com/blog/students-guide-to-raft/)
- [Raft's locking advice](https://pdos.csail.mit.edu/6.824/labs/raft-locking.txt)
- Raft's striu

