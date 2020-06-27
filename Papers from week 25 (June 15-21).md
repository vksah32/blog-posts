# Papers from week 25 (June 15-21)

## Haystack-fb

Object store which optimizes for file reads while minimizing #disk operations. It does this by:

*Haystack achieves this goal by dramatically reducing the memory used for filesystem metadata, thereby making it practical to keep all this metadata in main memory.*

*Recall that storing a single photo per file resulted in more filesystem metadata than could be reasonably cached. Haystack takes a straight-forward approach: it stores multiple photos in a single file and therefore maintains very large files.*

![Screen Shot 2020-06-20 at 1.17.08 PM](https://raw.githubusercontent.com/vksah32/screenshots/master/Screen_Shot_2020-06-20_at_1.17.08_PM.png)See annotated [paper](https://github.com/vvksh/readings/blob/master/distributed-systems/haystack-fb-2010.pdf).

