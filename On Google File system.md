# Google File System


- Read the annotated paper [here](https://github.com/vksah32/readings/blob/master/distributed-systems/gfs.pdf) 

- Architecture

  ![Screen Shot 2020-05-25 at 5.00.21 PM](https://raw.githubusercontent.com/vksah32/screenshots/master/Screen_Shot_2020-05-25_at_5.00.21_PM.png)

  

- Lecture video: [MIT 6.824: Lecture 3](https://www.youtube.com/watch?v=EpIgvowZr00)

- **Key observations:**

  - Single master architecture (but master state replicated in case master goes down)
  - client use a library to manage interactions with the file system
  - Read is straightforward; client gets chunk servers for a file from master and pings the nearest chunk server.
  - Write is pretty complicated, doesn't guarantee **strong consistency**
    - For each write; there's a primary and secondaries
    - two steps: client transmits data, gets ack and then sends append request; primary applies the *mutation* first and forwards the *mutation* request to secondaries; all primary and secondary must append for write to be successful
    - It could happen that some replicas have appended and some haven't; in this case the write is marked failure and client is expected to retry. 
      - When retries successful, can end up with replicas with data in different order (since its append only, if a replica previously appended, it will append again on rety)
      - can end up with inconsistent replica if the client dies before retrying. (some replicas would extra data than others- extra being data from failed writes)
    - Lease: handle split brain scenario; if master and primary got partitioned, it will only last for lease duration in worst case.
  - Issues:
    - single master load, running out of RAM
    - client is expected to handle inconsistencies,  more responsibilities on client
    - human intervention needed when master failed

- Includes references to AFS  ([wiki](https://en.wikipedia.org/wiki/Andrew_File_System)/ [paper](http://www.cs.cmu.edu/afs/cs/project/coda-www/ResearchWebPages/docdir/s11.pdf) ) (1988), [xFS](https://en.wikipedia.org/wiki/XFS) (1994), [Frangipani](https://pdos.csail.mit.edu/6.824/papers/thekkath-frangipani.pdf) [12] (1997), ,  [InterMezzo](https://en.wikipedia.org/wiki/InterMezzo_(file_system))  (1999), [NASD](https://en.wikipedia.org/wiki/Network-Attached_Secure_Disks) (1997-2001), [Global File System](https://en.wikipedia.org/wiki/GFS2)  (1995), [Lustre](https://en.wikipedia.org/wiki/Lustre_(file_system)) (2003) etc

